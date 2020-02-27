Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E054AC11D3D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A122469B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 17:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJgxlTQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A122469B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7MiK-0001aO-TJ
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 12:12:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j7MhX-00014h-Dk
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:11:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j7MhW-0002pE-DG
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:11:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60981
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j7MhW-0002p3-7O
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 12:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582823513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C/bwEV6N/6SLHHEHo4L7ef+gE9c47gthlpme7V+Sq1k=;
 b=OJgxlTQKGzGU0+nIZBp9apOf+9iK+Yfm58QmHOl8GD9K8MakkAQqvsrUwEOhuzzXpX96EV
 ds+zIFuwNl1k5OH/A1bslAP9mDGwpbPTA4TFBTVPgOiz9i5PT3bPJuNrHrukvml3Hpq8Zz
 QEyiezRsSTN5rw6Skg/uRV5c0bFqJMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-s_yYK3PVPWmmsudRe5Wieg-1; Thu, 27 Feb 2020 12:11:49 -0500
X-MC-Unique: s_yYK3PVPWmmsudRe5Wieg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 975A4802562;
 Thu, 27 Feb 2020 17:11:47 +0000 (UTC)
Received: from localhost (ovpn-117-38.ams2.redhat.com [10.36.117.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10B6E9296C;
 Thu, 27 Feb 2020 17:11:41 +0000 (UTC)
Date: Thu, 27 Feb 2020 17:11:40 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH v5 49/50] multi-process: add the concept description to
 docs/devel/qemu-multiprocess
Message-ID: <20200227171140.GF315098@stefanha-x1.localdomain>
References: <cover.1582576372.git.jag.raman@oracle.com>
 <b6a030f0a81a1129b853c30a4c10def606a53089.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
In-Reply-To: <b6a030f0a81a1129b853c30a4c10def606a53089.1582576372.git.jag.raman@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, thanos.makatos@nutanix.com, rth@twiddle.net,
 kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 03:55:40PM -0500, Jagannathan Raman wrote:
> From: John G Johnson <john.g.johnson@oracle.com>
>=20
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> ---
>  docs/devel/index.rst             |    1 +
>  docs/devel/qemu-multiprocess.rst | 1102 ++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 1103 insertions(+)
>  create mode 100644 docs/devel/qemu-multiprocess.rst
>=20
> diff --git a/docs/devel/index.rst b/docs/devel/index.rst
> index 4dc2ca8..1a95871 100644
> --- a/docs/devel/index.rst
> +++ b/docs/devel/index.rst
> @@ -25,3 +25,4 @@ Contents:
>     tcg-plugins
>     bitops
>     reset
> +   multi-process
> diff --git a/docs/devel/qemu-multiprocess.rst b/docs/devel/qemu-multiproc=
ess.rst
> new file mode 100644
> index 0000000..477e246
> --- /dev/null
> +++ b/docs/devel/qemu-multiprocess.rst
> @@ -0,0 +1,1102 @@
> +Disaggregating QEMU

Please revise this document and the patch series to use consistent
terminology.  At least "qemu-multiprocess.rst", "--enable-mpqemu", and
"disaggregated QEMU" are used to describe this feature (there are
probably more, I have only looked at 2 patches so far).

It's confusing for someone who stumbles across one of these terms and
then has to figure out that we're talking about the same thing when
encountering other terms later on.

Please use a single name and use it consistently.

> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +QEMU is often used as the hypervisor for virtual machines running in the
> +Oracle cloud. Since one of the advantages of cloud computing is the
> +ability to run many VMs from different tenants in the same cloud
> +infrastructure, a guest that compromised its hypervisor could
> +potentially use the hypervisor's access privileges to access data it is
> +not authorized for.
> +
> +QEMU can be susceptible to security attack because it is a large,

s/attack/attacks/

> +monolithic program that provides many features to the VMs it services.
> +Many of these feature can be configured out of QEMU, but even a reduced

s/feature/features/

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5X+EwACgkQnKSrs4Gr
c8gfwwf9EO2qrxovaGOiXwn2B9bb2wkU5P7aKjMasHSfAEs1YHkBAjGBAptwleiR
cRwx/BjNw5Zcu/+lS0Z/ac+f0DO3IRs1tqdMULKGYg3CanXbjKvk21cQrj6UsxWh
KUFbwf5JGHiXSCMQxIfuysey7n7B19za6kjHJbIeJUwfxKireWW9D8JcwlWtPh66
rCfHZemcXPJEwnxwxGUZ0MfHwpTgmcdzKRbCv/tRYw7s23Oyc2/kY1KWOHIsTKiF
eO9smVOn4y0n3cNeYN+InjR4Rdb9OZOpfGfG2gsB8uIKc8sGSyhshxGyJBauj+jQ
TwX6E4zi28eCD2HssDcI0D/zza01Tg==
=Pv7s
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--


