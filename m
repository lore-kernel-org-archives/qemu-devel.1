Received: from eggs.gnu.org ([2001:4830:134:3::10]:53356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dufcj-0002qj-Fs
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dufce-0001ed-CH
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:05:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45126
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dufce-0001e4-5Y
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:05:04 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8KE4GJk066530
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 10:05:02 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d3q1wcb83-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 10:05:01 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 20 Sep 2017 15:04:58 +0100
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
	<1500028867-134709-34-git-send-email-borntraeger@de.ibm.com>
	<5eb9a7bd-2761-bea1-738a-da7a6d3fbfcf@de.ibm.com>
	<f6da1ec7-4845-fe78-b6b8-29a71d481458@de.ibm.com>
	<20170920145935.7d177fcf.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 20 Sep 2017 16:04:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170920145935.7d177fcf.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5a85b32b-baa2-ff08-2bb2-aabde5261ca3@de.ibm.com>
Subject: Re: [Qemu-devel] block ais migration for machines <= 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Michael Roth <mdroth@linux.vnet.ibm.com>



On 09/20/2017 02:59 PM, Cornelia Huck wrote:
> On Wed, 20 Sep 2017 14:53:07 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> Something like the following seems to do the tricks.
>> Needs proper patch description, review, full test with different kernel versions.....
> 
> Looks sane.
> 
> Will you handle it?


Yes, I will do more testing etc and then send a proper version.
