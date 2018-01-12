Received: from eggs.gnu.org ([2001:4830:134:3::10]:60821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ea3mi-00063T-Cu
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:10:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ea3mf-0000GG-OC
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:10:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38546
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ea3mf-0000FK-Hw
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:10:29 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0CI9lMD024657
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 13:10:28 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fexcbnbv7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 13:10:27 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 12 Jan 2018 18:10:25 -0000
References: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 12 Jan 2018 19:10:20 +0100
MIME-Version: 1.0
In-Reply-To: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <f9224bba-08fb-589e-ed6e-d8e967a8fe67@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] vfio: ccw: basic channel path
 event handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, pmorel@linux.vnet.ibm.com



On 01/11/2018 04:04 AM, Dong Jia Shi wrote:
> What are still missing, thus need to be offered in the next version are:
> - I/O termination and FSM state handling if currently we have I/O on the status
>   switched path.
> - Vary on/off event is not sensible to a guest.

I don't see a doc update. We do have documentation (in
Documentation/s390/vfio-ccw.txt) in which the uapi interface with the
regions and their purpose/usage  is at least kind of explained. You are
changing this interface without updating the doc.

I would like to see documentation on this because I'm under the
impression either the design is pretty convoluted or I did not
get it at all.

Regards,
Halil
