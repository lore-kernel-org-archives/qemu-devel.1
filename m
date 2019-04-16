Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D04FC10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 14:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E58223F0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 14:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E58223F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37618 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGOuh-0006Ld-KR
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 10:18:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1hGOti-0005zv-JC
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phrdina@redhat.com>) id 1hGOth-0004ES-FG
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:17:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <phrdina@redhat.com>) id 1hGOth-0004BR-4l
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 10:17:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 369E0C0467E4;
	Tue, 16 Apr 2019 14:17:14 +0000 (UTC)
Received: from antique-laptop (unknown [10.43.2.63])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DA24A5C22C;
	Tue, 16 Apr 2019 14:17:02 +0000 (UTC)
Date: Tue, 16 Apr 2019 16:17:00 +0200
From: Pavel Hrdina <phrdina@redhat.com>
To: Pu Wen <puwen@hygon.cn>
Message-ID: <20190416141700.GR18986@antique-laptop>
References: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a+0P3INHs7aeI7wh"
Content-Disposition: inline
In-Reply-To: <1555416373-28690-1-git-send-email-puwen@hygon.cn>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 16 Apr 2019 14:17:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] i386: Add new Hygon 'Dhyana' CPU model
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com, qemu-devel@nongnu.org,
	ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190416141700.j_8mG5sWdFYDU0Rzxprt3ZT7axUYQMc7JDZcD7EmUz0@z>


--a+0P3INHs7aeI7wh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 08:06:13PM +0800, Pu Wen wrote:
> Add a new base CPU model called 'Dhyana' to model processors from Hygon
> Dhyana(family 18h), which derived from AMD EPYC(family 17h).
>=20
> The following features bits have been removed compare to AMD EPYC:
> aes, pclmulqdq, sha_ni
>=20
> The Hygon Dhyana support to KVM in Linux is already accepted upstream[1].
> So add Hygon Dhyana support to Qemu is necessary to create Hygon's own
> CPU model.

I have once question that we will have to solve for EPYC CPUs as well.
The name should not be based on the Product name or Model name as that
usually doesn't change with introduction of new microarchitecture.

With EPYC we made a mistake to name the CPU like that, luckily with
Intel we already use the microarchitecture name, so the EPYC CPU should
have been named ZEN-Server and for Ryzen CPUs there should be ZEN-Client
if there is any difference or otherwise we can simply use ZEN.

The issue here is what happens once the ZEN2 microarchitecture is out
wihch introduces new features and we will have to come up with a CPU
name.

Obviously we cannot change/remove the EPYC models so the question is
what is the difference between the AMD EPYC CPU and this new Dhyana CPU
if they are both based on the ZEN microarchitecture?

In addition is there any way how we can introduce ZEN-Server &
ZEN-Client or simply ZEN, if there is no difference, as an alias or a
new model next to the EPYC?

Pavel

--a+0P3INHs7aeI7wh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAly149wACgkQUi1kczAH
4Yxf5xAAkQS4kdIN1qUNuNUjj6siAcoXDVfzlLrqFuXSdfAuUMqmA7oYSpCfrf5x
bqhWGlHCqkCx60txwJ++6YchHrh5Z6aM5oH0+uZpOENabgRfEYIrRZm8QBfesak4
G/Li57eCfTkhuNOX3cXDFQ9S/1vYkAW7RnLuWwZCmI+26iKotmB3bggVd3vYSyqd
j2vjbDL775TLN+zI+An77PYHGjnfqD/FoxOmL8yzrtYnp09uLGg3cCVtwOLnHsI4
RaT7HfI2Ig6jKy1FApQAKZveHuw4rl6NqfHEPD97iuS66lRHU8Y671JcPFfWdb9/
0c9wc+bbqbCN4Vr0m/LWe+NFIyk3DD2fiKWISnpKS3rafXtH3UAdzHh7qQds+8tI
2vtRCY8tOmLO3/OJ4g8dLDlAZ4WX/UFskaVr5Oib3GmUOAQbncE8K7OMQJiQ7QP0
ukusFCa8f0w/NcCujsZ7IuDF9SDOOzqUFQk1LjXL0s7eSWj9/c2eFxV/gaLCYxjE
cnIb56B6x9LmagpZBwOK19VD3HiUrMdjsLmJ1Fene50r/jn/JRd56BqMx1bXhwSo
CJf5Vc2gFwLQHJicY7DZJJobC+UNv6hh/IlcgxcwVZDaqeXyYv++u3opM57dVGKt
YMDTht9T4rCApNhfl8JVnnBoGbX0/5p/9jAFa/BYxZe7SUGosw0=
=6FWe
-----END PGP SIGNATURE-----

--a+0P3INHs7aeI7wh--

