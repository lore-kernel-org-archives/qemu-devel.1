Received: from eggs.gnu.org ([2001:4830:134:3::10]:44889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fcWSe-0003GE-Ik
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fcWSb-0007vx-Fy
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:44:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fcWSb-0007vJ-AS
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:44:13 -0400
References: <1528185295-14199-1-git-send-email-slp@redhat.com>
	<4e35ea24-147d-1b51-fa1b-0f1cc32966e0@redhat.com>
	<CAJ+F1CLjAXcdkUS2cj_6x2UnE1jTcFAfy88yDWfomp6+Mt7v+g@mail.gmail.com>
	<CAFEAcA8WN1K-r0u6ZDBFRwRa1WZAMBf2MQhkhg-WDRazfVjQzw@mail.gmail.com>
	<CAJ+F1CKk=3amSNTSusbPj1MUM+ksTse2YVddLyTf5jqr6RDyFQ@mail.gmail.com>
	<01f5d4ef-cea1-ff81-82cc-30a617a3c648@redhat.com>
	<CAFEAcA8J40JyvMgtNjscVsPYaGxavEctC+pk6eqPXoUjZMhpyQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <005419af-3739-af1b-6cde-fbbebec4bc81@redhat.com>
Date: Mon, 9 Jul 2018 15:44:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8J40JyvMgtNjscVsPYaGxavEctC+pk6eqPXoUjZMhpyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/char/serial: Only retry if
 qemu_chr_fe_write returns 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Sergio Lopez <slp@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>

On 09/07/2018 15:21, Peter Maydell wrote:
>>
>> However, indeed it seems to me that the logic of the patch is backward=
s:
>>
>> - -1/EAGAIN should retry
>>
>> - 0 should *not* retry, because it means the other side has hung up
> This seems weird, because it doesn't follow the usual pattern
> for non-blocking functions, where 0 just means "nothing was
> written" and actual error conditions like the other side having
> gone away are reported via -1 and some errno.
>=20

Ah no, that's read(2).  write(2) is as you say, so the patch should
check for EAGAIN.

Paolo
