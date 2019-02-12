Received: from eggs.gnu.org ([209.51.188.92]:53572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtUys-0002Ki-A1
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gtUvu-0003yH-A4
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:04:54 -0500
Date: Tue, 12 Feb 2019 11:04:39 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190212110439.38e3fbb2.cohuck@redhat.com>
In-Reply-To: <20190212011657.18324-1-walling@linux.ibm.com>
References: <20190212011657.18324-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] s390x/cpumodel: mepochptff: warn
 when no mepoch and re-align group init
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

On Mon, 11 Feb 2019 20:16:55 -0500
Collin Walling <walling@linux.ibm.com> wrote:

> The extended PTFF features (qsie, qtoue, stoe, stoue) are dependent
> on the multiple-epoch facility (mepoch). Let's print a warning if these
> features are enabled without mepoch.
> 
> While we're at it, let's move the FEAT_GROUP_INIT for mepochptff down
> the s390_feature_groups list so it can be properly indexed with its
> generated S390FeatGroup enum.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> ---
>  target/s390x/cpu_features.c | 2 +-
>  target/s390x/cpu_models.c   | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)

Not a comment for this patch (looks fine to me), but more general:
Could you please add a cover letter if you send more than one patch?
It's easy to miss that there are three patches and not two :)
