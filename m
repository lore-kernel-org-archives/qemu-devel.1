Received: from eggs.gnu.org ([2001:4830:134:3::10]:50361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRhTA-0005NT-32
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:43:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRhT7-0006Wh-7S
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:43:48 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:56657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eRhT6-0006Un-Ud
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:43:45 -0500
References: <20171219201613.7399-1-michael.weiser@gmx.de>
	<20171219201613.7399-6-michael.weiser@gmx.de>
	<6f0ce872-849b-dc5a-25e7-3242a6e5c624@vivier.eu>
	<20171220153715.GC15475@weiser.dinsnail.net>
	<1d8aa1e1-2160-015a-28f5-58baaa51f728@vivier.eu>
	<20171220161556.GF15475@weiser.dinsnail.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bcf948cb-fe73-bc72-5e93-b776740fa80d@vivier.eu>
Date: Wed, 20 Dec 2017 17:43:34 +0100
MIME-Version: 1.0
In-Reply-To: <20171220161556.GF15475@weiser.dinsnail.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] linux-user: Add aarch64_be magic
 numbers to qemu-binfmt-conf.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Weiser <michael.weiser@gmx.de>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Le 20/12/2017 à 17:15, Michael Weiser a écrit :
> Hi Laurent,
> 
> On Wed, Dec 20, 2017 at 04:56:41PM +0100, Laurent Vivier wrote:
> 
>>> Based on that I suspect that qemu-binfmt-conf.sh's current assignment of
>>> armeb and aarch64 into the arm CPU family is over-optimistic as well.
>>> So I'd suggest treating all of arm, armeb, aarch64 and aarch64_be as
>>> separate families.
>> So it's not like on intel/AMD where we can execute a 32bit binary on a
>> 64bit kernel?
> 
> An aarch64 CPU is capable of running arm (i.e. aarch32) code. And I
> think this is supported as a multilib setup on Linux. But not in mixed
> endianess as far as I know.
> 
> Looking at the code again, I'm confused now: Wouldn't the current logic
> treat an actual i386 machine as capable of running x86_64 binaries
> natively and omit registering the handler for x86_64?

It can be read like that, but actually 32bit machine cannot emulate
64bit architecture, so we don't register it.

So for the same family:

- on 64bit machine, we don't register the interpreter because the 32bit
binary can be executed natively,

- on 32bit machine, we don't register the interpreter because the
interpreter cannot work,

Thanks,
Laurent
