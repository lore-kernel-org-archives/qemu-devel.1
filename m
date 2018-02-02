Received: from eggs.gnu.org ([2001:4830:134:3::10]:44046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dotanb75@yahoo.com>) id 1ehcel-0005VU-2F
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:49:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dotanb75@yahoo.com>) id 1ehceg-0005zb-Oj
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:49:35 -0500
Received: from sonic314-13.consmr.mail.bf2.yahoo.com ([74.6.132.123]:38919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dotanb75@yahoo.com>) id 1ehceg-0005yn-JI
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:49:30 -0500
Date: Fri, 2 Feb 2018 12:08:59 +0000 (UTC)
From: Dotan Barak <dotanb75@yahoo.com>
Reply-To: Dotan Barak <dotanb75@yahoo.com>
Message-ID: <2019319026.1970662.1517573339806@mail.yahoo.com>
In-Reply-To: <20180201205511.19198-4-marcel@redhat.com>
References: <20180201205511.19198-1-marcel@redhat.com>
	<20180201205511.19198-4-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V9 3/4] pvrdma: initial implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "yuval.shaia@oracle.com" <yuval.shaia@oracle.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>

Reviewed-by: Dotan Barak <dotanb@mellanox.com>

      From: Marcel Apfelbaum <marcel@redhat.com>
 To: qemu-devel@nongnu.org 
Cc: ehabkost@redhat.com; yuval.shaia@oracle.com; marcel@redhat.com; pbonzini@redhat.com; mst@redhat.com; cohuck@redhat.com; dotanb75@yahoo.com
 Sent: Thursday, February 1, 2018 10:55 PM
 Subject: [Qemu-devel] [PATCH V9 3/4] pvrdma: initial implementation
   
From: Yuval Shaia <yuval.shaia@oracle.com>

PVRDMA is the QEMU implementation of VMware's paravirtualized RDMA device.
It works with its Linux Kernel driver AS IS, no need for any special guest
modifications.

While it complies with the VMware device, it can also communicate with bare
metal RDMA-enabled machines and does not require an RDMA HCA in the host, it
can work with Soft-RoCE (rxe).

It does not require the whole guest RAM to be pinned allowing memory
over-commit and, even if not implemented yet, migration support will be
possible with some HW assistance.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>


   
