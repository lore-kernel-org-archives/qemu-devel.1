Received: from eggs.gnu.org ([2001:4830:134:3::10]:39561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fk5yc-0004xh-CR
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fk5yX-0000e2-CN
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:04:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50028 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fk5yX-0000dk-6H
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:04:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A09504021FC6
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 11:04:28 +0000 (UTC)
Date: Mon, 30 Jul 2018 13:04:25 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180730130425.61884cc3@redhat.com>
In-Reply-To: <1532703031-166467-1-git-send-email-imammedo@redhat.com>
References: <1532703031-166467-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.0] pc: acpi: fix memhp regression by
 reducing stub SRAT entry size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, mst@redhat.com

On Fri, 27 Jul 2018 16:50:31 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> Commit 848a1cc1e (hw/acpi-build: build SRAT memory affinity structures for DIMM devices)
> broke the first dimm hotplug in following cases:
> 
>  1: there is no coldplugged dimm in the last numa node
>     but there is a coldplugged dimm in another node
> 
>   -m 4096,slots=4,maxmem=32G               \
>   -object memory-backend-ram,size=2G,id=m0 \
>   -device pc-dimm,memdev=m0,node=1         \
>   -object memory-backend-ram,id=m1,size=2G \
>   -device pc-dimm,memdev=m1,node=0         \
>   -numa node,nodeid=0                      \
>   -numa node,nodeid=1
> 
>  2: if order of dimms on CLI is:
>        1st plugged dimm in node1
>        2nd plugged dimm in node0
> 
>   -m 4096,slots=4,maxmem=32G               \
>   -object memory-backend-ram,id=m1,size=2G \
>   -device pc-dimm,memdev=m1,node=0         \
>   -numa node,nodeid=0                      \
>   -numa node,nodeid=1
> 

self-NACK on this one,
I've mixed up examples in commit message, it should have been other way around.
I've just posted v2 with fixed commit message


[...]
