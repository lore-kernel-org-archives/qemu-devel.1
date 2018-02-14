Received: from eggs.gnu.org ([2001:4830:134:3::10]:42805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1elspn-0000SD-NE
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 03:54:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aderumier@oxygem.tv>) id 1elspj-0008Ll-Rh
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 03:54:35 -0500
Received: from mailpro.odiso.net ([89.248.211.110]:42428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aderumier@oxygem.tv>) id 1elspj-0008Dq-K5
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 03:54:31 -0500
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 561881F559CE
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 09:54:21 +0100 (CET)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Vh0sBW3Fsxmx for <qemu-devel@nongnu.org>;
	Wed, 14 Feb 2018 09:54:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mailpro.odiso.net (Postfix) with ESMTP id 3938E1F559CD
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 09:54:21 +0100 (CET)
Received: from mailpro.odiso.net ([127.0.0.1])
	by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KmdkRnSkrQbT for <qemu-devel@nongnu.org>;
	Wed, 14 Feb 2018 09:54:21 +0100 (CET)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.111])
	by mailpro.odiso.net (Postfix) with ESMTP id 24E881F559CC
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 09:54:21 +0100 (CET)
Date: Wed, 14 Feb 2018 09:54:21 +0100 (CET)
From: Alexandre DERUMIER <aderumier@odiso.com>
Message-ID: <201297396.3423395.1518598461012.JavaMail.zimbra@oxygem.tv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] drive-mirroring to nbd is failing with multiple
 parallel jobs (qemu 2.9 -> 2.11)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

Hi,

I currently have failing mirroring jobs to nbd, when multiple jobs are running in parallel.


step to reproduce, with 2 disks:


1) launch mirroring job of first disk to remote target nbd.(to qemu running target)
2) wait until is reach  ready = 1 , do not complete
3) launch mirroring job of second disk to remote target nbd(to same qemu running target)

-> mirroring job of second disk is currently running (ready=0), first disk is still at ready=1 and still mirroring new write coming.


then, after some time, mainly if no new write are coming to first disk (around 30-40s), the first job is crashing with input/output error.



Note that I don't have network problem, or disk problem, I'm able to mirror both disk individually.


Another similar bug report on proxmox bugzilla:

https://bugzilla.proxmox.com/show_bug.cgi?id=1664


Maybe related to this :
https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg03086.html
?


I don't remember to have the problem with qemu 2.7, but I'm able to reproduce with qemu 2.9 && qemu 2.11.


Best Regards,

Alexandre
