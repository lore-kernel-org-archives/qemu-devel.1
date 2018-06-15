Received: from eggs.gnu.org ([2001:4830:134:3::10]:33304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fTntb-0006RM-Sm
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fTntY-0006Nv-Pz
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:32:03 -0400
Date: Fri, 15 Jun 2018 14:31:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180615143153.21bfd105@redhat.com>
In-Reply-To: <bbac3756-1966-b69b-8974-d6c9b31208eb@redhat.com>
References: <20180615112500.19854-1-david@redhat.com>
	<20180615112500.19854-3-david@redhat.com>
	<20180615135134.05f1e018@redhat.com>
	<bbac3756-1966-b69b-8974-d6c9b31208eb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/12] pc: rename
 pc_dimm_(plug|unplug|...)* into pc_memory_(plug|unplug|...)*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On Fri, 15 Jun 2018 13:52:25 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 15.06.2018 13:51, Igor Mammedov wrote:
> > On Fri, 15 Jun 2018 13:24:50 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> Use a similar naming scheme as spapr. This way, we can go ahead and
> >> rename e.g. pc_dimm_memory_plug to pc_dimm_plug_plug, which avoids  
> >                                      ^^^^^ typo?  
> 
> Indeed, luckily only in the patch description.

with that fixed
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
