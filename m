Received: from eggs.gnu.org ([2001:4830:134:3::10]:40230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1e5Xf9-0004BO-Of
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1e5Xf4-0007ln-QB
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:48:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40800
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1e5Xf4-0007lX-JV
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:48:30 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9KDikVF093891
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 09:48:26 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dqgug4a2s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 09:48:26 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Fri, 20 Oct 2017 09:48:26 -0400
References: <20171020102517.28385-1-borntraeger@de.ibm.com>
	<67132f0e-cc4d-312f-140a-1966f0d877c6@suse.de>
	<7a65ad71-9c6d-ee0a-851c-ab6bd9806180@de.ibm.com>
	<b4a828b6-b563-55f0-2952-8a3447a8a30a@de.ibm.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Fri, 20 Oct 2017 09:48:22 -0400
MIME-Version: 1.0
In-Reply-To: <b4a828b6-b563-55f0-2952-8a3447a8a30a@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <9292cbd5-49b5-c9da-cc34-33466818a02e@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: print carriage return with new
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Bjoern Walk <bwalk@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>



On 10/20/2017 07:02 AM, Christian Borntraeger wrote:
> --- a/pc-bios/s390-ccw/sclp.c
> +++ b/pc-bios/s390-ccw/sclp.c
> @@ -83,7 +83,7 @@ long write(int fd, const void *str, size_t len)
>          return -EIO;
>      }
>
> -    for (p = str; *p; ++p) {
> +    for (p = str; len ; ++p, len--) {
>          if (data_len > SCCB_DATA_LEN - 1) {
>              return -EFBIG;
>          }
>
>
>
The write function returns len, wouldn't this change make write return 0?
