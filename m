Received: from eggs.gnu.org ([2001:4830:134:3::10]:54816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gPLEe-0005C9-N9
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 00:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gPLEd-00021J-Bm
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 00:39:36 -0500
Date: Wed, 21 Nov 2018 13:39:23 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20181121053923.GA31447@magic>
References: <afa43fbb-98e0-f6e7-0d41-e7005501e256@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afa43fbb-98e0-f6e7-0d41-e7005501e256@oracle.com>
Subject: Re: [Qemu-devel] When AioHandler->is_external=true?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Qemu-block <qemu-block@nongnu.org>, qemu-devel@nongnu.org

On Tue, 11/20 20:34, Dongli Zhang wrote:
> Hi,
> 
> Would you please help explain in which case AioHandler->is_external is true, and
> when it is false?
> 
> I read about iothread and mainloop and I am little bit confused about it.

VirtIO's ioeventfd is an example of is_external == true. It means the events
handler on this fd may initiate more I/O, such as read/write on virtual storage
backend, so are specially taken care of at certain points when we won't want
more I/O requests to be processed, such as when a block job is completing, or in
the middle of a QMP transaction.

Fam
