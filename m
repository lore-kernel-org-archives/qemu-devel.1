Return-Path: <SRS0=iAYr=VY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58251C7618B
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2019 06:16:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B3420840
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2019 06:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="W9OaU+kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B3420840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrG0F-0005qX-Sm
	for qemu-devel@archiver.kernel.org; Sat, 27 Jul 2019 02:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53471)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.kiszka@web.de>) id 1hrFzz-0005G5-Ex
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 02:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@web.de>) id 1hrFzy-0002w7-9W
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 02:16:07 -0400
Received: from mout.web.de ([212.227.15.4]:35081)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1hrFzx-0002YT-4f
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 02:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1564208150;
 bh=SvluMIiZjXT+iQb9ZfZF36xhI/RV62E9Bo8M7KKGTpY=;
 h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
 b=W9OaU+kvmJdVz/w/sKJ9T0GOGlne+VaPxYBYnCJQDyfKgPqLqc/NfvzewpbiuOW6Q
 kOxECiBNq7NOhzyEC230Dbtqx6hPy1Btc7q23xrDg3trBNE48P7wf/4Y4zpFrFSCKK
 zsB+A9tu92EdcArupD3dHucCPXtRs9mlGhhmOvZM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.55.156]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdEif-1iHD5r0tiT-00iQaZ; Sat, 27
 Jul 2019 08:15:50 +0200
To: qemu-devel <qemu-devel@nongnu.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <759f8f44-9a01-a9f1-c7cf-65d40151a93a@web.de>
Date: Sat, 27 Jul 2019 08:15:48 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IAJKmlKCwYXUaGpDriqdG1S+jUgthk6mYg9oFquoA8Kg52hLJ3y
 T0MsWEuvd/lx59jq11qLPIeiwwtTnoTpHf98dXViWVsRukHOcQ7X0oWVcge0YtIHn+JmGeT
 l3DIOmoPVOm4i8/ZuivaQGCDQLgyi8xdxERtxshIIHDb+3sMTCtvRTQsqfltgYo/ZRuVzn6
 nXjntlQPw+Tq4m75PhgiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W91EnSsTd4c=:xf04fqCwfeqVIDj9uanhxa
 mYm3fxerUD/oLwE/UKGoWqgiRDfo6uSn7U9q6ErILxoNXwYSisklEZK+erHq007MX9WA4pHZc
 wSEJmHyLklk3CvkMMaFg3EyW80qoifEgxcMqmtQ/qjHX/+oLrOgiDUgPIwDQ/cCQb17m+vCd1
 GG1nSjcFQ3gvlKVlhQXQO8HBm7z9mHmToW0uJao05cCCo0kN3WVTcj8x3WANaRHTRXpiqFDhI
 ZxZ1JoiJFmnYdfPODwE+cNOWd7C0S/EVjSRxTK/MnGjXBO0OGWcp/eDm9KMahcF/u3y0XJ4M8
 fOnl34cXaCcqSuaFZfGaB3N4ufvICSJQkKGaKx/L2gfIbHr4wyMrgokxU3474NRLWxk6JCvJT
 QEtAMVEQUq/s5RcolJqso5250qf8YERkcTW/d+ox3yhANz56tlnNEtzFjDsScplvK5kbmzthT
 Ia5vZ1+pMjt1mef1oVzouaRvDBPXroL1g5W9c++412ULjToFKxX+DQTQ7BFICOUoEkfjQpD/h
 Ucr/hRBhB1xscdzkMfyVVAWtdR2hAEBj4IZMWVr18XvRpNhaTMISt8CxwkXYdWyazu8x8XZ9w
 7uBhPmcKx8Gb+TORNpodYUr80RRY5SqWj+2rqWjyGkI49bkSo+Axu5/d7c62ctiQ+2eS1iIwF
 rrUo9+W6dR+ZvShyodf8MX8mhEMdcUqJUdVmd2tf3zF0bJI+VRFoTlROHqEY6vuSerOgepVan
 lvnYxBiVF8njrDfR44I1v0G9tkEZGtX98aNGy9Vm8wOJzjOrSrosMcMEJwe5teuSB/jYsrO5H
 3FQFrU5IZd310OrBSw3Qb5AsHNd/jf6l1vjP+Ev/Vz9Uh6ilsMWptpvfcLaO5VBU/qvH50Mrv
 Cg7QXHmmBLO5c2TShqF+wbSClsJ2gLjNgbLtEWMeEjAU9QhI9/HBdRYXruYewE7L57HIvZN7k
 asfj31VAwrns+YGqbAqUIDjDj064l1/eh9iflnF5qml6LE0NDLNYFOPuUBUJvA7q1aFziYqbm
 hXLKrV2spfUA5MFwsLmr0Nnhc91RsYBtCdhWJf0aVk1wcpFQoZICaj/wv0AbfcuETxbIwFHNz
 2ti5KBbDAIjsu14nk9uZbfNutW2cLAJoNrK
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.4
Subject: [Qemu-devel] [PATCH] MAINTAINERS: slirp: Remove myself as maintainer
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

I haven't been doing anything here for a long time, nor does my git repo
still play a role.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6de200453..238feb965f 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2089,13 +2089,11 @@ F: include/hw/registerfields.h

 SLIRP
 M: Samuel Thibault <samuel.thibault@ens-lyon.org>
-M: Jan Kiszka <jan.kiszka@siemens.com>
 S: Maintained
 F: slirp/
 F: net/slirp.c
 F: include/net/slirp.h
 T: git https://people.debian.org/~sthibault/qemu.git slirp
-T: git git://git.kiszka.org/qemu.git queues/slirp

 Stubs
 M: Paolo Bonzini <pbonzini@redhat.com>
=2D-
2.16.4

