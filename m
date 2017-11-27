Received: from eggs.gnu.org ([2001:4830:134:3::10]:43733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1eJLzN-0006zJ-5O
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1eJLzH-0006Y8-DG
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:10:33 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:51726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1eJLzG-0006XG-TE
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 11:10:27 -0500
References: <ab2eda3b-571f-025e-66e9-6c1577793a08@physik.fu-berlin.de>
	<b3becdc0-6540-30a6-b70b-8312ac5dddd9@physik.fu-berlin.de>
	<af9abebc-0650-a7c7-e63d-adafaa7031d6@linaro.org>
	<CAFEAcA_mR86vZhqe7yZwUdSSFyKDcms6UoK-NnXgW2ER8GL5tw@mail.gmail.com>
	<9e520d68-0aba-1a32-06d9-351e90d0a7bf@linaro.org>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <35cfeff9-fd4f-ea38-5eaf-c9e7bb7d0428@physik.fu-berlin.de>
Date: Mon, 27 Nov 2017 17:10:22 +0100
MIME-Version: 1.0
In-Reply-To: <9e520d68-0aba-1a32-06d9-351e90d0a7bf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>, QEMU Developers <qemu-devel@nongnu.org>, Michael Karcher <debian@mkarcher.dialup.fu-berlin.de>, James Clarke <jrtc27@jrtc27.com>, Laurent Vivier <laurent@vivier.eu>, Adhemerval Zanella <adhemerval.zanella@linaro.com>

On 11/27/2017 05:07 PM, Adhemerval Zanella wrote:> However I am not very compelled to change internal posix_spawn
> on GLIBC on Linux mainly because it uses a slight less resources
> than the generic POSIX one (check e83be730910c) and it works
> on Linux kernel as expected.

But it breaks QEMU and Microsoft Windows Services for Linux who -
combined together - are certainly not a small number of users.

Isn't there any workaround we can use for the time being?

Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
