Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C46FC54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F035E20722
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 11:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Y7kPtTKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F035E20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY6Uu-0004ij-Uc
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 07:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6Ko-0004uB-Qg
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:10:58 -0400
Received: from mout.web.de ([212.227.17.12]:50661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jY6Kn-0005kp-Vb
 for qemu-devel@nongnu.org; Mon, 11 May 2020 07:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589195449;
 bh=fHF36Ki6yNEwvH+HbsyWEOYKs0aX/3g3RLEGn37QNNQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Y7kPtTKDnZLnyyUcEIb1sJ+hrK31f73NOOIdvjgr8TvWU4TzC+WtkkyWS7G9k24yZ
 imszOWin4ky8ZGMZwp6YaFzy9c2SEBgfwg3wTteU5Ko9u3fL9pFf0bo2pNk90lLTJL
 B0liIoggwDz7jzZeq/KFyJnmvqAjrUuYs/3U33eM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPpQU-1jUERf2eIc-004zSU; Mon, 11
 May 2020 13:10:49 +0200
Date: Mon, 11 May 2020 13:10:48 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 2/6] migration/colo.c: Use cpu_synchronize_all_states()
Message-ID: <9675031ce557b73ebd10e7bd20ebbf57f30b177c.1589193382.git.lukasstraub2@web.de>
In-Reply-To: <cover.1589193382.git.lukasstraub2@web.de>
References: <cover.1589193382.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T.A0yy34WUUll3kRBVs_g1_";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:J4iiaiK1ynPM7Kmwo10bTHc7piCUCoI/HzNwQLPal82GaYiXvum
 MXqTuslu5KSg59/KDgWm7lhRITLwYcbII/a5Jkn+K2qNDNWL+Td2ma8/T440Itas4KCh4OL
 UioQxsxtPN5c9dQnjCEQHFrLRd7Q1dIQL6FfUSVsT0UvmnhW43NGcptvQYr391vVcxJnz5V
 lbU46LzV1EM8Y6iY8DFbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v8rXSVK0XTY=:K1WWX7lmUKDuUCj1Qpx/kC
 WqSxI4VeNh37f8/uOyYIRzQb+j0rLG2bwW5T0KGA9sh3jF6N00n4vb1aHDlRthUkuqTO2kOcI
 kK4DQJd+mBn21qxGy7NQ70eqbbDHEoLzz78pL70yYAXt4OTEzt7mOEL220o5NcPWbYPLBPCVr
 amusBpTnEu954twQHjEseO5y3jBOuMTRd6Jbt71aBwvwPFDl1GrzZ5p/BrSU2+LE5g0gfunCV
 oL6taFOH6SWYpo8of9YUrGMQoBCr/ZsCWe003NfH3uIew0dIw0TmlRGdJvEcpaG6iIZGSfsvS
 1j4IR5az6F9wQebhmBVgvp0PVF08f2osN7vBIs+xDW0UqctxAF1MdZl4M4J+veTLt/0UotnvW
 3A+sy2xTgokz6IEpH6K2JQtM9B1/MsDIGJuv7IojXdPMS5W+5DEv8tUURmmm8Ro7EUlP9xPhg
 AYICAQvuJB7tXFXBsIxb2vpeHujs6rdB+M0ZObFk5BUEBwZdKJLnqwkkZq7JnXWfqtomvAViA
 uPtvPHJs6CHZ1B//nYc6vQWSMXjieI61iu2YgQlwSqqiIyniWGgy6LBk4bTsbizsUPWbRRX1p
 EIgMo0L4qsBHO1uipmROhY0LEpx9j6onTkXrllARsPSxLyveA4FTkGCOyXK9OjAF5ioTbQu3v
 u+VMCeRsirsb/1JB86RRqHKsliGUucGb0QAWYfxSJO7DcQ11ZhhoKtaOGv1mxfgX1Dkubum3y
 najaqPxvM64lmgzDl3qcxxGt5Yl4CPBn02y5VDF8WjM8TySeYe/yWDixDZvklg7vZicXkFKtm
 MBJQgoHaxGs5IeXVDPJLUzP71/9iJDC6Eyu2NJh8HWKxZa1rgAGFjQyzmQFxUHMGCWu37T/Zi
 EuxDq8mAZEmpalh8CfKp3gIeG4VDRHpsrCxT0iDkVuFQQ8x0NfMrXIaHg2FaXZx+2gM47dkxR
 bNQ7RK/RxPXj8sziEeMEywhVryvRMag+NkdjXWqZzZGU2JV/VNGjz44WOCQksdWzA8e7hv6S8
 RXt9Mh8fdtmmEcmrVnU937N/QFBnwyfT0sQYfJOUtxEABFhJ8yM4NhJk6RWbop2PTRDQ0hsAF
 sfKoQ4GpuQw8/Wq84EO48xNrieNNsoNmI4LIIRCsiva4UVDJbdUe4ku6Udn+VZBFxByTYyvX+
 dg+df9CUjjgbClqTcMClD+rkGk8mNPm5hSPNDNg5gz7BRvx3riHqmJHs9fdloDg2WPvyDght4
 8SvVq6PIzuXKJsDYq
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

--Sig_/T.A0yy34WUUll3kRBVs_g1_
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
=20
     qemu_mutex_lock_iothread();
-    cpu_synchronize_all_pre_loadvm();
+    cpu_synchronize_all_states();
     ret =3D qemu_loadvm_state_main(mis->from_src_file, mis);
     qemu_mutex_unlock_iothread();
=20
--=20
2.20.1


--Sig_/T.A0yy34WUUll3kRBVs_g1_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65MrgACgkQNasLKJxd
slilZQ/+PUEBgUpfk41XvDCGVewbQa7b1LnrepwIyJzNBO/gdYd5SqhOgoMxY4ir
47+tAaj72/26rH0fiCUCZuRStN4QEeU/9h8FiWACuDshrawNnk/i763JFiiUAZR2
W4jgs08fzOH1kt0CttQSToKhIYB62w+ajQizEVkeFlvIwckJ8f84VhY+rJf3J1bp
OkkeJE6JI9lR5pPNPc8RUskKfsOnIHnfzo74xj8M5Rf1XfXvVCwgspK9zZ2jieXF
w60MwpcJb8X2HexuLZMUX/cGVosQEdI5Ec6dZCgjoUkqlYtV91ibxfyB6rQaVJfI
zgpYBBjTbq2uYyvR38oWEduhswQeIv+7Ue9khCdfVRcW8u4IjMTZ7vKpWs6VIKPR
EUZXCbmWu3vLEAKMoh2iYyHN8X36nJpG0o9MA8mmFHy64X6TH6o2JzvygT5KI4b+
7my9/CWyHS7Zd+54hfQEZUYEb/ThTDO5ibT/VMFtJ7uraEsbJ/U29LsVWQitVdwO
UOEXU+2SJ47GmAabN66acBsqlzdtC7ePQiBkVTrNk2x/J4BoyBZ4EeRTq1JsifaB
DAw2e/RbqP3YNGsOZ+8NZgdUWYaoWJooE34+utx3PReX0//Yeika7sSQMJaZ/VfP
D8+wJjCV8HwDt895vTBGqX1qmGoVrL/MHjtFEjB+fSvNy45y5Sw=
=H7Vo
-----END PGP SIGNATURE-----

--Sig_/T.A0yy34WUUll3kRBVs_g1_--

