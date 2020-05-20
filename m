Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBEEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 20:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53DEC20829
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 20:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="APDrhYgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53DEC20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbVbF-00087S-8Q
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 16:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVXn-0005jr-GC
 for qemu-devel@nongnu.org; Wed, 20 May 2020 16:42:27 -0400
Received: from mout.web.de ([212.227.15.14]:37307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jbVXm-00074N-Ls
 for qemu-devel@nongnu.org; Wed, 20 May 2020 16:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590007337;
 bh=LivmC0T4MlEYh1b0AKhwKgJifO6Iy7vR+p/8U/uGwlM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=APDrhYgAcyOvuq8G6Q8EMPVtD5yl5wa6fe4wogYdScJ3h2ZKrnoE6Ptv8gjbNfaA+
 2pYCyCpSCKG7KbDXeksgM3eSm9JkiJBYo+P1ChJVXxDf99afeOr/zNzjmaQ0suMPEA
 SpPHqBUt/choLSMGz8MzfbvRnQtlf74hEsrpwhjA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.105]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MSJH1-1jVIHa371f-00TTDl; Wed, 20
 May 2020 22:42:17 +0200
Date: Wed, 20 May 2020 22:42:16 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH v2 2/6] migration/colo.c: Use cpu_synchronize_all_states()
Message-ID: <9cacbf2006c8687a983d67ed1565317b58dc55c9.1590007004.git.lukasstraub2@web.de>
In-Reply-To: <cover.1590007004.git.lukasstraub2@web.de>
References: <cover.1590007004.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GmakCHzVEDb6avtmD9VvRdI";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:VspTdd77bpHWFOBfwaUo4LojGXS5krH0gtRO61e3ItG/YdpHPDg
 AHOesQ8Makmbiy3y6EHPFEbmjJYwvNEkzQBppc92BTDDA9PQM5IZfH80Y/ehwvLxja8AANR
 A1j3yeBvNe/T5nYmev6gUfcjsleERRKR+EiHStHRcIwUEu8nMNMUr4pLcZ5j4y6YqXdBdQD
 Z04y4yzGO+UEFTiNvz1Fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xTmUBPZDSc4=:cSqxp6veOHyfQ7jEWmy+qs
 FHkotW2YBylVKXXM868kzIouA5FjZIxbzdC3g3gg1hV24T0HY1ORysARLS71DepdXyduDI6xE
 plevC+UFwP7gkLypjqreQD1HmIYagL8xHCLxOuL6eIizjW0+ea0RynnJHWy9D4Mi6jEp3sVGc
 EsCmaD70k3aeEdZ8CHqKiRBvRWMavrvt9T7/51+PFWh+wrwDLqGvSHfcJjRqJfrOgr3B83qYq
 sxSL/cyAI3sNj9YPeeNSJxsGS1Zvskje6XcppgUTuqdlqOvlbogHRDNdr9b0Ve1mNvN0DkJG7
 2Z0Ir0pkO7lz2oAn7MxhfgULr34xfBfNHbObghLiEtYwtHKRKYSFchi+D0WOIK18eBRtZ0e3y
 6RwUwVDg1Hs3sZrI4lyTYFXaxDdGyAMfvjwpz26ef4GBFgGu+fmCW10Xo5nc09irPCWFiuvR9
 esE7ybH6GlJ8a4KJUN3KzyYK/BC+o29bUoyf+CcbHuHGUaw+Ba7JXr7OaX9WTWRJG8OlZjUYV
 2qd/bPndrOqEWpORWIp5jdy2MmaKjnJ7omeneepbwdMvE/N702SVQKrLDwZQRm2hxRztE6hGg
 LjceDfRa7UMZDp9nfAS/0mOGuqOWv4NnSYy1b+BDXRXKlEF+QM0JiCXtTxFPfBY64Gj0ivc9v
 Vrwq20lEYGk751Ftrf/kmZP6wLE2hTm+y3JDeJrO6+tiYv5ghpfWERiMjCcrfxIKiKIowo9Dd
 4OveEj01zmaM3jVE4k2qDd6HR1foXsXS5qXfiop2rPRCmhnwKntm5NcZpcXBB9OrcG58k54H3
 xhlC34kyXFFP5FQI5oAqZNMUAgP8O4/tfVn3NqjoyGHk4QvL1in5d3YZ7AqIllsqFSQR5Y9dD
 pOK84OhFe10tR5X9u03T11mJ8QhQFiEsdibzdNZIC9F+jEOjQRtEqb2Zt+VsIt+YYG1Uq3NFt
 6j5QnwmCxaQ+vIZrQLrSp96aTKaH14EOiy74eNYTjFc73xsGETR1yngNnJA/y3g4XwG2Atkfk
 AnIo4idhHeOjhtQ8Chg6kdvTxm5LJZ5QhHx80GBJmRx/WkuvKoCCvUenr3SJZNmTLNJcOjWNW
 FAaSQup0FxZpqVS15jFz67ZO+7EBFohAvC4wAPXVGWbftuIXS55kuEseqyS0Y5DYUGGwP/rOd
 ATmfrIgjWtzkulq344r1b4ZBbHnzZUHkX7qyXv+xbAB4IWWz5E0Y6SHdrrfktk8rDuiUJ8rPY
 O4k7cg4W6L08QPElQ
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 16:42:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--Sig_/GmakCHzVEDb6avtmD9VvRdI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

cpu_synchronize_all_pre_loadvm() marks all vcpus as dirty, so the
registers are loaded from CPUState before we continue running
the vm. However if we failover during checkpoint, CPUState is not
initialized and the registers are loaded with garbage. This causes
guest hangs and crashes.

Fix this by using cpu_synchronize_all_states(), which initializes
CPUState from the current cpu registers additionally to marking
the vcpus as dirty.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/colo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/colo.c b/migration/colo.c
index 09168627bc..6b2ad35aa4 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -696,7 +696,7 @@ static void colo_incoming_process_checkpoint(MigrationI=
ncomingState *mis,
     }

     qemu_mutex_lock_iothread();
-    cpu_synchronize_all_pre_loadvm();
+    cpu_synchronize_all_states();
     ret =3D qemu_loadvm_state_main(mis->from_src_file, mis);
     qemu_mutex_unlock_iothread();

--
2.20.1


--Sig_/GmakCHzVEDb6avtmD9VvRdI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7FligACgkQNasLKJxd
sljUNA//YpgRBu5h4tEwYNNUJ4FWM2hk7qyXOw06BmfcIs/RTpBThvNDh9eBidAc
EZedF/gPSz6si1Lu+x/uRQG/bm/45/wf13KdrlZsPGy7jeu4YXKqesBCPrXFou9Y
q1NKlQb3kYcHvrPpFoO4ysMYq2HA7SzPaVabstBvF33/6qYy2SOwBjDBASAV7neo
1BeR75lP9QIJUjGWMYfnTDKtJeheX8bASngqmeFA3ySvjs/YPy26Wr4QwKB8VsBL
u2syaHEys1qIoNoSFHLQf+QvIsDBxvIDVvqdriQ/eN+EYR/0WcVkYhKPM1A5JsMX
XMOu8kRHPL039AQ9n4MtJD59SmDbJYoWAY65EBCObv6icTefIJpKS03tvzzXMMO9
kZuAz4y8GgMIfvo17cCG8epFhTV1IiPYljeYEELq+Q0ZpwFZJy0QOqadKOrA73yf
FY6lyPKqtSE+/jJV0tTRCSrD/tb4Ek7IdLAUloCc5cevnFB1vs9sB5LW2i5WWiLy
lv00UaC2B3W19W1lkUdA76LawpktXsDp/GSh4mAGWLncDWsh7/gJ9kZ6inuZR2gO
uj6RqIvcckPZw8fEEH8THmDl3V0thgSGgewmn9f6XBCBsjZJRcLiM5u+XuSEqduI
smtKbTf7sl9YNTfEl89X4Sy8EC6ozA6ZkNih3/6IOfhimeGHEgU=
=g/7R
-----END PGP SIGNATURE-----

--Sig_/GmakCHzVEDb6avtmD9VvRdI--

