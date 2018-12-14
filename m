Received: from eggs.gnu.org ([2001:4830:134:3::10]:48461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXnu0-0007QW-IB
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:53:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXntx-0001E4-CJ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:53:16 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXntw-0001DI-W6
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:53:13 -0500
Received: by mail-ot1-x342.google.com with SMTP id t5so5464359otk.1
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 05:53:12 -0800 (PST)
References: <20181213115503.24188-1-alex.bennee@linaro.org>
	<20181213115503.24188-2-alex.bennee@linaro.org>
	<CANW4E-1UmZOGHya4jHxj10O2Ki7MPGMqme7wT0jaCO8Ufrii6g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d82faf0e-87d4-984a-0db8-558d4e8bda13@linaro.org>
Date: Fri, 14 Dec 2018 07:53:06 -0600
MIME-Version: 1.0
In-Reply-To: <CANW4E-1UmZOGHya4jHxj10O2Ki7MPGMqme7wT0jaCO8Ufrii6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/2] target/arm: kvm64 make guest debug
 AA32 break point aware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Omair Javaid <omair.javaid@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: mark.rutland@arm.com, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, ard.biesheuvel@linaro.org

On 12/14/18 2:37 AM, Omair Javaid wrote:
> Are you expecting GDB to switch targets (from AArch64 to AArch32 or
> vice versa) when there is mode switch for example a AArch64 binary
> calling a AArch32 library function.

Mode changes happen only at privilege level changes.  E.g. AArch32 binary makes
a system call to an AArch64 kernel, or an AArch32 guest kernel takes an i/o
emulation trap to an AArch64 hypervisor.

But for this sort of system debugging, it would be nice to be able to
single-step through the whole operation.


r~
