Received: from eggs.gnu.org ([2001:4830:134:3::10]:58308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ewYdm-0000Ff-Oh
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:34:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ewYdj-00065T-Ml
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:34:18 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:45066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ewYdj-00065A-FL
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 15:34:15 -0400
Received: by mail-pf0-x243.google.com with SMTP id h19so3209803pfd.12
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 12:34:15 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180315191958.28937-1-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8ed72173-427f-d16f-bcec-26649511836d@twiddle.net>
Date: Fri, 16 Mar 2018 03:34:09 +0800
MIME-Version: 1.0
In-Reply-To: <20180315191958.28937-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/3] target/m68k: fix TCGv array overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

On 03/16/2018 03:19 AM, Laurent Vivier wrote:
> I try to fix this by introducing a new TCG function
> to try to free a TCGv if it is a temporary one and
> do nothing otherwise (patches 1 and 2)

I would prefer not to approach this in this way.

Better is to have translator helpers that allocate temps
that are freed at the end of the insn.

C.f. new_tmp_a64 in target/arm/translate-a64.c.


r~
