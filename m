Received: from eggs.gnu.org ([2001:4830:134:3::10]:52208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejstD-0007YZ-Q8
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejstA-0003tQ-Ng
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:33:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ejstA-0003tF-IC
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:33:48 -0500
Date: Thu, 8 Feb 2018 18:33:42 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180208203342.GE13981@localhost.localdomain>
References: <20180208111732.09869f84@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208111732.09869f84@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luiz Capitulino <lcapitulino@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, mihajlov@linux.vnet.ibm.com, eblake@redhat.com, berrange@redhat.com

On Thu, Feb 08, 2018 at 11:17:32AM -0500, Luiz Capitulino wrote:
[...]
> The "halted" field is somewhat controversial. On the one hand,
> it offers a convenient way to know if a guest CPU is idle or
> running. On the other hand, it's a field that can change many
> times a second. In fact, the halted state can change even
> before query-cpus-fast has returned. This makes one wonder if
> this field should be dropped all together. Having the "halted"
> field as optional gives a better option for dropping it in
> the future, since we can just stop returning it.

I'd just drop it, unless we find a use case where it's really
useful.

Also, the code that sets/clears cpu->halted is target-specific,
so I wouldn't be so sure that simply checking for
!kvm_irqchip_in_kernel() is enough on all targets.

-- 
Eduardo
