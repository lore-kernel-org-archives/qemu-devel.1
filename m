Received: from eggs.gnu.org ([2001:4830:134:3::10]:44047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fXqm8-0005IE-Jo
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1fXqm5-0007hw-UX
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:25:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58342 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1fXqm5-0007hc-Px
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:25:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CB4F407048F
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 16:25:01 +0000 (UTC)
References: <20180626154028.11133-1-pbonzini@redhat.com>
	<20180626154028.11133-4-pbonzini@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <9bffdc65-6199-f487-88f1-b14d2ae99636@redhat.com>
Date: Tue, 26 Jun 2018 18:24:59 +0200
MIME-Version: 1.0
In-Reply-To: <20180626154028.11133-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] pr-manager-helper: avoid SIGSEGV when
 writing to the socket fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 06/26/2018 05:40 PM, Paolo Bonzini wrote:
> When writing to the qemu-pr-helper socket failed, the persistent
> reservation manager was correctly disconnecting the socket, but it
> did not clear pr_mgr->ioc.  So the rest of the code did not know
> that the socket had been disconnected, accessed pr_mgr->ioc and
> happily caused a crash.
> 
> To reproduce, it is enough to stop qemu-pr-helper between QEMU
> startup and executing e.g. sg_persist -k /dev/sdb.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scsi/pr-manager-helper.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Michal Privoznik <mprivozn@redhat.com>

Michal
