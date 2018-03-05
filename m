Received: from eggs.gnu.org ([2001:4830:134:3::10]:40032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1esoCr-0001hf-7F
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:23:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1esoCo-0003Uu-6C
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:23:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36852)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1esoCn-0003UH-So
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:22:58 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w25BMaUO119844
	for <qemu-devel@nongnu.org>; Mon, 5 Mar 2018 06:22:56 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gh3t4atv0-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 06:22:56 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 5 Mar 2018 11:22:54 -0000
References: <152024589806.7327.9844777027357521578.malonedeb@gac.canonical.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 5 Mar 2018 12:22:50 +0100
MIME-Version: 1.0
In-Reply-To: <152024589806.7327.9844777027357521578.malonedeb@gac.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <083d2e7c-5ada-88c9-bf50-0c68e7c19136@de.ibm.com>
Subject: Re: [Qemu-devel] [Bug 1753437] [NEW]
 qemu/pc-bios/s390-ccw/libc.c:82: bad test ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1753437 <1753437@bugs.launchpad.net>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>

Adding qemu-s390x.

On 03/05/2018 11:31 AM, dcb wrote:
> Public bug reported:
> 
> qemu/pc-bios/s390-ccw/libc.c:82]: (style) Unsigned variable 'num_idx'
> can't be negative so it is unnecessary to test it.
> 
> Source code is
> 
> 
>     while (num_idx >= 0) {
> 
> but
> 
>     size_t num_idx = 1; /* account for NUL */
> 
> So there is no escape from the while loop.
> 
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
> 
