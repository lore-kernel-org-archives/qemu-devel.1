Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9487C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 06:31:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC5624679
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 06:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsxWZwFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC5624679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ishdL-0003uk-PA
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 01:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ishcb-0003Pg-L1
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:30:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ishca-0006m4-DU
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:30:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48762
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ishca-0006kV-AC
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 01:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579329011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hmL/SyB1R329nZ3cIm25g7c+uXsxvfvSEJuWlZ13c7M=;
 b=ZsxWZwFxYxeh2ifnWb/6t+Lofv4fq1oHfvIrJ9/Pn8VzOLArnvRY9xVxMze+XIk3LssdGZ
 ktT1/zOzThyQiKhv0dp1eMPE9+j2UX90d9p7Kdg1d9KJ58pt7ZKqS8y0a1HAx+kQ6lRDvp
 am/LD/8s65iVlFm4Z9BoGASfFxfVj+w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-ygQfVNLMNPGxKTgnL6if_Q-1; Sat, 18 Jan 2020 01:30:09 -0500
Received: by mail-wr1-f70.google.com with SMTP id i9so11439312wru.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 22:30:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vfG9VG63R+accGV9M8fVJYN0v6qPi36iQI4dEDoQYzU=;
 b=PB9GPAEqt/X83ouOq09hJtiZ7qvGlAYYkuk42cYaSBCTTssnyGZefLXtAhC8pxm7K7
 0QVi/Rw3+tlgUZG9+5Zy6G1sc8dtV0bBWRHrGWUv3blWmNM3mUbpk9IYAapa1N5vc03S
 6DTXkXvCCXt5xG4szo5yD9Y9rv1DFpKMsox1CoCatKq2foNZ6L4Us4vZi+QPEbeETX9I
 H6PNgiCdcK3wok9gP5klVWrHIca7T6GCi2dM76hxb+fGDskYKbgIITc9nsRVR4X5tx59
 Pk8nPtqqhQ1IsDZ1aU50TOCEJXj9GdX2DfltrfLNy4ARitK5KnEVD1FVbw93mDVF8swq
 Efew==
X-Gm-Message-State: APjAAAV/9KglhLHGTABEdAn2UxybOp7nZy/RKQH8nuBW9tvLJz4te9eQ
 meHqzn4O40sofHGjOMtbZCNXVTtPnM5e9ISLsUbs1Yj2jrdKeiXnhr+Mlz8U2xpEzK2nUZwi2Fq
 RtJ6r73K3GUS5ek0=
X-Received: by 2002:a1c:3187:: with SMTP id x129mr8690008wmx.91.1579329005000; 
 Fri, 17 Jan 2020 22:30:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqygIYg6hOfLoMhBbvFPcxVshHjqAdx1WBG0aloi/QavW4yLTIO7iUCMcua6dPfzihQDMcWcbA==
X-Received: by 2002:a1c:3187:: with SMTP id x129mr8689996wmx.91.1579329004772; 
 Fri, 17 Jan 2020 22:30:04 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id c9sm12461964wmc.47.2020.01.17.22.30.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 22:30:04 -0800 (PST)
Subject: Re: [PATCH] audio/dsound: fix invalid parameters error
To: KJ Liew <liewkj@yahoo.com>, qemu-devel@nongnu.org,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20200117182621.GB13724.ref@chuwi-lt0>
 <20200117182621.GB13724@chuwi-lt0>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <29987343-f835-2280-4457-067d970c9c5e@redhat.com>
Date: Sat, 18 Jan 2020 07:30:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117182621.GB13724@chuwi-lt0>
Content-Language: en-US
X-MC-Unique: ygQfVNLMNPGxKTgnL6if_Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 1/17/20 7:26 PM, KJ Liew wrote:
> QEMU Windows has broken dsound backend since the rewrite of audio API in
> version 4.2.0. Both playback and capture buffers failed to lock with
> invalid parameters error.

Fixes: 7fa9754ac88 (dsoundaudio: port to the new audio backend api)

Cc'ing Zolt=E1n who wrote 7fa9754ac88, and Gerd (the maintainer of this fil=
e):

   $ ./scripts/get_maintainer.pl -f audio/dsoundaudio.c
   Gerd Hoffmann <kraxel@redhat.com> (maintainer:Audio)

> --- ../orig/qemu-4.2.0/audio/dsoundaudio.c=092019-12-12 10:20:47.00000000=
0 -0800
> +++ ../qemu-4.2.0/audio/dsoundaudio.c=092020-01-17 08:05:46.783966900 -08=
00
> @@ -53,6 +53,7 @@
>   typedef struct {
>       HWVoiceOut hw;
>       LPDIRECTSOUNDBUFFER dsound_buffer;
> +    void *last_buf;
>       dsound *s;
>   } DSoundVoiceOut;
>  =20
> @@ -414,10 +415,10 @@
>       DSoundVoiceOut *ds =3D (DSoundVoiceOut *) hw;
>       LPDIRECTSOUNDBUFFER dsb =3D ds->dsound_buffer;
>       HRESULT hr;
> -    DWORD ppos, act_size;
> +    DWORD ppos, act_size, last_size;
>       size_t req_size;
>       int err;
> -    void *ret;
> +    void *ret, *last_ret;
>  =20
>       hr =3D IDirectSoundBuffer_GetCurrentPosition(dsb, &ppos, NULL);
>       if (FAILED(hr)) {
> @@ -426,17 +427,24 @@
>           return NULL;
>       }
>  =20
> +    if (ppos =3D=3D hw->pos_emul) {
> +        *size =3D 0;
> +        return ds->last_buf;
> +    }
> +
>       req_size =3D audio_ring_dist(ppos, hw->pos_emul, hw->size_emul);
>       req_size =3D MIN(req_size, hw->size_emul - hw->pos_emul);
>  =20
> -    err =3D dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, &ret=
, NULL,
> -                          &act_size, NULL, false, ds->s);
> +    err =3D dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, &ret=
, &last_ret,
> +                          &act_size, &last_size, false, ds->s);
>       if (err) {
>           dolog("Failed to lock buffer\n");
>           *size =3D 0;
>           return NULL;
>       }
>  =20
> +    ds->last_buf =3D g_realloc(ds->last_buf, act_size);
> +    memcpy(ds->last_buf, ret, act_size);
>       *size =3D act_size;
>       return ret;
>   }
> @@ -445,6 +453,8 @@
>   {
>       DSoundVoiceOut *ds =3D (DSoundVoiceOut *) hw;
>       LPDIRECTSOUNDBUFFER dsb =3D ds->dsound_buffer;
> +    if (len =3D=3D 0)
> +        return 0;
>       int err =3D dsound_unlock_out(dsb, buf, NULL, len, 0);
>  =20
>       if (err) {
> @@ -508,10 +518,10 @@
>       DSoundVoiceIn *ds =3D (DSoundVoiceIn *) hw;
>       LPDIRECTSOUNDCAPTUREBUFFER dscb =3D ds->dsound_capture_buffer;
>       HRESULT hr;
> -    DWORD cpos, act_size;
> +    DWORD cpos, act_size, last_size;
>       size_t req_size;
>       int err;
> -    void *ret;
> +    void *ret, *last_ret;
>  =20
>       hr =3D IDirectSoundCaptureBuffer_GetCurrentPosition(dscb, &cpos, NU=
LL);
>       if (FAILED(hr)) {
> @@ -520,11 +530,16 @@
>           return NULL;
>       }
>  =20
> +    if (cpos =3D=3D hw->pos_emul) {
> +        *size =3D 0;
> +        return NULL;
> +    }
> +
>       req_size =3D audio_ring_dist(cpos, hw->pos_emul, hw->size_emul);
>       req_size =3D MIN(req_size, hw->size_emul - hw->pos_emul);
>  =20
> -    err =3D dsound_lock_in(dscb, &hw->info, hw->pos_emul, req_size, &ret=
, NULL,
> -                         &act_size, NULL, false, ds->s);
> +    err =3D dsound_lock_in(dscb, &hw->info, hw->pos_emul, req_size, &ret=
, &last_ret,
> +                         &act_size, &last_size, false, ds->s);
>       if (err) {
>           dolog("Failed to lock buffer\n");
>           *size =3D 0;
>=20


