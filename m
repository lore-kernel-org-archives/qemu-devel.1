Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A12FC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FEFD206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEFD206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tKp-0005CI-IY
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i9svz-0003Dk-4z
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i9svw-0000Ta-Bv
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:28:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59554)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1i9svw-0000Sm-5t; Mon, 16 Sep 2019 11:28:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D5C290B24;
 Mon, 16 Sep 2019 15:28:54 +0000 (UTC)
Received: from localhost (unknown [10.36.118.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11D445C1D6;
 Mon, 16 Sep 2019 15:28:53 +0000 (UTC)
Date: Mon, 16 Sep 2019 16:28:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190916152852.GB5683@stefanha-x1.localdomain>
References: <20190912131011.6255-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
In-Reply-To: <20190912131011.6255-1-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Mon, 16 Sep 2019 15:28:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hw/*/Makefile.objs: Move many .o files to
 common-objs
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2019 at 03:10:11PM +0200, Thomas Huth wrote:
> We have many files that apparently do not depend on the target CPU
> configuration, i.e. which can be put into common-obj-y instead of
> obj-y. This way, the code can be shared for example between
> qemu-system-arm and qemu-system-aarch64, or the various big and
> little endian variants like qemu-system-sh4 and qemu-system-sh4eb,
> so that we do not have to compile the code multiple times anymore.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/adc/Makefile.objs     |  2 +-
>  hw/block/Makefile.objs   |  2 +-
>  hw/char/Makefile.objs    | 16 ++++++++--------
>  hw/core/Makefile.objs    |  2 +-
>  hw/display/Makefile.objs |  2 +-
>  hw/dma/Makefile.objs     |  6 +++---
>  hw/gpio/Makefile.objs    |  8 ++++----
>  hw/i2c/Makefile.objs     |  4 ++--
>  hw/i2c/ppc4xx_i2c.c      |  1 -
>  hw/input/Makefile.objs   |  6 +++---
>  hw/net/Makefile.objs     |  6 +++---
>  hw/nvram/Makefile.objs   |  2 +-
>  hw/pcmcia/Makefile.objs  |  2 +-
>  hw/sd/Makefile.objs      |  8 ++++----
>  hw/ssi/Makefile.objs     |  4 ++--
>  hw/timer/Makefile.objs   | 22 +++++++++++-----------
>  hw/usb/Makefile.objs     |  4 ++--
>  17 files changed, 48 insertions(+), 49 deletions(-)

Nice.  Again, I think the poisoned symbols would break compilation and
CI would tell us if any changes made in this patch were incorrect.
Therefore, looks good:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1/qjQACgkQnKSrs4Gr
c8hz2gf9EwjsM8w9vx1FBwHaBcLjqqoUcCzhZRS7r0Eoh6HCikKADY2fp85vW79f
/5GLBDrCP/2ZSSU1jJa+B3FNpe1pagBD5Bypc+R4Tvw8kOnVakzlvgHOYVYzhenF
GkzlGWhx5fPv/mOuwtnryKFZrNV+RXEqQNiH1OA05zHqWimuK2jIbyLT2O4ivu7K
wAtNlVCctl85YXjcQmZOQXyGOtTcHddM2mNIgCENBXtX4b6E18YXLKtVh50jtJpm
vFZ6r9Ai9E+xxC0VtvHqtI22lzz+RQ5wG/klULuptbUVIFdxBL12FdBbRCt/CtTm
Qzqh9y1f3Ei3nNasN5NJG2qGKHiXWQ==
=7+Dv
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--

