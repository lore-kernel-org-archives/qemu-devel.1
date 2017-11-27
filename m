Received: from eggs.gnu.org ([2001:4830:134:3::10]:52469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <adhemerval.zanella@linaro.org>) id 1eJMEP-000595-C6
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <adhemerval.zanella@linaro.org>) id 1eJMEM-0004u0-Ls
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:26:05 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <adhemerval.zanella@linaro.org>)
	id 1eJMEM-0004tO-DI
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:26:02 -0500
Received: by mail-qk0-x244.google.com with SMTP id p19so33140362qke.2
	for <qemu-devel@nongnu.org>; Mon, 27 Nov 2017 08:26:02 -0800 (PST)
References: <ab2eda3b-571f-025e-66e9-6c1577793a08@physik.fu-berlin.de>
	<b3becdc0-6540-30a6-b70b-8312ac5dddd9@physik.fu-berlin.de>
	<af9abebc-0650-a7c7-e63d-adafaa7031d6@linaro.org>
	<CAFEAcA_mR86vZhqe7yZwUdSSFyKDcms6UoK-NnXgW2ER8GL5tw@mail.gmail.com>
	<9e520d68-0aba-1a32-06d9-351e90d0a7bf@linaro.org>
	<35cfeff9-fd4f-ea38-5eaf-c9e7bb7d0428@physik.fu-berlin.de>
From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Message-ID: <3baaf549-b67c-4c36-f96c-8fb8f21c1a36@linaro.org>
Date: Mon, 27 Nov 2017 14:25:55 -0200
MIME-Version: 1.0
In-Reply-To: <35cfeff9-fd4f-ea38-5eaf-c9e7bb7d0428@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] glibc "linux: spawni.c: simplify error reporting
 to parent" breaks qemu-user/Windows Service For Linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>, QEMU Developers <qemu-devel@nongnu.org>, Michael Karcher <debian@mkarcher.dialup.fu-berlin.de>, James Clarke <jrtc27@jrtc27.com>, Laurent Vivier <laurent@vivier.eu>, Adhemerval Zanella <adhemerval.zanella@linaro.com>



On 27/11/2017 14:10, John Paul Adrian Glaubitz wrote:
> On 11/27/2017 05:07 PM, Adhemerval Zanella wrote:> However I am not very compelled to change internal posix_spawn
>> on GLIBC on Linux mainly because it uses a slight less resources
>> than the generic POSIX one (check e83be730910c) and it works
>> on Linux kernel as expected.
> 
> But it breaks QEMU and Microsoft Windows Services for Linux who -
> combined together - are certainly not a small number of users.

You can bring this to libc-alpha, but I am not sure how other 
maintainers will see to limit the possible Linux API glibc can use 
because of potentially unsupported semantics of non default emulation 
layers.

I personally do not see it a good precedence because we can't really
foretell what kind of kernel ABI or semantic the non default 
emulation runtime will support or not, so we can't really plan to 
set what will break or not depending of the underlying emulation.

> 
> Isn't there any workaround we can use for the time being?
> 
> Adrian
> 

Maybe recompile glibc with the posix implementation instead of the
Linux one. If I recall correctly it should be a workable replacement.
