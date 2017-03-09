Received: from eggs.gnu.org ([2001:4830:134:3::10]:39703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <piotr.rybicki@innervision.pl>) id 1clv2T-0001zB-JM
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 05:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <piotr.rybicki@innervision.pl>) id 1clv2Q-0005sY-DV
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 05:11:17 -0500
Received: from mail.iv.net.pl ([195.191.233.10]:60682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <piotr.rybicki@innervision.pl>)
	id 1clv2Q-0005rG-1G
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 05:11:14 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.iv.net.pl (Postfix) with ESMTP id 8374B1F0AD88
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 11:11:11 +0100 (CET)
Received: from mail.iv.net.pl ([127.0.0.1])
	by localhost (mail.iv.net.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VrgW02kzFL3z for <qemu-devel@nongnu.org>;
	Thu,  9 Mar 2017 11:11:11 +0100 (CET)
Received: from [192.168.127.114] (195.191.233.250.rev.iv.net.pl
	[195.191.233.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.iv.net.pl (Postfix) with ESMTPSA id 62AAA1F0AD86
	for <qemu-devel@nongnu.org>; Thu,  9 Mar 2017 11:11:11 +0100 (CET)
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<CAFEAcA9cM=LjBRzrZdfsOss2xm4bKC6QM7gyg3HD4z-yeumTyw@mail.gmail.com>
	<940ff281-82cd-18cf-160e-c5234f65db18@redhat.com>
	<9d6c61bc-4a95-ce72-3565-e498f9c2b351@redhat.com>
	<b815c2f9-1ce9-efed-4afa-c3553786dab1@redhat.com>
From: Piotr Rybicki <piotr.rybicki@innervision.pl>
Message-ID: <7829c1dc-9138-c784-dcc5-3c46ec9b5c05@innervision.pl>
Date: Thu, 9 Mar 2017 11:11:09 +0100
MIME-Version: 1.0
In-Reply-To: <b815c2f9-1ce9-efed-4afa-c3553786dab1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] external snapshots freezes block device since qemu 2.8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello there.

I discovered, that since qemu 2.8 , external snapshots (very similar to: 
http://wiki.libvirt.org/page/Live-disk-backup-with-active-blockcommit), 
freezes block device after:

# virsh blockcommit (...)

There is no error message after completion of the command above.
I'm using gluster + ZFS fuse mount as a storage for a VM on gentoo.
libvirt debug showed nothing helpful.
With qemu <2.8 -: snapshots are working as expected.

Is this a known issue?
Is it qemu or libvirt ?

If it helps, how can i diagnose this further?

Thank You & Best regards
Piotr Rybicki
