Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F66DC33CB3
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 18:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E130520679
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 18:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eWWEGSz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E130520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixxWO-00023u-2b
	for qemu-devel@archiver.kernel.org; Sat, 01 Feb 2020 13:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40565)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liewkj@yahoo.com>) id 1ixxVO-000154-W0
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 13:28:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liewkj@yahoo.com>) id 1ixxVN-0002FL-BE
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 13:28:30 -0500
Received: from sonic306-21.consmr.mail.ne1.yahoo.com ([66.163.189.83]:45397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liewkj@yahoo.com>) id 1ixxVN-0002CV-67
 for qemu-devel@nongnu.org; Sat, 01 Feb 2020 13:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1580581707; bh=0NaouDo3Cp0qbzASeYqmvJjrFcCjLuXNushgUfnrbZ8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
 b=eWWEGSz4M0fiXApE7txtotv81I7fyuI1wFmQF/JdLW85OvsEv/iqKEhllu2K5onCp24x49K2ohxjFhoEkUWJ7oaREYzEvqRssVv3SW1x3xBr3QLIyEKwCB16ICGowdjVHNdJ44yJ0r9AVHoEmzgBccypbAyYw9ntBMbYoGmf5Gqa6BU6zYEAUODJrk3oQSubH4EUsY40IKbmAuFZo1Exfbrrl0UvZfnInpfyOOv1V2CH2cLM/q1BjIPymHCPmSoEiQkpxM0bBf+gy6CVqMJ/y6WmpH0D99e5/HsejJv83MgCvH+cnSHh+wHOV6n/cDM5oZauIYBGC593l8WgJsFujw==
X-YMail-OSG: 43AtZsIVM1mZyB4t64qq_OyGd3XLyhglzrWARy5FfXhkWdpoN1ZsYxVfn1jBfyq
 EeXc2n7tbjP9imRgDkteI2hoelWfPtHXvh6_3u0eycE6DEOojnEu.r3rGe5ARgVBf46aJULDcBj6
 M2Lrkba0mgMNfcu2TlrFepadjbXEk5x0ZcTGh8QVDu22ab9DrJ5IAG5oSD2B55ej_DhVdYk0S10_
 _JMN2IStAIS6Gp_gHMnNgSBBwYJqf5lNPax9_MKO_1WII85.u2hRoJVT4.v7EwabZploNQD2EsSE
 6FFE9q65qE_iMH0VdYTXmpX_NIft_FUTq5uUcB8CJjO8Pqxs712zNq3k6KD_pHNqwzwMRT6esKGF
 GkBVMAdZkHO5KFbW7JnP0.YS.6llnd6XcL_XVwDgr_lyI92fesbGUcsjY2zvCiw9FRmHg6UkvfD0
 yMsnXJ6taI78wP5aaFpGSN7I8Eu7s_._MA5lQCmboiSBOhSl3hJgQkIkfAQhDeEZ2e31oqRau7Mq
 yb6s9cFl8uVP75DK.6nCLZDhzK3d5vRZUMsgVsdZ7b1iI6nCXw_FGfuPuaY0UD.c7_QAoBZWU2hX
 L845vtau.4KhRMvSObeSO6zhXdZrdAhlMlmhnB6s1LDQCCmQ1Gue02iNbcGjtCZcyUNHg2can7Qb
 d1LavaA5BoQF3P2D_aXaxnKDOgUDhdKkh6nDuDmwMwygHQUXh1NGfkw6bdxVXb3AmuKgO8KVuZH8
 RzMrWcnufwDl_40o2e484tA.PfL69rz7X96KM12esAo9Ey_ffMvnJ9JS6fOv0cLPkt9f5MFSjX21
 QZ7VzHT0cno0WzgGyzBodTt7QtJ.Y7YGmILYXY0IsCDMu_p2LjAd2U95susAde0bmA238QCcALAW
 v3ip0Mv1pou4nx7fJKaKSdHJfP7eOwQRJGVUVA093JuP7GZWOoL8Rz3rWkhE4nFsXbUAZbxK2VpF
 PU9uM1OFi2NKgG1qJaicz6AGsV2PP1BPeL4yBYCF_gkaoDAn2FkuZT020NM75PLf4IKQYhvNfTb6
 Kkl1lqkMr0uyT5xKiwp0C87WkQyG7XPIEzkzmwGiFdY3pImzaU2VBNy8mx_fjjr4Y08uwuX4ZEnx
 ttfN4J7H9p1C2V4VadNqaOAll.9jt7ytBeinQIdOKSvfF49AjhOEMBJN7H5tSoW1VXQOeL2pwY93
 S1hCPmej7dNpyqLEQzzeMB6V0Du6neQwleLhuf7R4kzgcxa6D2Y.7Mm_5rLBk9G_utDbEic7l5s_
 E6SnTXa1Bbye0U8z7o3Mhns3WO8ksoYA7s7FKhS2KorAsdHGdCf_LPGzgBzBVrjm4T1TbATr1jgh
 TDns34y75t2FhGOWCdtn_VOjXb235Ngy88KEBZ2lFFcrY77ko4A8dpvzkXwnRanN12wyRi4vNmom
 8JWTNlSNEDIQ-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sat, 1 Feb 2020 18:28:27 +0000
Received: by smtp406.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID b4251f41c5ad79e0d302d7903f98515c; 
 Sat, 01 Feb 2020 18:28:23 +0000 (UTC)
Date: Sat, 1 Feb 2020 10:28:14 -0800
From: KJ Liew <liewkj@yahoo.com>
To: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] audio/dsound: fix invalid parameters error
Message-ID: <20200201182814.GA35660@PC-SEANJYE>
References: <20200117182621.GB13724.ref@chuwi-lt0>
 <20200117182621.GB13724@chuwi-lt0>
 <29987343-f835-2280-4457-067d970c9c5e@redhat.com>
 <2b889c2c-04ac-c6ef-ae3e-2901492a2824@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b889c2c-04ac-c6ef-ae3e-2901492a2824@gmail.com>
X-Mailer: WebService/1.1.15149 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_181)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 66.163.189.83
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 27, 2020 at 02:46:58AM +0100, Zoltán Kővágó wrote:
> On 2020-01-18 07:30, Philippe Mathieu-Daudé wrote:
> > On 1/17/20 7:26 PM, KJ Liew wrote:
> > > QEMU Windows has broken dsound backend since the rewrite of audio API in
> > > version 4.2.0. Both playback and capture buffers failed to lock with
> > > invalid parameters error.
> > 
> > Fixes: 7fa9754ac88 (dsoundaudio: port to the new audio backend api)
> 
> Hmm, I see the old code specified those parameters, but MSDN reads:
> 
> If the application passes NULL for the ppvAudioPtr2 and pdwAudioBytes2
> parameters, the lock extends no further than the end of the buffer and does
> not wrap.
> 
> Looks like this means that if the lock doesn't fit in the buffer it fails
> instead of truncating it.  I'm sure I tested the code under wine, and
> probably in a win8.1 vm too, and it worked there, maybe it's dependent on
> the windows version or sound driver?
>

I was testing on several real Win10 machines. QEMU built with
MSYS2/mingw-w64-x86_64 GNU toolchain.

> > 
> > Cc'ing Zoltán who wrote 7fa9754ac88, and Gerd (the maintainer of this
> > file):
> > 
> >    $ ./scripts/get_maintainer.pl -f audio/dsoundaudio.c
> >    Gerd Hoffmann <kraxel@redhat.com> (maintainer:Audio)
> > 
> > > --- ../orig/qemu-4.2.0/audio/dsoundaudio.c    2019-12-12
> > > 10:20:47.000000000 -0800
> > > +++ ../qemu-4.2.0/audio/dsoundaudio.c    2020-01-17
> > > 08:05:46.783966900 -0800
> > > @@ -53,6 +53,7 @@
> > >   typedef struct {
> > >       HWVoiceOut hw;
> > >       LPDIRECTSOUNDBUFFER dsound_buffer;
> > > +    void *last_buf;
> > >       dsound *s;
> > >   } DSoundVoiceOut;
> > > @@ -414,10 +415,10 @@
> > >       DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
> > >       LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
> > >       HRESULT hr;
> > > -    DWORD ppos, act_size;
> > > +    DWORD ppos, act_size, last_size;
> > >       size_t req_size;
> > >       int err;
> > > -    void *ret;
> > > +    void *ret, *last_ret;
> > >       hr = IDirectSoundBuffer_GetCurrentPosition(dsb, &ppos, NULL);
> > >       if (FAILED(hr)) {
> > > @@ -426,17 +427,24 @@
> > >           return NULL;
> > >       }
> > > +    if (ppos == hw->pos_emul) {
> > > +        *size = 0;
> > > +        return ds->last_buf;
> > > +    }
> > > +
> > >       req_size = audio_ring_dist(ppos, hw->pos_emul, hw->size_emul);
> > >       req_size = MIN(req_size, hw->size_emul - hw->pos_emul);
> > > -    err = dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size,
> > > &ret, NULL,
> > > -                          &act_size, NULL, false, ds->s);
> > > +    err = dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size,
> > > &ret, &last_ret,
> > > +                          &act_size, &last_size, false, ds->s);
> > >       if (err) {
> > >           dolog("Failed to lock buffer\n");
> > >           *size = 0;
> > >           return NULL;
> > >       }
> > > +    ds->last_buf = g_realloc(ds->last_buf, act_size);
> > > +    memcpy(ds->last_buf, ret, act_size);
> > >       *size = act_size;
> > >       return ret;
> > >   }
> 
> I don't really understand what's happening here, why do you need that memory
> allocation and memcpy?  This function should return a buffer where the
> caller will write data, that *size = 0; when returning ds->last_buf also
> looks incorrect to me (the calling function won't write anything into it).

I was trying to fix the invalid parameters errors from
dsound_lock_out()/dsound_lock_in(). I have to say that I wasn't quite sure if the
content of buffer matters to the caller, but an assumption that safe buffer for
read/write got to be there. So I just memcpy to keep the last good
buffer.

The lock seemed to fail for dsound_lock_out()/dsound_lock_in() when
(ppos == hw->pos_emul) for _out and (cpos == hw->pos_emul) for _in.
Hence, the last_buf was returned to the caller. Since the lock did not
take place, the *size = 0 provides the hint to skip the unlock,
otherwise, dsound_unlock_out() failed for buffer that has never been
locked.

> I'm attaching a patch with a probably better (and totally untested) way to
> do this (if someone can tell me how to copy-paste a patch into thunderbird
> without it messing up long lines, please tell me). 
 
I checked out your patch. Unfortunately, it did not
address the invalid paramters errors. The console still flooded with error
messages:
dsound: Could not lock playback buffer
dsound: Reason: An invalid parameter was passed to the returning function
dsound: Failed to lock buffer

> > > @@ -445,6 +453,8 @@
> > >   {
> > >       DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
> > >       LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
> > > +    if (len == 0)
> > > +        return 0;
> > >       int err = dsound_unlock_out(dsb, buf, NULL, len, 0);
> > >       if (err) {
> 
> Msdn says "The second pointer is needed even if nothing was written to the
> second pointer." so that NULL doesn't look okay.
> 
> > > @@ -508,10 +518,10 @@
> > >       DSoundVoiceIn *ds = (DSoundVoiceIn *) hw;
> > >       LPDIRECTSOUNDCAPTUREBUFFER dscb = ds->dsound_capture_buffer;
> > >       HRESULT hr;
> > > -    DWORD cpos, act_size;
> > > +    DWORD cpos, act_size, last_size;
> > >       size_t req_size;
> > >       int err;
> > > -    void *ret;
> > > +    void *ret, *last_ret;
> > >       hr = IDirectSoundCaptureBuffer_GetCurrentPosition(dscb, &cpos,
> > > NULL);
> > >       if (FAILED(hr)) {
> > > @@ -520,11 +530,16 @@
> > >           return NULL;
> > >       }
> > > +    if (cpos == hw->pos_emul) {
> > > +        *size = 0;
> > > +        return NULL;
> > > +    }
> > > +
> > >       req_size = audio_ring_dist(cpos, hw->pos_emul, hw->size_emul);
> > >       req_size = MIN(req_size, hw->size_emul - hw->pos_emul);
> > > -    err = dsound_lock_in(dscb, &hw->info, hw->pos_emul, req_size,
> > > &ret, NULL,
> > > -                         &act_size, NULL, false, ds->s);
> > > +    err = dsound_lock_in(dscb, &hw->info, hw->pos_emul, req_size,
> > > &ret, &last_ret,
> > > +                         &act_size, &last_size, false, ds->s);
> > >       if (err) {
> > >           dolog("Failed to lock buffer\n");
> > >           *size = 0;
> > > 
> 
> You're completely ignoring last_ret and last_size here.  Don't you lose
> samples here?  I think it's possible to do something like I posted above
> with output here.
> 
> Regards,
> Zoltan

> diff --git a/audio/dsoundaudio.c b/audio/dsoundaudio.c
> index c265c0094b..b6bc241faa 100644
> --- a/audio/dsoundaudio.c
> +++ b/audio/dsoundaudio.c
> @@ -53,6 +53,9 @@ typedef struct {
>  typedef struct {
>      HWVoiceOut hw;
>      LPDIRECTSOUNDBUFFER dsound_buffer;
> +    void *buffer1, buffer2;
> +    DWORD size1, size2;
> +    bool has_remaining;
>      dsound *s;
>  } DSoundVoiceOut;
>  
> @@ -414,10 +417,16 @@ static void *dsound_get_buffer_out(HWVoiceOut *hw, size_t *size)
>      DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
>      LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
>      HRESULT hr;
> -    DWORD ppos, act_size;
> +    DWORD ppos, act_size1, act_size2;
>      size_t req_size;
>      int err;
> -    void *ret;
> +    void *ret1, *ret2;
> +
> +    if (ds->has_remaining) {
> +        ds->has_remaining = false;
> +        *size = ds->size2;
> +        return ds->buffer2;
> +    }
>  
>      hr = IDirectSoundBuffer_GetCurrentPosition(dsb, &ppos, NULL);
>      if (FAILED(hr)) {
> @@ -429,15 +438,20 @@ static void *dsound_get_buffer_out(HWVoiceOut *hw, size_t *size)
>      req_size = audio_ring_dist(ppos, hw->pos_emul, hw->size_emul);
>      req_size = MIN(req_size, hw->size_emul - hw->pos_emul);
>  
> -    err = dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, &ret, NULL,
> -                          &act_size, NULL, false, ds->s);
> +    err = dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, &ret1, &ret2,
> +                          &act_size1, &act_size2, false, ds->s);
>      if (err) {
>          dolog("Failed to lock buffer\n");
>          *size = 0;
>          return NULL;
>      }
>  
> -    *size = act_size;
> +    *size = act_size1;
> +    ds->buffer1 = ret1;
> +    ds->buffer2 = ret2;
> +    ds->size1 = act_size1;
> +    ds->size2 = act_size2;
> +    ds->has_remaining = ret2 != NULL;
>      return ret;
>  }
>  
> @@ -445,7 +459,16 @@ static size_t dsound_put_buffer_out(HWVoiceOut *hw, void *buf, size_t len)
>  {
>      DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
>      LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
> -    int err = dsound_unlock_out(dsb, buf, NULL, len, 0);
> +    int err;
> +
> +    if (ds->has_remaining) {
> +        ds->size1 = len;
> +        hw->pos_emul = (hw->pos_emul + len) % hw->size_emul;
> +        return len;
> +    }
> +
> +    *(ds->buffer2 ? &ds->size2 : &ds->size1) = len;
> +    err = dsound_unlock_out(dsb, ds->buffer1, ds->buffer2, ds->size1, ds->size2);
>  
>      if (err) {
>          dolog("Failed to unlock buffer!!\n");


