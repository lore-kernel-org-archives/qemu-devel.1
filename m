Received: from eggs.gnu.org ([209.51.188.92]:35637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtZKv-0005FV-7V
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:47:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtZG1-0003RV-Dm
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:41:57 -0500
Date: Tue, 12 Feb 2019 15:41:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190212154121.43c8e279.cohuck@redhat.com>
In-Reply-To: <20190212134758.10514-4-dgilbert@redhat.com>
References: <20190212134758.10514-1-dgilbert@redhat.com>
	<20190212134758.10514-4-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] kvm: Add kvm_set_ioeventfd* traces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, kraxel@redhat.com, mst@redhat.com, qemu-trivial@nongnu.org

On Tue, 12 Feb 2019 13:47:57 +0000
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Add a couple of traces around the kvm_set_ioeventfd* calls.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  accel/kvm/kvm-all.c    | 3 +++
>  accel/kvm/trace-events | 2 ++
>  2 files changed, 5 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Maybe I'll add a tracepoint for the s390 subchannel ioeventfd as well...
