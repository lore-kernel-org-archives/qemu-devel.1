Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EC2C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:38:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80291206D6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="q3d/oDlE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80291206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY7hI-000461-EM
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 08:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37686)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY7Ww-0006Gu-No
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:27:34 -0400
Received: from mout.web.de ([212.227.15.3]:60591)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY7Wv-00063k-SG
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589200028;
 bh=Rdxixi7KV4eiUZcjalX0wrnXk1aVs2YQ0vK98vYI6WU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=q3d/oDlEOOkPZymhC29pvlAMCIEWksXfdkjcn58o1Mlom7oNQXyB2XymNGCdk84cv
 6rXInsKeWYYIad6RIDpuLmlaws7znUslqWP6rEhiPga5aLt3AZUNwg0eqxMekxB38z
 c2Mgjx+KToamCdHSzTL45Ph5ikIWkao6p5XRKDj4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LhNmy-1ilubk3QxM-00mf4N; Mon, 11
 May 2020 14:27:08 +0200
Date: Mon, 11 May 2020 14:27:07 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 4/5] configure,Makefile: Install colo resource-agent
Message-ID: <334d8321f91f23759ef82a7b904f977003164475.1589199922.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589199922.git.lukasstraub2@web.de>
References: <cover.1589199922.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hyZojprBdL+onStKDkN5i4L";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:kzRApTIPUtXSXuplx1eKea1e2uuM1fGZVxV6CUIhKCpSXo+GlmG
 ZwdaCoxJqxNfnJZB2C/fgG/xkJoDTwerSUv5RBo0dHqWbXPheMRHmmn8NI5auUyUCNZQim8
 kSBvjDDTAyB5BFg3wIi2z8qu2Ps+OeXYGh0WbEMFcVNQJ3/fBGxLICtMREyP7i1AdBITAGQ
 D/RrsVGxey1F7H5v+5yug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A88D/8D1VRs=:w2cXqlouHjy1Yz0HM9EBOV
 QOPXKFPmfH82uHLqR64F+5TrhGjXxDbv61nYNAqKzUaE9INnA1WN01iYmM2IWrTpyxEGnW67A
 lgWQNjc+Rlm/9fzU3Y4GE9zk59HpOu1y81ZoY4Pto2OhTYRksprb6IjIZC8o8Meefw5qx5gsx
 rEvNH4pngsFjEIZGOcLnFUV7jM7cM7JRrTlefbexy1c5S229JLBjzmptLpVJvYXEfbrTFSAlO
 In8hEqI1NV0G+GgItZROEDR8+xJTnItQ1/k1bn6VSaAX1ycai9rwEXcfvpiHRP8NWzCgL9Q2R
 BR0osjGLYVPkm/33cJ59u55xXrlBlgwUtZ2jsAd+YuncyejqOFVO2ryip1uqEhKL7GoOnCU5D
 QBFE/B8TZdx83SC5mRLXn9cUULckj+0z7TlRJvV7x2E7F8KBGeSDBIUNdoDaed/yqN/e40CwA
 fNWtwEpJ+c6wR/mkhpA9ULtl26wCOx5YnVkgOYI/PNw5p6+G2WPouqPlNfpJElTNid/FPLsF8
 s5MCVHkh4EKgg/VC0ko6FxlJrLhePTRecEiHScSOxtEbfa96CI6KJsy+4j9em4Z+UVabyzWM+
 xhXJ61zbKDEu3px/ONhvn9h0I/EzeG9ad6HjQ7s2xBaoLqZGOW3aZKV7/EO/+l8J5Kte4YT7g
 B6c+gvCTOr+ZPSQ8+h21Vs1dmwbxwPVlokOjbkkjMQcEM9g2itIhZcPm0RvAV5h1qoS8WKcus
 up2vlmpTDHpSR9ges2OuuxmNjXnxCy144o3dVxdNucUJ3OyEr+zyOa17DRocaunAtGYU2JV3T
 wwcHcO3FEHfm+dzmkyQqzre1DyEYu5LuucIRn0ZeYcvqltZHqEReZcKm4rsNTe9sPD5Qkxbp/
 2Wf/4rFduxtZnF4wOHbQQqxwtY+VCNFlGGiPLc9h0h0+a6F7kHmHhr98hnI1MdWsxXz+jnFDh
 Do12la1sB6DHoSmiMaHJggwDC4+PR6KtyqmMgDzvfJVM/gU2iMYZJ/xtlPKN+FVLCOBRvJvXF
 4sbBkPhoGXpFGd5vqyifH3Pc5f0Xi3JUP4D1H3DyeF5LWb6XwAY6iwr8DA8KmrhQqxGZFp0TJ
 spliA9btU2+hki9CshlEZylATslbywwKF8067uyhBHEsEJ9rKW3OKs4Gvd7Zp0roGlJ2jawu3
 gXSvrxTXE2WTG83UypElTJ0qkrN1ARPRSbeZGq3u+jP0XSXlWCrjbmOf8/p0+tDDTmQVgMTFN
 gRWLN85ldP6FbgLaC
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 07:11:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: Zhang Chen <chen.zhang@intel.com>, Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/hyZojprBdL+onStKDkN5i4L
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
--=20
2.20.1


--Sig_/hyZojprBdL+onStKDkN5i4L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65RJsACgkQNasLKJxd
slg4+Q/+M9UtlOWcoWKBDO2Te+FUHe5EFvtvtVIGNjUncp4tq5r+rj/TyilkVGrl
OHn8iv1Lakx2QHKKw6rPM0EUfluq5AdeVF2dZbZ53dYrjn6jRKRjmSVoBPmwLQKU
BBHRLnIZOuGIYKTPnx+VFI+UjuBwgRoy5ahmXH3ZWDHu7Qv6A+SCYtXP/PweXNSd
AVwXkNier5KCllwVRBmEuGGkmGES7Lkjfs9t3U5bkxSVkbXeCDs7OGnZdWeUrG8K
CrnS3VbKHnbCf7nJIRH7M58wCxrGPKs+6YbW2ZHJ8x1R15TFFRlIylc/mFZ8NSFQ
IXrajI16t7G07Om0p/C8ftXsBYqvfj78pcy+LqDeqwi3QFNm5w328hwdVWOgVKe3
8n/rDXUGUAdnaiK4WdpOTSvcmeZPOUBQ5V6V9KpVVGVWZvoxNoEkiRzbPWAtqVk6
VAhbaMcL3acQ9sW6k3KldGF5liDW0UyYgmEhMWpEX02udMl0ExA9EDdFKzAnpGED
V9m6C/kHr2bb3ixModY2Cd21xho3LPvKmO/ce7x1VfR+1TEc6R++fnLz8QvrS7tK
RiE+QnhM+wsSbHem1GqkedL3UjBZKAhf1SOy1IAxlaWMLC5mjrsrkv6VV+LvnUno
yIW5JiK2FP3UjNjq9PB9HHI05xth7e++C5adCSZ0cJkOQ427fi8=
=olhj
-----END PGP SIGNATURE-----

--Sig_/hyZojprBdL+onStKDkN5i4L--

