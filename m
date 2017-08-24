Received: from eggs.gnu.org ([2001:4830:134:3::10]:50668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkufU-0001kN-CQ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkufO-0003W0-Mv
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:07:40 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dkufO-0003V8-EK
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 12:07:34 -0400
Received: by mail-wm0-x231.google.com with SMTP id p30so9054140wmi.0
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 09:07:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c9a6a1ec-eb7c-08a6-82ad-87ad5412ad19@linux.vnet.ibm.com>
References: <e2a1b182-83a9-2259-27f9-68b61b5061d5@linux.vnet.ibm.com>
	<20170824171355.29d1ec32.cohuck@redhat.com>
	<30333b41-508d-f9a3-ac2d-4830a7791475@redhat.com>
	<34f0f307-d16f-7c76-1589-fa06252f6d09@linux.vnet.ibm.com>
	<ad0ef5a7-c0e0-9e54-a417-858c4b32a80e@redhat.com>
	<c9a6a1ec-eb7c-08a6-82ad-87ad5412ad19@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Aug 2017 17:07:11 +0100
Message-ID: <CAFEAcA-oE=E3ydugLdVnPS2Tquqkou=BEhsB_DALqZxbVD0GDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] S390 bios breaks in qemu 2.10.rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>

On 24 August 2017 at 16:53, Farhan Ali <alifm@linux.vnet.ibm.com> wrote:
>
>
> On 08/24/2017 11:50 AM, Thomas Huth wrote:
>> True, so that could still be an issue. Looking at the cio.h in the
>> kernel, they define the struct like this:
>>
>> struct ccw1 {
>>         __u8  cmd_code;
>>         __u8  flags;
>>         __u16 count;
>>         __u32 cda;
>> } __attribute__ ((packed,aligned(8)));
>>
>> So I guess adding the aligned(8) is the right way to go?

> This was my initial fix and it works on my system. But for some reason this
> fix does not work on my colleague's system. So I am hesitant about
> submitting this fix

It seems like it ought to be the obvious fix, so I would double
check that on your colleague's system the change really did
get recompiled and it's actually using the new version (that
sort of mistake can be easy to make and very confusing...)

thanks
-- PMM
