Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBEFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 06:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 097B42073B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 06:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="H+VKf/Ad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097B42073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc1Wj-0002Sh-0C
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 02:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jc1TJ-0007TD-TS
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:47:57 -0400
Received: from mout.web.de ([212.227.15.4]:38849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jc1TI-000167-PS
 for qemu-devel@nongnu.org; Fri, 22 May 2020 02:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590130063;
 bh=ccn6+rX95KPnZc453AzARCcdDXrnJE3FRVs3VRcf8r8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=H+VKf/AdfUmmR5GSJpzr3xM6laegk3q1EgUm3PepEXVnHvCEwkhp+TVg+1RyheJy/
 9vYp02NA/2Duee8UaQpB+dRC933Daa8EYLQlV9elSxcy6eUo9IjeLsEvyr8Ei2sC/k
 GPX1VipTGAknv4LBmHKXHAfQIzBZ6co0vYIFJt1Y=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.67]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHEXc-1jpAdD2DT6-00DKkS; Fri, 22
 May 2020 08:47:43 +0200
Date: Fri, 22 May 2020 08:47:42 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v6 4/6] net/colo-compare.c: Only hexdump packets if tracing
 is enabled
Message-ID: <8a4db9598051334ae3fa97b73556cdbaac5bbe43.1590129793.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590129793.git.lukasstraub2@web.de>
References: <cover.1590129793.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/90druBuHZiQR/w=D3dOHZYB";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:kRqQK+J+UXSe/5J61Czr8joRBqKJwVkRhvNs85XNF3cQQMCew0M
 wJllyPnCDe9qsnbvdry1Q/yLkkQJ30V8aqRxPxOPnKFIEjljhaZE/Bflv3HAmZFluFxbxpp
 MPpc51in6IJ0Y2Eg0Bz75n4YUWmqruAzATww30i7WbQN/Sz75xa381GPYlXLZFKjdLFRTaU
 Lu/RR39FhDiPShC+Cm0qw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tJW2wBz5+UU=:nGtIWeJ/W8oQ0qwWnyDl08
 gzNY/rqiS/VwAUMDYygXbf0qcXG1eLf0Nmn4xw2+b37ctjGj3ZVi5kSfeQr0HFWHfwzj/8xof
 byTrydJJKtlZLsKAWzWvx8FX2cmef+U1/nKE4YHKZ9YPsXnVAV0CBqN/gurGkAPfSLjJaFH1t
 H0/M3cP5aOTRp5MPlbve8qJWLT0ceBLlt6cQk41KMj/FWf6M4qmNjuv3HFC/gWUMkaTUptyPw
 5EIDp65/5Hc0Vr2zovzK1ItKiIQjVQqICG0gvr5iH5JsH4PymnNaZTw1ZVzX/o0SuMgI9QOVb
 jujkwwBVVYZrTT2bRij+YbBjWAq0EApldbvuN1T3detnJecPYq+VJlAyzloDrfsQnvQjpHIm7
 8p0W8YYfWwhzvlwB9G8qYhb5TyJTm14Ni/YspSD5wFXc/Ea1/OKnYbvxSjocLn2b8+/fLQLOS
 mUAUJe9e/ly3BLFenxjFbhq23ofvaE7Jz2i0SIJUgzFadID9bmVSwTBRjZrp24ZvxbAtHhNd7
 JMyu45pPqC52rcj0etllG0eKvX/EXZ2qIw5/tNUHsR2xONRI4Hrqu3BkZ4TAk4XX2BIDxl0QS
 qiW699rHXG8kuSAfB5N4ghjaaBCbmtv+WX6yz10lniaPmZINte8HmbdKS6sS0mgJyS1fI2HBW
 e9jluAY5OLAZ05Q21GqF7PTP6mhLl1FIYRmWz8PSl8U6OIx/W0OSGMfjCb4wXqLL4loQAe2EE
 ZGhqk86xrcxdqgzazJ1IQyGi+gP45Xs1Pn/iP8+IFX2WDOsi46AZfxg9xb/pizDBvUQMmF+aY
 dXd5Ur9b3/vmlSrugahL2nM0tz8Khz9ROkUiFiBQYwoY6UrDkQh8P9ID09MO3mf5dzojLIqdY
 AX2maJrIyIelBeYs/RC/DuCKYaDo+bwjz1BzgRIjkhJUSRhNJhUBy0W2M8Nm3fRt4JfiJ4j4l
 OhJG74YTqrEzY9bntrn4PTRk/BOVwbiwhxD/OHC2eWMw14fx6Sgi96oXGAubaE0RKSmGxSz9t
 knoDNldmebGeyscp4NqDnCvu43qv45AQHqATp+N5ia3sgsQo6rryt4N2gTSbOTBGalQoKkJu4
 x2xRZol98ZJmC8qz5NvgoQYlFBGLlf4emXZrAOt5KxpaklJXrVedqHFsOwtO1i+1XW9FBZFGj
 KatYUCs5a8s5OQCW9yQYVoxGoS7AVi+EZ8zWTNyI3EUs5EGAB4KEFAitvyffEXTx1UTwLk5SS
 MEmiX/b2domU85OOz
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 02:47:49
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/90druBuHZiQR/w=D3dOHZYB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Else the log will be flooded if there is a lot of network
traffic.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 net/colo-compare.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index e47c8c6049..7886444cdf 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -483,10 +483,12 @@ sec:
         g_queue_push_head(&conn->primary_list, ppkt);
         g_queue_push_head(&conn->secondary_list, spkt);

-        qemu_hexdump((char *)ppkt->data, stderr,
-                     "colo-compare ppkt", ppkt->size);
-        qemu_hexdump((char *)spkt->data, stderr,
-                     "colo-compare spkt", spkt->size);
+        if (trace_event_get_state_backends(TRACE_COLO_COMPARE_MISCOMPARE))=
 {
+            qemu_hexdump((char *)ppkt->data, stderr,
+                        "colo-compare ppkt", ppkt->size);
+            qemu_hexdump((char *)spkt->data, stderr,
+                        "colo-compare spkt", spkt->size);
+        }

         colo_compare_inconsistency_notify(s);
     }
--
2.20.1


--Sig_/90druBuHZiQR/w=D3dOHZYB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7HdY4ACgkQNasLKJxd
slhwhw//TU+wzem+FrVD4Tpxz7kbWEYTiflLdPgWo0u7hGRERQN9SwyELU3bosNc
HYsraOvdjvrA4bfhn5fSU/L+Mc0iRgHD/yXpjGL+PmRCCY3N9SbSLE/EAD2X78aB
vWlgkr3uDXgXctt7VFyhjpcJ6IL7pzH6jUHJk75ZyTsnqdDv/ALKPwEEJ+6W8P/Y
zmC5kwgFiyo/VmUzwZGEsDBfy53xZ9Lfvr0C31QyFyel12WkSDr/QVqyYuOhFpET
HF/tMfWfpEFpiJVC8WbB0tAyghTVahFZOk47ULKlqq7MbLPkK356MvC2ArD7HLlo
zd8czGIxIJi+DP3K5hgsNK6A2IJTToIBe0EdCofXmXxugPtq17zUQmbjv+IpaVSJ
/fJ4x8lAVWxNeS3opgmVA4LfoydPtzcu1oL/MQAsWa7fj8p4mhI+QqXtXJhUuUY2
D8zeGgc2DkGCt1ukXkazowuqE/84bVAwVah+V+M2HVx4PvlbvorRHwwU3JZLloOB
fnfgzUG6N7bBugqQOSaGHVe/S3IpaiEcZEj2g+84FyjGgy48SejvbC9vmnz1gs0C
EugNfRIDbE/5/OQFxdfcn7YHWfI9F9sIs1i97q9hb1eqwfON0xCoNgVBGvQuwx4b
SnhbiUrBMeoponp7nLRXQIPgxliF3OSnrDKVABM+Dg8UP3um2Wo=
=XpCR
-----END PGP SIGNATURE-----

--Sig_/90druBuHZiQR/w=D3dOHZYB--

