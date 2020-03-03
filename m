Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5A9C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 05:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA52220716
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 05:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMIfvrQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA52220716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j90Pg-0005mp-0H
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 00:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1j90Ov-0005Jm-6d
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 00:47:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1j90Ot-0000UK-Ky
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 00:47:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50113
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1j90Ot-0000Tq-Bh
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 00:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583214446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0SJm4ctOByyEnQ9FgMX2aJ9svEbpdSenhHnpyGvQkDc=;
 b=eMIfvrQN/V1L56nqpjIm+17ZQI90ieB7N/t2HBtKc9jImDzh2oRT//87HJGA+S9qBMaQdA
 Wy4ld87ey9FVVD+acQdgQh/v+fBO4dz4FtBMNYgklpmoJ/LLmXRxHpM01hBH8F51upi7nm
 2HVNCVai0MsmM4Lx0Qf0Y5WU1ONBpv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-S_5Wnwr4ONuB8LZGYilsJQ-1; Tue, 03 Mar 2020 00:47:24 -0500
X-MC-Unique: S_5Wnwr4ONuB8LZGYilsJQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C7F3107ACCD;
 Tue,  3 Mar 2020 05:47:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-129.ams2.redhat.com
 [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E4D39CA3;
 Tue,  3 Mar 2020 05:47:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0C87011386A6; Tue,  3 Mar 2020 06:47:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH 1/5] qapi/audio: add documentation for AudioFormat
References: <417bfe2f-e3c1-d83d-b437-47859daf524d@t-online.de>
 <20200302191004.5991-1-vr_qemu@t-online.de>
Date: Tue, 03 Mar 2020 06:47:17 +0100
In-Reply-To: <20200302191004.5991-1-vr_qemu@t-online.de> ("Volker
 =?utf-8?Q?R=C3=BCmelin=22's?=
 message of "Mon, 2 Mar 2020 20:10:00 +0100")
Message-ID: <87k1423s7u.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 John Arbuckle <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Volker R=C3=BCmelin <vr_qemu@t-online.de> writes:

> The review for patch ed2a4a7941 "audio: proper support for
> float samples in mixeng" suggested this would be a good idea.
>
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> ---
>  qapi/audio.json | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/qapi/audio.json b/qapi/audio.json
> index d8c507cced..07e7b05516 100644
> --- a/qapi/audio.json
> +++ b/qapi/audio.json
> @@ -273,6 +273,20 @@
>  #
>  # An enumeration of possible audio formats.
>  #
> +# @u8: unsigned 8 bit integer
> +#
> +# @s8: signed 8 bit integer
> +#
> +# @u16: unsigned 16 bit integer
> +#
> +# @s16: signed 16 bit integer
> +#
> +# @u32: unsigned 32 bit integer
> +#
> +# @s32: signed 32 bit integer
> +#
> +# @f32: single precision floating point (since 5.0)

floating-point

> +#
>  # Since: 4.0
>  ##
>  { 'enum': 'AudioFormat',

Acked-by: Markus Armbruster <armbru@redhat.com>


