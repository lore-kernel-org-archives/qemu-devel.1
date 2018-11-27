Received: from eggs.gnu.org ([2001:4830:134:3::10]:39111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRdOr-0005rG-3C
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:27:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRdEO-0006gq-RV
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:16:51 -0500
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4c274aa6-90e9-bf8f-c0d0-55c7553e472b@redhat.com>
Date: Tue, 27 Nov 2018 07:16:44 -0600
MIME-Version: 1.0
In-Reply-To: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/9] ppc: get rid of
 g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>

On 11/27/18 7:04 AM, Greg Kurz wrote:
> As explained in HACKING, the g_malloc(sizeof(T) * n) construct is unsafe
> because it can't detect multiplication overflowing size_t and doesn't
> allow type checking.
> 
> It appears to be used in a bunch of places though:
> 
> $ git grep -E 'malloc.*sizeof' | grep ' \* '  | wc -l
> 101
> 
> This series fixes the ppc target and ppc machine code. The changes are
> mostly trivial. Only the mac99 and e500 machines required some more work
> that should be reviewed carefully, as it was only compile-tested.

Did you do this all manually, or did you try to use Coccinelle?  Hmm - 
we have a Coccinelle script for this mentioned in commit b45c03f (most 
recently reused in bdd81add) - but it is not yet in scripts/coccinelle/. 
  Maybe that would be worth doing now.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
