Received: from eggs.gnu.org ([2001:4830:134:3::10]:60959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1faLTq-0007Sg-H8
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1faLTm-0000QU-O2
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:36:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59424 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1faLTm-0000Pz-GQ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 09:36:26 -0400
Date: Tue, 3 Jul 2018 21:36:21 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180703133621.GH485@lemon.usersys.redhat.com>
References: <20180702165842.11423-1-rkagan@virtuozzo.com>
	<42e1ca43-c31a-43a7-950e-57695c5ddd7f@redhat.com>
	<20180703074717.GB30904@rkaganb.sw.ru>
	<20180703080035.GF485@lemon.usersys.redhat.com>
	<0688fe25-4b5c-38f6-03fb-a4d3e7cb9ce7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0688fe25-4b5c-38f6-03fb-a4d3e7cb9ce7@redhat.com>
Subject: Re: [Qemu-devel] patchew header docs [was: Re: [PATCH 0/6] hyperv:
 refactor HvSintRoute management]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, Liran Alon <liran.alon@oracle.com>, Igor Mammedov <imammedo@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>

On Tue, 07/03 07:48, Eric Blake wrote:
> On 07/03/2018 03:00 AM, Fam Zheng wrote:
> > On Tue, 07/03 10:47, Roman Kagan wrote:
> > > On Mon, Jul 02, 2018 at 03:55:33PM -0500, Eric Blake wrote:
> > > > On 07/02/2018 11:58 AM, Roman Kagan wrote:
> > > > > This series modifies the management of HvSintRoute, which is an
> > > > > important building block in Hyper-V emulation infrastructure, to make it
> > > > > easier to maintain and enhance, and paves the way to the more complete
> > > > > Synthetic Interrupt Controller (SynIC) emulation.
> > > > > 
> > > > > This series applies on top of "[PATCH 0/2] hyperv: ensure VP index equal
> > > > > to QEMU cpu_index" series (message-id:
> > > > > <20180702134156.13404-1-rkagan@virtuozzo.com>).
> > > > 
> > > > Rewriting that in a form that patchew can parse:
> > > > 
> > > > Based-on: 20180702134156.13404-1-rkagan@virtuozzo.com
> > > 
> > > Thanks!
> > > 
> > > Are patchew-recognized headers documented anywhere?
> > 
> > No dedicated documentation so far becasue the only recognized syntax is this
> > "^Based-on: $MESSAGE_ID$" line, which is mentioned in
> 
> I seem to recall that "^Based-on: $URL$" also works, when $URL points to a
> message within https://lists.gnu.org/archive/html/qemu-devel/ (at least,
> I've used it in a few cases, rather than further looking up the translation
> from $URL to $MESSAGE_ID myself).
> 
> > 
> > https://wiki.qemu.org/Contribute/SubmitAPatch
> > 
> > There are requests to support more, such as the git base tree information:
> > 
> > https://github.com/patchew-project/patchew/issues/79
> 
> And if my recollection was wrong, adding $URL support would be one of those
> requests, and perhaps ought to be given an issue so we don't forget it.

I've created one now:

https://github.com/patchew-project/patchew/issues/84

Thanks,
Fam
