Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AF4C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9942B20746
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="CMoW0J2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9942B20746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY7bm-0008DB-MC
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 08:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY7Wi-0006AJ-P3
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:27:20 -0400
Received: from mout.web.de ([212.227.15.4]:47933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY7Wh-0005vn-Kp
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589200011;
 bh=qfGg68Nfb6jE9N0y6KIMdqu5LDQlJ+AcA8oLmpKWpJ4=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=CMoW0J2dOSKFKGd3UaXKl1zMBEcPMB15+5j8shcpax+XAoO5bflZrbk3XLrOWRLPI
 tIx3ClH2ZT3IF4Yi92qLaeLgYcu+2W26Gx/0FcXC9hsZbJh2uqqLeVgw84X0FbJMy3
 FT4SpIptDCnvAEzSSb4/Xs5ccLhrAURSH2T1r02Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MJZLX-1jWCuG25Gd-0031lc; Mon, 11
 May 2020 14:26:51 +0200
Date: Mon, 11 May 2020 14:26:41 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 0/5] colo: Introduce resource agent and test suite/CI
Message-ID: <cover.1589199922.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YV7hbUDMAZhIGSqYwkB0cHN";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:JCN1WQU/u4Sw7qVGrnjacK0WJRnT0GsAhvo9okb+ZiSt1eAaqO7
 snyPu6RCywCV93nczoSfK4SZY9FifHwCInYDubYwQGy70tuH3XLGrtvFYYAoTjVac8Wkamf
 xNjzOvHYamWGs7hcK11KeA0RV9bHuoSNtOo0w0ZTS6T1mbZG6/rhoYW/hwxAo2DwE4tUDhb
 4PbwO+6JgSwat9r0CKNPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+cnAJbnDbqI=:b322e51DVd8McZYRQdz53y
 OsDCFLyUWNRENoXROxj+19z3DdS7GBWauWHiUlomgTcEZqLfAkDtJ65KMmRMZSeTeEXqWQYKD
 9YiDBydALJY4cdFB9EH6sWklFc4wawCLlfb7XWuDGYQvbDRqopyTh0F2mmk21dbEQ0ImEjAqm
 ivQA7sMmoTCSgpsXT6Cg5+1fE51WK3VyrrFsj+tELWXgwsVKI6s6d+/58I4w0lVXQlQ6FqAJl
 QJ+ehsf9EXVnbLiw+gSYqYmSzI24V1vcMnmapA/sI4sEiKkCcrTVFK6QQCbNzpiJ9UI3m/s41
 knzUpxQCtN8FOse+LEzQ2wavoCtThSiuEJUfNWNuL4ZG+bvl46NOT7B1YX/gFiaDITUgycG0O
 MFMkq+beWDIX847RkMqcLldrnnZJgvB0jMwM8n/yxmr073vgI0cpbKf/h33LeHFf3HaWLC4t+
 bpMQ3U/R8dQCqNX8WwJSZWz2/ih1s0wBRB0RMFvbHdVWaPnlsSz7oJjQgjdVKKvhU+RA/7aQS
 BkJLEAo3xRqK9k6VHRKNGIsb1I7o2byi9NrmsQ32JcwI89GYP5/hXx9plCCjdsHQir3lTwojI
 kpZ9v3fOsIb2DZb5x9EHBOsWZwwcO3tHw+1fI/guiOFBaGHIOoy4+6xdOLhPGPDaRI6ShpHq5
 HKwbgIPKyJICaYjmdOH9GwF9CgMV+BbTuaiJSHqmzIXNdqvWEAz6blMQuiarb5DPV2Z7Kn2uN
 DQRku1bR9MNymOtNQyYbBLTZC7DBqmCuzC8aswQ/28RdUdz4AUval/AbbuBq2VyaacDPCYxqE
 oZDRLqw8ZGoJQCo/0CfOYPTVt2bs8r7Wya5wJN5COnCk4f6nRsJhgnJN4OJ/TZ+i7f7Gmhsup
 eM54zwHcE6XB5p94YSSxaXVm6H0EFdjHU3Kie3LUqHtvUyMchQKL8oKA0onzX/4AYaGUKTc3g
 6sB9MrbVTWa4Mu5JBFwmRb13RqU38xwfyobnlvEUfbhGSK26Bua0A1qrGeuEyL2uSLIe2gdSP
 edqHP5BJrOnvjhmWpXbqW+p8YoJ5lC7xfNV3HBPhX+5E+DB5zI5pohc1Nkt3uwm5tOdFeuZrg
 HL3Xt8+shlJRhWLBLfWAPfDRsdq3nGbQLS/dmg/GGmKPMTMH2l1I1wp95HaIyNz74f2HNw7j7
 brXmydM569CJFl5ubqvZsubeQuf2VT14Zx97sUzvTtndo7QIqPaGZCtJiGLE9/dlp9oKru5Zm
 hHsLdRS1LaK/0XYfN
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 07:14:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

--Sig_/YV7hbUDMAZhIGSqYwkB0cHN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
These patches introduce a resource agent for fully automatic management of =
colo
and a test suite building upon the resource agent to extensively test colo.

Test suite features:
-Tests failover with peer crashing and hanging and failover during checkpoi=
nt
-Tests network using ssh and iperf3
-Quick test requires no special configuration
-Network test for testing colo-compare
-Stress test: failover all the time with network load

Resource agent features:
-Fully automatic management of colo
-Handles many failures: hanging/crashing qemu, replication error, disk erro=
r, ...
-Recovers from hanging qemu by using the "yank" oob command
-Tracks which node has up-to-date data
-Works well in clusters with more than 2 nodes

Run times on my laptop:
Quick test: 200s
Network test: 800s (tagged as slow)
Stress test: 1300s (tagged as slow)

The test suite needs access to a network bridge to properly test the networ=
k,
so some parameters need to be given to the test run. See
tests/acceptance/colo.py for more information.

I wonder how this integrates in existing CI infrastructure. Is there a comm=
on
CI for qemu where this can run or does every subsystem have to run their own
CI?

Regards,
Lukas Straub


Lukas Straub (5):
  block/quorum.c: stable children names
  colo: Introduce resource agent
  colo: Introduce high-level test suite
  configure,Makefile: Install colo resource-agent
  MAINTAINERS: Add myself as maintainer for COLO resource agent

 MAINTAINERS                              |    6 +
 Makefile                                 |    5 +
 block/quorum.c                           |   20 +-
 configure                                |   10 +
 scripts/colo-resource-agent/colo         | 1429 ++++++++++++++++++++++
 scripts/colo-resource-agent/crm_master   |   44 +
 scripts/colo-resource-agent/crm_resource |   12 +
 tests/acceptance/colo.py                 |  689 +++++++++++
 8 files changed, 2209 insertions(+), 6 deletions(-)
 create mode 100755 scripts/colo-resource-agent/colo
 create mode 100755 scripts/colo-resource-agent/crm_master
 create mode 100755 scripts/colo-resource-agent/crm_resource
 create mode 100644 tests/acceptance/colo.py

--=20
2.20.1

--Sig_/YV7hbUDMAZhIGSqYwkB0cHN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65RIEACgkQNasLKJxd
sliRBQ/+M8ZHJRk0YYjsL6HgKCRvX77rGkonQSdYnG4bn8s4OI72LXT3R2Buttf9
P3NJHxpvFiRd/WjMnsyn7SgoaajAWzelTH+2JWPkkPXOy3+4o1PJZ7KkbQ3rIFVw
IsKRZXFCNs0dFuGkdJ4unuI0yu3aX5RIIpZJmpUyBK/C92Jda5jeR6K9tneO/khP
YN9qZskLiMpF0l45k7lLQrqt75xiZq6mvBm+UiZSb3o79b5j7l+tkHfGWTpAJfZi
R+9NYWATI3R9Gy4mkxY83RtiH2RLZpjCdMzgBG5Ch5B1P3ESCvs6llHZSRPyPQal
39SVqkjB1fZmt8M5jjzun8Bwd7HAlJeqgQwClZc4nOgqJhXRf6gmWvwd2U0ZvMpU
46RACHCDwJvrqHNJkqzZpCuUHLOYXRtJn63ohDXKHyHRHT6J3yg8nAU147+tzhW8
9BKY/XWHnLiRWy4LNBtNV7kgS9lJBNd4HKFrcGF81kHN8QuNB7f3xkXyCgXqqFID
HyhRqcotEjRJwAO9NTPqb/k3tOATSc9/5N2gOhUqpcKupIzBToESczwpyB1Jfy4c
bZ42Bm0uQvHcwk/QDbC3w/ySzxOBviavhfRyUfEBFdOvv4HlYtKmOgtihWvj4aTY
pRlM0Si+Ywutz1+jdOkhNLmTfGSLo0SKJsX0U0osCAcDXuy3zu4=
=3IzG
-----END PGP SIGNATURE-----

--Sig_/YV7hbUDMAZhIGSqYwkB0cHN--

