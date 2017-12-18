Received: from eggs.gnu.org ([2001:4830:134:3::10]:48057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eQvso-0007vt-49
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eQvsk-0005FE-S5
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:55:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36884
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eQvsk-0005Dw-Kf
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 08:55:02 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBIDsmt0191077
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 08:55:00 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2exehh1ehq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 08:54:59 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 18 Dec 2017 13:54:57 -0000
References: <1513350170-20168-1-git-send-email-den@openvz.org>
	<1513350170-20168-2-git-send-email-den@openvz.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 18 Dec 2017 14:54:51 +0100
MIME-Version: 1.0
In-Reply-To: <1513350170-20168-2-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <229a8ddd-2745-b08c-96cf-87135713353f@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] pc, q35: add 2.12 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>

On 12/15/2017 04:02 PM, Denis V. Lunev wrote:

>  include/hw/compat.h  |  2 ++
>  include/hw/i386/pc.h |  3 +++
>  hw/i386/pc_piix.c    | 13 ++++++++++++-
>  hw/i386/pc_q35.c     | 12 +++++++++++-
>  4 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index cf389b4..026fee9 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -1,6 +1,8 @@
>  #ifndef HW_COMPAT_H
>  #define HW_COMPAT_H
> 
> +#define HW_COMPAT_2_11 \
> +
>  #define HW_COMPAT_2_10 \
>      {\

FWIW, arm, s390, power also include HW_COMPAT_* for their machines.
As it happens s390 and power already introduced HW_COMPAT_2_11 last
week so these changes should be fine. 

Peter, maybe ARM should add a 2.11 compat machine (and a switch to 2.12)
sooner than usual?
