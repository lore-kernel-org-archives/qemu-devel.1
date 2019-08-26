Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51062C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 08:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28304206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 08:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28304206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2A9d-0006O3-4P
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 04:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45390)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i2A8s-0005ws-LG
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:14:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i2A8q-0004Ev-PA
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:14:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34894)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1i2A8q-0004EP-K9
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:14:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AD82848FD;
 Mon, 26 Aug 2019 08:14:18 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 739925D9CC;
 Mon, 26 Aug 2019 08:14:14 +0000 (UTC)
Message-ID: <919818148f19e9c3b01b1dcef3d93c3d7b430550.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: =?UTF-8?Q?K=C5=91v=C3=A1g=C3=B3=2C_Zolt=C3=A1n?=
 <dirty.ice.hu@gmail.com>,  qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 11:14:13 +0300
In-Reply-To: <5206082e64b6d7b9194e9076180399e5c5183650.1566779143.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566779143.git.DirtY.iCE.hu@gmail.com>
 <5206082e64b6d7b9194e9076180399e5c5183650.1566779143.git.DirtY.iCE.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Mon, 26 Aug 2019 08:14:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] audio: paaudio: ability to specify
 stream name
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-08-26 at 02:29 +0200, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n wro=
te:
> This can be used to identify stream in tools like pavucontrol when one
> creates multiple -audiodevs or runs multiple qemu instances.
>=20
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
> ---
>  qapi/audio.json | 6 ++++++
>  audio/paaudio.c | 4 ++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/qapi/audio.json b/qapi/audio.json
> index 9fefdf5186..a433b3c9d7 100644
> --- a/qapi/audio.json
> +++ b/qapi/audio.json
> @@ -206,6 +206,11 @@
>  #
>  # @name: name of the sink/source to use
>  #
> +# @stream-name: name of the PulseAudio stream created by qemu.  Can be
> +#               used to identify the stream in PulseAudio when you
> +#               create multiple PulseAudio devices or run multiple qem=
u
> +#               instances (default "qemu", since 4.2)
> +#
>  # @latency: latency you want PulseAudio to achieve in microseconds
>  #           (default 15000)
>  #
> @@ -215,6 +220,7 @@
>    'base': 'AudiodevPerDirectionOptions',
>    'data': {
>      '*name': 'str',
> +    '*stream-name': 'str',
>      '*latency': 'uint32' } }
> =20
>  ##
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index 777b8e4718..827f442b6e 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -562,7 +562,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct auds=
ettings *as,
> =20
>      pa->stream =3D qpa_simple_new (
>          c,
> -        "qemu",
> +        ppdo->has_stream_name ? ppdo->stream_name : "qemu",
>          PA_STREAM_PLAYBACK,
>          ppdo->has_name ? ppdo->name : NULL,
>          &ss,
> @@ -630,7 +630,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audset=
tings *as, void *drv_opaque)
> =20
>      pa->stream =3D qpa_simple_new (
>          c,
> -        "qemu",
> +        ppdo->has_stream_name ? ppdo->stream_name : "qemu",
>          PA_STREAM_RECORD,
>          ppdo->has_name ? ppdo->name : NULL,
>          &ss,

Tested and works.
Code also seems to be OK.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


