Received: from eggs.gnu.org ([2001:4830:134:3::10]:40883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cqCCJ-0001D0-0P
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 01:19:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cqCCF-0006aH-SA
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 01:19:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cqCCF-0006Zz-MC
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 01:19:03 -0400
References: <20170317094714.32220.9387.malonedeb@chaenomeles.canonical.com>
	<20170320142057.GZ17887@stefanha-x1.localdomain>
	<CAFEAcA8MiN9CvMndx=qTSBoYxwh7FvGMDH9EQb6P8o0QaH5Uiw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <274b141e-7ae6-9f42-5b06-bdb3232fe8c8@redhat.com>
Date: Tue, 21 Mar 2017 13:18:57 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8MiN9CvMndx=qTSBoYxwh7FvGMDH9EQb6P8o0QaH5Uiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1673722] [NEW] Reading register at offset. It
 is not fully implemented warning make VM impossible to use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Bug 1673722 <1673722@bugs.launchpad.net>, Leonid Bloch <leonid.bloch@ravellosystems.com>, QEMU Developers <qemu-devel@nongnu.org>, Dmitry Fleytman <dmitry.fleytman@ravellosystems.com>



On 2017=E5=B9=B403=E6=9C=8820=E6=97=A5 22:58, Peter Maydell wrote:
> On 20 March 2017 at 14:20, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> On Fri, Mar 17, 2017 at 09:47:14AM -0000, Julien Duponchelle wrote:
>>> Hi,
>>>
>>> Since this commit:
>>> https://github.com/qemu/qemu/commit/bc0f0674f037a01f2ce0870ad6270a356=
a7a8347
>>>
>>> We can no longer use the IOSvL2 image from Cisco. The problem is we g=
ot a lot of warning message saying:
>>> e1000: Reading register at offset: 0x00002410. It is not fully implem=
ented.
>>>
>>> User got so much of this warning that they can't use the VM.
>> CCing the author and maintainers.
>>
>> DBGOUT() is compiled in by default.  Warnings that can be triggered at=
 a
>> high rate by the guest should be off by default or use a
>> printf_once()-style macro so they are only printed once and not again.
>>
>> Leonid: do you want to adjust e1000 DBGOUT() usage to avoid printing
>> guest-triggerable messages by default?
> If we want to report "whoops, we don't implement this yet" messages the=
n
> the recommended way to do that is
>   qemu_log_mask(LOG_UNIMP, "....");
>
> (these are not reported by default but only if the user asks for them.)
>
> thanks
> -- PMM
>

I don't see a reason that enabling E1000E_DEBUG by default. How about=20
just disable it by default?

Thanks
