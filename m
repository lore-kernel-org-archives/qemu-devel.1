Received: from eggs.gnu.org ([2001:4830:134:3::10]:54945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fkxnF-0005mq-9V
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 16:32:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fkxn9-0004QV-Vi
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 16:32:24 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fkxn9-0004Q2-Kr
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 16:32:19 -0400
References: <1532967169-22265-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1532967169-22265-8-git-send-email-aleksandar.markovic@rt-rk.com>
	<4bc391e5-9aac-57c6-7173-0fdd7a25bccc@vivier.eu>
	<BN7PR08MB4868ECFD24601E06677D4C55C62D0@BN7PR08MB4868.namprd08.prod.outlook.com>
	<CAFEAcA9xdOSKY6LRRYM4HZQx=xbFiD1-24zMGn-i7BiDWqTZSA@mail.gmail.com>
	<BN7PR08MB4868ACB7B1F69351E1A44885C62D0@BN7PR08MB4868.namprd08.prod.outlook.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e26f557a-2b56-9222-526d-51eb7ea9287b@vivier.eu>
Date: Wed, 1 Aug 2018 22:31:35 +0200
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB4868ACB7B1F69351E1A44885C62D0@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 07/76] elf: Remove duplicate
 preprocessor constant definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paul Burton <pburton@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

Le 01/08/2018 à 22:01, Aleksandar Markovic a écrit :
>>
>> From: Peter Maydell <peter.maydell@linaro.org>
>> Sent: Wednesday, August 1, 2018 9:37 PM
>>
>>> The simplest way to do that is just to delete
>>> the second (original) EF_MIPS_ARCH #define, the one just
>>> below the EF_MIPS_NAN2008 define.
>>>
>>> We could line up with the order the glibc headers use, but
>>> that seems like overkill compared to just deleting a line.
>>
> 
> This sounds reasonable to me, and, if nobody disputes it, I will implement it this way in the next version.

I agree

Laurent
