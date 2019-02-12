Received: from eggs.gnu.org ([209.51.188.92]:40096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtfrO-0003SD-Iu
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:44:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtfrN-0001U7-Q5
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:44:58 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtfrN-0001Sb-Hu
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 16:44:57 -0500
Received: by mail-pl1-x644.google.com with SMTP id s1so86204plp.9
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 13:44:57 -0800 (PST)
References: <20190212074840.13542-1-richard.henderson@linaro.org>
	<20190212074840.13542-2-richard.henderson@linaro.org>
	<dc08d748-eb29-ccb1-ae1b-62b7ad0d6ffd@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0629643f-66bf-8373-14d8-32ede95938ce@linaro.org>
Date: Tue, 12 Feb 2019 13:44:53 -0800
MIME-Version: 1.0
In-Reply-To: <dc08d748-eb29-ccb1-ae1b-62b7ad0d6ffd@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] linux-user: Add ELF_PLATFORM for arm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org

On 2/12/19 12:31 AM, Laurent Vivier wrote:
> I know nothing about ARM, but in kernel we have also a "v5t"
> (cpu_elf_name) and in QEMU we have a ARM_FEATURE_V4T which is set with
> ARM_FEATURE_V5. Is it related?

>From the ARM ARM (DDI 0406C, page A1-30):

The valid variants of ARMv4, ARMv5, and ARMv6 are as follows:
ARMv4, ARMv4T, ARMv5T, ARMv5TE, ARMv5TEJ, ARMv6, ARMv6K, ARMv6T2

So all v5 are "t".  The use of "v5t" within the kernel seems to be an outlier
and perhaps a bug to be squashed:

$ grep -r cpu_elf_name . | grep v5
./mm/proc-xsc3.S:	string	cpu_elf_name, "v5"
./mm/proc-arm1020.S:	string	cpu_elf_name, "v5"
./mm/proc-arm946.S:	string	cpu_elf_name, "v5t"
./mm/proc-arm1020e.S:	string	cpu_elf_name, "v5"
./mm/proc-arm1022.S:	string	cpu_elf_name, "v5"
./mm/proc-feroceon.S:	string	cpu_elf_name, "v5"
./mm/proc-xscale.S:	string	cpu_elf_name, "v5"
./mm/proc-mohawk.S:	string	cpu_elf_name, "v5"
./mm/proc-arm926.S:	string	cpu_elf_name, "v5"
./mm/proc-arm1026.S:	string	cpu_elf_name, "v5"


r~
