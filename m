Received: from eggs.gnu.org ([208.118.235.92]:47359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g9WmJ-0001Nw-8Z
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g9Wk2-0003PQ-71
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:42:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1g9Wk1-0003JU-S8
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 10:42:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECCA6308213A
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 14:42:24 +0000 (UTC)
Date: Mon, 8 Oct 2018 11:42:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181008144223.GA14505@habkost.net>
References: <1536836762-273036-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536836762-273036-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 0/2] deprecate incorrect CPUs topolog
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

On Thu, Sep 13, 2018 at 01:06:00PM +0200, Igor Mammedov wrote:
> Changelog since v7:
>   * drop repetitive sentence in deprication doc (Eric Blake <eblake@redhat.com>)
> Changelog since v5:
>   * add(v6) and then remove(v7) Notes section to/from deprication doc
>      (Eduardo Habkost <ehabkost@redhat.com>)
>   * fix up wording and math formating in deprication doc
>      (Eduardo Habkost <ehabkost@redhat.com>)
>   * drop !socket check as it always evaluates to true at that point
>      (Eduardo Habkost <ehabkost@redhat.com>)
> Changelog since v4:
>   * extend deprication doc, adding that maxcpus should be multiple of
>         present on CLI [sockets/cores/threads] options
>         (Eduardo Habkost <ehabkost@redhat.com>)
> 
> series bundles together 2 related patches posted separately earlier:
>   vl.c deprecate incorrect CPUs topology
>   vl:c: make sure that sockets are calculated  correctly in '-smp X' case
> 
> Goal is to depricate invalid topologies so we could make sure that topology
> configuration is correct by forbidding invalid input once deprecation
> period ends.

Thanks, queued on machine-next.

-- 
Eduardo
