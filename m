Received: from eggs.gnu.org ([2001:4830:134:3::10]:45329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffLyQ-00033R-B1
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:08:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffLyN-00087s-5L
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:08:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60914 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ffLyN-00087R-0A
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:08:43 -0400
Date: Tue, 17 Jul 2018 11:08:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180717110837.61736ec7.cohuck@redhat.com>
In-Reply-To: <20180716173743.133393-2-dgilbert@redhat.com>
References: <20180716173743.133393-1-dgilbert@redhat.com>
	<20180716173743.133393-2-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 3.1 1/4] scsi/migration: Allow bus load
 request to fail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com, famz@redhat.com, amit@kernel.org

On Mon, 16 Jul 2018 18:37:40 +0100
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Allow the load_request method on a bus to fail and error
> the migration cleanly.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/scsi/scsi-bus.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
