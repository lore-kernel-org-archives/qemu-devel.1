Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0B3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:12:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F16214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 16:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="In7fAtzY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F16214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixYtv-0007OY-Ml
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 11:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1ixYe0-0007Mw-3A
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:55:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1ixYdv-0005aO-B2
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:55:44 -0500
Received: from mail-yw1-xc2b.google.com ([2607:f8b0:4864:20::c2b]:32947)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1ixYdv-0005Yo-46
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:55:39 -0500
Received: by mail-yw1-xc2b.google.com with SMTP id 192so5160814ywy.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 07:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=f5hrlS77TAxjUCJk3JD4gINUtLSam/mkMAuUqAP5cbc=;
 b=In7fAtzYw1dpHbx0+veGVV8Jv4gy+8x6L8kiMYdJnUDtxITcqFopEtGYtyfJJxq6Bp
 /NXbrottc/K/LGggwyoUa6K6YAxMQQ8axwDVL0Ov8MJozYtPzro/0MdQBIlRsdW2CIqK
 854i7YUkVXu2a1N1uBEB+t2uBeGACPDl6xTv/f0KV52W58D1vP60K0VMWEobWeZFBbjg
 mOGWSgRLzeVVQhbB0jek0d4f2p/s6PtML1xcUHAcBUEWbmAHw9FLBKDj7BkZNKnz/y+H
 cJdgbZZ9m047C+jHzNahA0baRo/grqm6k5OMG/hh8S/PK4Ql4WUgGmMOMnJyb8Bm3xW/
 u5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=f5hrlS77TAxjUCJk3JD4gINUtLSam/mkMAuUqAP5cbc=;
 b=Pt+hcmjm/Nva5T6iUXkumB2ReJH3zUFDsalRMJ0t7kHD1gN+TNAxVhEq1cX6hKH+pI
 a3zw/RvxcJ6as9h03zhjf/aBI9CmXPJbBOB2e5WqIEoPO6DmjfxW2ReUhzWvhhqNv8ps
 4N9RXHgW1qdQZUU9iM2En8L26y2LCZvP/uudgRqYZnKGon+wqmQuTCV16LkscO4cPYLe
 jDy8yWgY+yfGNZarfQangGjt9CI3oh0zlakgnFKgB36OwR7wZgQxt0Za7XMtcb4l/c1f
 5CtS1Xrf1AJwkVcxOIBLlyKpTmvVUtBBgkkhyrw77yiX8ca/GaQ84FiRcFIlnZk8Z2tK
 73GQ==
X-Gm-Message-State: APjAAAWcIpC/ib6BbpUXjZ1cwqbIUyExv2MOSZPGYMoAA1b8SEpQfqIG
 j4/70MMndIC2EYlu5fj68Vc=
X-Google-Smtp-Source: APXvYqx8QKwUOyNwYCjMGLtG3nhsECl3K8UDxAws/kLzf6Ytu4z9aaHXYo2ikF93Nyw2gt7wp9ej0Q==
X-Received: by 2002:a25:9b01:: with SMTP id y1mr8518584ybn.179.1580486138207; 
 Fri, 31 Jan 2020 07:55:38 -0800 (PST)
Received: from [192.168.0.5] (d149-67-30-58.try.wideopenwest.com.
 [67.149.58.30])
 by smtp.gmail.com with ESMTPSA id 207sm4126493ywq.100.2020.01.31.07.55.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 31 Jan 2020 07:55:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC] coreaudio: fix coreaudio_test.diff
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <f03b7ae9-344c-5a7f-414c-6250a9c5ec2f@t-online.de>
Date: Fri, 31 Jan 2020 10:55:36 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <6DC8EF02-E8AF-4E10-934D-CD76D3230F72@gmail.com>
References: <43D423C6-78D4-4DCE-B97C-0658D3D2E3BD@gmail.com>
 <4021690b-2380-3925-209e-d4cc66928773@gmail.com>
 <5314e860-dffe-3bc0-209f-bd2b937cd0c6@t-online.de>
 <CABLmASGcUVyASudNizcgPshEqahwYt-4m9Z1DXEhVe2vdko9cQ@mail.gmail.com>
 <54f5ddf3-5ea9-bd6d-8c71-edf4db527463@t-online.de>
 <f03b7ae9-344c-5a7f-414c-6250a9c5ec2f@t-online.de>
To: =?utf-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c2b
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
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu Developers <qemu-devel@nongnu.org>, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On Jan 29, 2020, at 2:13 AM, Volker R=C3=BCmelin <vr_qemu@t-online.de> =
wrote:
>=20
> This is an untested patch that tries to fix the problems in the
> patch found at
> =
https://lists.nongnu.org/archive/html/qemu-devel/2020-01/msg02142.html.=20=

>=20
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> ---
> audio/audio_template.h | 16 ++++++++--------
> audio/coreaudio.c      |  5 +++++
> 2 files changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/audio/audio_template.h b/audio/audio_template.h
> index a7b46b8363..e6724c5d68 100644
> --- a/audio/audio_template.h
> +++ b/audio/audio_template.h
> @@ -153,13 +153,6 @@ static int glue (audio_pcm_sw_init_, TYPE) (
>     sw->ratio =3D ((int64_t) sw->info.freq << 32) / sw->hw->info.freq;
> #endif
>=20
> -#ifdef FLOAT_MIXENG
> -#ifdef DAC
> -    sw->conv =3D mixeng_conv_float;
> -#else
> -    sw->clip =3D mixeng_clip_float;
> -#endif
> -#else
> #ifdef DAC
>     sw->conv =3D mixeng_conv
> #else
> @@ -169,7 +162,6 @@ static int glue (audio_pcm_sw_init_, TYPE) (
>         [sw->info.sign]
>         [sw->info.swap_endianness]
>         [audio_bits_to_index (sw->info.bits)];
> -#endif
>=20
>     sw->name =3D g_strdup (name);
>     err =3D glue (audio_pcm_sw_alloc_resources_, TYPE) (sw);
> @@ -284,6 +276,13 @@ static HW *glue(audio_pcm_hw_add_new_, =
TYPE)(AudioState *s,
>         goto err1;
>     }
>=20
> +#ifdef FLOAT_MIXENG
> +#ifdef DAC
> +    hw->clip =3D mixeng_clip_float;
> +#else
> +    hw->conv =3D mixeng_conv_float;
> +#endif
> +#else
> #ifdef DAC
>     hw->clip =3D mixeng_clip
> #else
> @@ -293,6 +292,7 @@ static HW *glue(audio_pcm_hw_add_new_, =
TYPE)(AudioState *s,
>         [hw->info.sign]
>         [hw->info.swap_endianness]
>         [audio_bits_to_index (hw->info.bits)];
> +#endif
>=20
>     glue(audio_pcm_hw_alloc_resources_, TYPE)(hw);
>=20
> diff --git a/audio/coreaudio.c b/audio/coreaudio.c
> index 4e7e509ad0..ff0d23fd7d 100644
> --- a/audio/coreaudio.c
> +++ b/audio/coreaudio.c
> @@ -482,6 +482,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, =
struct audsettings *as,
>     Audiodev *dev =3D drv_opaque;
>     AudiodevCoreaudioPerDirectionOptions *cpdo =3D =
dev->u.coreaudio.out;
>     int frames;
> +    struct audsettings fake_as;
>=20
>     /* create mutex */
>     err =3D pthread_mutex_init(&core->mutex, NULL);
> @@ -490,6 +491,10 @@ static int coreaudio_init_out(HWVoiceOut *hw, =
struct audsettings *as,
>         return -1;
>     }
>=20
> +    memcpy(&fake_as, as, sizeof(struct audsettings));
> +    as =3D &fake_as;
> +    /* size of float is 32bits */
> +    as->fmt =3D AUDIO_FORMAT_S32;
>     audio_pcm_init_info (&hw->info, as);
>=20
>     status =3D coreaudio_get_voice(&core->outputDeviceID);
> --=20
> 2.16.4
>=20

I could not apply this patch using 'patch -p1 < <patch file>'. I kept =
seeing the error malformed patch.=20

When I applied the patch by hand QEMU was able to play sound normally =
again. Thank you :)

I used qemu-system-i386 at git commit =
adcd6e93b9519f7fe421d543e3aa646895b32e1a to test this patch.=20

Both the AC97 and SB16 sound cards with Windows XP and Windows NT 4.0 =
respectively. Only the ES1370 sound card used with Windows 2000 failed =
to play anything. This is probably a problem with it and not your patch.

Reviewed-by: John Arbuckle <programmingkidx@gmail.com>=

