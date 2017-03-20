Received: from eggs.gnu.org ([2001:4830:134:3::10]:50800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpyaL-0004Ez-J2
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpyaK-00072v-UE
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:47:01 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:36661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpyaK-00072N-Nv
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:47:00 -0400
Received: by mail-wr0-x233.google.com with SMTP id u108so93979422wrb.3
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 07:47:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAG48ez1tcz7GGsc5+L3EF140NsW=UyNir=0UpuZZYrBn4ZxrSA@mail.gmail.com>
References: <CAG48ez1tcz7GGsc5+L3EF140NsW=UyNir=0UpuZZYrBn4ZxrSA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 14:46:39 +0000
Message-ID: <CAFEAcA8-GJxpmppZGF5ygSAL4Y81BdvYKqso-XhjR2pbjMLi+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [BUG] user-to-root privesc inside VM via bad
 translation caching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jann Horn <jannh@google.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>

On 20 March 2017 at 14:36, Jann Horn <jannh@google.com> wrote:
> This is an issue in QEMU's system emulation for X86 in TCG mode.
> The issue permits an attacker who can execute code in guest ring 3
> with normal user privileges to inject code into other processes that
> are running in guest ring 3, in particular root-owned processes.

> I am sending this to qemu-devel because a QEMU security contact
> told me that QEMU does not consider privilege escalation inside a
> TCG VM to be a security concern.

Correct; it's just a bug. Don't trust TCG QEMU as a security boundary.

We should really fix the crossing-a-page-boundary code for x86.
I believe we do get it correct for ARM Thumb instructions.

thanks
-- PMM
