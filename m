Received: from eggs.gnu.org ([2001:4830:134:3::10]:48965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gC9QO-0002SR-Jo
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gC9QN-0007Gi-I3
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 16:25:12 -0400
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-2-mreitz@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <39d66b09-34a1-189a-854d-6a6ca817fb40@redhat.com>
Date: Mon, 15 Oct 2018 16:24:50 -0400
MIME-Version: 1.0
In-Reply-To: <20181015141453.32632-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/9] iotests: Make nbd-fault-injector flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>



On 10/15/18 10:14 AM, Max Reitz wrote:
> When closing a connection, make the nbd-fault-injector flush the socket.
> Without this, the output is a bit unreliable with Python 3.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>
