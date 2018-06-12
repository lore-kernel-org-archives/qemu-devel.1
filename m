Received: from eggs.gnu.org ([2001:4830:134:3::10]:58357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fShZ1-0001is-7A
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fShYy-0001Ry-4T
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:34:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38978 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fShYx-0001Rf-Vd
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 07:34:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 64A7880401A8
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 11:34:11 +0000 (UTC)
References: <20180612062430.GA15344@xz-mi>
	<20180612064119.GC29380@lemon.usersys.redhat.com>
	<20180612065229.GB15344@xz-mi>
	<20180612070152.GD29380@lemon.usersys.redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a8a0c642-ab81-d693-3326-4db87c6a9240@redhat.com>
Date: Tue, 12 Jun 2018 13:34:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180612070152.GD29380@lemon.usersys.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Is there a way to package QEMU binaries?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: QEMU Devel Mailing List <qemu-devel@nongnu.org>

On 06/12/18 09:01, Fam Zheng wrote:

>     scp -r /tmp/qemu-install $remote

"tar -c | ssh $remote tar -x" is generally much more performant than scp
(because of asynchronity), plus "tar" can transfer a bunch of extended
file attributes too, if parametrized correctly (my preference is "--acls
--selinux --xattrs" when it matters).

For progress updates, pass "-v" to the remote tar, or else insert "pv"
("pipe viewer") between the local tar and ssh.

Thanks,
Laszlo
