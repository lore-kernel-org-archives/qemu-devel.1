Received: from eggs.gnu.org ([2001:4830:134:3::10]:36297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsQ0T-00010p-Jo
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsQ0R-0002oh-J7
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:04:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38866 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsQ0R-0002nW-57
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:04:51 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1533562177-16447-2-git-send-email-lidongchen@tencent.com>
	(Lidong Chen's message of "Mon, 6 Aug 2018 21:29:27 +0800")
References: <1533562177-16447-1-git-send-email-lidongchen@tencent.com>
	<1533562177-16447-2-git-send-email-lidongchen@tencent.com>
Reply-To: quintela@redhat.com
Date: Wed, 22 Aug 2018 12:04:42 +0200
Message-ID: <87sh3667k5.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 01/11] migration: disable RDMA WRITE
 after postcopy started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: zhang.zhanghailiang@huawei.com, dgilbert@redhat.com, qemu-devel@nongnu.org, Lidong Chen <lidongchen@tencent.com>

Lidong Chen <jemmy858585@gmail.com> wrote:
> From: Lidong Chen <jemmy858585@gmail.com>
>
> RDMA WRITE operations are performed with no notification to the destination
> qemu, then the destination qemu can not wakeup. This patch disable RDMA WRITE
> after postcopy started.
>
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
