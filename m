Received: from eggs.gnu.org ([209.51.188.92]:36316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtr8i-00079b-Cd
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:47:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtr8g-0007Dc-Tq
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:47:35 -0500
Date: Wed, 13 Feb 2019 10:47:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190213104721.7347c4ae.cohuck@redhat.com>
In-Reply-To: <20190212011657.18324-2-walling@linux.ibm.com>
References: <20190212011657.18324-1-walling@linux.ibm.com>
	<20190212011657.18324-2-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] s390x/cpumodel: default enable
 mepoch for z14 and later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, david@redhat.com, borntraeger@de.ibm.com, pasic@linux.ibm.com, rth@twiddle.net

On Mon, 11 Feb 2019 20:16:56 -0500
Collin Walling <walling@linux.ibm.com> wrote:

> Latest systems and host kernels support mepoch, which is a
> feature that was meant to be supported for z14 GA1 from the
> get-go. Let's copy it to the z14 GA1 default CPU model.
> 
> Machines s390-ccw-virtio-3.1 and older will retain the old CPU
> models and will not provide this bit nor the extended PTFF
> functions in the default model.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
> @Christian, @David: I elected to not add your r-b's to this
> patch since I've added some code to disable feature groups.
> I'd like to know what you both think :)
> ---
>  hw/s390x/s390-virtio-ccw.c  |  2 ++
>  target/s390x/cpu_models.c   | 24 ++++++++++++++++++++++++
>  target/s390x/cpu_models.h   |  2 ++
>  target/s390x/gen-features.c |  2 ++
>  4 files changed, 30 insertions(+)

This gained a conflict in s390-virtio-ccw.c, which I fixed up.

Thanks, applied.
