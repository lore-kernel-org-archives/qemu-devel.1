Received: from eggs.gnu.org ([2001:4830:134:3::10]:41650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f0pDb-00074L-S9
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f0pDX-0000WV-OZ
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:04:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50400 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f0pDX-0000WN-JX
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:04:51 -0400
Date: Tue, 27 Mar 2018 15:04:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180327140440.GC2838@work-vm>
References: <20180327123800.28851-1-sathnaga@linux.vnet.ibm.com>
	<c7c474a1-9084-543f-e374-270458fae7d8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7c474a1-9084-543f-e374-270458fae7d8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hmp.c: Revert hmp_info_cpus output format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: sathnaga@linux.vnet.ibm.com, qemu-devel@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

* Eric Blake (eblake@redhat.com) wrote:
> [adding the maintainer in cc]
> 
> On 03/27/2018 07:38 AM, sathnaga@linux.vnet.ibm.com wrote:
> > From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > 
> > This commit 137b5cb6ab565cb3781d5337591e155932b4230e
> > refactors info cpus output and changes output format from
> > 'thread_id' to 'thread-id', this would break parsing
> > of output in above layers like libvirt, test framework etc.
> > 
> > This patch just reverts back output format to 'thread_id'.
> > 
> > CC: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> > Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > ---
> >   hmp.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I can take this through my qapi tree if David is happy with it

Yes, with the commit message change you suggested.


Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> 
> > 
> > diff --git a/hmp.c b/hmp.c
> > index 679467d85a..a25c7bd9a8 100644
> > --- a/hmp.c
> > +++ b/hmp.c
> > @@ -381,7 +381,7 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
> >           monitor_printf(mon, "%c CPU #%" PRId64 ":", active,
> >                          cpu->value->cpu_index);
> > -        monitor_printf(mon, " thread-id=%" PRId64 "\n", cpu->value->thread_id);
> > +        monitor_printf(mon, " thread_id=%" PRId64 "\n", cpu->value->thread_id);
> >       }
> >       qapi_free_CpuInfoFastList(cpu_list);
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
