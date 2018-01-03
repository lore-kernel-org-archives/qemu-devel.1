Received: from eggs.gnu.org ([2001:4830:134:3::10]:48792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eWnVC-0002b8-UC
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:10:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eWnV9-0008Cw-P9
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:10:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37400)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eWnV9-0008CV-Jy
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:10:55 -0500
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-5-marcandre.lureau@redhat.com>
	<CAJ+F1CLxk6vC+ZB09BUBMnJj12RuaeYS=S5KwcBGhoHiYbCd5g@mail.gmail.com>
	<CAJ+F1CLHsFoRFYy825f0MxyAU4T+97YrjMQWfmu6Cni49zyZWQ@mail.gmail.com>
	<bfe98eaa-bf87-dabe-ec63-7eae338495a2@redhat.com>
	<CAFEAcA96TDZR7O75q_NH_vOdLBYr3ygnx-qzoZrQaeRqfrHAkA@mail.gmail.com>
	<CAJ+F1C+xQGWy8jCEXwzPg17vWJxixVydzEf_jb-FvjohTKwPng@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f73e4d0b-ced0-2063-6475-2061511434e0@redhat.com>
Date: Wed, 3 Jan 2018 19:10:48 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+xQGWy8jCEXwzPg17vWJxixVydzEf_jb-FvjohTKwPng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/13] build-sys: add AddressSanitizer
 when --enable-debug if possible
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On 03/01/2018 19:02, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Jan 3, 2018 at 6:52 PM, Peter Maydell <peter.maydell@linaro.org=
> wrote:
>> On 2 January 2018 at 17:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> 2) I think removing -O2 from --enable-debug should be removed at the
>>> same time.  That pretty much guarantees that nobody will use
>>> --enable-debug, and optimized builds are decently debuggable nowadays=
.
>>> The best would be to detect -Og, and add either -Og or -O1 depending =
on
>>> presence.
>>
>> Hmm. I use --enable-debug all the time and one of the reasons
>> I use it is that the optimized build is usually more pain
>> to debug with...
>=20
>        -Og Optimize debugging experience.  -Og enables optimizations
> that do not interfere with debugging. It should be the optimization
> level of choice for the standard edit-compile-debug cycle, offering
>            a reasonable level of optimization while maintaining fast
> compilation and a good debugging experience.
>=20
> That should cover debugging nicely. Tbh, I am quite happy with
> compiler default to O0 when --enable-debug. Og doesn't give me much
> different experience.
>=20
> However, it produces false-positive warnings with gcc.

-O0 doesn't enable those warnings at all, because it would have even
more false positives. :)

Paolo
