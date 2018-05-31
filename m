Received: from eggs.gnu.org ([2001:4830:134:3::10]:51187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOQYD-0004Ky-00
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keno@juliacomputing.com>) id 1fOQYC-0003dd-1R
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:35:45 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:46550)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <keno@juliacomputing.com>)
	id 1fOQYB-0003dH-Ro
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:35:43 -0400
Received: by mail-pg0-x242.google.com with SMTP id a3-v6so9948283pgt.13
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 09:35:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180529233205.59770326@bahia.lan>
References: <cover.1527310210.git.keno@alumni.harvard.edu>
	<a648afd776c8eb50398524c6c8d53629f5141211.1527310210.git.keno@alumni.harvard.edu>
	<20180529233205.59770326@bahia.lan>
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 31 May 2018 12:35:02 -0400
Message-ID: <CABV8kRzWaLMx68bLF=r6XEHkys6QhgE8ovUgWqD4HBe0Tbh36g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 08/13] 9p: darwin: Ignore O_{NOATIME,
 DIRECT}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Keno Fischer <keno@alumni.harvard.edu>

>
> Please don't kill the spaces.
>

Sorry, will undo. My editor has strong opinions about styling.

>> +#ifndef CONFIG_DARWIN
>> +        {P9_DOTL_NOATIME, O_NOATIME},
>> +        /* On Darwin, we could map to F_NOCACHE, which is
>> +           similar, but doesn't quite have the same
>> +           semantics. However, we don't support O_DIRECT
>
> But are these semantics worse than dumping the flag ?
>

I don't know. I looked around a bit and most OS abstraction
layers tend to not do this translation automatically:

https://github.com/libuv/libuv/issues/1600

>> +           even on linux at the moment, so we just ignore
>> +           it here. */
>
> Yeah, and I doubt we'll ever support it on linux either. But,
> anyway, why filter these out ? Do they cause a build break ?
>

Yes, neither O_DIRECT nor O_NOATIME are defined on Darwin,
so trying to use them causes errors.
