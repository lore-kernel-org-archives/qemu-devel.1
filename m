Received: from eggs.gnu.org ([2001:4830:134:3::10]:48011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dugqr-0002Pu-Fr
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dugqm-0007xF-0k
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:23:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58930
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dugql-0007wG-MK
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 11:23:43 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8KAxPuY134697
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 07:03:04 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3phjtb45-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 07:03:03 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 20 Sep 2017 12:03:02 +0100
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-5-pasic@linux.vnet.ibm.com>
	<20170920074751.GI11080@bjsdjshi@linux.vnet.ibm.com>
	<20170920102537.6b329909.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 20 Sep 2017 13:02:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170920102537.6b329909.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1254ddda-74a6-fa8e-5d7c-9ab995497a04@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/5] 390x/css: introduce maximum data
 address checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/20/2017 10:25 AM, Cornelia Huck wrote:
> On Wed, 20 Sep 2017 15:47:51 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
>> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-19 20:27:44 +0200]:
> 
>>> @@ -828,7 +836,9 @@ void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
>>>      g_assert(!(orb->ctrl1 & ORB_CTRL1_MASK_MIDAW));
>>>      cds->flags = (orb->ctrl0 & ORB_CTRL0_MASK_I2K ? CDS_F_I2K : 0) |
>>>                   (orb->ctrl0 & ORB_CTRL0_MASK_C64 ? CDS_F_C64 : 0) |
>>> +                 (orb->ctrl0 & ORB_CTRL0_MASK_FMT ? CDS_F_FMT : 0) |  
>> This reminds me one more question:
>> Calling ccw_dsteram_init() after copy_ccw_from_guest() may lead to a
>> fmt-1 @ccw with an @orb that designates fmt-0 ccw. This sounds insane.
> 
> That's just a consequence of us translating everything to format-1
> ccws. A bit confusing, but no problem if we pay attention to the format
> bit everywhere it makes a difference.
> 

Agree.

Halil
