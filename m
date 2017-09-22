Received: from eggs.gnu.org ([2001:4830:134:3::10]:41663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dvNnC-00058E-Kp
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dvNn9-0000aM-9H
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:14:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dvNn9-0000Zh-2I
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:14:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 612677E43E
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 13:14:49 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
References: <cover.1504771369.git.mprivozn@redhat.com>
Message-ID: <7296576e-9f52-f385-7bde-d5c6d9de71b7@redhat.com>
Date: Fri, 22 Sep 2017 15:14:47 +0200
MIME-Version: 1.0
In-Reply-To: <cover.1504771369.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/3] watchdog.h: Drop local redefinition
 of actions enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

On 09/07/2017 10:05 AM, Michal Privoznik wrote:
> diff to v4:
> - in 3/3 compare passed action string case insensitively to the qapi enum
> 
> Michal Privoznik (3):
>   qapi: Rename WatchdogExpirationAction enum
>   watchdog.h: Drop local redefinition of actions enum
>   watchdog: Allow setting action on the fly
> 
>  hw/watchdog/watchdog.c    | 65 ++++++++++++++++++++++++-----------------------
>  hw/watchdog/wdt_diag288.c |  6 ++---
>  include/sysemu/watchdog.h | 12 ++-------
>  monitor.c                 |  4 +--
>  qapi-schema.json          |  9 +++++++
>  qapi/run-state.json       |  6 ++---
>  6 files changed, 52 insertions(+), 50 deletions(-)
> 

Thanks for all the reviews. What do I need to get it pushed ;-)

Michal
