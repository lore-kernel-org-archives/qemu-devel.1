Received: from eggs.gnu.org ([2001:4830:134:3::10]:45267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzkH6-0007gt-Vo
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 11:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fzkH3-0000Gc-0I
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 11:08:20 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fzkH2-0000GO-Hz
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 11:08:16 -0400
Received: by mail-wr1-x441.google.com with SMTP id w11-v6so26446789wrc.5
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 08:08:16 -0700 (PDT)
References: <20180911140631.18481-1-alex.bennee@linaro.org>
	<20180911140631.18481-4-alex.bennee@linaro.org>
	<8346c1bb-9cb6-4c08-66a2-b5e5a31903d4@vivier.eu>
	<f28e18ac-b883-e97e-1c0a-599dd154cf60@denx.de>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <f28e18ac-b883-e97e-1c0a-599dd154cf60@denx.de>
Date: Tue, 11 Sep 2018 16:08:13 +0100
Message-ID: <87tvmwax7m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 3/4] linux-user/nios2: bump min uname
 to 4.16.0 [!HACK]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marek Vasut <marex@denx.de>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, 1791796@bugs.launchpad.net, thuth@redhat.com, Riku Voipio <riku.voipio@iki.fi>, Chris Wulff <crwulff@gmail.com>


Marek Vasut <marex@denx.de> writes:

> On 09/11/2018 04:14 PM, Laurent Vivier wrote:
>> Le 11/09/2018 =C3=A0 16:06, Alex Benn=C3=A9e a =C3=A9crit:
>>> This is to work around the limitations of the buildroot
>>> qemu_nios2_10m50_defconfig which sets the base kernel version for
>>> glibc.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>>  linux-user/nios2/target_syscall.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/linux-user/nios2/target_syscall.h b/linux-user/nios2/targe=
t_syscall.h
>>> index ca6b7e69f6..905b80d112 100644
>>> --- a/linux-user/nios2/target_syscall.h
>>> +++ b/linux-user/nios2/target_syscall.h
>>> @@ -2,7 +2,7 @@
>>>  #define TARGET_SYSCALL_H
>>>
>>>  #define UNAME_MACHINE "nios2"
>>> -#define UNAME_MINIMUM_RELEASE "3.19.0"
>>> +#define UNAME_MINIMUM_RELEASE "4.16.0"
>>>
>>>  struct target_pt_regs {
>>>      unsigned long  r8;    /* r8-r15 Caller-saved GP registers */
>>>
>>
>> I have no objection. Perhaps you could ask NiosII Maintainers (cc).
>
> If that's needed, so be it. The Linux 3.19 was required because some
> obscure ABI change happened at that point.

I don't think so - it's an artefact of the way the buildroot toolchain
is built. But the real question which I address in the cover letter is
does nios2-linux-user get much use? I tried enabled tests/tcg for it and
it fails rather badly.

--
Alex Benn=C3=A9e
