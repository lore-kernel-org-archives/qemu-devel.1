Received: from eggs.gnu.org ([2001:4830:134:3::10]:47448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1duIe6-0006HD-79
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1duIe2-0002Ym-Qm
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:33:02 -0400
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:35701)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1duIe2-0002XQ-LR
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:32:58 -0400
Received: from player691.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id EE63193E4E
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 15:32:56 +0200 (CEST)
Date: Tue, 19 Sep 2017 15:32:31 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170919131405.301817a8@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <7d5e2b72-808b-2a71-b285-35c16a273f94@huawei.com>
References: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1505385610-35529-3-git-send-email-pradeep.jagadeesh@huawei.com>
	<23a3b68e-efa5-5daa-363e-f697e3d8ae2f@redhat.com>
	<7d5e2b72-808b-2a71-b285-35c16a273f94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v11 2/6] qmp: Use ThrottleLimits structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Cc: Eric Blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On Tue, 19 Sep 2017 12:06:26 +0200
Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com> wrote:

> On 9/18/2017 7:10 PM, Eric Blake wrote:
> > On 09/14/2017 05:40 AM, Pradeep Jagadeesh wrote:  
> >> This patch factors out code to use the ThrottleLimits
> >> strurcture.  
> >
> > s/strurcture/structure/
> >  
> >>
> >> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> >> Reviewed-by: Greg Kurz <groug@kaod.org>
> >> Reviewed-by: Eric Blake <eblake@redhat.com>  
> >
> > Echoing the sentiments made elsewhere - this is a significant rewrite
> > from the earlier version, so you WANT reviewers to look at it fresh
> > rather than assuming that previous reviews still apply.
> >  
> OK, but shall I send them as V12 or V01 again?
> 

The version is rather tied to the whole patchset than to each
individual patch. The next round will be the 12th, so all
patches should have v12 in the Subject.

> -Pradeep
> 

-- 
Gregory Kurz                                     kurzgreg@fr.ibm.com
                                                 gkurz@linux.vnet.ibm.com
Software Engineer @ IBM/LTC                      http://www.ibm.com
Tel 33-5-6218-1607

"Anarchy is about taking complete responsibility for yourself."
        Alan Moore.
