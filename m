Received: from eggs.gnu.org ([2001:4830:134:3::10]:46643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ew3O5-00036Y-PM
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 06:12:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ew3O2-00074J-It
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 06:12:01 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:38655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ew3O2-00073R-8v
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 06:11:58 -0400
References: <CAFEAcA8Pu=SkYCPwCnRdKTEFPScsZhj4vJm0dTs+jV1jTWOAog@mail.gmail.com>
	<0304e590-ab51-649b-7cee-bb7c5be6f5e4@redhat.com>
	<c7b075f5-8084-99c0-02e0-3da555bea4df@mail.uni-paderborn.de>
	<87y3j1jn8z.fsf@linaro.org>
	<08f1ea76-5b50-267e-4dfa-fbd39d19baff@mail.uni-paderborn.de>
	<CAFEAcA-JwWcB42CbL0rmZVYj06L+jT4BoK4tDaYmEprfcezNFg@mail.gmail.com>
	<51404.203.187.182.140.1521018597.squirrel@mprc.pku.edu.cn>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <61c9aef6-0355-d59c-3082-ea16a1f50802@vivier.eu>
Date: Wed, 14 Mar 2018 11:11:34 +0100
MIME-Version: 1.0
In-Reply-To: <51404.203.187.182.140.1521018597.squirrel@mprc.pku.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Deprecate tilegx ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gxt@mprc.pku.edu.cn, Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Chen Gang <chengang@emindsoft.com.cn>, Chen Gang <gang.chen.5i5j@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=e8=8c=85e?= <alex.bennee@linaro.org>, Chen Gang <xili_gchen_5257@hotmail.com>, Richard Henderson <rth@twiddle.net>

Le 14/03/2018 à 10:09, Xuetao Guan a écrit :
> 
>> [...]
>> Personally, I think it's useful to consider not merely "do we
>> have anybody actively maintaining this" (after all our x86 frontend
>> is not exactly very well-loved!) but also "are there users of QEMU
>> out there using it?" and "is this actually something that exists
>> in the real world as actual silicon in any quantity?". I think
>> unicore32 failed on both of those, but tilegx passes the latter
>> and possibly the former.
>>
>> thanks
>> -- PMM
>>
> 
> UniCore is a real silicon product, integrated into PKUnity SoC, and sold
> in a large amount of embedded boxes, such as cloud terminals and set top
> boxes. Since we provide complete product solutions, few users use QEmu
> directly to simulate the booting and running of unicore32-linux runtime
> system.
> For me, I still maintain unicore32 port, and I really appreciate having
> unicore32 port in the tree.

We keep unicore32 in the system emulation part, but my latest pull
request removes it from the linux user emulation part (patch from Peter
Maydell) as it is broken and disabled for a long time now.

If you want unicore32 in the linux-user emulation part, you must fix it
and send a patch series to re-introduce it.

Moreover, in the future, to be able to test it, I'd like to know where
to find a distro I can install.

Thanks,
Laurent
