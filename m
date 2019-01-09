Received: from eggs.gnu.org ([209.51.188.92]:38279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1ghGOY-00044k-GU
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:07:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1ghGOW-0007nL-IY
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:07:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49926
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1ghGOW-0007hy-8v
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 11:07:52 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x09G4BL0031076
	for <qemu-devel@nongnu.org>; Wed, 9 Jan 2019 11:07:44 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pwjn9w738-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 11:07:43 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Wed, 9 Jan 2019 16:07:43 -0000
References: <20190108151114.33140-1-liq3ea@163.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Wed, 9 Jan 2019 11:07:35 -0500
MIME-Version: 1.0
In-Reply-To: <20190108151114.33140-1-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <84e965df-1992-862a-ee0e-a3b058bfc2e6@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] s390: avoid potential null dereference
 ins390_pcihost_unplug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, cohuck@redhat.com, rth@twiddle.net, david@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 1/8/19 10:11 AM, Li Qiang wrote:
> When getting the 'pbdev', the if...else has no default branch.
> From Coverity, the 'pbdev' maybe null when the 'dev' is not
> the TYPE_PCI_BRIDGE/TYPE_PCI_DEVICE/TYPE_S390_PCI_DEVICE.
> This patch adds a default branch for device plug and unplug.
> 
> Spotted by Coverity: CID 1398593
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
> 

[...]

Reviewed-by: Collin Walling <walling@linux.ibm.com>
