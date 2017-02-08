Received: from eggs.gnu.org ([2001:4830:134:3::10]:45568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbbkU-0004jB-5C
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:34:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cbbkT-0003Zf-1q
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:34:06 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:35994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cbbkS-0003ZO-R0
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 18:34:04 -0500
Received: by mail-wm0-x22c.google.com with SMTP id c85so215202893wmi.1
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 15:34:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4c51c959-fe9c-b27f-552a-84d8a2fe68c1@denx.de>
References: <1486595166-34097-1-git-send-email-juro.bystricky@intel.com>
	<1486595166-34097-2-git-send-email-juro.bystricky@intel.com>
	<4c51c959-fe9c-b27f-552a-84d8a2fe68c1@denx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Feb 2017 23:33:43 +0000
Message-ID: <CAFEAcA-AaWtH8hqLVe+hr-FLAyusuiismw3safmR6mcxVnfLDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 1/1] nios2: Add Altera JTAG UART
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marek Vasut <marex@denx.de>
Cc: Juro Bystricky <juro.bystricky@intel.com>, QEMU Developers <qemu-devel@nongnu.org>, jurobystricky@hotmail.com, Chris Wulff <crwulff@gmail.com>

On 8 February 2017 at 23:22, Marek Vasut <marex@denx.de> wrote:
> On 02/09/2017 12:06 AM, Juro Bystricky wrote:
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version
>> + * 2 of the License, or (at your option) any later version.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, see <http://www.gnu.org/licenses/>.
>
> Isn't QEMU GPLv2 only and NOT GPLv2+ ?

As a binary as a whole QEMU is GPLv2, because that is the most
restrictive and thus the controlling license. Individual
source files are under a variety of licenses, which is
fine as long as those licenses are GPL-2-compatible.
We have a preference against 2-only (see the LICENSE file),
and also you should at least use a license we're already
using. GPL2-or-later is fine and a common choice.

> btw for trivial patches like this, cover letter is not necessary .

The rough rule is "single patches don't need a cover letter;
series of more than one patch always do."

thanks
-- PMM
