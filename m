Received: from eggs.gnu.org ([2001:4830:134:3::10]:43578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dXjXS-0003hT-BZ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dXjXN-0006Hp-Kn
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:36:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dXjXN-0006HY-Er
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:36:49 -0400
Date: Wed, 19 Jul 2017 09:36:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170719093650.2ec8f439@Igors-MacBook-Pro.local>
In-Reply-To: <201707191225539935494@zte.com.cn>
References: <201707191225539935494@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hmp: allow cpu index for "info lapic"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wang.yi59@zte.com.cn
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, liu.yunh@zte.com.cn, dgilbert@redhat.com, pbonzini@redhat.com, Liu.Jianjun3@zte.com.cn, rth@twiddle.net

On Wed, 19 Jul 2017 12:25:53 +0800 (CST)
<wang.yi59@zte.com.cn> wrote:

> >On Mon, 17 Jul 2017 21:49:37 -0400
> 
> >Yi Wang <address@hidden> wrote:
> 
> >
> 
> >> Add [vcpu] index support for hmp command "info lapic", which is
> 
> >> useful when debugging ipi and so on. Current behavior is not
> 
> >> changed when the parameter isn't specified.
> 
> >we shouldn't expose cpu_index to users anymore,
> 
> >
> 
> >I would suggest using to use real APIC ID here but we don't
> 
> >have monitor command that returns APIC IDs for present cpus.
> 
> 
> 
> 
> Would you like to explain the reason we shouldn't use cpu_index any
> 
> more, which is more straightforward than socket-id/core-id/thread-id?
> 
> As Eduardo wrote in the next reply, "CPU #<n>" is already a perfectly
> 
> good identifier for a human interface :-)
We are working on hiding cpu_index from user interface,
it's still work in progress but and having old commands, that use cpu_index
and haven't been fixed yet, doesn't mean that we should add more.

Anyways as Eduardo pointed out combo of cpu/info lapic should be sufficient
for your task and this patch seems unnecessary.

> 
> Many thanks.
> 
> 
> 
> 
> 
> ---
> 
> Best wishes
> 
> Yi Wang
