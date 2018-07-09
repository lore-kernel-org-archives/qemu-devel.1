Received: from eggs.gnu.org ([2001:4830:134:3::10]:49088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fcYXM-0001Fx-Ex
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fcYXJ-0003HE-EL
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:57:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51560 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fcYXJ-0003HA-92
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 11:57:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1F1F4001388
	for <qemu-devel@nongnu.org>; Mon,  9 Jul 2018 15:57:12 +0000 (UTC)
Date: Mon, 9 Jul 2018 17:57:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180709175711.19f079ea@redhat.com>
In-Reply-To: <20180705091402.26244-1-armbru@redhat.com>
References: <20180705091402.26244-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com, ehabkost@redhat.com

On Thu,  5 Jul 2018 11:14:00 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Please refer to PATCH 1 for rationale.
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

Acked-by: Igor Mammedov <imammedo@redhat.com>
