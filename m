Received: from eggs.gnu.org ([2001:4830:134:3::10]:50692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ehcmg-0004Dy-Sz
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ehcmd-0001tc-24
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:57:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ehcmc-0001t7-SF
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:57:42 -0500
References: <20180201205511.19198-1-marcel@redhat.com>
	<20180201205511.19198-4-marcel@redhat.com>
	<2019319026.1970662.1517573339806@mail.yahoo.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <bef0cc87-e43c-4b3e-60b2-48b36b15284e@redhat.com>
Date: Fri, 2 Feb 2018 14:27:53 +0200
MIME-Version: 1.0
In-Reply-To: <2019319026.1970662.1517573339806@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Dotan Barak <dotanb75@yahoo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>, "yuval.shaia@oracle.com" <yuval.shaia@oracle.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, Dotan Barak <dotanb@mellanox.com>

On 02/02/2018 14:08, Dotan Barak wrote:
> Reviewed-by: Dotan Barak <dotanb@mellanox.com>
> 

The Mellanox review for the RDMA code is very much appreciated!

Thanks Dotan, we know you put much effort into it and the V9
re-spin quality just went up :)
Marcel


> ------------------------------------------------------------------------------------------------------------------------
> *From:* Marcel Apfelbaum <marcel@redhat.com>
> *To:* qemu-devel@nongnu.org
> *Cc:* ehabkost@redhat.com; yuval.shaia@oracle.com; marcel@redhat.com; pbonzini@redhat.com; mst@redhat.com;
> cohuck@redhat.com; dotanb75@yahoo.com
> *Sent:* Thursday, February 1, 2018 10:55 PM
> *Subject:* [Qemu-devel] [PATCH V9 3/4] pvrdma: initial implementation
> 
> From: Yuval Shaia <yuval.shaia@oracle.com <mailto:yuval.shaia@oracle.com>>
> 
> PVRDMA is the QEMU implementation of VMware's paravirtualized RDMA device.
> It works with its Linux Kernel driver AS IS, no need for any special guest
> modifications.
> 
> While it complies with the VMware device, it can also communicate with bare
> metal RDMA-enabled machines and does not require an RDMA HCA in the host, it
> can work with Soft-RoCE (rxe).
> 
> It does not require the whole guest RAM to be pinned allowing memory
> over-commit and, even if not implemented yet, migration support will be
> possible with some HW assistance.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com <mailto:yuval.shaia@oracle.com>>
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com <mailto:marcel@redhat.com>>
> 
> 
> 
