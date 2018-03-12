Received: from eggs.gnu.org ([2001:4830:134:3::10]:56900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evNln-0007Gf-Pf
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:45:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evNln-0005z7-49
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:45:43 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evNlm-0005yU-Vn
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:45:43 -0400
Received: by mail-ot0-x241.google.com with SMTP id n74so15308544ota.1
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 06:45:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMxuvayOHENoibkYscXP5x-u8iTBYrLWkfL0eBuXX2YPBi5nYw@mail.gmail.com>
References: <1520615003-20869-1-git-send-email-wei@redhat.com>
	<CAMxuvayOHENoibkYscXP5x-u8iTBYrLWkfL0eBuXX2YPBi5nYw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 13:45:21 +0000
Message-ID: <CAFEAcA-qcFSTzhGYKdWE9QxPgRESMzMCWJ7UT6RfD1YV9xhsgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] dump: Update correct kdump phys_base
 field for AArch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: Wei Huang <wei@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 11 March 2018 at 17:42, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> Hi
>
> On Fri, Mar 9, 2018 at 6:03 PM, Wei Huang <wei@redhat.com> wrote:
>> For guest kernel that supports KASLR, the load address can change every
>> time when guest VM runs. To find the physical base address correctly,
>> current QEMU dump searches VMCOREINFO for the string "NUMBER(phys_base)=
=3D".
>> However this string pattern is only available on x86_64. AArch64 uses a
>> different field, called "NUMBER(PHYS_OFFSET)=3D". This patch makes sure
>> QEMU dump uses the correct string on AArch64.
>>
>> Signed-off-by: Wei Huang <wei@redhat.com>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks; applied to target-arm.next for 2.12.

-- PMM
