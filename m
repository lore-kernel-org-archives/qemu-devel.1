Received: from eggs.gnu.org ([2001:4830:134:3::10]:32836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnigE-0003lM-Ot
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnigD-0001LG-TP
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:23:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cnigD-0001Kk-Me
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:23:45 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 72D6A80461
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:23:45 +0000 (UTC)
References: <20170313124434.1043-1-quintela@redhat.com>
	<20170313124434.1043-14-quintela@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b1d7d458-d3d3-a396-a048-21eea329a05c@redhat.com>
Date: Tue, 14 Mar 2017 10:23:42 +0100
MIME-Version: 1.0
In-Reply-To: <20170313124434.1043-14-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/16] migration: Create thread
 infrastructure for multifd recv side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: amit.shah@redhat.com, dgilbert@redhat.com



On 13/03/2017 13:44, Juan Quintela wrote:
>          case RAM_SAVE_FLAG_MULTIFD_PAGE:
>              fd_num = qemu_get_be16(f);
> -            if (fd_num != 0) {
> -                /* this is yet an unused variable, changed later */
> -                fd_num = fd_num;
> -            }
> +            multifd_recv_page(host, fd_num);
>              qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
>              break;

I still believe this design is a mistake.

Paolo
