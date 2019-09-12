Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB2AC4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 330A320830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330A320830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8QJ5-0002wU-1S
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i8Q8J-0003G2-N1
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i8Q8H-0004AK-7H
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:31:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49034)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i8Q8G-00049A-W9
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:31:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 476DF18CB8E7;
 Thu, 12 Sep 2019 14:31:35 +0000 (UTC)
Received: from localhost (ovpn-117-48.ams2.redhat.com [10.36.117.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 802535D9CA;
 Thu, 12 Sep 2019 14:31:28 +0000 (UTC)
Date: Thu, 12 Sep 2019 16:31:27 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jagannathan Raman <jag.raman@oracle.com>
Message-ID: <20190912143127.GL23174@stefanha-x1.localdomain>
References: <cover.1567534653.git.jag.raman@oracle.com>
 <aef3fada5cd53cd16dfb485c33407d8b2b5e41b6.1567534653.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ai3I8gwHc37+ASRI"
Content-Disposition: inline
In-Reply-To: <aef3fada5cd53cd16dfb485c33407d8b2b5e41b6.1567534653.git.jag.raman@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 12 Sep 2019 14:31:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v3 PATCH 05/45] multi-process: Add config
 option for multi-process QEMU
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 mst@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com, quintela@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com,
 mreitz@redhat.com, ross.lagerwall@citrix.com, marcandre.lureau@gmail.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ai3I8gwHc37+ASRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2019 at 04:37:31PM -0400, Jagannathan Raman wrote:
> @@ -1543,6 +1544,10 @@ for opt do
>    ;;
>    --disable-libpmem) libpmem=3Dno
>    ;;
> +  --enable-mpqemu) mpqemu=3Dyes
> +  ;;
> +  --disable-mpqemu) mpqemu=3Dno

A previous patch used "remote" instead of "mpqemu", which is confusing.

"mpqemu" seems reasonable.  "remote" is too generic.  Can you use
"mpqemu" everywhere?

> +  ;;
>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -1842,6 +1847,7 @@ disabled with --disable-FEATURE, default is enabled=
 if available:
>    capstone        capstone disassembler support
>    debug-mutex     mutex debugging support
>    libpmem         libpmem support
> +  mpqemu          multi-process QEMU support
> =20
>  NOTE: The object files are built at the place where configure is launched
>  EOF
> @@ -6481,6 +6487,7 @@ echo "docker            $docker"
>  echo "libpmem support   $libpmem"
>  echo "libudev           $libudev"
>  echo "default devices   $default_devices"
> +echo "multiprocess QEMU $mpqemu"

multi-process (see above) or multiprocess? :-)

--ai3I8gwHc37+ASRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl16Vr4ACgkQnKSrs4Gr
c8iQmQgAyZx4BdvPfJHzpJZAOtIRhBsW9m/X0fFyVMbitXlMt8vP+BCiqyukO3zA
pf5k6lFo2ThZn94hkxMUmCjCyHmWQ+G2XOzEoGSq0JK71DajP0cu0eQXSeWPPtmV
p0EnkDaUMd//IAXfpPTj51KzHwujvTnLKAHgSFC+GdjX5/1+csyxlQsQxBEv6gfQ
9imFYpWtB8nvNPeSfeniskszcciQTLZZf1BoABkXaL98B7Ene9J5oWV+8K/QGaMq
WlU3mOLedGusI4WS9cWu+tX/zl0kVE3GSvqb89W2sINbkwDoPBkVtP7pzzgvINiX
RzYLSYURCEiQE8YM6srXKkm9WPFOgg==
=LA7j
-----END PGP SIGNATURE-----

--ai3I8gwHc37+ASRI--

