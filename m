Received: from eggs.gnu.org ([2001:4830:134:3::10]:47751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwpyU-0003O4-7K
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwpyT-0004i7-Ct
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:32:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dwpyT-0004hW-6G
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:32:33 -0400
Date: Tue, 26 Sep 2017 15:32:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170926153223.234b2b22.cohuck@redhat.com>
In-Reply-To: <20170925112917.21340-4-dgilbert@redhat.com>
References: <20170925112917.21340-1-dgilbert@redhat.com>
	<20170925112917.21340-4-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/6] migration: Check field save returns
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

On Mon, 25 Sep 2017 12:29:14 +0100
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Check the return values from vmstate_save_state for fields and also the
> return values from 'put' for fields that use that.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/vmstate.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
