Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20385C3A59E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 08:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA6321744
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 08:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA6321744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2AGr-0001Yx-Ud
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 04:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i2AG4-00014u-7i
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i2AG2-0007ZW-4V
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:21:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1i2AG1-0007Ym-He
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 04:21:46 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ED91A189DACC;
 Mon, 26 Aug 2019 08:21:43 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 576255D9CC;
 Mon, 26 Aug 2019 08:21:40 +0000 (UTC)
Message-ID: <117a307ac9ec4169d173eb80e68288a89d181386.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: =?UTF-8?Q?K=C5=91v=C3=A1g=C3=B3=2C_Zolt=C3=A1n?=
 <dirty.ice.hu@gmail.com>,  qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 11:21:39 +0300
In-Reply-To: <9db7233c490836c221bab463305d08e34db9f037.1566779143.git.DirtY.iCE.hu@gmail.com>
References: <cover.1566779143.git.DirtY.iCE.hu@gmail.com>
 <9db7233c490836c221bab463305d08e34db9f037.1566779143.git.DirtY.iCE.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Mon, 26 Aug 2019 08:21:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] audio: paaudio: fix client name
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

On Mon, 2019-08-26 at 02:29 +0200, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n wro=
te:
> pa_context_new expects a client name, not a server socket path.
>=20
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
> ---
>  audio/paaudio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index bfef9acaad..777b8e4718 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -866,7 +866,7 @@ static void *qpa_conn_init(const char *server)
>      }
> =20
>      c->context =3D pa_context_new(pa_threaded_mainloop_get_api(c->main=
loop),
> -                                server);
> +                                "qemu");
>      if (!c->context) {
>          goto fail;
>      }

Also tested, and this works.

May I suggest though to make this configurable as well, for the sake of
usability since gnome sound settings show only the client name, and it
is per each sound card.
Although on the other thing the client name is qemu.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky



