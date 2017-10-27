Received: from eggs.gnu.org ([2001:4830:134:3::10]:43194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e85uH-0005VN-Gb
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e85uA-00077w-Hr
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:46:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56938
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e85uA-00076Q-CP
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:46:38 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9REkGsM036665
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 10:46:35 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dv6pjgpdv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 10:46:34 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 27 Oct 2017 15:46:30 +0100
References: <1509114613-10601-1-git-send-email-walling@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 27 Oct 2017 16:46:25 +0200
MIME-Version: 1.0
In-Reply-To: <1509114613-10601-1-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ab482340-6ac0-5f1a-2e24-3e2f9278a5bb@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] s390-ccw: print carriage return with
 new lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, cohuck@redhat.com
Cc: thuth@redhat.com, bwalk@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, pasic@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, rth@twiddle.net



On 10/27/2017 04:30 PM, Collin L. Walling wrote:
> The sclp console in the s390 bios writes raw data,
> leading console emulators (such as virsh console) to
> treat a new line ('\n') as just a new line instead
> of as a Unix line feed. Because of this, output
> appears in a "stair case" pattern.
> 
> Let's print \r\n on every occurrence of a new line
> in the string passed to write to amend this issue.
> 
> This is in sync with the guest Linux code in
> drivers/s390/char/sclp_vt220.c which also does a line feed
> conversion  in the console part of the driver. 
> 
> This fixes the s390-ccw and s390-netboot output like
> $ virsh start test --console
> Domain test started
> Connected to domain test
> Escape character is ^]
> Network boot starting...
>                           Using MAC address: 02:01:02:03:04:05
>                                                                 Requesting information via DHCP:  010
> 
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

FWIW, please remove my signed-off-by when resending.
