Received: from eggs.gnu.org ([2001:4830:134:3::10]:52714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dBhjs-0004hh-7A
	for qemu-devel@nongnu.org; Fri, 19 May 2017 09:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dBhjr-00040m-Hh
	for qemu-devel@nongnu.org; Fri, 19 May 2017 09:14:40 -0400
References: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1495172439-1504-2-git-send-email-bharata@linux.vnet.ibm.com>
	<20170519073303.GK12284@umbus.fritz.box>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <b39e67c9-f7e7-9277-56e5-8e0769efc15d@redhat.com>
Date: Fri, 19 May 2017 15:14:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170519073303.GK12284@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/4] migration: Introduce
 unregister_savevm_live()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: rnsastry@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sam.bobroff@au1.ibm.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 19/05/2017 09:33, David Gibson wrote:
> On Fri, May 19, 2017 at 11:10:36AM +0530, Bharata B Rao wrote:
>> Introduce a new function unregister_savevm_live() to unregister the vmstate
>> handlers registered via register_savevm_live().
>>
>> register_savevm() allocates SaveVMHandlers while register_savevm_live()
>> gets passed with SaveVMHandlers. During unregistration, we  want to
>> free SaveVMHandlers in the former case but not free in the latter case.
>> Hence this new API is needed to differentiate this.
>>
>> This new API will be needed by PowerPC to unregister the HTAB savevm
>> handlers.
>>
>> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> 
> I could take this through my tree, but it would need an ACK from Dave
> Gilbert or Juan Quintela.

I cc: them for that.

Just a comment on the patch.

Instead of introducing a new function, perhaps we can homogenize the use
of register_savevm() by always providing a SaveVMHandlers pointer and
never a couple of (SaveStateHandler, LoadStateHandler) so the
unregister_save() has never to free se->ops?

Laurent
