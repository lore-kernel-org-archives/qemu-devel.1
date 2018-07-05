Received: from eggs.gnu.org ([2001:4830:134:3::10]:37420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fb7KI-0004tq-8A
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fb7KF-0003BG-5Y
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:41:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fb7KE-0003At-V6
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:41:47 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com
	[10.5.11.26])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21467804EC
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 16:41:46 +0000 (UTC)
Date: Thu, 5 Jul 2018 13:41:44 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180705164144.GP7451@localhost.localdomain>
References: <20180705091402.26244-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705091402.26244-1-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Let's not chisel --preconfig in stone
 without a user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, eblake@redhat.com, pkrempa@redhat.com

On Thu, Jul 05, 2018 at 11:14:00AM +0200, Markus Armbruster wrote:
> Please refer to PATCH 1 for rationale.

Justification is good.  We're far from having machine
initialization code (i.e. everything between the two main_loop()
calls) safe to run with an active QMP monitor.

Acked-by: Eduardo Habkost <ehabkost@redhat.com>

> 
> Markus Armbruster (2):
>   qapi: Do not expose "allow-preconfig" in query-qmp-schema
>   cli qmp: Mark --preconfig, exit-preconfig experimental
> 
>  hmp.c                      |  2 +-
>  qapi/introspect.json       |  5 +----
>  qapi/misc.json             |  6 +++---
>  qemu-options.hx            |  9 +++++----
>  qemu-tech.texi             | 11 ++++-------
>  qmp.c                      |  2 +-
>  scripts/qapi/introspect.py |  3 +--
>  tests/numa-test.c          |  2 +-
>  tests/qmp-test.c           |  6 +++---
>  9 files changed, 20 insertions(+), 26 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
Eduardo
