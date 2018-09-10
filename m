Received: from eggs.gnu.org ([2001:4830:134:3::10]:59154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzQSG-0008Al-Tj
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 13:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fzQSC-0002GN-De
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 13:58:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40182 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fzQSC-0002Fk-8o
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 13:58:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9E4CD400C3C2
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 17:58:27 +0000 (UTC)
References: <1536067356-44609-1-git-send-email-imammedo@redhat.com>
	<1536067356-44609-2-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <94590e00-d0ae-2ac2-ea88-abb883066037@redhat.com>
Date: Mon, 10 Sep 2018 12:58:24 -0500
MIME-Version: 1.0
In-Reply-To: <1536067356-44609-2-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] [PATCH v5 1/2] vl.c deprecate incorrect
 CPUs topology
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, drjones@redhat.com, ehabkost@redhat.com

On 9/4/18 8:22 AM, Igor Mammedov wrote:
> -smp [cpus],sockets/cores/threads[,maxcpus] should describe topology
> so that total number of logical CPUs [sockets * cores * threads]
> would be equal to [maxcpus], however historically we didn't have
> such check in QEMU and it is possible to start VM with an invalid
> topology.
> Deprecate invalid options combination so we can make sure that
> the topology VM started with is always correct in the future.
> Users with an invalid sockets/cores/threads/maxcpus values should
> fix their CLI to make sure that
>     [sockets * cores * threads] == [maxcpus]
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

>   
> +@subsection -smp X,[socket=a,core=b,thread=c],maxcpus=Y (since 3.1)
> +
> +CPU topology properties should describe whole machine topology including
> +possible CPUs, but historically it was possible to start QEMU with
> +an incorrect topology where
> +  sockets * cores * threads >= X && X < maxcpus
> +which could lead to an incorrect topology enumeration by the guest.
> +Support for invalid topologies will be removed, the user must ensure
> +topologies described with -smp include all possible cpus, i.e.
> +  sockets * cores * threads == maxcpus
> +Note: it's assumed that maxcpus value must be multiple of the topology
> +options present on command line to avoid creating an invalid topology.
> +If maxcpus isn't be multiple of present topology options then the condition

s/be/a/

> +(sockets * cores * threads == maxcpus) can't be satisfied and it will
> +trigger deprecation warning which later will be converted to a error.

a/a error/an error/

> +If you get deprecation warning it's recommended to explicitly specify

s/get/get a/

> +a correct topology to make warning go away and ensure that it will
> +continue working in the future.
> +
-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
