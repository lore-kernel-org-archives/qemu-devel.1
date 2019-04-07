Received: from eggs.gnu.org ([209.51.188.92]:46287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <skrtbhtngr@gmail.com>) id 1hD6S7-0008PS-I6
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 07:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <skrtbhtngr@gmail.com>) id 1hD6S6-0007KZ-IO
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 07:59:11 -0400
Received: from smtp1.iitb.ac.in ([103.21.127.13]:45394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <skrtbhtngr@gmail.com>)
	id 1hD6S6-0007Ji-6E
	for qemu-devel@nongnu.org; Sun, 07 Apr 2019 07:59:10 -0400
Received: from ldns1.iitb.ac.in (ldns1.iitb.ac.in [10.200.12.1])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 79EBF104D0C9
	for <qemu-devel@nongnu.org>; Sun,  7 Apr 2019 17:29:07 +0530 (IST)
Received: from jeeves.cse.iitb.ac.in (miller.cse.iitb.ac.in [10.129.3.1])
	by ldns1.iitb.ac.in (Postfix) with ESMTP id BF2A1360034
	for <qemu-devel@nongnu.org>; Sun,  7 Apr 2019 17:29:03 +0530 (IST)
Received: from localhost.localdomain (unknown [10.130.4.191])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jeeves.cse.iitb.ac.in (Postfix) with ESMTPSA id C4E0C8C2BBF
	for <qemu-devel@nongnu.org>; Sun,  7 Apr 2019 17:29:02 +0530 (IST)
From: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Date: Sun,  7 Apr 2019 17:28:37 +0530
Message-Id: <20190407115839.25054-1-skrtbhtngr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RESEND v2 0/2] Move hvf_cpu_synchronize* calls
 to cpu_synchronize* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Changes made in v2:
- added a patch to declare hvf_handle_io only if NEED_CPU_H
  is defined so that the poisoned type CPUArchState does not
  produce an error when include/sysemu/hvf.h is included for
  common object compilation

Link to v1:
https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg06902.html

Sukrit Bhatnagar (2):
  hvf: declare hvf_handle_io if NEED_CPU_H is defined
  cpus: move hvf_cpu_synchronize* calls to cpu_synchronize* functions

 cpus.c                    | 12 ------------
 include/sysemu/hvf.h      |  4 ++++
 include/sysemu/hw_accel.h | 10 ++++++++++
 3 files changed, 14 insertions(+), 12 deletions(-)

--=20
2.20.1
