Received: from eggs.gnu.org ([2001:4830:134:3::10]:57692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkB0B-0000yq-Ok
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dkB0A-0005Dp-UB
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:21:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dkB0A-0005DW-LP
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:21:58 -0400
Date: Tue, 22 Aug 2017 16:21:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170822152151.GD5398@stefanha-x1.localdomain>
References: <1503313839-10258-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<1503313839-10258-3-git-send-email-chugh.ishani@research.iiit.ac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503313839-10258-3-git-send-email-chugh.ishani@research.iiit.ac.in>
Subject: Re: [Qemu-devel] [PATCH 2/3] Test for full Backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ishani Chugh <chugh.ishani@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com

On Mon, Aug 21, 2017 at 04:40:38PM +0530, Ishani Chugh wrote:
> +_make_test_img $size
> +export QEMU_BACKUP_CONFIG=$CONFIG_FILE
> +qemu_comm_method="monitor"
> +echo
> +_launch_qemu -nographic -drive if=virtio,file=$TEST_IMG -qmp $SOCKET,server,nowait

-nographic is already included by _launch_qemu, please don't duplicate
it here.

The same applies below.
