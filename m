Received: from eggs.gnu.org ([2001:4830:134:3::10]:55953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d8r3N-0007gP-CB
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d8r3M-0007Gk-IU
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:35:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45680)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1d8r3M-0007GR-DB
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:35:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9659E4E4C6
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 16:34:58 +0000 (UTC)
References: <20170511153440.6475-1-quintela@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <fe7e66f8-7014-9f69-2d1a-2bc4f6e54f50@redhat.com>
Date: Thu, 11 May 2017 18:34:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170511153440.6475-1-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] migration: Pass Error ** argument to
 {save, load}_vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com

On 11/05/2017 17:34, Juan Quintela wrote:
> This way we use the "normal" way of printing errors for hmp commands.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> ---
> 
> 
> Add err_report_err() in replay-snapshot.c to really print the error
> messages (dave suggestion)
> 
> 
> ---
>  hmp.c                    |  9 +++++++--
>  include/sysemu/sysemu.h  |  4 ++--
>  migration/savevm.c       | 51 ++++++++++++++++++++++++------------------------
>  replay/replay-snapshot.c |  8 ++++++--
>  vl.c                     |  4 +++-
>  5 files changed, 43 insertions(+), 33 deletions(-)
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
