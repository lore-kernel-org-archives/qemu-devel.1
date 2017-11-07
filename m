Received: from eggs.gnu.org ([2001:4830:134:3::10]:47123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eBxpv-0008BN-8W
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 01:58:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eBxps-0007ZD-6t
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 01:58:15 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:60643)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eBxpr-0007Xu-Tn
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 01:58:12 -0500
References: <492245211.936616.1510023015797.JavaMail.zimbra@xes-inc.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <03986f7a-f1f8-751a-4967-ab7d1a5093fd@vivier.eu>
Date: Tue, 7 Nov 2017 07:57:59 +0100
MIME-Version: 1.0
In-Reply-To: <492245211.936616.1510023015797.JavaMail.zimbra@xes-inc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: Support explicit targets for
 PowerPC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Sierra <asierra@xes-inc.com>, Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org

Le 07/11/2017 à 03:50, Aaron Sierra a écrit :
> Enable building PowerPC targets supporting a specific CPU, without
> having to set QEMU_CPU via the environment. For example these build
> targets (and many more) become available:
> 
>     qemu-ppc.e500mc
>     qemu-ppc.e500v2
>     qemu-ppc.e5500
>     qemu-ppc.e600
>     qemu-ppc.e6500
> 
> These (statically compiled) binaries have proven useful for emulating
> PowerPC CPUs within Docker containers, where it's hard to reliably
> define environment variables that are available for every process.

I agree with you.

I have patches to do that for years, perhaps we can merge our both
solutions to have something working:

linux-user: define default cpu model in configure instead of
linux-user/main.c
https://github.com/vivier/qemu-m68k/commit/1488df8c9fa3a5b099bbc4f41c077a6c69305cc2

linux-user: specify the cpu model during configure
https://github.com/vivier/qemu-m68k/commit/496f804fd97d5f0ef26da1090e1d95ad15bcc50e

The part missing in my series is to rename the qemu binaries with the
suffix of the default CPU.

Thanks,
Laurent
