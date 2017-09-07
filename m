Received: from eggs.gnu.org ([2001:4830:134:3::10]:48412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpvBn-0005T6-5j
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpvBi-0003Hd-BW
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:41:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpvBi-0003HG-5w
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:41:38 -0400
Date: Thu, 7 Sep 2017 13:41:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170907134134.00f387e8.cohuck@redhat.com>
In-Reply-To: <27b2addf-0d1c-81d7-1e82-1a8cdac70231@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-5-pasic@linux.vnet.ibm.com>
	<20170831115535.1e4201d3.cohuck@redhat.com>
	<7540741b-d230-e7c4-50d3-036f31997c8b@linux.vnet.ibm.com>
	<20170905182546.00457332.cohuck@redhat.com>
	<fe102a7a-e998-8ebe-b94d-e653c4f66c39@linux.vnet.ibm.com>
	<20170906043108.GY31680@bjsdjshi@linux.vnet.ibm.com>
	<8946b1ec-4d14-c953-deab-aaded7cd2c9d@linux.vnet.ibm.com>
	<20170906162019.45eeec4a.cohuck@redhat.com>
	<cc6eab96-969d-eb66-91b5-cdb965c1bcbb@linux.vnet.ibm.com>
	<20170907085831.GF31680@bjsdjshi@linux.vnet.ibm.com>
	<20170907122400.5b2e3faa.cohuck@redhat.com>
	<27b2addf-0d1c-81d7-1e82-1a8cdac70231@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/9] s390x: refactor error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Thu, 7 Sep 2017 13:32:41 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/07/2017 12:24 PM, Cornelia Huck wrote:

> > So we would do an equipment check for the first two ("equipment", i.e.
> > the software, is malfunctioning) and use a more appropriate way for the
> > malformed idaw?
> >   
> 
> You have probably missed my previous email where I state something very
> similar (MID  <2aa8cf98-c331-fe5a-0a7e-1a553c6c5054@linux.vnet.ibm.com>).
> There I say: if we change the kernel code, yes, if we don't I prefer a
> program check.

Not missed, they crossed in mid-air.

But I agree, the decision is Dong Jia's.
