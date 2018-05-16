Received: from eggs.gnu.org ([2001:4830:134:3::10]:45416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJ0uk-0001uu-Q6
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fJ0uh-0004DG-MF
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:12:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fJ0uh-0004CJ-HT
	for qemu-devel@nongnu.org; Wed, 16 May 2018 14:12:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBF6519EE25
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 18:12:34 +0000 (UTC)
Date: Wed, 16 May 2018 15:12:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180516181232.GD4903@localhost.localdomain>
References: <1525423069-61903-1-git-send-email-imammedo@redhat.com>
	<1525423069-61903-2-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1525423069-61903-2-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 01/11] numa: postpone options
 post-processing till machine_run_board_init()
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

On Fri, May 04, 2018 at 10:37:39AM +0200, Igor Mammedov wrote:
> in preparation for numa options to being handled via QMP before
> machine_run_board_init(), move final numa configuration checks
> and processing to machine_run_board_init() so it could take into
> account both CLI (via parse_numa_opts()) and QMP input
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Queued, thanks.

-- 
Eduardo
