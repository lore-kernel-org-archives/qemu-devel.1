Received: from eggs.gnu.org ([2001:4830:134:3::10]:59211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1epEap-0007Bj-7W
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:45:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1epEam-0003y4-0C
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:44:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52286
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1epEal-0003vH-P2
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:44:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1NEiJBY142087
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:44:55 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gajk8xg05-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:44:54 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 23 Feb 2018 14:44:52 -0000
References: <1519390265-15576-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1519390265-15576-4-git-send-email-imbrenda@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 23 Feb 2018 15:44:48 +0100
MIME-Version: 1.0
In-Reply-To: <1519390265-15576-4-git-send-email-imbrenda@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <95b90dd7-82aa-bc7f-896b-88aed8f9ee80@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] s390x/sclp: extend SCLP event masks
 to 64 bits
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

> 
> +static bool vmstate_event_facility_mask64_needed(void *opaque)
> +{
> +    SCLPEventFacility *ef = opaque;
> +
> +    return (ef->receive_mask & 0xFFFFFFFF) != 0;
> +}
> +
> +static int vmstate_event_facility_mask64_pre_load(void *opaque)
> +{
> +    SCLPEventFacility *ef = opaque;
> +
> +    ef->receive_mask &= ~0xFFFFFFFFULL;
> +    return 0;
> +}

again, no need for a pre-load here. The ef->receive_mask should start out as 0.
