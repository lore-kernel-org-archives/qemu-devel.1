Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB43C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 11:06:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3611206DA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 11:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="h9HAoLYf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3611206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2ulx-0001PY-NT
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 07:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2uTn-0000zi-Rv
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:47:35 -0400
Received: from mout.web.de ([212.227.17.12]:40481)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k2uTl-0003cF-Qe
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1596538029;
 bh=O/7XckwoOtMpoz1hmSWxudDgqLsR2nByhlKynLe0Tck=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=h9HAoLYf48VPacbRoKDCuF1BdqNrd2TTKk+/YD3/FWJgYKn6Y/U9AO2MD6a5f/rfF
 xCbGR/41ruN7+BrTLqnZOwFKEHpUPaC9XlvtC8Jfzxcr9LJJjeBCXjfs5Eaqw0tsfn
 4DmuYnafQC5hbzlzKxH04FRjMJHySLEmjNfCFEog=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.220]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjBRn-1khRtI0o7R-00f8fd; Tue, 04
 Aug 2020 12:47:09 +0200
Date: Tue, 4 Aug 2020 12:47:06 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v3 6/7] configure,Makefile: Install colo resource-agent
Message-ID: <108a9f4106fcc52f089c9bded571d46f79929235.1596536719.git.lukasstraub2@web.de>
In-Reply-To: <cover.1596536719.git.lukasstraub2@web.de>
References: <cover.1596536719.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OzzWLfXsGOAlOtCfcgn/=9S";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:724UH4ULdnYgsHHqfGjtg9VMHrOiuTi4sSyc4of7UxUnvwKXJ0x
 SVLhrcIuwm42CN3CIVf2EkGpIRyYzAJ2G5tsn1knnGa7b50IQtqejy8Le6FZEEoA0Y+PEFU
 Adm3g7CkGVK4ETLWMssoOqNFWJfPwgJJ9g8WG51nt5LXvdNivRdghguBBzzStmhmqAAwm5E
 9b2GIpI+/+jGcBv2rOr9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i+iLXdHYT+Q=:2f9AM3uQh6Sh3vg30gbEP+
 ZVI2YOxcHRpzxJvdw7t5K6V/ZBrKyPreuGyJfiWA5s8FqirMVpt9MagYPvydR3srkFtMmoy88
 hfynTfmrpjRoT0kO6W43sE4b3w5EB7pED0as4YCrTAvmYHWPNm/QI2WUhV8Pighr0Gej/DHCD
 C/8RHoV9PkTjQPVaTBl2xOpmL1KPsITICtcGHJRvVwHDBn+vrVBBX/VpLaNad+yhTUyHGlOII
 fFU/Dbm3WNHPOab9AyucuHjhN8n4MdAupIiCR0DyauBs2ZrcM4Uh0tylqbTcPbVrX61GND7JK
 JclL9ghhK86BM28dnOcEB8S/1lheXD1rDXVNGuAy20mHGPbzxlPbtfCJzcaPl7CoToJ6mVWPI
 M73dgg4IOS877PQ68NewroI6hrKUSPsmkLyRuUJJStZSzlv9m7xBChfowzcL0RnEhQfIkN9OA
 ds39ncJ3EKG1f4gdY7VSozv4s4jGWFLnC9RG01h3UBiweSxNv/39kXClz/9ZAk2HTGaDP8wIy
 sHJyP6+qnYIs6VJrcz17YS5MvXDRaAm1t8ijXaZ4uS2EfLZ+K1opI3oF3YDCjJ58Yab1+jkEq
 Tu3msfUCIO1wuhDjZsUBbGxbapGU/TkBg58B0PzUhFymxiWsvmT14pV8P1a2wCnuW8gg4478m
 s/ZjNpJ1vcKCl0M4+BoV+m9AVqB5M24l5EmHn24VzZxJXS8GydsBWfuewqHdGyLtYWGdZimIc
 pqX+QT070LsqOruiyVbBkRHTnoBzTbMI+ZQDpEnJoFqVi/aBpHNfQXQWuHaXhxoNnDyCSA3oa
 Ptvg0oN/AIx6rKI3T/FlMyWwRzfDTuD8z5PkUVCBnkpZQhYzi8Mcm4uR0wjahq4n2mUt46WYb
 /KBIPcdci6biU8qAN6mJOk3k8BGIjPTSyyjCMcC0nh/zol1Y2lLkN9/qpqmzojhkRpnu/qDUV
 2Qme/0MlLwQ43uifL9gD7F3tWYApVKEjtPAmGZG1M3saz1KNIWfm+HDLfgxSd8d/AOBQnNrP8
 YJGp9bvGKKaw92hQkO7z/w3F/26yECpTQ1vX970yL+f5ZDTw2xEGgng3Vgl+MSYQj1XAgIU7y
 jICdP7IbIpet4GHJBlZWJHrxaNx11fGFjC3+2Iiz//6rAW6EF7FbN/eGhxf6Jf4NZGLnnmtIP
 oKuLGQzMkiMREkp30N5KFwvMMO+Ed/fwD32r1lPh+id13XhKd1wCuuDGys7s+lJ5Sl2ff/BPJ
 3eLdp9+IyaZ9vHSQNBasUQj9vVCHZ5jcPpsG3aw==
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 06:47:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/OzzWLfXsGOAlOtCfcgn/=9S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Optionally install the resouce-agent so it gets picked up by
pacemaker.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 Makefile  |  5 +++++
 configure | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Makefile b/Makefile
index c2120d8d48..dccc20b120 100644
--- a/Makefile
+++ b/Makefile
@@ -969,6 +969,11 @@ ifneq ($(DESCS),)
 		$(INSTALL_DATA) "$$tmpf" \
 			"$(DESTDIR)$(qemu_datadir)/firmware/$$x"; \
 	done
+endif
+ifdef INSTALL_COLO_RA
+	mkdir -p "$(DESTDIR)$(libdir)/ocf/resource.d/qemu"
+	$(INSTALL_PROG) "scripts/colo-resource-agent/colo" \
+		"$(DESTDIR)$(libdir)/ocf/resource.d/qemu/colo"
 endif
 	for s in $(ICON_SIZES); do \
 		mkdir -p "$(DESTDIR)$(qemu_icondir)/hicolor/$${s}/apps"; \
diff --git a/configure b/configure
index 2acc4d1465..39051d25f8 100755
--- a/configure
+++ b/configure
@@ -438,6 +438,7 @@ softmmu=3D"yes"
 linux_user=3D"no"
 bsd_user=3D"no"
 blobs=3D"yes"
+colo_ra=3D"no"
 edk2_blobs=3D"no"
 pkgversion=3D""
 pie=3D""
@@ -1336,6 +1337,10 @@ for opt do
   ;;
   --disable-blobs) blobs=3D"no"
   ;;
+  --disable-colo-ra) colo_ra=3D"no"
+  ;;
+  --enable-colo-ra) colo_ra=3D"yes"
+  ;;
   --with-pkgversion=3D*) pkgversion=3D"$optarg"
   ;;
   --with-coroutine=3D*) coroutine=3D"$optarg"
@@ -1821,6 +1826,7 @@ Advanced options (experts only):
   --enable-gcov            enable test coverage analysis with gcov
   --gcov=3DGCOV              use specified gcov [$gcov_tool]
   --disable-blobs          disable installing provided firmware blobs
+  --enable-colo-ra         enable installing the COLO resource agent for p=
acemaker
   --with-vss-sdk=3DSDK-path  enable Windows VSS support in QEMU Guest Agent
   --with-win-sdk=3DSDK-path  path to Windows Platform SDK (to build VSS .t=
lb)
   --tls-priority           default TLS protocol/cipher priority string
@@ -6930,6 +6936,7 @@ echo "Linux AIO support $linux_aio"
 echo "Linux io_uring support $linux_io_uring"
 echo "ATTR/XATTR support $attr"
 echo "Install blobs     $blobs"
+echo "Install COLO resource agent $colo_ra"
 echo "KVM support       $kvm"
 echo "HAX support       $hax"
 echo "HVF support       $hvf"
@@ -7496,6 +7503,9 @@ fi
 if test "$blobs" =3D "yes" ; then
   echo "INSTALL_BLOBS=3Dyes" >> $config_host_mak
 fi
+if test "$colo_ra" =3D "yes" ; then
+  echo "INSTALL_COLO_RA=3Dyes" >> $config_host_mak
+fi
 if test "$iovec" =3D "yes" ; then
   echo "CONFIG_IOVEC=3Dy" >> $config_host_mak
 fi
--
2.20.1


--Sig_/OzzWLfXsGOAlOtCfcgn/=9S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8pPKoACgkQNasLKJxd
slhsJw/6AwNjh/hzP/v1Zq10/FlLGnvIDqTp0YmVUsPwAcflnU29z3W5dHpkiLR3
/Uq2rnz3o0yp6988I0IDXe5uh2RANnq1RTc+8VK4xJwfQdDM4pXsO7iaNMLSfQ0z
peuLHmy+TWGLCvAoyytpk1bf7ioIA6VeVdz77xXI1Zs9pbw7FatcCWqr/Fbq4m7d
J1AU2OhmM4Ud3y+SjhALX+co3BSaXRM9iYXgZYBQI7z5fE4hj3q5ZvQPcsh4tvsJ
bcVpFYAipaRUlVGiim5KDp/CZcOM7YESHmEMbasWrRnJfbt6s7xlpVTrZ1RABMMH
8vka+roZuBFe/b7TsaZvZfTfMYMzjkzyoQt8b7jHG+CgigCdAdBjH5cddjuOAlXR
9cAndZ2IdSM3AUaJhQFc/ioD17ORqffhLPxheIY/09Vxs/oGga291iHsQKl6SJMW
zT8LaYUpXamg5P3G1EmiJesB21/TwCfe0Y+8K25iSB/74vrcxI3iarz+n6DEZSBr
hELiCxI4Uj8WSkMnq4Z68YG07STLWMyv8od0Qt02lylojaEWkdn79LCI6XA5k8VQ
RD4PaEjLAfmCyJ44+ExDFprcZBA2gr2b9vN12jVZ7jEbWKzbaDzCHbgNlSEczWsm
t1fZAsHzHT9K0vBkvewxS6gBBMGJpWXsvSL/PUf4KRgG0C3vIKg=
=yOS+
-----END PGP SIGNATURE-----

--Sig_/OzzWLfXsGOAlOtCfcgn/=9S--

