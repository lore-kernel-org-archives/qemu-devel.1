Received: from eggs.gnu.org ([2001:4830:134:3::10]:55375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr6mX-00016P-NO
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cr6mW-0004jj-SV
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:44:17 -0400
MIME-Version: 1.0
In-Reply-To: <20170316212351.13797-1-jsnow@redhat.com>
References: <20170316212351.13797-1-jsnow@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 23 Mar 2017 17:44:12 +0000
Message-ID: <CAJSP0QU1g9iijqMnrf27Yp5BTr_U4c--+GqYTnvnVtyud0O2Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 0/3] block: pause block
 jobs for bdrv_drain_begin/end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On Thu, Mar 16, 2017 at 9:23 PM, John Snow <jsnow@redhat.com> wrote:
> Reference: https://bugzilla.redhat.com/show_bug.cgi?id=1367369#c8
>
> It's possible to wedge QEMU if the guest tries to reset a virtio-pci
> device as QEMU is also using the drive for a blockjob. This patchset
> aims to allow us to safely pause/resume jobs attached to individual
> nodes in a manner similar to how bdrv_drain_all_begin/end do.

Weird, I thought the 0 nanosecond sleep that block jobs do in their
main loop allows aio_poll() loops to finish.

Maybe this bug is a regression?

I've CCed Fam because I think he has also tackled this issue in the past.

Stefan
