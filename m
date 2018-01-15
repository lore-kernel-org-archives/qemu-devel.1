Received: from eggs.gnu.org ([2001:4830:134:3::10]:57264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <scottgar@linux.vnet.ibm.com>) id 1ebAto-0000jn-1Q
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 14:58:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <scottgar@linux.vnet.ibm.com>) id 1ebAtk-0005fC-Vq
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 14:58:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36820
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <scottgar@linux.vnet.ibm.com>)
	id 1ebAtk-0005eu-QP
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 14:58:24 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0FJsS8b124467
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 14:58:23 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fh0caeak6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 14:58:23 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <scottgar@linux.vnet.ibm.com>;
	Mon, 15 Jan 2018 12:58:22 -0700
From: Scott Garfinkle <scottgar@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2018 13:58:19 -0600
In-Reply-To: <151600970022.20222.12880965081591608460.malonedeb@chaenomeles.canonical.com>
References: <151600970022.20222.12880965081591608460.malonedeb@chaenomeles.canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <1516046299.20858.1.camel@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Bug 1743337] [NEW] OS/2 Warp 4 HPFS corruption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1743337 <1743337@bugs.launchpad.net>, qemu-devel@nongnu.org

On Mon, 2018-01-15 at 09:48 +0000, MVoloshin wrote:
> Public bug reported:
> 
> How to reproduce:
> Install OS/2 Warp 4 onto HPFS-formatted partition. After reboot there
> will be messages about "missing" files and OS2.INI not found. Chkdsk
> C: complains about FS corruption. Nothing changes even after fixing
> errors and next reboot. If you install OS/2 onto FAT partition
> instead, everything will be OK. I also tried booting images with OS/2
> pre-installed through VBOX with same results. Is that HPFS driver or
> QEMU fault?
> 
Well, traps in OS2LVM (your other bug) and filesystem corruption (this
one) make my think there's something about the storage model in use.
Try a different one. I'm probably the last person ever to make changes
to any of that code, and that was like 15 years ago. I doubt that
anyone anywhere even has a build/debug environment set up any more. 
Anyhow, if changing the guests's storage device model doesn't work,
then you could also try hacking in the old OS2DASD, OS2LVM, IBM1S506
(iirc), and HPFS.  Good luck.

-Scott Garfinkle
IBM Linux KVM Development
formerly OS/2 
