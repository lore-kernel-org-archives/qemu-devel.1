Received: from eggs.gnu.org ([2001:4830:134:3::10]:48362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJ19X-00016N-1f
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJ19R-0006nn-VL
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:27:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fJ19R-0006hm-Pk
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:27:49 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com
	[10.5.11.27])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0FE0730DAE0D
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 18:27:49 +0000 (UTC)
Date: Wed, 16 May 2018 15:27:47 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180516182747.GK4903@localhost.localdomain>
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
	<1525423069-61903-12-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1525423069-61903-12-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 11/11] tests: functional tests for QMP
 command set-numa-node
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

On Fri, May 04, 2018 at 10:37:49AM +0200, Igor Mammedov wrote:
>  * start QEMU with 2 unmapped cpus,
>  * while in preconfig state
>     * add 2 numa nodes
>     * assign cpus to them
>  * exit preconfig and in running state check that cpus
>    are mapped correctly.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Nice, this is the test case I asked for in previous patches.  :)

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
