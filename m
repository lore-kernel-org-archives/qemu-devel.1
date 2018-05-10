Received: from eggs.gnu.org ([2001:4830:134:3::10]:46745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fGi7y-0006gh-Pw
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fGi7u-0005CS-UM
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:44:46 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:43071)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fGi7u-0005C3-KS
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:44:42 -0400
References: <20180510092935.29088-1-laurent@vivier.eu>
	<CAFEAcA9xE=7ZRO4iivpFGkX1ELWpS=QcurrDMDPux_sK1+fQdg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <16565256-5823-b56a-88bf-f12b62a83667@vivier.eu>
Date: Thu, 10 May 2018 11:44:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9xE=7ZRO4iivpFGkX1ELWpS=QcurrDMDPux_sK1+fQdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: move thunk.c to linux-user/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>

Le 10/05/2018 à 11:35, Peter Maydell a écrit :
> On 10 May 2018 at 10:29, Laurent Vivier <laurent@vivier.eu> wrote:
>> thunk.c is part of linux-user and only used by it,
>> so move it to the linux-user directory.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  Makefile.target               | 2 +-
>>  linux-user/Makefile.objs      | 2 +-
>>  thunk.c => linux-user/thunk.c | 0
>>  3 files changed, 2 insertions(+), 2 deletions(-)
>>  rename thunk.c => linux-user/thunk.c (100%)
> 
> bsd-user doesn't use it now, but I have a feeling maybe
> the currently-out-of-tree improvements do?

Yes, you're right, I've found it in

https://github.com/seanbruno/qemu-bsd-user/blob/bsd-user/bsd-user/bsd-ioctl.c

Thanks,
Laurent
