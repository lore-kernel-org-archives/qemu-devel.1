Received: from eggs.gnu.org ([2001:4830:134:3::10]:45513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gxt@mprc.pku.edu.cn>) id 1ew5DA-0006FI-7V
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 08:08:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gxt@mprc.pku.edu.cn>) id 1ew5D5-0001PK-9n
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 08:08:52 -0400
Received: from [162.105.89.7] (port=50402 helo=mprc.pku.edu.cn)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gxt@mprc.pku.edu.cn>) id 1ew5D4-0001Nt-6j
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 08:08:47 -0400
Message-ID: <57013.203.187.182.140.1521028863.squirrel@mprc.pku.edu.cn>
In-Reply-To: <61c9aef6-0355-d59c-3082-ea16a1f50802@vivier.eu>
References: <CAFEAcA8Pu=SkYCPwCnRdKTEFPScsZhj4vJm0dTs+jV1jTWOAog@mail.gmail.com>
	<0304e590-ab51-649b-7cee-bb7c5be6f5e4@redhat.com>
	<c7b075f5-8084-99c0-02e0-3da555bea4df@mail.uni-paderborn.de>
	<87y3j1jn8z.fsf@linaro.org>
	<08f1ea76-5b50-267e-4dfa-fbd39d19baff@mail.uni-paderborn.de>
	<CAFEAcA-JwWcB42CbL0rmZVYj06L+jT4BoK4tDaYmEprfcezNFg@mail.gmail.com>
	<51404.203.187.182.140.1521018597.squirrel@mprc.pku.edu.cn>
	<61c9aef6-0355-d59c-3082-ea16a1f50802@vivier.eu>
Date: Wed, 14 Mar 2018 20:01:03 +0800 (CST)
From: "Xuetao Guan" <gxt@mprc.pku.edu.cn>
Reply-To: gxt@mprc.pku.edu.cn
MIME-Version: 1.0
Content-Type: text/plain;charset=gb2312
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Deprecate tilegx ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: gxt@mprc.pku.edu.cn, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Chen Gang <chengang@emindsoft.com.cn>, Chen Gang <gang.chen.5i5j@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, QEMU Developers <qemu-devel@nongnu.org>, Alex =?gb2312?Q?Benn=E8=8C=85e?= <alex.bennee@linaro.org>, Chen Gang <xili_gchen_5257@hotmail.com>, Richard Henderson <rth@twiddle.net>

> Le 14/03/2018 =C3=A0 10:09, Xuetao Guan a =C3=A9crit=C2=A0:
>>
>>> [...]
>>> Personally, I think it's useful to consider not merely "do we
>>> have anybody actively maintaining this" (after all our x86 frontend
>>> is not exactly very well-loved!) but also "are there users of QEMU
>>> out there using it?" and "is this actually something that exists
>>> in the real world as actual silicon in any quantity?". I think
>>> unicore32 failed on both of those, but tilegx passes the latter
>>> and possibly the former.
>>>
>>> thanks
>>> -- PMM
>>>
>>
>> UniCore is a real silicon product, integrated into PKUnity SoC, and so=
ld
>> in a large amount of embedded boxes, such as cloud terminals and set t=
op
>> boxes. Since we provide complete product solutions, few users use QEmu
>> directly to simulate the booting and running of unicore32-linux runtim=
e
>> system.
>> For me, I still maintain unicore32 port, and I really appreciate havin=
g
>> unicore32 port in the tree.
>
> We keep unicore32 in the system emulation part, but my latest pull
> request removes it from the linux user emulation part (patch from Peter
> Maydell) as it is broken and disabled for a long time now.
>
> If you want unicore32 in the linux-user emulation part, you must fix it
> and send a patch series to re-introduce it.

For unicore32-linux-user part, that's ok to remove it. We haven't updated
it since abi changed. Thanks Laurent. It should be my work.

>
> Moreover, in the future, to be able to test it, I'd like to know where
> to find a distro I can install.
>
> Thanks,
> Laurent
>
After both qemu and linux update to latest version, I'll put a busybox
system on my website for test. Maybe four months later, since my time is
limited recently.

Thanks,
Guan Xuetao
