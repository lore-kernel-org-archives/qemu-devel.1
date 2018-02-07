Received: from eggs.gnu.org ([2001:4830:134:3::10]:41868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejRcB-0002ns-Ih
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:26:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejRc8-0004fd-Fu
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:26:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ejRc8-0004fC-An
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 10:26:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7025BE1854
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 15:26:23 +0000 (UTC)
Date: Wed, 7 Feb 2018 13:25:52 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180207152552.GK3291@localhost.localdomain>
References: <20180207125710.GJ3291@localhost.localdomain>
	<1518013857-4372-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518013857-4372-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] cpu: drop unnecessary NULL check and
 cpu_common_class_by_name()
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

On Wed, Feb 07, 2018 at 03:30:57PM +0100, Igor Mammedov wrote:
> both do nothing as for the first all callers
>    parse_cpu_model() and qmp_query_cpu_model_()
> should provide non NULL value, so just abort if it's not so.
> 
> While at it drop cpu_common_class_by_name() which is not need
> any more as every target has CPUClass::class_by_name callback
> by now, though abort in case a new arch will forget to define one.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
