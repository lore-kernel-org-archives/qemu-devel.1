Received: from eggs.gnu.org ([2001:4830:134:3::10]:38556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSmjH-0001Z1-Oo
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSmjD-0008GG-Np
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:37:27 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSmjD-0008Ft-FM
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 12:37:23 -0500
Received: by mail-pg1-x544.google.com with SMTP id 80so2795971pge.4
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 09:37:23 -0800 (PST)
References: <20181123144558.5048-1-richard.henderson@linaro.org>
	<20181123144558.5048-10-richard.henderson@linaro.org>
	<87sgzi32fk.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <49a0e9a4-9266-aad5-4059-b4197a3d64ba@linaro.org>
Date: Fri, 30 Nov 2018 09:37:19 -0800
MIME-Version: 1.0
In-Reply-To: <87sgzi32fk.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 09/37] tcg/i386: Use
 TCG_TARGET_NEED_LDST_OOL_LABELS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Alistair.Francis@wdc.com

On 11/30/18 9:22 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Move the entire memory operation out of line.
> 
> Given Emilio's numbers is it likely we will want to support both options
> given the variability on x86?

No, I don't want to support two methods in any one tcg backend.
Which is why I'm not really sure what to do about Emilio's results.


r~
