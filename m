Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00AFC54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F97D206D6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 12:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="cbkxlGQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F97D206D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY7mD-0007MI-Hu
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 08:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY7X0-0006LK-AX
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:27:38 -0400
Received: from mout.web.de ([212.227.17.12]:55115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY7Wz-000649-9k
 for qemu-devel@nongnu.org; Mon, 11 May 2020 08:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589200033;
 bh=WHLl8IB544s/xbL4S9Gq3qqev/C2bzs+WF4myt75DTM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=cbkxlGQH2T6rZ9gSIELKLDnoQK7B4CBVqK1QZJHBEQoqspsLl9S8lWvIGpWc4B6iz
 nrCEPk9kMfE+oTDkUxRBLZBUXsCQ/XbFJECSLYqs4KPlJIMFHDZkgemApfij10bNLM
 UNCN/2nxhfloXAjgQWBIR2coH56LrvYa9ubF0N+c=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LeLWz-1ikXgy0UcH-00qCGE; Mon, 11
 May 2020 14:27:13 +0200
Date: Mon, 11 May 2020 14:27:11 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 5/5] MAINTAINERS: Add myself as maintainer for COLO resource
 agent
Message-ID: <57d7784ead7a2f3be4437b14a0c69ed87bc55a91.1589199922.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589199922.git.lukasstraub2@web.de>
References: <cover.1589199922.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tqhr02zDZJ9i_MNE=83F3ke";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:rA8ZYAEABW72dxjlKx4b62qk8VzjlQyHSWFmMuBHAmzxmNQSYag
 u9zSg6qifV9j7h4+bfsIh/3gOsZjqltL/lyiBnCbdUtV7JwAfUtDcLnq++guFp2+vEFRjCM
 C+oZyWqv4KhBYixUVxOJtp9X1CNGdojx1EBqtevqgIAdt7qj0fnRWHQAgagV6RlBCuMP1Nf
 oXki2At3aT1gvJPA1fFOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G48vKEeada8=:qegn5ve0cO9B1KEGUmfjMQ
 RkbkkDtC5siS6EuLL6VqenUD6XrAYNnbr9hZhNODXVZh6THD2yEtHtJGPziMakXfwiGTcd5UR
 7I8TVOkgX71tvD5oAWz6UnEjL9YkMXL/7QcnvgGJvgHkBpoddDQOtmKQ0jNQiOzdomB6N433m
 GdTH79mC5jBrdpikdwzhClcGByfr+rJSHBJRL971gILu/+K5Hiv8P5rMqmZp4DIw352Zv304O
 +ptC5jb2G7lIB9slCPv75Oyh7tfm2UUAThBPtEg2dp7g7xh7PB4FrBGTWPfNvSIm582q1UORp
 052JM/dN8DhEa+kCdRuK93dwtxvGPwHk5Qsb0GHA4v5HCuUk77Wg5hTyX5PPVoXK9tXm7Euzt
 soSoq9+xHjx/vw7OAzjH2WWzEfotatAmIEo4hslr4/cDBht3z7hxG+LCMoprkcKYOiv/NdXvU
 lvNQoaa0UN35enh5jgo49KlGcm4hbdFshEclvDnPzrK/rGUCRlb2fKNtCniMRSR82WZrOFavb
 oaJyAoU4t/zgLWRDjrzpaFvL62flIy3hTvR+EOmP8xU/8SUtmjwZZaLYMw+QPwZB4x8zlDPD4
 obMBjaPPeIDqMAEFdDgZOkXrYnmsE1GIqaIYbcPr197jO1dzk1WuMMaQjZPOHtpuIdDLApo09
 a6Ir1sczfsCAv3DYDnk5GSF+kJiKT42ZXW8SNQt+GKz75X/Wlx0Kx6MWAjl2ifb/kvPj7A7lh
 QsQv4tkyizcviCXCisaJenyMOwUfJeW94SODSzNBO+kLmo8DpNa/+2r6Vl3hlsKrEsmXFAJSG
 +ZUwX8hUwhVFFA0xfFKOMXM1WlHrarXvZhqVhYlXdjUrmC6zhaDtjna9U7Ebx+qvfoDFNofvB
 fGeXNyZqUaTGlqdcW/FztQmW2QST2xPAr5KKjtQpSwFeNaRVOTJSi3lqgmKvzStjIFe/TcS+l
 VIw/JgQUJT5Jt1zQU0zNfd5CilmUlaeBi/mBGLni+0SjxETNFYNXkLO/tkqB58dINeA2UPKsR
 NeoHJXS0xBF10Epg0A5EgqzdWSwoT1zsSwOcRkgG1ozRGqZeLC5elW7flMziD+JzZ8J2xWHup
 i+uv+K6q1xu7SPg0crvGFHmXhiEj8xg9b9HTx5kWdd9zcsmvWprKf6Vt7XELw0PqOq5MVini8
 qoi+XM5S/HU+mWMpA29y7KpuCAAMNZ4U7Kc3CiJbNrw9SHgTbtap3KLod48AiVSN4AGYjIBD+
 IdzjMkE/+B2P++5L4
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 07:10:54
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

--Sig_/tqhr02zDZJ9i_MNE=83F3ke
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

While I'm not going to have much time for this, I'll still
try to test and review patches.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cbc1fac2b..4c623a96e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2466,6 +2466,12 @@ F: net/colo*
 F: net/filter-rewriter.c
 F: net/filter-mirror.c
=20
+COLO resource agent and testing
+M: Lukas Straub <lukasstraub2@web.de>
+S: Odd fixes
+F: scripts/colo-resource-agent/*
+F: tests/acceptance/colo.py
+
 Record/replay
 M: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
 R: Paolo Bonzini <pbonzini@redhat.com>
--=20
2.20.1

--Sig_/tqhr02zDZJ9i_MNE=83F3ke
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65RJ8ACgkQNasLKJxd
slic8g//U10f9tOlXyXC9RQPuopPuMipcghIJ18pUnsQb/KRlmne8I2xv4NzeKOq
0EiOlVmwoFrqTfbmXHumd36N0LHLuxwYpyRm5/fxxoDhEllinujJsZcodybUK/n2
Avw8Xb+uDG6c9J15yw7u8TRQy3aVtjtFLYIJh+67mIleginakKN8yZ/TuLuvDDSC
NDHggjeGy3KL2+Y95UszYm8h/99cXoLeDDGJPy2IYtK53Q6e6TqXKlSg3Kf3E0Ut
AdNODfjvMv7Q9p8CcjwJpWP/EUauXfraWTH+rUPC7XCH6h+j+3pPAPgV8sQEb1yH
CwtUZ8Kgw7VmUqq/11EvaeZXOLlxVJ+sa8nQ/KlIt75T7BjN+7FgbQ1zCXWSgpEk
lWScfERC7rb5nGss+2B5G6/ztp11ShWyshXpIjahOa4Bw9t+Cf9J+rjYRfdqbBFt
Teal6DmGPgkydjShw3i6F8ftosK+G1UWbuPzruvV9igASWh4HDJ/Z8qTcZZxsSam
u/hoGe3LdCmvlyHcCbxV+/OAneecyiDq3T7ro7YQJ0tk3Rlslil2eHxLVkPvB1xH
8P9TtTexE5JVcmsohZ2bjcKp2cxGQ+cjYxefneD4tbc0HbHGwgeTJDzadpw9Y8KT
2YZ5BSoWVibnA40WPcUByT6VQX7EbnaZO6UqoETckDZCeetTtfw=
=QTmt
-----END PGP SIGNATURE-----

--Sig_/tqhr02zDZJ9i_MNE=83F3ke--

