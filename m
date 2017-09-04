Received: from eggs.gnu.org ([2001:4830:134:3::10]:35962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gkurz@linux.vnet.ibm.com>) id 1domqg-00020e-EX
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 04:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gkurz@linux.vnet.ibm.com>) id 1domqd-0005m4-6Y
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 04:35:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gkurz@linux.vnet.ibm.com>)
	id 1domqc-0005kS-SU
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 04:35:11 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v848XmBY068158
	for <qemu-devel@nongnu.org>; Mon, 4 Sep 2017 04:35:08 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cs2shsut8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 04:35:08 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <gkurz@linux.vnet.ibm.com>;
	Mon, 4 Sep 2017 09:35:06 +0100
Date: Mon, 4 Sep 2017 10:35:00 +0200
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
In-Reply-To: <786fcc685c5e840bf56e3170008eb9a2.squirrel@mifritscher.de>
References: <1460447520-12499-1-git-send-email-michael@fritscher.net>
	<20160509103828.6bfc5b96@bahia.huguette.org>
	<840931cd5e646cc3ed11876ff556d032.squirrel@mifritscher.de>
	<786fcc685c5e840bf56e3170008eb9a2.squirrel@mifritscher.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170904103500.23baf790@bahia>
Subject: Re: [Qemu-devel] [PATCH v2] [WIP] [RFC ]Add initial 9pfs support
 for Windows hosts v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Fritscher <michael@fritscher.net>
Cc: sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org

On Mon, 28 Aug 2017 09:35:45 +0200
"Michael Fritscher" <michael@fritscher.net> wrote:

> Good day,
> 

Hi!

> only a short announcement: Sorry for the very long delay :-( But I'm
> working on this again. The biggest issue seems to be the *at stuff. I'll
> try to workaround this via getting the directories' path from the file
> descriptor with the /proc (as it is already done in the 9pfs_utils) -
> luckily,the mingw environment emulates the /proc. If this doesn't work
> I've another idea (the file descriptors needs to be "registered" with the
> path (and saved in a sparse vector or map with the fd as key and the path
> as value). The "big" solution would be to write a 9p_local_windows.c from
> scratch, but I would like to avoid it.
> 
> Additionally, I changed my approach: Instead of one big patch with
> everything in it, I split it into 2 patch series with several patches:
> 

I'd prefer to have a single series with all the patches because...

>   * The first one only fixes the build via adding #ifdefs, creating stubs
> in os-win32.h etc. and introduces no regressions. Status: Ready in my
> local repo: It compiles fine with enabled 9pfs and works. If 9pfs is
> tried to use there is a clean error message that the fsdev couldn't be
> initialized - as expected.
>   * The second one actually get 9pfs working. This involves mostly
> implementing the *at functions and a few tiny things (O_BINARY and so
> on) Status: Not started yet (will be at the next weekend I hope), but is
> a combination of parts of the the old patch + the implementation of the
> *at functions.
> 
> My hope is that the first series could be merged independently from the
> second. Meanings? If so I'll clean up the first patch series a bit

... I don't want to merge a bunch of code before I'm 100% sure the 9pfs
support on win32 is viable.

Cheers,

--
Greg

> (History cleaning) and send it to the list.
> 
> Best regards,
> Michael Fritscher
> 



-- 
Gregory Kurz                                     kurzgreg@fr.ibm.com
                                                 gkurz@linux.vnet.ibm.com
Software Engineer @ IBM/LTC                      http://www.ibm.com
Tel 33-5-6218-1607

"Anarchy is about taking complete responsibility for yourself."
        Alan Moore.
