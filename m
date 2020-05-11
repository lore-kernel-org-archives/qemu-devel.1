Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DDCC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B341220708
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ElpuAmr3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B341220708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6fd-00052l-Nf
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6L2-0005E5-OM
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:11:12 -0400
Received: from mout.web.de ([212.227.17.12]:41025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6L1-0005mk-Tq
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589195463;
 bh=8aa/cXv8MJaQTeNGuhAYmWL57Hgij/DmXi7owbKM+js=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=ElpuAmr32P3BcPMQbFvM1DiqPwEaQsMWeMEr2oUIegE5pSG70OfSd7H2ZKsq8Go0d
 rkBIvGVAITuKb4ItpfGotd3L1iE885lucHhx3X40KhsE0+c2P3Ws8FrBLLZO4FPlps
 wLwhH80F0AZbA/yPU0C829Ohy23ZsXOw+9auErQ8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsJSy-1jF43B1gD4-00teTy; Mon, 11
 May 2020 13:11:03 +0200
Date: Mon, 11 May 2020 13:11:01 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 6/6] migration/colo.c: Move colo_notify_compares_event to
 the right place
Message-ID: <d4555dd5146a54518c4d9d4efd996b7c745c6687.1589193382.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589193382.git.lukasstraub2@web.de>
References: <cover.1589193382.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SRb1ob89Z9y2QWedmIRxl6S";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:IU3txvhBiDREI7tNkWx5REKG0Uwnv8IAQ5LmYKL67wiqxUBMOz0
 p5ndNdGAW5FFPlTEc5QTBzYWe6+xo9MWfLMPlNqr2WfNX6zhM/GzCk6rGlev1VD5PTHdepY
 dK17zoILIrgBBtobj8jFp+DIh/2AqBGVqEzE6EOUoGM+FEVxNSg2NpmRuExPh44ZD0+bEzt
 wVCL4Nancp9BOYIvLFkfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0DKC7TXAbnA=:DWl6hDFq3XycRpSa+M1Hp/
 hHGddW+YlCsAHnie+oATtR+re7h3E41g3fHGSLJqgBpsLi2etwMDeFUBuMXXzRzKuc+bC/ACJ
 QVwuqm2DboB9boqVwxkNmpu3JFXYmTAjKDnPt0Yal9bzRfC2T9Y3CXCRLXSH8ER/MtptiJeeu
 axIEa/KMy1Tb2Yx8UjLhN9av6zYRbeHOLarY+Ed9A9cGoD7Fe7lDPyNond4f+CRK/NkpH3H3A
 xO5Pg6hmv/jpultud0CM7HDS/jdSzDMEow1AXzrhZmNA4nw2A7vYzdPr0+h5zoFyChPOr8asd
 Ra0yqjMdoYQO3uASIi3kEP7IXVpKjNOKuKqsmqEUtMNwd1RQggl8c1I8Yy5PBshvgGbm/EiBS
 EL753HU4MsQzJncjA4dcChrq5eRdHXPtUPM2LWtK7z5Kn95fdCOj8E4BDjzw/hCiC1398NJ6V
 F/dAdq6LMitG2pmz2Gvyu2rqpNS1jbjrkSWxibm+WEZ6+m7cwX2ApFs1c5QCtAC2n57+qvdM9
 l09dZpmAuSGsqv/enXkKKlQbHO7a6uEE4yZ6DPj5Pd/YJTwQg4o60tePPzUT6HUDgCDXxJ4uQ
 sIr+t9b3mz2QJq0IiwSOXYj9pXGN1JCJyeTCGkVFkdeOe4r40ahfjR3QRBQw1KyInCuuOIw9h
 7lj4YOyaMSGcB5U2q5x/dKXnAwcG2WMVA1pIFBL7ObxkoZJoHl8G0awGeYkBjydfeXbpmtaQT
 VPaTnaD+yrz68mePAL1Fov9q8jD/FBNmKdwKOqa8nTJ82ztnR8bYyDdI9uP3UiDpSaiszHJaR
 5AOtHtW1jgJTXgS4SRDv4/3NjiK2vgbTRVzZYA7fE6HAAWoYCO7OliBdLO7W8iTrf2W9d7t88
 FDJN8/QReDVxto0RXdk+BjadKW17dLNO5YCvK4EA1v6/1yV9OBHQr5E+bVPNdjSvOrJ+9xgWY
 xsdLGkvG7N0pWKMijf5LuQPnK52sK0F94zje8SbtPMvotB4XJt758E1uuePvUyVSquJunOasS
 xc8Dnf1s5oIhYvZsR80dYQSsqcTfSB7fQUPggmDYbqZCs0OgF7kdJtgRFtomnjtWCnban41F7
 RyLccvU7BF0mXftQKvRH7t2WtOh04L/+IIPi2aMPQgS/wegoMdpdHxcuJIXsJtNgUTBRPjl2d
 q5ZtkUyxRi4pdwdGRlLBXvqujdLJaP4gZ8lbLNR2j47S/7s+dOEcM2bb9Xh4f8XRErhCPOSVO
 5YYf7WPd2bR/Xp4Np
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
Cc: Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/SRb1ob89Z9y2QWedmIRxl6S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

If the secondary has to failover during checkpointing, it still is
in the old state (i.e. different state than primary). Thus we can't
expose the primary state until after the checkpoint is sent.

This fixes sporadic connection reset of client connections during
failover.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 migration/colo.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index a69782efc5..a3fc21e86e 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -430,12 +430,6 @@ static int colo_do_checkpoint_transaction(MigrationSta=
te *s,
         goto out;
     }
=20
-    qemu_event_reset(&s->colo_checkpoint_event);
-    colo_notify_compares_event(NULL, COLO_EVENT_CHECKPOINT, &local_err);
-    if (local_err) {
-        goto out;
-    }
-
     /* Disable block migration */
     migrate_set_block_enabled(false, &local_err);
     qemu_mutex_lock_iothread();
@@ -494,6 +488,12 @@ static int colo_do_checkpoint_transaction(MigrationSta=
te *s,
         goto out;
     }
=20
+    qemu_event_reset(&s->colo_checkpoint_event);
+    colo_notify_compares_event(NULL, COLO_EVENT_CHECKPOINT, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
     colo_receive_check_message(s->rp_state.from_dst_file,
                        COLO_MESSAGE_VMSTATE_LOADED, &local_err);
     if (local_err) {
--=20
2.20.1

--Sig_/SRb1ob89Z9y2QWedmIRxl6S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65MsUACgkQNasLKJxd
sljf7A//XMzwV5vPfRb8lhiXwt1UwOJiJIkZ06ZtD3frAU07bMOE6eExDQZlw52e
R+IA9MzX/0WWsSx5U2LAhFKfoNC0so7w5BfADuwaU40j9K8quIi8P17YGyt80oLa
UMDOUu2lPu+5PlRkjI72djMCWk3knHxWhFdeFEtxdiUtK3kUjk/W3T5xNZJatPPA
KTdOf/YIlBAhdQ6JOKCoaPHZ00ETQcqaE31Rn1l57Kun0EF3D/fuW2YVPah42jTr
amZqCVSIk1K+WSOxHA51Oqgfs4uHnmHHhXuIBBTuDpZVg5p967xHiW4yw/dOrlOz
8DhWan7TCv4xvkspuZMA3+mGUPyyqRPp8eWsYJD9GfpA/qGKlWJrHxCSwgjIWO0t
vyeghDjYC1+mYnA9CBuAJR0kc0GLGepeO6q0RNSjwz+GReOrk1LB1PJJVgphlrKX
8piZgiz4VjcPLzz12EGG5gtIR3MYFZwCPnIHjD082G0mYszZBumeU5rMTVj6IfYM
1p2zykVK8a2ahxMk9Cxen3cN1bzoHimHNUjx2cwoI5YVm+1/cUHsX/Yv5qRQnYiq
/67dUaaCwZYUngFchG/8ExMi/PSCp70SjlXpWUAxhBnUBCm3MtOffPCKwLQP6QP7
Ezq5J7idBWwof41wEwdxYtBCiJMOOlJJHuu/KJoK6fYAPuXLeNs=
=PntW
-----END PGP SIGNATURE-----

--Sig_/SRb1ob89Z9y2QWedmIRxl6S--

