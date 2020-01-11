Return-Path: <SRS0=vKWr=3A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24FAC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2020 00:33:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD562080D
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2020 00:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruFXuJHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD562080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iq4ia-0001me-MW
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 19:33:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iq4ht-0001Ld-6G
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 19:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty.ice.hu@gmail.com>) id 1iq4hr-00054g-P9
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 19:32:49 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53917)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dirty.ice.hu@gmail.com>)
 id 1iq4hr-0004wy-DC
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 19:32:47 -0500
Received: by mail-wm1-x344.google.com with SMTP id m24so3821206wmc.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 16:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:subject:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=0hgc6m9g0afupjBE27t4QSRy3DQ06k1S0qe+MwDC95c=;
 b=ruFXuJHLzU39V8MBTgUaBXm9FT0ITe2iJfk6MAv7sPH1rRb4wOsjpfD67rJKVSonfL
 RHzReXukZV+FWungUYZ/0QCQ2lsqsZ8jhNikIViCqIqKnZlNwV/fdmEz+bHqfoZ5nzsc
 cAGN0QfZZRTrh9LossiixnUoqjXvtp2/unfrv7zp+jIDpuyScuuWgI+DuM8KgUXHhCtF
 pnETALgCpFUddFFCQp6131ft8bHVQe+zts7qZEjBABcfWAmv0MnbP4yZkZ/uiPAAakHy
 AkkftdSaPOb9K4+DREdjC7w34zi030TihoFNLdC0+frZk7jeM6Xet+DcREFKs0Dsjno+
 Omng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=0hgc6m9g0afupjBE27t4QSRy3DQ06k1S0qe+MwDC95c=;
 b=jH+jxUnIyQqXg9vDP6gcdq3CM+kMHe/cYS7QqK4W7CHPghvtMlPCHt6MDSjSGybp0r
 eUppC2nR7syL0M+UQP54V7SG9RDpdvIx8kagdUETBpR+VW7O8Ru6GV7iX+UchxzPQd74
 h4XmdlEAPtajEImZfnPDkI/LjgfdJtR1EFfw81PbiVspYxrb0v/6gjQZjHQt7CYMA6tc
 S4yJDMYtG9qxxlVbVyZJeq2MGr12s6JzZ+fdqvYuxi/xE9szydwAoQto3FsamdYXjMz/
 EOXAgE9+RTNNheLyxyMEppHup9DNfVUIkKdhMLFX5NxHeyW3Q2OzwmWTAppxZX1Mc56N
 xKAw==
X-Gm-Message-State: APjAAAV80YXsUDZlv29okZA5i05aODd6bRc/07KLOtpqF4zTOtCyOWeO
 7wox4btiK2NnzD2Kv6F/ZmI=
X-Google-Smtp-Source: APXvYqy3CYxmWS8iBpT5EvOq1OTnttN4tn/03T6VC/y+JvLLuV3WZ0OiNgtPpD+PIYL8VNg9TmbSvQ==
X-Received: by 2002:a05:600c:305:: with SMTP id
 q5mr7034102wmd.167.1578702765769; 
 Fri, 10 Jan 2020 16:32:45 -0800 (PST)
Received: from ?IPv6:fd00:835b:d940:d4fc:1::31?
 (2a01-036c-0113-a0f7-0001-0000-0000-0031.pool6.digikabel.hu.
 [2a01:36c:113:a0f7:1::31])
 by smtp.gmail.com with ESMTPSA id k16sm4315685wru.0.2020.01.10.16.32.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2020 16:32:45 -0800 (PST)
From: "=?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=" <dirty.ice.hu@gmail.com>
X-Google-Original-From: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?=
 <DirtY.iCE.hu@gmail.com>
Subject: Re: [PATCH v2] Implement the Screamer sound chip for the mac99
 machine type
To: Programmingkid <programmingkidx@gmail.com>,
 qemu Developers <qemu-devel@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <43D423C6-78D4-4DCE-B97C-0658D3D2E3BD@gmail.com>
Message-ID: <4021690b-2380-3925-209e-d4cc66928773@gmail.com>
Date: Sat, 11 Jan 2020 01:32:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.9) Goanna/4.4
 Interlink/52.9.7282
MIME-Version: 1.0
In-Reply-To: <43D423C6-78D4-4DCE-B97C-0658D3D2E3BD@gmail.com>
Content-Type: multipart/mixed; boundary="------------F915027D61FE6F5F868AADFA"
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------F915027D61FE6F5F868AADFA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2020-01-05 02:58, Programmingkid wrote:
> I found the patch that breaks Screamer sound support for qemu-system-ppc. It is this:
> 
> commit 2ceb8240fa4e4e30fb853565eb2bed3032d74f62
> Author: Kővágó, Zoltán <dirty.ice.hu@gmail.com>
> Date:   Thu Sep 19 23:24:11 2019 +0200
> 
>      coreaudio: port to the new audio backend api
>      
>      Signed-off-by: Kővágó, Zoltán <DirtY.iCE.hu@gmail.com>
>      Message-id: 586a1e66de5cbc6c5234f9ae556d24befb6afada.1568927990.git.DirtY.iCE.hu@gmail.com
>      Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> 
> Reversing this patch should make the Screamer patch work with the current git version of QEMU.
> 

Hi,

Unfortunately it's not that simple to simply revert the patch since the 
old backend api no longer exists.  Also I don't have a Mac so it's 
almost impossible for me to test the results.  I looked at the specified 
commit and I think I found a problem, could you please apply the 
attached patch on the current git master and check whether it solves the 
problem?  If yes I'll turn it into a proper patch.

Regards,
Zoltan


--------------F915027D61FE6F5F868AADFA
Content-Type: text/x-patch; charset=UTF-8;
 name="coreaudio_test.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="coreaudio_test.diff"

diff --git a/audio/audio_template.h b/audio/audio_template.h
index 3287d7075e..a7b46b8363 100644
--- a/audio/audio_template.h
+++ b/audio/audio_template.h
@@ -153,6 +153,13 @@ static int glue (audio_pcm_sw_init_, TYPE) (
     sw->ratio = ((int64_t) sw->info.freq << 32) / sw->hw->info.freq;
 #endif
 
+#ifdef FLOAT_MIXENG
+#ifdef DAC
+    sw->conv = mixeng_conv_float;
+#else
+    sw->clip = mixeng_clip_float;
+#endif
+#else
 #ifdef DAC
     sw->conv = mixeng_conv
 #else
@@ -162,6 +169,7 @@ static int glue (audio_pcm_sw_init_, TYPE) (
         [sw->info.sign]
         [sw->info.swap_endianness]
         [audio_bits_to_index (sw->info.bits)];
+#endif
 
     sw->name = g_strdup (name);
     err = glue (audio_pcm_sw_alloc_resources_, TYPE) (sw);
diff --git a/audio/mixeng.h b/audio/mixeng.h
index 18e62c7c49..343f5fb810 100644
--- a/audio/mixeng.h
+++ b/audio/mixeng.h
@@ -41,6 +41,11 @@ typedef void (f_sample) (void *dst, const struct st_sample *src, int samples);
 extern t_sample *mixeng_conv[2][2][2][3];
 extern f_sample *mixeng_clip[2][2][2][3];
 
+#ifdef FLOAT_MIXENG
+void mixeng_conv_float(struct st_sample *dst, const void *src, int samples);
+void mixeng_clip_float(void *dst, const struct st_sample *src, int samples);
+#endif
+
 void *st_rate_start (int inrate, int outrate);
 void st_rate_flow(void *opaque, st_sample *ibuf, st_sample *obuf,
                   size_t *isamp, size_t *osamp);
diff --git a/audio/coreaudio.c b/audio/coreaudio.c
index 66f0f459cf..4e7e509ad0 100644
--- a/audio/coreaudio.c
+++ b/audio/coreaudio.c
@@ -471,20 +471,6 @@ static OSStatus audioDeviceIOProc(
     return 0;
 }
 
-static UInt32 coreaudio_get_flags(struct audio_pcm_info *info,
-                                  struct audsettings *as)
-{
-    UInt32 flags = info->sign ? kAudioFormatFlagIsSignedInteger : 0;
-    if (as->endianness) { /* 0 = little, 1 = big */
-        flags |= kAudioFormatFlagIsBigEndian;
-    }
-
-    if (flags == 0) { /* must not be 0 */
-        flags = kAudioFormatFlagsAreAllClear;
-    }
-    return flags;
-}
-
 static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
                               void *drv_opaque)
 {
@@ -572,15 +558,6 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
 
     /* set Samplerate */
     core->outputStreamBasicDescription.mSampleRate = (Float64) as->freq;
-    core->outputStreamBasicDescription.mFormatID = kAudioFormatLinearPCM;
-    core->outputStreamBasicDescription.mFormatFlags =
-        coreaudio_get_flags(&hw->info, as);
-    core->outputStreamBasicDescription.mBytesPerPacket =
-        core->outputStreamBasicDescription.mBytesPerFrame =
-        hw->info.nchannels * hw->info.bits / 8;
-    core->outputStreamBasicDescription.mFramesPerPacket = 1;
-    core->outputStreamBasicDescription.mChannelsPerFrame = hw->info.nchannels;
-    core->outputStreamBasicDescription.mBitsPerChannel = hw->info.bits;
 
     status = coreaudio_set_streamformat(core->outputDeviceID,
                                         &core->outputStreamBasicDescription);
diff --git a/audio/mixeng.c b/audio/mixeng.c
index 2f5ba71381..424ffe30d7 100644
--- a/audio/mixeng.c
+++ b/audio/mixeng.c
@@ -267,6 +267,27 @@ f_sample *mixeng_clip[2][2][2][3] = {
     }
 };
 
+#ifdef FLOAT_MIXENG
+void mixeng_conv_float(struct st_sample *dst, const void *src, int samples)
+{
+    float *in = (float *) src;
+    while (samples--) {
+        dst->l = *in++;
+        dst->r = *in++;
+        dst++;
+    }
+}
+
+void mixeng_clip_float(void *dst, const struct st_sample *src, int samples)
+{
+    float *out = (float *) dst;
+    while (samples--) {
+        *out++ = src->l;
+        *out++ = src->r;
+        src++;
+    }
+}
+#endif
 
 void audio_sample_to_uint64(void *samples, int pos,
                             uint64_t *left, uint64_t *right)

--------------F915027D61FE6F5F868AADFA--

