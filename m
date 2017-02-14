Received: from eggs.gnu.org ([2001:4830:134:3::10]:49978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kumar.shubham@research.iiit.ac.in>)
	id 1cdknm-0004sJ-Dk
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:38:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kumar.shubham@research.iiit.ac.in>)
	id 1cdknj-0003sa-8z
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:38:22 -0500
Received: from research.iiit.ac.in ([196.12.53.8]:51738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kumar.shubham@research.iiit.ac.in>)
	id 1cdkni-0003pe-MX
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 16:38:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by research.iiit.ac.in (Postfix) with ESMTP id 5B0AF741E30
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 03:08:13 +0530 (IST)
Received: from research.iiit.ac.in ([127.0.0.1])
	by localhost (research.iiit.ac.in [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id KvcCQOoye0zX for <qemu-devel@nongnu.org>;
	Wed, 15 Feb 2017 03:08:12 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by research.iiit.ac.in (Postfix) with ESMTP id 6CB09741E21
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 03:08:12 +0530 (IST)
Received: from research.iiit.ac.in ([127.0.0.1])
	by localhost (research.iiit.ac.in [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cqszxgUHucUY for <qemu-devel@nongnu.org>;
	Wed, 15 Feb 2017 03:08:12 +0530 (IST)
Received: from research.iiit.ac.in (localhost [127.0.0.1])
	by research.iiit.ac.in (Postfix) with ESMTP id 56FBC741B59
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 03:08:12 +0530 (IST)
Date: Wed, 15 Feb 2017 03:08:12 +0530 (IST)
From: Shubham Kumar <kumar.shubham@research.iiit.ac.in>
Message-ID: <1202180823.778907.1487108292243.JavaMail.zimbra@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] regarding bug name : -hda FAT:. limited to 504MBytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Since the problem seems like the used FAT-16 file system , 
Will it solve the problem if I change the code of  vvfat.c for FAT-32 file system to increase acceptable file size ?

Regards
Shubham Kumar
