Received: from eggs.gnu.org ([2001:4830:134:3::10]:36697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZj2s-0005Ad-Cc
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:01:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZj2o-00006L-Bn
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:01:50 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:45780)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZj2o-00005c-5y
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 15:01:46 -0500
Received: by mail-pg0-x242.google.com with SMTP id c194so2884019pga.12
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 12:01:45 -0800 (PST)
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
	<1515637324-96034-7-git-send-email-mjc@sifive.com>
	<a490bac7-e88b-cd4c-9922-f50461c591bc@linaro.org>
	<CAHNT7Ns5GKU0g9V2DwbQWO0ahjE67+OO0gYnEyU+88BjXghKJg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c97716bd-69fa-c7d5-5e27-af8201e6d999@linaro.org>
Date: Thu, 11 Jan 2018 12:01:41 -0800
MIME-Version: 1.0
In-Reply-To: <CAHNT7Ns5GKU0g9V2DwbQWO0ahjE67+OO0gYnEyU+88BjXghKJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 06/21] RISC-V FPU Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 01/11/2018 10:09 AM, Michael Clark wrote:
> 
> The RISC-V QEMU port is presently quite usable, and we have fedora and debian
> folk both working on packacking for RISC-V. The general sentiment is does our
> port need to be perfect to be accepted in-tree? or can we work on clean-ups and
> bug fixes in tree? We're pretty committed to transforming it into a high
> quality port and we will have plently of time going forward to address any
> issues. We have to balance cleanups and bug fixes for corner cases with adding
> and improve device emulation support. So far all of the recent effort has gone
> into the former, i.e. clean-ups and bug fixes, so you can be sure we will
> attend to any remaining issues in the comitted blocks of time we have available
> to work on the port.

No, it doesn't have to be perfect to go in.  I would like the actual errors
fixed before going in; but I suppose this fp stuff falls into the "just
cleanup" category.


r~
