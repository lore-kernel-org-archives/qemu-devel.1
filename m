Received: from eggs.gnu.org ([2001:4830:134:3::10]:47288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWTZ2-0004k8-Ex
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWTYy-00019R-KM
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:53:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWTYy-00018k-Er
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:53:32 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1509369390-8285-4-git-send-email-a.perevalov@samsung.com>
	(Alexey Perevalov's message of "Mon, 30 Oct 2017 16:16:27 +0300")
References: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
	<CGME20171030131648eucas1p14830b04b73c8eb12d07b752738238b8a@eucas1p1.samsung.com>
	<1509369390-8285-4-git-send-email-a.perevalov@samsung.com>
Reply-To: quintela@redhat.com
Date: Tue, 02 Jan 2018 21:53:26 +0100
Message-ID: <87tvw43ruh.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v12 3/6] migration: calculate vCPU
 blocktime on dst side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, i.maximets@samsung.com, heetae82.ahn@samsung.com, dgilbert@redhat.com

Alexey Perevalov <a.perevalov@samsung.com> wrote:
> This patch provides blocktime calculation per vCPU,
> as a summary and as a overlapped value for all vCPUs.
>
> This approach was suggested by Peter Xu, as an improvements of
> previous approch where QEMU kept tree with faulted page address and cpus bitmask
> in it. Now QEMU is keeping array with faulted page address as value and vCPU
> as index. It helps to find proper vCPU at UFFD_COPY time. Also it keeps
> list for blocktime per vCPU (could be traced with page_fault_addr)
>
> Blocktime will not calculated if postcopy_blocktime field of
> MigrationIncomingState wasn't initialized.
>
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
>  # migration/exec.c
>  migration_exec_outgoing(const char *cmd) "cmd=%s"

Reviewed-by: Juan Quintela <quintela@redhat.com>
