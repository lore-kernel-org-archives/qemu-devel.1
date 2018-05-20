Received: from eggs.gnu.org ([2001:4830:134:3::10]:48276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fKEUv-0001Nf-G3
	for qemu-devel@nongnu.org; Sat, 19 May 2018 22:55:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fKEUs-0000UJ-E3
	for qemu-devel@nongnu.org; Sat, 19 May 2018 22:55:01 -0400
Received: from mail-pl0-x22b.google.com ([2607:f8b0:400e:c01::22b]:36452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fKEUs-0000Tr-8o
	for qemu-devel@nongnu.org; Sat, 19 May 2018 22:54:58 -0400
Received: by mail-pl0-x22b.google.com with SMTP id v24-v6so6778362plo.3
	for <qemu-devel@nongnu.org>; Sat, 19 May 2018 19:54:57 -0700 (PDT)
Date: Sun, 20 May 2018 11:54:54 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20180520025454.GH3652@lianli.shorne-pla.net>
References: <CALAE4RoqNTXyGEUbV3LmonNcyA=o8toPhRrDS23w4W_Zg3z3qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAE4RoqNTXyGEUbV3LmonNcyA=o8toPhRrDS23w4W_Zg3z3qg@mail.gmail.com>
Subject: Re: [Qemu-devel] OpenRISC - SPR_PICMR always 'OR-ing' the values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Davidson Francis <davidsondfgl@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>, Openrisc <openrisc@lists.librecores.org>

On Sat, May 19, 2018 at 08:08:47PM -0300, Davidson Francis wrote:
> Hello Stafford,
> 
> I'm currently using or1k as a target CPU in an operating system that
> I'm working.
> It happens that I'm having some issues regarding the PICMR register: I realize
> that in the latest Qemu version (2.12) when I write into PICMR, the Qemu is
> actually 'OR-ing' the values (as I could note in target/openrisc/sys_helper.c
> file), so I can't mask an already enabled interrupt.
> 
> I don't know if this behaviour is expected and if so, I'm sorry, but this does
> not occurs in the or1ksim, so I thought this could be might an issue.

Hello, thanks for pointing this out.  It looks wrong to me too.  Have you tested
changing it to just `env->picmr = rb;`?

-Stafford
