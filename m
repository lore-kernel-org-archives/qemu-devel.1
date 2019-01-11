Received: from eggs.gnu.org ([209.51.188.92]:46171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1ghu6G-0003LY-7h
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1ghu6D-0002pD-OD
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:31:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41540
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1ghu6C-0002o0-3I
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:31:36 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x0BATPL5129090
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 05:31:29 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pxr4ym129-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 05:31:29 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 11 Jan 2019 10:31:27 -0000
Date: Fri, 11 Jan 2019 11:31:21 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190110175722.4ee8d4d6.cohuck@redhat.com>
References: <1545062250-7573-1-git-send-email-akrowiak@linux.ibm.com>
	<112a03e6-3d6c-1c14-10ab-c9cea09ad388@linux.ibm.com>
	<20190108173113.3c2d830c.cohuck@redhat.com>
	<20190108175021.003deab9@oc2783563651>
	<20190108180615.7e48cf13.cohuck@redhat.com>
	<4876194e-1a87-1491-a8b3-eed5b0a9afe6@linux.ibm.com>
	<20190109111419.426ec6d7.cohuck@redhat.com>
	<a59d5b64-0fb3-4b70-96ff-b1a0c037c6ac@linux.ibm.com>
	<20190109183538.05bab3c8@oc2783563651>
	<04965ae7-da3d-a68a-ce0c-eb0b02e542ed@linux.ibm.com>
	<20190110175722.4ee8d4d6.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190111113121.05199eac@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH v3] qdev/core: fix qbus_is_full()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, imammedo@redhat.com, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Peter Maydell <peter.maydell@linaro.org>

On Thu, 10 Jan 2019 17:57:22 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> > I thought the same. They could also be made unsigned long or
> > unsigned long long to increase the number of child devices that can be
> > plugged in before having to deal with exceeding the index value.  
> 
> Making them unsigned long long would push the problem out far enough to
> be irrelevant in practice. Not sure if we care about fixing it
> completely, though.

My intuition says that INT_MAX hotplug's on a bus is already an
'academic' thing. The rationale behind asking about unsigned is that
I would consider something like 'child[-42]' weird.

My intuition was that this is something that the community considers
not important enough to invest in. If we don't want to leave it as is, I
would prefer some proper fix (explicit limit on the number of hotplug
operations, or scanning for the first free one).

Regards,
Halil
