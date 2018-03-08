Received: from eggs.gnu.org ([2001:4830:134:3::10]:45063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etttL-0001GO-U9
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:39:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1etttK-0003bL-Qp
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:39:23 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1520507908-16743-3-git-send-email-pl@kamp.de> (Peter Lieven's
	message of "Thu, 8 Mar 2018 12:18:25 +0100")
References: <1520507908-16743-1-git-send-email-pl@kamp.de>
	<1520507908-16743-3-git-send-email-pl@kamp.de>
Reply-To: quintela@redhat.com
Date: Thu, 08 Mar 2018 12:39:41 +0100
Message-ID: <876066eqyq.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/5] migration/block: reset dirty bitmap
 before read in bulk phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, dgilbert@redhat.com, famz@redhat.com, stefanha@redhat.com, jjherne@linux.vnet.ibm.com, qemu-stable@nongnu.org

Peter Lieven <pl@kamp.de> wrote:
> Reset the dirty bitmap before reading to make sure we don't miss
> any new data.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>
