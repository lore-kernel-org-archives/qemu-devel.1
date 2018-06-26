Received: from eggs.gnu.org ([2001:4830:134:3::10]:39236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXogL-0004IO-Uo
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXogI-0008Tt-QA
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:10:57 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:44155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXogI-0008SB-IU
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 10:10:54 -0400
Received: by mail-pg0-x22e.google.com with SMTP id b10-v6so4008051pgq.11
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 07:10:54 -0700 (PDT)
References: <20180621015359.12018-1-richard.henderson@linaro.org>
	<20180621015359.12018-10-richard.henderson@linaro.org>
	<CAFEAcA-gGuY5JG+DmU3vrfiky0wsz2YBtUe2uYnFxL+ZrRiiSg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a33b3f6e-3340-1a48-d2f9-4111c6dfa0bb@linaro.org>
Date: Tue, 26 Jun 2018 07:10:46 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-gGuY5JG+DmU3vrfiky0wsz2YBtUe2uYnFxL+ZrRiiSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 09/35] target/arm: Implement SVE load
 and broadcast element
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/25/2018 08:46 AM, Peter Maydell wrote:
> 
>> +/* Copy Zn into Zn, and store zero into inactive elements.  */
>> +void HELPER(sve_movz_b)(void *vd, void *vn, void *vg, uint32_t desc)
> Given the prototype, presumably "into Zd" ?

Hah, yes.

r~
