Received: from eggs.gnu.org ([209.51.188.92]:51854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gm1A3-0000iw-Pn
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:52:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gm1A2-0000Lo-4l
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:52:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55832
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gm1A1-0000Ii-Kq
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:52:34 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0MFJgpq067348
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:21:32 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q65jd8jq3-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 10:21:32 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Tue, 22 Jan 2019 15:21:30 -0000
Date: Tue, 22 Jan 2019 16:21:24 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190121110354.2247-5-cohuck@redhat.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-5-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190122162124.43d08692@oc2783563651>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 4/5] s390/cio: export hsch
 to modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Mon, 21 Jan 2019 12:03:53 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> The vfio-ccw code will need this, and it matches treatment of ssch
> and csch.
> 
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.ibm.com>

;)

> ---
>  drivers/s390/cio/ioasm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/s390/cio/ioasm.c b/drivers/s390/cio/ioasm.c
> index 14d328338ce2..08eb10283b18 100644
> --- a/drivers/s390/cio/ioasm.c
> +++ b/drivers/s390/cio/ioasm.c
> @@ -233,6 +233,7 @@ int hsch(struct subchannel_id schid)
>  
>  	return ccode;
>  }
> +EXPORT_SYMBOL(hsch);
>  
>  static inline int __xsch(struct subchannel_id schid)
>  {
