Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8001DC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 11:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547FE205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 11:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547FE205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Zdy-000169-DY
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 07:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i2Zcf-00005w-IG
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i2Zce-0005EW-9Z
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:26:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59790)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1i2Zce-0005Dn-3y
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 07:26:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 642C43084242;
 Tue, 27 Aug 2019 11:26:47 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 505175C1B2;
 Tue, 27 Aug 2019 11:26:43 +0000 (UTC)
Message-ID: <63ac8d96328866229cbe51aaff26991d151e6a73.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?K=C5=91v=C3=A1g=C3=B3=2C_Zolt=C3=A1n?= <dirty.ice.hu@gmail.com>
Date: Tue, 27 Aug 2019 14:26:43 +0300
In-Reply-To: <20190827053756.jir3fpid4l5e5vc3@sirius.home.kraxel.org>
References: <cover.1566847960.git.DirtY.iCE.hu@gmail.com>
 <f7c0fa20f3ee3c10409bde0d474fc2a47177838d.1566847960.git.DirtY.iCE.hu@gmail.com>
 <20190827053756.jir3fpid4l5e5vc3@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 27 Aug 2019 11:26:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 3/4] audio: paaudio: fix client name
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

On Tue, 2019-08-27 at 07:37 +0200, Gerd Hoffmann wrote:
> On Mon, Aug 26, 2019 at 09:59:03PM +0200, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=
=A1n wrote:
> > pa_context_new expects a client name, not a server socket path.
> >=20
> > Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail=
.com>
> > Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  audio/paaudio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/audio/paaudio.c b/audio/paaudio.c
> > index bfef9acaad..777b8e4718 100644
> > --- a/audio/paaudio.c
> > +++ b/audio/paaudio.c
> > @@ -866,7 +866,7 @@ static void *qpa_conn_init(const char *server)
> >      }
> > =20
> >      c->context =3D pa_context_new(pa_threaded_mainloop_get_api(c->ma=
inloop),
> > -                                server);
> > +                                "qemu");
>=20
> qemu_get_vm_name() would be a better default (returns the name set by
> the user using "qemu -name $whatever", can be NULL if unset).

That is exactly what I was thinking about this too.
Best regards,
	Maxim Levitsky

>=20
> cheers,
>   Gerd
>=20



