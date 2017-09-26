Received: from eggs.gnu.org ([2001:4830:134:3::10]:49165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwq32-0006EH-B7
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwq2z-0007q0-4o
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:37:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dwq2y-0007pT-UB
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:37:13 -0400
Date: Tue, 26 Sep 2017 15:36:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170926153656.4b715383.cohuck@redhat.com>
In-Reply-To: <20170925112917.21340-6-dgilbert@redhat.com>
References: <20170925112917.21340-1-dgilbert@redhat.com>
	<20170925112917.21340-6-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/6] migration: Route errors up through
 vmstate_save
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, famz@redhat.com, peter.maydell@linaro.org, rth@twiddle.net

On Mon, 25 Sep 2017 12:29:16 +0100
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Route the errors from vsmtate_save_state back up through
> vmstate_save and out to the normal device state path.
> That's the normal error path done.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/savevm.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
