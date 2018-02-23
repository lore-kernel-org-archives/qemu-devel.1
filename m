Received: from eggs.gnu.org ([2001:4830:134:3::10]:55409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1epEN6-0002HW-Rp
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1epEN3-0001Yc-5t
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:30:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44776
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1epEN2-0001Y3-WA
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:30:45 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1NEJ99b079464
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:30:44 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gahx9q3a1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:30:43 -0500
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 23 Feb 2018 14:30:42 -0000
References: <1519390265-15576-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1519390265-15576-3-git-send-email-imbrenda@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 23 Feb 2018 15:30:38 +0100
MIME-Version: 1.0
In-Reply-To: <1519390265-15576-3-git-send-email-imbrenda@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9018fa2d-578d-a0c0-8f6a-444902639348@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/3] s390x/sclp: clean up sclp masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, cohuck@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 02/23/2018 01:51 PM, Claudio Imbrenda wrote:
> Introduce an sccb_mask_t to be used for SCLP event masks instead of just
> unsigned int or uint32_t. This will allow later to extend the mask with
> more ease.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
