Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589FCCA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 17:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7C721726
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 17:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7C721726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQx2U-0001Kj-N1
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 13:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iQwzl-0000Dx-Cj
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 13:15:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iQwzj-0006Yk-Fa
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 13:15:24 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:38343)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iQwzj-0006NA-6C
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 13:15:23 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mtf39-1i6Fqe0tzj-00vA8y; Sat, 02 Nov 2019 18:15:15 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] dp8393x: fix problems detected with Quadra 800 machine
Date: Sat,  2 Nov 2019 18:15:08 +0100
Message-Id: <20191102171511.31881-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+Zl3PnJTxSCPNWlBjauQg+taTTEcC23Eny+0vdm/ZSVsOtuWh0t
 Aet3TDC39kvNShL6mitAU/K+X1Tq8OItzayhp4tVrkwM8Lw74R5bE+DoUpcT6Iq0J9+9z5c
 yTC8HrJEaFQU3+dBrhUmaoeWEImQJjotyXCuG5sSXwmGy61DrBdijxn5XS5JjDXwFOKQSco
 CqFcrPcY6TkJaAzp74tNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CLFINZY+btc=:FMQCwHuhU/kNSxnO/Igbyp
 I+vvHFnRNwZeg8tjPNMSTZ/UHmrZS9INAtB0DX7/UnU+jg+dnrWhqv41Ad5WS6//ZqDzELJ4R
 w1E2mRZTeu+JmsP1Bs919miT6XtPjdVLzlfTroIqmP4eLMYcolRQ1WnfiEWEbRJ9qiNlfZJ0z
 FeLKf2Xhfv+Nsax3tTZoUwWJywyDuFVwLjLBlM1+6G/795WHgbdTzOtaXoHCKvRQOkTgudO9v
 NmrHzTf/qf1JxZNZkEsuIp8biqc6lQamtO6FCwtS/omBMBIWBpCvFZvykOVe2fgidfhqBcN/8
 QS0UjnRHgqspjq7Fg/6wAUKT6wBJoXRSrN4ej3JyJjQxdvgw5jv9cHQxeDaHxzL+9pW0I585L
 TK/7n9HiXgNu9irXhtDvmfYwKP6Gr0RnWZNonx3DCIaKRy1Rf9At+9smdj/W7ET2Hu69jZa3G
 vaydoo8iVqfFt9RJ4EKl6N4urc5RArC+kb+hT0bFYe59T6AMOuH9qSksnz1/vEj6eN8U29dn6
 m61a9MhWpxAluvgJ74DiCA5cPJ9MrWodXINhMS0HDsQMESdtMqGukbPiyVrSA5v0t0K0WhOcm
 Eja07E8GCWeHlHC5p3TdMxPWtSz/V0rqG/YGLHkDSBFimF4J0+J8/8dlnI1g1rByYmPDPAwox
 n2LLRaHdEIgZfb9X6SiHYrHOTlWcgQr+HjRrMOqZAJ3on65/DpUEmgGVi42ABmjIZKmH6gOd0
 IMd3d7BmlZZW1CRfUTJnghOIfHEywc4zwz6h9+sEwHPEPDshtdoRv/8e8gGdKXkPyF9da1vvP
 dxxfteoro+ncTrwhFyGyl12Nsv0MfDx4NN1915vJB2lgCXaxCLlQz8Xg25zp2ZOI5gifJWDXB
 5F2ZvOtaefEWwXdKcoAg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series starts with a cleanup of the DMA buffer, moving
it from the stack to the state structure.

The following patch allows to negociate the IP address with
the DHCP server.

The last one fixes the buffer exhaustion case.

With this series Q800 networking card is fully functionnal.

Laurent Vivier (3):
  dp8393x: put the DMA buffer in the state structure
  dp8393x: fix dp8393x_receive()
  dp8393x: fix receiving buffer exhaustion

 hw/net/dp8393x.c | 136 +++++++++++++++++++++++------------------------
 1 file changed, 66 insertions(+), 70 deletions(-)

-- 
2.21.0


