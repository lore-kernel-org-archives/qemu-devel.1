Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE8EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6B52067B
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="F1VWM23H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6B52067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jheYx-0006pa-Lj
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jheL8-0004hq-V8
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:18:46 -0400
Received: from mout.web.de ([212.227.17.12]:57427)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jheL7-0005do-No
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591471097;
 bh=M2wUbERBYXkG9+JKl52v0XU9Jkn+Ar+DrSWBvHw2TRs=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=F1VWM23HU3KMePOYdou/mvm4D44+ZR1wLRyk9F1jz5gxR5yBmieMsAyrSrQBvtTSp
 LDlBY6KsArpAbUvEDyyQfneGdYnxZx5SRS0IAu0YWcrVq/dHk8RMG4C+c7ZUf6tBmA
 +w4SWlPXA0HCdXhRwQgBohsC/iG667zagQO1lTIc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.73]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M57Vi-1ikbgt1x42-00zFj1; Sat, 06
 Jun 2020 21:18:17 +0200
Date: Sat, 6 Jun 2020 21:18:16 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 6/7] configure,Makefile: Install colo resource-agent
Message-ID: <a1ec11b307ce158a6101c4fe30a9cb4591d29004.1591456338.git.lukasstraub2@web.de>
In-Reply-To: <cover.1591456338.git.lukasstraub2@web.de>
References: <cover.1591456338.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C6NBoAG9r4uHDmHjzHFIVx0";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:O1sxOPo1cfXbWRMsgDzY+tHhX+15cbpW1Gp4bUWbhdG3VuFw6RC
 JFQpLwydxvmbHUi5NWaa/nt9f/wV3CmjBhGSo4ASUSz3Q+IMfkSDxvDS4rEBnReb/YHalLy
 vFanEkyb2CHwqxaJH6/T6aVM9KJuZ8TpPZbwXKoqVVu3Add9BTzOraPV53CO7U7uvOJE9Xt
 VhlKuCJBq3wIiVmcuvhqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7FYAYU9faS0=:pV857PrqQavR9e5dxCZhcT
 NFREqDqqK7ZB7zvZdjwbYSl+Ib8iwqofSGyF9Vt+tAjByV5tkRfwhXdSoALIYS5n826rjT4Jt
 aqxOtOgEILlRvgyKxQVvWAfnE9pNyvFl4KwANzhPhpWj+s7xRWCUCDSsxA4xiWQJuKNBj9aA0
 6sAsmORWsITO/wB7hq1V6mbI6IY1eFCKCvnuk7+aDe8dXjKFeeWmwbat/BkSWN8OyWGoqoHVE
 H/5jEzsm+EHs6+BSERohAIJgWvg+F6bHXrL1BjOpb5cf38f7sQ0yewhZvSqSn43nnAfrFf7o/
 wzdIrh/F4OnLK29faLx1fV9kmkSexzOlRnhrOq5zb3Qm1Ursq9/iN9CeKms8nbb36Pytx8le3
 miKdk5IUNxG78NhUTOKadYl9dw1Juu2mLMezZyBq+pRRdIJKMg1Z6Ign6/Ub2JcSZeAlkebGb
 zPZYptJ9WXMC0t153fh7+OHH6ZScxdVXXiI0seuxcQzupNcPiFT2gHsGnjWhrKaxyR2nbhlvw
 Vgzomqjpgd4pcSr/GFs0I4fVrmOSHOQy7szcGroETU+VwW2ScEI62jjEiQ9rKyGOwY3awEffn
 4yvW2LdgvUMFIy1eSKLPoGx6L1XWPoknsK1p0G83pgyPqLSEUZGLyPQ9GRHy5Oe8iAOYW+Lwo
 CBt7JyL/vif/OwKkZVaz9SHnFUpFpGgRONN7Ac06vW8B/77MgzD4WXtMqi+8salzrydIwe3gj
 8Zu0DlH8MWzbagEC4qeBFjV3+ke7ayL7/b5HIBg4KITdZtpccUbIHT7ISm+0GBM8j3pVetj6A
 PbRj5cxhR6SVHkb41pXui28BTDXbUZ37wr1Sp9wYE0G59KjVLTVIsZevMNrbkK/LbYmDXxIXM
 Usl2lN1K1jhcrvgdrAwVhtyrEtTD6WuXRRnnf+YaE+NqnOdkMOL87HR/whggglf4lRPXNr4JF
 VHOID+tm/vsvEZbhv6mrHoU6FZw5scgfmrFaaul3T/5cYNqenQ2A916wdlnm6iZpyrWBpzzEh
 J+UEktjzV6sAExsV1aCKh+rLtONEA8XWlMFgTPrfOTLFCs4dKuCFBYY2e4TmlpP7S/wleTSu3
 d2zJFul3SjS+tJu406rKRZpY52VwPkaGCsB/MPzT3WkI0WQT6wFtg67Raq/QNvoB+/R5ImRu+
 hxrhvCtnoALdgM15b+SopjdEojKzy0IWXgAXJ/nnv0QSDlvsegh14IcTlbxDz31D25NBFXpoz
 qP854NvmJ61/d/FIc
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 15:18:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--Sig_/C6NBoAG9r4uHDmHjzHFIVx0
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
index 8a9113e666..2ebffc4465 100644
--- a/Makefile
+++ b/Makefile
@@ -973,6 +973,11 @@ ifneq ($(DESCS),)
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
index 23b5e93752..c9252030cf 100755
--- a/configure
+++ b/configure
@@ -430,6 +430,7 @@ softmmu=3D"yes"
 linux_user=3D"no"
 bsd_user=3D"no"
 blobs=3D"yes"
+colo_ra=3D"no"
 edk2_blobs=3D"no"
 pkgversion=3D""
 pie=3D""
@@ -1309,6 +1310,10 @@ for opt do
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
@@ -1776,6 +1781,7 @@ Advanced options (experts only):
   --enable-gcov            enable test coverage analysis with gcov
   --gcov=3DGCOV              use specified gcov [$gcov_tool]
   --disable-blobs          disable installing provided firmware blobs
+  --enable-colo-ra         enable installing the COLO resource agent for p=
acemaker
   --with-vss-sdk=3DSDK-path  enable Windows VSS support in QEMU Guest Agent
   --with-win-sdk=3DSDK-path  path to Windows Platform SDK (to build VSS .t=
lb)
   --tls-priority           default TLS protocol/cipher priority string
@@ -6647,6 +6653,7 @@ echo "Linux AIO support $linux_aio"
 echo "Linux io_uring support $linux_io_uring"
 echo "ATTR/XATTR support $attr"
 echo "Install blobs     $blobs"
+echo "Install COLO resource agent $colo_ra"
 echo "KVM support       $kvm"
 echo "HAX support       $hax"
 echo "HVF support       $hvf"
@@ -7188,6 +7195,9 @@ fi
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


--Sig_/C6NBoAG9r4uHDmHjzHFIVx0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7b6/gACgkQNasLKJxd
slhIoQ//dLzLi8/Adnqd9wp7sxtQrOBotPXEaBg0ASiZ+MVF6pbvKR3XdSxL5FlC
1Wze8gNizQwQfmJsthxd3ix0ugudjqy1u4qTj8HkGgxiW1XZDz/PPbBBGx50msaN
ejlPesOIrc3+3see3VWXfvAza/8ktvu+A/SOkDeWtOaPf8ozfOsvzp+KMVWBKu3p
987qMQVINPKa+W8xm+/arZeTp13YlBiwANfi/p7gdnGIEk9ZLfOokFNjZ2jBdjIQ
iiuF/IIQdpbzPe1HhBk4Lkmu9sLWzo2bZXRNfaOxDgy4FFWdVPzebeePUC9ZUnqU
gcZbIUlutU9uCLFLa6GzOpyxCZct5QT5Dr4QIGazgGGU2hPMlzPoyo3sJ1bm3+g/
nUpGa8Ay9kWWdHNVdzf2nSZeQ/AukT+4j1eFA2IJszjK5ml9vDGlbaonOF0qJnF8
Ql1kgBIRlQ27D+TPKKIMyVcPkCFXcHlyBSFPvPNeKuCeQp93I4IXQUOtx9jEGbya
cHkKL0IKFPvyQ3E0TYmb/XUZbxQ05jfZN96gpBYACZ9Z8UwZxbIDaEx2jgj97kbT
4GLfew+x7ZCOUhPS+e5LQljfIlIeVD4EKiJvxlba4qIHgf1gAfRJ998lzZpSLy+m
BfRrTNERKbHKDaJhnVN8D6TRXdZ7ct8PsaaCLema4ptTEPljb8U=
=JArT
-----END PGP SIGNATURE-----

--Sig_/C6NBoAG9r4uHDmHjzHFIVx0--

