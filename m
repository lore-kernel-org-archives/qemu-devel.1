Received: from eggs.gnu.org ([2001:4830:134:3::10]:57646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gQAbs-0002jH-Od
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 07:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gQAbo-0000nS-PS
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 07:31:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52846
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gQAbo-0000m5-Jy
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 07:30:56 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wANCTpmt176466
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 07:30:56 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2nxerh7j2r-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 07:30:55 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 23 Nov 2018 12:30:53 -0000
Reply-To: pmorel@linux.ibm.com
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-3-cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 23 Nov 2018 13:30:48 +0100
MIME-Version: 1.0
In-Reply-To: <20181122165432.4437-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <b7f5c715-c9fb-6a86-087f-d77ffe3e3367@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] s390/cio: export hsch to modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On 22/11/2018 17:54, Cornelia Huck wrote:
> The vfio-ccw code will need this, and it matches treatment of ssch
> and csch.
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   drivers/s390/cio/ioasm.c | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/s390/cio/ioasm.c b/drivers/s390/cio/ioasm.c
> index 14d328338ce2..08eb10283b18 100644
> --- a/drivers/s390/cio/ioasm.c
> +++ b/drivers/s390/cio/ioasm.c
> @@ -233,6 +233,7 @@ int hsch(struct subchannel_id schid)
>  =20
>   	return ccode;
>   }
> +EXPORT_SYMBOL(hsch);
>  =20
>   static inline int __xsch(struct subchannel_id schid)
>   {
>=20

LGTM

Reviewed-by: Pierre Morel<pmorel@linux.ibm.com>



--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
