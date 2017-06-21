Received: from eggs.gnu.org ([2001:4830:134:3::10]:41692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dNWQw-0002is-GK
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 23:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dNWQv-0001C0-MP
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 23:35:58 -0400
MIME-Version: 1.0
In-Reply-To: <CAOE=1Z1Bbgb494m6mYRnX1-80eT0tSnF0F6zNM7efEie4rd7DA@mail.gmail.com>
References: <CAOE=1Z1Bbgb494m6mYRnX1-80eT0tSnF0F6zNM7efEie4rd7DA@mail.gmail.com>
From: Sam <batmanustc@gmail.com>
Date: Wed, 21 Jun 2017 11:35:56 +0800
Message-ID: <CAOE=1Z1LJr9rpaEQ9+b7D5vM3N=Wy0oGunRnzoQ79x3dWA3oaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Will huge page have negative effect on guest vm in
 qemu enviroment?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dev@dpdk.org, users@dpdk.org, qemu-devel@nongnu.org, qemu-discuss@nongnu.org

BTW, we also think about use ovs-dpdk in docker enviroment, but test result
said it's not good idea, we don't know why.

2017-06-21 11:32 GMT+08:00 Sam <batmanustc@gmail.com>:

> Hi all,
>
> We plan to use DPDK on HP host machine with several core and big memory.
> We plan to use qemu-kvm enviroment. The host will carry 4 or more guest vm
> and 1 ovs.
>
> Ovs-dpdk is much faster then normal ovs, but to use ovs-dpdk, we have to
> enable huge page globally.
>
> My question is, will huge page enabled globally have negative effect on
> guest vm's memory orperate or something? If it is, how to prevent this, or
> could I enable huge page on some core or enable huge page for a part of
> memory?
>
> Thank you~
>
