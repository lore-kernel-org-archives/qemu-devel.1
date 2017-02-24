Received: from eggs.gnu.org ([2001:4830:134:3::10]:43845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1chDqf-00021H-HT
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:15:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1chDqa-0001nM-IE
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:15:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34773
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1chDqa-0001mS-Ad
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:15:36 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1OB9Swd113803
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 06:15:35 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28thjb57e8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 06:15:35 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 24 Feb 2017 04:15:34 -0700
References: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
	<20170220141943.8426-4-cornelia.huck@de.ibm.com>
	<d8c1475a-765b-e980-cb48-255c29efdaf6@redhat.com>
	<4340aa12-3289-9d19-6156-9121a9643749@linux.vnet.ibm.com>
	<75631dfb-bd96-b905-6720-84980cbd477d@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 24 Feb 2017 12:15:29 +0100
MIME-Version: 1.0
In-Reply-To: <75631dfb-bd96-b905-6720-84980cbd477d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Message-Id: <715482cf-c074-848f-5651-fd9fad535bb6@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] s390x/ipl: Load network boot image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org
Cc: jfrei@linux.vnet.ibm.com, agraf@suse.de

On 02/24/2017 11:11 AM, Thomas Huth wrote:

>>> ... and then you do another error_report here again ... so one error
>>> gets reported with two error message. Wouldn't it be nicer to rather do
>>> error_setg(...) in load_netboot_image() and then report only one error
>>> at this level here?
>>>
>>
>> What would be the advantage of doing that?
> 
> It's just good coding style to report an error only once, at the
> outermost calling function. Otherwise the same error gets reported
> multiple times to the user, with different error messages, and that can
> easily get confusing. It's likely not a big problem here yet, since the
> call depths is only 2 functions, but imagine a situation where you've
> got a call depth or 5 or more and an error is reported at every
> depths... that's ugly. So this is why we've got error_setg() and friends
> in QEMU.
> 
>  Thomas

Farhan was already convinced. Can you check v2 of this patch set?
Thanks for doing the review :-)
