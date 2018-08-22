Received: from eggs.gnu.org ([2001:4830:134:3::10]:37071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsQ3P-0003Xl-HZ
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsQ3M-0004lg-2T
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:07:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36990 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsQ3L-0004kT-A6
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:07:51 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1533562177-16447-8-git-send-email-lidongchen@tencent.com>
	(Lidong Chen's message of "Mon, 6 Aug 2018 21:29:33 +0800")
References: <1533562177-16447-1-git-send-email-lidongchen@tencent.com>
	<1533562177-16447-8-git-send-email-lidongchen@tencent.com>
Reply-To: quintela@redhat.com
Date: Wed, 22 Aug 2018 12:07:44 +0200
Message-ID: <87bm9u67f3.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 07/11] migration: poll the cm event
 while wait RDMA work request completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: zhang.zhanghailiang@huawei.com, dgilbert@redhat.com, qemu-devel@nongnu.org, Lidong Chen <lidongchen@tencent.com>, Gal Shachaf <galsha@mellanox.com>, Aviad Yehezkel <aviadye@mellanox.com>

Lidong Chen <jemmy858585@gmail.com> wrote:
> From: Lidong Chen <jemmy858585@gmail.com>
>
> If the peer qemu is crashed, the qemu_rdma_wait_comp_channel function
> maybe loop forever. so we should also poll the cm event fd, and when
> receive RDMA_CM_EVENT_DISCONNECTED and RDMA_CM_EVENT_DEVICE_REMOVAL,
> we consider some error happened.
>
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> Signed-off-by: Gal Shachaf <galsha@mellanox.com>
> Signed-off-by: Aviad Yehezkel <aviadye@mellanox.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
