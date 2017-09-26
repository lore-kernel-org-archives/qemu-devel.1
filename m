Received: from eggs.gnu.org ([2001:4830:134:3::10]:47057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwpvq-0002FF-Qx
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwpvn-0002YW-MC
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:29:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dwpvn-0002XN-GD
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:29:47 -0400
Date: Tue, 26 Sep 2017 15:29:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170926152924.65d377d2.cohuck@redhat.com>
In-Reply-To: <20170925112917.21340-3-dgilbert@redhat.com>
References: <20170925112917.21340-1-dgilbert@redhat.com>
	<20170925112917.21340-3-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/6] migration: check pre_save return in
 vmstate_save_state
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

On Mon, 25 Sep 2017 12:29:13 +0100
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Check the return value of pre_save state and fail vmstate_save_state
> if the pre_save failed.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  include/migration/vmstate.h |  4 ++--
>  migration/trace-events      |  1 +
>  migration/vmstate.c         | 12 ++++++++++--
>  3 files changed, 13 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
