Received: from eggs.gnu.org ([2001:4830:134:3::10]:41500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cgHkl-0006y3-NF
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:13:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cgHkh-0002WF-CW
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:13:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cgHkh-0002Vi-6p
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 16:13:39 -0500
References: <9533ba99-b143-b577-0115-742119d089a4@kamp.de>
From: John Snow <jsnow@redhat.com>
Message-ID: <9292fef8-929a-e89e-eca5-cd247ca9334b@redhat.com>
Date: Tue, 21 Feb 2017 16:13:36 -0500
MIME-Version: 1.0
In-Reply-To: <9533ba99-b143-b577-0115-742119d089a4@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Qemu and Changed Block Tracking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 02/21/2017 07:43 AM, Peter Lieven wrote:
> Hi,
> 
> 
> is there anyone ever thought about implementing something like VMware
> CBT in Qemu?
> 
> 
> https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1020128
> 
> 
> 
> Thanks,
> Peter
> 
> 

A bit outdated now, but:
http://wiki.qemu-project.org/Features/IncrementalBackup

and also a summary I wrote not too far back (PDF):
https://drive.google.com/file/d/0B3CFr1TuHydWalVJaEdPaE5PbFE

and I'm sure the Virtuozzo developers could chime in on this subject,
but basically we do have something similar in the works, as eblake says.

--js
