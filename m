Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C754C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:51:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3742420643
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="KsUAtStR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3742420643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVYgy-00057V-Br
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jVYKt-0007IB-L1
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:28:31 -0400
Received: from mout.web.de ([212.227.17.11]:54321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jVYKs-0002X7-Pt
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588588095;
 bh=Wy1r8kXVFQEJD4feg9AKnhcEY54oyF5+k98OBFiC6Js=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=KsUAtStR7Heztved51D7oS4i0+LVCSCdpmq3fsvkki7/O0a7dLPNdRtdTKGezbzSh
 snNLeIqceAMxwEZiSnHvAMMUnqcZamTuiNJajEu14aDM60AhwqqH/aPm53IK0YGL0T
 IW08y9Xd/kTbiAbLldeADPMxF0py/lhAvCjHg9vw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.27]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M25FH-1jAiKC0rf9-00u5w2; Mon, 04
 May 2020 12:28:15 +0200
Date: Mon, 4 May 2020 12:28:14 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v4 4/6] net/colo-compare.c: Only hexdump packets if tracing
 is enabled
Message-ID: <8a940c893b26ec19d741d2efe929b85df559d850.1588587700.git.lukasstraub2@web.de>
In-Reply-To: <cover.1588587700.git.lukasstraub2@web.de>
References: <cover.1588587700.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//Qvfqfq1Fx.LzDNMryf_ydZ";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:844YZtcyHbd/8rlSWnpMwk+baWA1JwxJd7vG9+vZtdeD38ey620
 7FwYDNNpqmpXqTNeCZlUXRoCBnwQXMh+/VLKykODvuLjl3zt4ueQLtAWjw7+jJQJ+7ne/4l
 tK5qWuZhUl1TrCGKZRUq4VEvUjEdST6RFhdfl2/LuLuZJz6VZuksD7/K9SG2dLEG5o8GjcQ
 1cwGHriEf/CzFiPg35jjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3oxcVJG3SDM=:ZKx5DcNrDrqmbDzGi4aH/c
 cFXHuFPLm0oSKR/lnHm1kJuTOPr+VCOkw1BCTazY8ghasejfWdp01BqkzhFS2hyVQK5GPgu+p
 7k9mUVPsvRak6p39KlGRzT2uidcAfzlcHs0C6yfuvbHW2OFn596W7fnBB2XKbd7s6jvjHNSYF
 s2OBz3UEuwA1SawNLjbLAmidX1M4yg1L6smLT/ja3h82c8Zdk6STWAMdcjKkKzdfj+eLQnSm4
 h6re2TeeApyc54po/GsehPjD0svlDfzFngTWkX3cW+PLC2JThvtayLyFefSNyalMnr5Ducp8Y
 +uc/4UZm9lMjKY1yttzZitz95aESV96hwHoV4kINfxeOmr2LiuEWlVyJMf34MUOA2o10kPVdq
 7YNJsI64o37aUNqQSu9Buc2KXBUnpyuHM8NsvEbaj8QNWNwFPnoBdWhgrdIxLmb7jW3NXrc/A
 Ime0gjhLCUQlh3LIxNzo+jZzBebcvqwQm02FrgocToe3gjHw7/oBe2e8/z9jMRvjJZEsKuHMU
 NY4U4UWc8kDGFfguvgvwTv4Rje1qROeS/ftKKdO07bO/NMV+wcvp/08jQFguULytjvCfBN0fA
 4Rr4Kzf4aFfybllDkX03KbP1KiQ0rsBQcbuX7lPgjptx3mV0s3G5boCSWs57bgJ9nCUvukAJr
 4z/6POlnE90wwM5SOk9c885/SHnwF4hqCCHeAATOO/Wdihw2+zpwY3j6TNkndTtWLsO2ptBIg
 /rF506MHrPocq0kJLtW2KIOqyYxTfxiPnGsMZGHxqhamZD4fFjieefaBSudyIHX3VYEKIcx9m
 FCrYA5oo3X+A10A4iE18m7+8Z2PaLbrty69941S7v2biRigyjjGQtF4DXiJrFRqlMcbhJ6/6i
 S7K+3dNPm3kKLuaalrYknL5IyV+WBc12emKBkgINzXwBv7mVTYCEgDiV2NkmEEjiRfPJdTieW
 /ecOT2oLcYzedCIaS71lu1sUEE3P+6we0Fy0hjf8pqVIkz/7rBBvVT331c7LLFJxJWm/otQPB
 sq/oInFVsOkTosodqvICNgF6SmCudfVmFgE4u0QvTpotgrTaRmSh4nzUfzrVRJGGnF2qvAIjW
 M44DPs1sU0ZRzjZlynln3H0gtBKIXAbcdcyOKXOVk+Rp74cjkT2hYzxzNSeHzGBaa8a6aFRYl
 e3e7zicy/ZIIQbr517bf1sTVk8Q0nwYSwfEOBvnWBNd14A5h8Cx/YYT9THR0eJN9rsZokQ2u1
 tG6J28TPSe4sKrdIZ
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 06:28:29
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
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_//Qvfqfq1Fx.LzDNMryf_ydZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Else the log will be flooded if there is a lot of network
traffic.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
---
 net/colo-compare.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 2a4e7f7c4e..56db3d3bfc 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -483,10 +483,12 @@ sec:
         g_queue_push_head(&conn->primary_list, ppkt);
         g_queue_push_head(&conn->secondary_list, spkt);
=20
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
=20
         colo_compare_inconsistency_notify(s);
     }
--=20
2.20.1


--Sig_//Qvfqfq1Fx.LzDNMryf_ydZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6v7j4ACgkQNasLKJxd
sljOWg//aVeBiX99IhSqslQajyP2VO8odorq9lmVbX893KZ369KF0q/2pgjK4DDc
JowiEsDiM5PEzHueq97ai221rxFM6AvhrqmOdYFovrezx5DSSTKLIv+6mXvZ594S
hWBZ20DuCNf3DAQ/zwVB4h3R2ObmCav2Co4qQZgYwYo3jyhXvOHi7XM1Pz3FF97C
5dfUJu0qsF25RBEzl/1uwmIGX1nwuRPacFcZV1hTBwQAicNtz5qiTP7e4IUZ88CN
NSOvxWPpgMy4QS1kG9EhdjmZxX2fAwmQ756EZBp84pnqhnj4Iu66ctftyS0iouxW
ZE5EN2VSm8iXDhd/v8DCDffWgaXJi9/jraPgThwFIzbKYH6jA7UmX1EYf2SckjwO
th0Jjy5lLvlF6PkkD/+ZemgFlrnraAJ5Cg2i0IpOkv1qlBiMh2x+MhH6uvLmLOy0
a2cB5zEoyP99i5PBKJPWlipqQ9cB5WUin5cJGfBYJuFzwspsbFjNzY1cDp/4yCj5
XWFB1TiWpKax9p7blbOidPC3sNubWdxQ4+iVhls5WpDPbUY+QHNnfzUJ5QZOdaJR
yhJJB7qzxBGsK0XDDqVGmfjhZ/JFk0C5ZTl+XDlnw2hu0EQUEZRDkYX7AETDoqLX
uIMhJfrbtkTVZ5ytfqXT+p3GX32EbPN3FemevuX7tSTvtz09ceU=
=LRQr
-----END PGP SIGNATURE-----

--Sig_//Qvfqfq1Fx.LzDNMryf_ydZ--

