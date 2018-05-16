Received: from eggs.gnu.org ([2001:4830:134:3::10]:47880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJ169-0007fm-4d
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJ164-0004nZ-6K
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:24:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fJ164-0004iL-0R
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:24:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1D05B30C2135
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 18:24:19 +0000 (UTC)
Date: Wed, 16 May 2018 15:24:17 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180516182417.GI4903@localhost.localdomain>
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
	<1525423069-61903-10-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1525423069-61903-10-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 09/11] qmp: permit
 query-hotpluggable-cpus in preconfig state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com, armbru@redhat.com

On Fri, May 04, 2018 at 10:37:47AM +0200, Igor Mammedov wrote:
> it will allow mgmt to query possible CPUs, which depends on
> used machine(version)/-smp options, without restarting
> QEMU and use results to configure numa mapping or adding
> CPUs with device_add* later.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I suggest a follow-up patch adding a test for
query-hotpluggable-cpus on test_qmp_preconfig().

-- 
Eduardo
