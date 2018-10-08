Received: from eggs.gnu.org ([2001:4830:134:3::10]:54869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g9ZzC-0001cV-Qn
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:10:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1g9Zql-0004Kh-P8
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:01:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1g9Zqi-0004Hj-LP
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:01:45 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com
	[10.5.11.25])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF2A3D56FF
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 18:01:43 +0000 (UTC)
Date: Mon, 8 Oct 2018 15:01:42 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181008180142.GS5738@habkost.net>
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-26-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008173125.19678-26-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 25/31] numa: Clean up error reporting in
 parse_numa()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Oct 08, 2018 at 07:31:19PM +0200, Markus Armbruster wrote:
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  parse_numa() does that, and then fails without setting
> an error.  Its caller main(), via qemu_opts_foreach(), is fine with
> it, but clean it up anyway.
> 
> While there, give parse_numa() internal linkage.
> 
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Queueing on machine-next.  Thanks!

-- 
Eduardo
