Received: from eggs.gnu.org ([2001:4830:134:3::10]:36213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gC8lY-0006Qd-N3
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 15:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gC8lY-0005bc-2J
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 15:43:00 -0400
Date: Mon, 15 Oct 2018 16:42:50 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181015194250.GY31060@habkost.net>
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-2-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015141453.32632-2-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/9] iotests: Make nbd-fault-injector flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Mon, Oct 15, 2018 at 04:14:45PM +0200, Max Reitz wrote:
> When closing a connection, make the nbd-fault-injector flush the socket.
> Without this, the output is a bit unreliable with Python 3.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
