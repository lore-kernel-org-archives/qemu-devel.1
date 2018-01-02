Received: from eggs.gnu.org ([2001:4830:134:3::10]:34478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWReA-0006Cx-8A
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:50:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWRe6-0006VA-UR
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:50:46 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:53253)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWRe6-0006US-K9
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 13:50:42 -0500
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-17-laurent@vivier.eu>
	<66de9791-d16c-39b5-9a43-b32910a03300@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c060b8e5-f72b-f780-6066-c08d409c3667@vivier.eu>
Date: Tue, 2 Jan 2018 19:50:39 +0100
MIME-Version: 1.0
In-Reply-To: <66de9791-d16c-39b5-9a43-b32910a03300@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 16/17] target/m68k: add the Interrupt
 Stack Pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

Le 02/01/2018 à 18:13, Richard Henderson a écrit :
> On 01/01/2018 05:10 PM, Laurent Vivier wrote:
>>              env->sr = tmp;
>> +            m68k_switch_sp(env);
> 
> I would much prefer a cpu_m68k_set_sr here, akin to cpu_m68k_set_ccr.

Yes, it's a good idea, I also use several times helper_set_sr()
directly, I will replace them by a cpu_m68k_set_sr().

Thanks,
Laurent
