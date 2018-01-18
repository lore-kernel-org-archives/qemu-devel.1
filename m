Received: from eggs.gnu.org ([2001:4830:134:3::10]:42975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecCbR-0007iS-Ve
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ecCbN-0007WI-3w
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:59:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ecCbM-0007Vq-TZ
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 10:59:41 -0500
References: <20180118025245.13042-1-famz@redhat.com>
	<d1dd1750-c487-be35-05eb-ffb12f18e805@redhat.com>
	<a81a812f-065c-e8be-0d6d-92525a379a82@amsat.org>
	<cf2b427d-a8a0-a124-16dd-598d4f7eea46@redhat.com>
	<CAAdtpL4kR9qWjWHBuYYbZXv=FBoKXRgLE5tzaaC1nZyJZNHXNA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e7f2c735-d7b9-e05b-310f-c06f849b7660@redhat.com>
Date: Thu, 18 Jan 2018 16:59:28 +0100
MIME-Version: 1.0
In-Reply-To: <CAAdtpL4kR9qWjWHBuYYbZXv=FBoKXRgLE5tzaaC1nZyJZNHXNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scsi-generic: Simplify error handling code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 18/01/2018 16:55, Philippe Mathieu-Daud=C3=A9 wrote:
> On Thu, Jan 18, 2018 at 9:03 AM, Paolo Bonzini <pbonzini@redhat.com> wr=
ote:
>> On 18/01/2018 12:21, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> I'm not a fan of bool return types, in general (because "!" is often
>>>> success while "< 0" is failure) and especially when there is an Erro=
r**;
>>>> I disagree with commit 9d3b155186.  But the function is not in an ar=
ea I
>>>> maintain so I'm queuing this, thanks.
>>> Do you prefer "if (local_err)" and "if (errp && *errp)" ?
>>
>> The latter is wrong.  I do prefer
>=20
> Ok so my 253674981e24 missed that train too.

Well, sdhci_common_realize cannot fail so you can just remove the
Error** argument.

Paolo
