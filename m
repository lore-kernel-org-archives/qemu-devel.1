Received: from eggs.gnu.org ([2001:4830:134:3::10]:53447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eEWjl-0003kz-04
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:38:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eEWjh-0000f3-Tm
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:38:29 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:39280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eEWjh-0000di-MW
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 03:38:25 -0500
Received: by mail-wm0-x22e.google.com with SMTP id l8so14101762wmg.4
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 00:38:25 -0800 (PST)
References: <20171004184325.24157-1-richard.henderson@linaro.org>
	<20171004184325.24157-2-richard.henderson@linaro.org>
	<87ineetnux.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <45ba6528-e1ca-071a-32bb-6e1b0f86d18f@linaro.org>
Date: Tue, 14 Nov 2017 09:38:21 +0100
MIME-Version: 1.0
In-Reply-To: <87ineetnux.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v1 01/12] HACK: use objdump disas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 11/13/2017 12:33 PM, Alex Bennée wrote:
>> -    if (s.info.print_insn == NULL) {
>> +    if (1 || s.info.print_insn == NULL) {
>>          s.info.print_insn = print_insn_od_target;
>>      }
> 
> Because? Is this being droppped now for capstone?

Heh.  Since you mention it, capstone can't handle ARMv8.x, x > 0 either.  This
was so that I could pass the data through binutils master, which does support v8.3.

Obviously it won't go in, but...


r~
