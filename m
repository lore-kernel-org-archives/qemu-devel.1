Received: from eggs.gnu.org ([2001:4830:134:3::10]:42381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eBhTP-0006OO-DC
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:29:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eBhTM-0005S2-9B
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:29:55 -0500
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:48474)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eBhTM-0005RC-36
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 08:29:52 -0500
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id F08AB76CD7
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 14:29:48 +0100 (CET)
Date: Mon, 6 Nov 2017 14:29:41 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171106142941.2a555646@bahia>
In-Reply-To: <20170929111323.6308-1-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Make 9pfs buildable for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Fritscher <michael@fritscher.net>
Cc: sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org, Greg Kurz <gkurz@linux.vnet.ibm.com>

On Fri, 29 Sep 2017 13:13:05 +0200
Michael Fritscher <michael@fritscher.net> wrote:

> Good day,
> 

Hi,

Sorry for the late reply... Since I have only limited bandwidth, I'll only
be able to provide some limited feedback.

A global remark to start with: it is a usual practice to prefix each patch
title with the component's name, as explained here:

https://wiki.qemu.org/Contribute/SubmitAPatch#Write_a_meaningful_commit_message

eg, patch titles in this series should start with something like with fsdev: or
9pfs: or oslib-win32:

> this is the patch series to make 9pfs buildable (not working!) on Windows.
> It is compiling and starts, but obvousily 9pfs is not working - in fact it
> spits out a initializing error.
> 

What's the error message ?

> Next step: Implement the directory and file handling stuff.
> 
> Quoting myself:
> 
> "
> The biggest issue seems to be the *at stuff. I'll
> try to workaround this via getting the directories' path from the file
> descriptor with the /proc (as it is already done in the 9pfs_utils) -
> luckily,the mingw environment emulates the /proc. If this doesn't work
> I've another idea (the file descriptors needs to be "registered" with the
> path (and saved in a sparse vector or map with the fd as key and the path
> as value). The "big" solution would be to write a 9p_local_windows.c from
> scratch, but I would like to avoid it.
> "
> 
> I know that some people want to have compiling and working together, but I
> hope(!) that I get a first working version next week.
> 

Any updates ? Not sure people will spend time reviewing this series until
something actually works.

> Best regards,
> Michael Fritscher
> 

Cheers,

--
Greg

PS: if you repost, please use my maintainer's email address groug@kaod.org
