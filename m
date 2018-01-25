Received: from eggs.gnu.org ([2001:4830:134:3::10]:49550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eejJ4-0000gZ-JR
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:19:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eejJ1-0002fc-Af
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:19:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eejJ1-0002fC-1i
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 10:19:11 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0PFGmGg136314
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 10:19:09 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fqhbws7wy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 10:19:09 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Thu, 25 Jan 2018 10:19:07 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-5-git-send-email-walling@linux.vnet.ibm.com>
	<2a6618d7-566b-bec7-c267-26e4e7acb1a2@redhat.com>
	<ded3d6a0-3432-368a-3964-6641c7fef3fe@linux.vnet.ibm.com>
	<24ede72f-bc12-0911-a5c6-5d38fac2c060@redhat.com>
	<cfd9af56-8122-e195-f89f-e219bec9b23c@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Thu, 25 Jan 2018 10:19:04 -0500
MIME-Version: 1.0
In-Reply-To: <cfd9af56-8122-e195-f89f-e219bec9b23c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <e019b0ad-6d6b-a636-3dc6-c4dc0284ec2b@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 04/10] s390-ccw: update libc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.vnet.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, borntraeger@de.ibm.com, david@redhat.com

On 01/25/2018 10:08 AM, Eric Blake wrote:
> On 01/25/2018 06:06 AM, Thomas Huth wrote:
>>>> That's not "any whitespace", but only spaces.=C2=A0 A fully complian=
t
>>>> implementation would be checking isspace(), but I don't expect you t=
o
>>>> implement that; at a minimum, also checking '\t' would get you close=
r
>>>> (but not all the way to) compliance.
>>>
>>> I'll fix the comment to be more clear.
>>>
>>> I think it's okay to just have the menu code treat any other kind
>>> of whitespace as an error (it will check before calling atoi). I
>>> added support for negatives in bothfunctions because it was easy
>>> enough to do so and for the sakeof completeness.
>>>
>>> However, I worry trying to be 100% compliant will just bloat the
>>> code when we only need it for very specific use cases.
>>>
>>> Would you say what we have (along with the fix to itostr below) is
>>> sufficient enough?
>> IMHO the current way is good enough for a BIOS implementation. We're n=
ot
>> doing a full replacement of glibc here ;-)
> Documenting the issue is the best approach; don't bloat the code for
> something that none of the callers care about.  Perhaps as simple as ad=
ding:
>
> NOTE: This function is not quite like the standardized version in libc;
> it does not handle all forms of leading space or INT_MIN.
>
> (or whatever the actual differences are, based on your implementation
> choices).
>
> Another solution is to just not use the standardized name; keeping it
> named _atoi() instead of atoi() makes it obvious that you are calling a=
n
> internal function that does not have to have standardized semantics.
>
Sound good.=C2=A0 I'll prepend the underscore and document the difference=
s.
Thanks for your suggestions.

--=20
- Collin L Walling
