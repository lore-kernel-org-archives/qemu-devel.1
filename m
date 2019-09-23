Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF1CC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6B1205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 13:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6B1205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCOGq-00008B-41
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 09:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCOE2-0007E0-2J
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCOE0-0001u3-Cu
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:17:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:31691)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iCOE0-0001tR-7v
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 09:17:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 48AA01895A41;
 Mon, 23 Sep 2019 13:17:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C19C660BFB;
 Mon, 23 Sep 2019 13:17:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F13E113864E; Mon, 23 Sep 2019 15:17:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] audio: paaudio: ability to specify
 stream name
References: <cover.1568157545.git.DirtY.iCE.hu@gmail.com>
 <2d6e337c474ac84172d0809e6959c26b21d48120.1568157545.git.DirtY.iCE.hu@gmail.com>
Date: Mon, 23 Sep 2019 15:17:50 +0200
In-Reply-To: <2d6e337c474ac84172d0809e6959c26b21d48120.1568157545.git.DirtY.iCE.hu@gmail.com>
 (=?utf-8?B?IkvFkXbDoWfDsywgWm9sdMOhbiIncw==?= message of "Wed, 11 Sep 2019
 01:26:20 +0200")
Message-ID: <87h853m9s1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Mon, 23 Sep 2019 13:17:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n" <dirty.ice.hu@gmail.com> writes:

> This can be used to identify stream in tools like pavucontrol when one
> creates multiple -audiodevs or runs multiple qemu instances.
>
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.com>
> ---
>  audio/paaudio.c | 4 ++--
>  qapi/audio.json | 6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index 19b7e39092..d9cff9a2be 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -563,7 +563,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audset=
tings *as,
>=20=20
>      pa->stream =3D qpa_simple_new (
>          c,
> -        g->dev->id,
> +        ppdo->has_stream_name ? ppdo->stream_name : g->dev->id,
>          PA_STREAM_PLAYBACK,
>          ppdo->has_name ? ppdo->name : NULL,
>          &ss,
> @@ -631,7 +631,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsetti=
ngs *as, void *drv_opaque)
>=20=20
>      pa->stream =3D qpa_simple_new (
>          c,
> -        g->dev->id,
> +        ppdo->has_stream_name ? ppdo->stream_name : g->dev->id,
>          PA_STREAM_RECORD,
>          ppdo->has_name ? ppdo->name : NULL,
>          &ss,
> diff --git a/qapi/audio.json b/qapi/audio.json
> index 9fefdf5186..e45218f081 100644
> --- a/qapi/audio.json
> +++ b/qapi/audio.json
> @@ -206,6 +206,11 @@
>  #
>  # @name: name of the sink/source to use
>  #
> +# @stream-name: name of the PulseAudio stream created by qemu.  Can be
> +#               used to identify the stream in PulseAudio when you
> +#               create multiple PulseAudio devices or run multiple qemu
> +#               instances (default: audiodev's id, since 4.2)
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
>=20=20
>  ##

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>

