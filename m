Received: from eggs.gnu.org ([2001:4830:134:3::10]:36420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fH4Tk-00055V-MH
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fH4TK-0001IC-8P
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:36:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1fH4TJ-0001HM-Sq
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:36:18 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4B9Stap079153
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 05:36:16 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hw6nk50cg-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 05:36:16 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 11 May 2018 10:36:14 +0100
Reply-To: pmorel@linux.ibm.com
References: <20180509154822.23510-1-cohuck@redhat.com>
	<20180509154822.23510-2-cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 11 May 2018 11:36:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180509154822.23510-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <f93c7d39-0924-c3e6-d954-987d82252cb6@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] s390/cio: export hsch to modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 09/05/2018 17:48, Cornelia Huck wrote:
> The vfio-ccw code will need this, and it matches treatment of ssch
> and csch.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   drivers/s390/cio/ioasm.c | 1 +
>   1 file changed, 1 insertion(+)
>
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

hsch already defined in ioasm.h so, all OK

Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
