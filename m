Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1696CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 08:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D61882230C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 08:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N00qXOCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D61882230C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWyTE-0004E9-WA
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 03:02:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iWyS6-0003Lb-0G
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 03:01:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iWyS4-0005NW-VA
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 03:01:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26039
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iWyS4-0005N6-Qz
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 03:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574150492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EnC/TQfazeDor2kYnNw8O6s8n6I4iOG1JpgWF0W3w0Q=;
 b=N00qXOCMzKKHGz1Q84Q1/gnPOYsfcrVMdVosYPeLqBlDkQhqWQtERasS+ZCOCf/G5TInbi
 mbZHMlwCLVqtHriohYHDZFOPE71EhnjeO2C0GikYVEftYcekQ+gJxbyeFux8W8kbSfhzx6
 Vlm7ppjsnBv0KqhhsClTnFlwIOABmEs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-ojmCSdaNNbefROaPqEx4EA-1; Tue, 19 Nov 2019 03:01:31 -0500
Received: by mail-wm1-f71.google.com with SMTP id v8so1858610wml.4
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 00:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SxoKSkTJi8LNoDT3DjR5Se2NbqgjY1GLJXYX8RfxC7c=;
 b=R2s0SJ4VBgmY97SMSXGDZDux0GuslwAwlZP7anG34ZYFZf6l5vXC1KfTL1OaKisi7C
 ry5np1DdwtZmim8aQuF7K8xlaw1MSNhPXwO9h5DkwHj4iknPxjXGzyPZ0ecO991a2go2
 6zmVtFWVDr055w4SnsX5OoRJ+XoXa8HtEkMwXLQ599u8kLHRwpqq5ToeKiELx01q6Fii
 PWU+K+BNK1tTKo+Bbz2mUrAew2slcWRKaQ4fbZnpPMx1Nxo1S9qB5g4vyT4DjyJZHm7E
 hxW8neqRfKbVoaH7MwBLCrZ4fAYdQd4cWMOj7YPTzAPppMQI752/2SObGfmHlMUt+c++
 sYgw==
X-Gm-Message-State: APjAAAXwVz4/aaC3/ykglQzMCCoiB1nox8oyhDtz2nPdIC7SiFHqELDq
 ty35Cmkd0vi5pluBCvd9xDEAxW6LEYPE6BOOIbVm1kw3G/5c+b9TEPCexcf5G3addZdfN23HZM4
 ywjFmjP95jAhQcTU=
X-Received: by 2002:a1c:2846:: with SMTP id o67mr3875255wmo.7.1574150489576;
 Tue, 19 Nov 2019 00:01:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqyhKPdQsO26d9Qcjn/qC+Myf75/FoE2Z9aoCIp15Wc9Dqk2W0lkfAsGoIAgLRLyDk2cmPHdlQ==
X-Received: by 2002:a1c:2846:: with SMTP id o67mr3875229wmo.7.1574150489379;
 Tue, 19 Nov 2019 00:01:29 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id z15sm1295964wmi.12.2019.11.19.00.01.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2019 00:01:28 -0800 (PST)
Subject: Re: [PATCH] audio: fix audio recording
To: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?=
 <DirtY.iCE.hu@gmail.com>
References: <2fc947cf-7b42-de68-3f11-cbcf1c096be9@t-online.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a9ed793b-ebe7-b9da-3181-af246e16a59a@redhat.com>
Date: Tue, 19 Nov 2019 09:01:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2fc947cf-7b42-de68-3f11-cbcf1c096be9@t-online.de>
Content-Language: en-US
X-MC-Unique: ojmCSdaNNbefROaPqEx4EA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Zolt=C3=A1n.

On 11/19/19 7:58 AM, Volker R=C3=BCmelin wrote:
> With current code audio recording with all audio backends
> except PulseAudio and DirectSound is broken. The generic audio
> recording buffer management forgot to update the current read
> position after a read.
>=20
> Fixes: ff095e5231 "audio: api for mixeng code free backends"
>=20
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> ---
>   audio/audio.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/audio/audio.c b/audio/audio.c
> index 7fc3aa9d16..56fae55047 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1390,6 +1390,7 @@ void *audio_generic_get_buffer_in(HWVoiceIn *hw, si=
ze_t *size)
>           size_t read =3D hw->pcm_ops->read(hw, hw->buf_emul + hw->pos_em=
ul,
>                                           read_len);
>           hw->pending_emul +=3D read;
> +        hw->pos_emul =3D (hw->pos_emul + read) % hw->size_emul;

Anyway since read() can return a negative value, both previous=20
assignments should go after this if/break check...

>           if (read < read_len) {
>               break;
>           }
>=20


