Received: from eggs.gnu.org ([2001:4830:134:3::10]:55371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gMyXF-0000cG-2Y
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:01:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gMyXA-0001Tm-TT
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:01:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gMyXA-0001Rn-Lr
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 12:00:56 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAEGwZ7W054556
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 12:00:55 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nrqm98cm2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 12:00:54 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 14 Nov 2018 17:00:51 -0000
References: <20181114132931.22624-1-marcandre.lureau@redhat.com>
	<16b78816-f2cc-a1e5-0d21-906fc2dbaa3d@redhat.com>
	<a2d9a2fd-2c1a-66e3-86ba-17da9f564e79@redhat.com>
	<c0601dcb-142f-3033-b11f-1b951aaf0e3f@redhat.com>
	<CAFEAcA85vaAoo9wJLC25kF00MyPrAoTu_TSZ8NXxym8q7EhArQ@mail.gmail.com>
	<3784d1ce-045a-59aa-bde2-7590f51196f0@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 14 Nov 2018 18:00:42 +0100
In-Reply-To: <3784d1ce-045a-59aa-bde2-7590f51196f0@redhat.com>
Content-Language: en-US
Message-Id: <810a54c6-62ae-8e06-59a9-91a638addbcc@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: Quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] vmstate: constify VMStateField
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, "open list:S390" <qemu-s390x@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>



On 11/14/2018 05:56 PM, Thomas Huth wrote:
> On 2018-11-14 17:49, Peter Maydell wrote:
>> On 14 November 2018 at 16:39, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
.com> wrote:
>>> Hi Thomas,
>>>
>>> On 14/11/18 17:29, Thomas Huth wrote:
>>>> Please don't. For rationale, see:
>>>> https://www.kernel.org/doc/html/v4.19/process/coding-style.html#typede=
fs
>>>
>>>
>>> Thanks for the pointer, I am interested in understanding why not do tha=
t.
>>> However in the link you pasted I don't see a rational about enforcing
>>> constness, I understand that since this case doesn't match the 5 rules,=
 we
>>> should use 'struct VMStateField' directly and remove the typedef.
>>
>> QEMU's coding style is not the kernel's. In the kernel, yes,
>> they prefer "struct foo". In QEMU we generally prefer to use
>> a typedef for most structs.
>=20
> Yes - my point was simply: Let's do not start to hide more things beside
> "struct" in a typedef. If I look at QEMU source code containing just a
> "VMStateField", I expect it to be a shortcut for "struct VMStateField".
> I'd never expect that it also contains the "const" attribute. I'm pretty
> sure that this would cause some confusion in the future otherwise.

I agree. typedefing a struct is one thing, typedefing qualifiers in (like c=
onst)
is getting really unexpected.=20
