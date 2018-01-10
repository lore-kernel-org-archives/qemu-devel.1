Received: from eggs.gnu.org ([2001:4830:134:3::10]:58829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eZJVE-0003Pa-6u
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eZJVA-0005mJ-Rs
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:45:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eZJVA-0005la-KX
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:45:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA72C80484
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 16:45:19 +0000 (UTC)
Date: Wed, 10 Jan 2018 14:45:17 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180110164517.GT6646@localhost.localdomain>
References: <1515597770-268979-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515597770-268979-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] possible_cpus: add CPUArchId::type field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Jan 10, 2018 at 04:22:50PM +0100, Igor Mammedov wrote:
> Remove dependency of possible_cpus on 1st CPU instance,
> which decouples configuration data from CPU instances that
> are created using that data.
> 
> Also later it would be used for enabling early cpu to numa node
> configuration at runtime qmp_query_hotpluggable_cpus() should
> provide a list of available cpu slots at early stage,
> before machine_init() is called and the 1st cpu is created,
> so that mgmt might be able to call it and use output to set
> numa mapping.
> 
> Use MachineClass::possible_cpu_arch_ids() callback to set
> cpu type info, along with the rest of possible cpu properties,
> to let machine define which cpu type* will be used.
> 
> * for SPAPR it will be a spapr core type and for ARM/s390x/x86
>   a respective descendant of CPUClass.
> 
> Move parse_numa_opts() in vl.c after cpu_model is parsed into
> cpu_type so that possible_cpu_arch_ids() would know which
> cpu_type to use during layout initialization.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Queued to machine-next, thanks.

-- 
Eduardo
