Received: from eggs.gnu.org ([2001:4830:134:3::10]:35792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d1wvB-00089F-U5
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 11:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d1wv8-0000In-Hz
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 11:26:01 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d1wv8-0000IM-5A
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 11:25:58 -0400
Received: by mail-wm0-x242.google.com with SMTP id z129so9775437wmb.1
	for <qemu-devel@nongnu.org>; Sat, 22 Apr 2017 08:25:57 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <cover.1492384862.git.shorne@gmail.com>
	<fb69c137317a365dcb549dfef1ecd2fbff48e92c.1492384862.git.shorne@gmail.com>
	<6914f9b7-ece1-973d-2210-871b71319ae0@twiddle.net>
	<20170418142055.GB2599@lianli.shorne-pla.net>
	<20170422100942.GA4797@lianli.shorne-pla.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ab4f029c-8264-7d35-b0e0-9b35a8e80d9d@twiddle.net>
Date: Sat, 22 Apr 2017 17:25:53 +0200
MIME-Version: 1.0
In-Reply-To: <20170422100942.GA4797@lianli.shorne-pla.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] target/openrisc: add shutdown logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: qemu-devel@nongnu.org, openrisc@lists.librecores.org, agraf@suse.de, wbx@openadk.org

On 04/22/2017 12:09 PM, Stafford Horne wrote:
> I discussed a bit on #qemu and Alexander Graf suggested to properly define
> shutdown semantics for openrisc. Some examples were shown from ppc, s390
> and arm.

Yes, properly defining this in the spec goes a long way toward fixing the 
underlying problem.

It's probably worth thinking about a wait-state condition as well, so that qemu 
can avoid staying pegged at 100% host cpu for an idle guest cpu.

>    ppc - platform
>    http://git.qemu.org/?p=qemu.git;a=blob;f=hw/ppc/e500.c;hb=HEAD#l936
>    Registers hardware device mpc8xxx_gpio which handles shutdown via gpio

That's one possibility.  Another is to define an SPR.


r~
