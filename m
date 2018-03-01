Received: from eggs.gnu.org ([2001:4830:134:3::10]:36021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1erQmm-0001rv-OX
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1erQmh-0001oL-UQ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:10:24 -0500
Received: from mail-pl0-x22a.google.com ([2607:f8b0:400e:c01::22a]:47056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1erQmh-0001mg-LB
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:10:19 -0500
Received: by mail-pl0-x22a.google.com with SMTP id y8-v6so3877234pll.13
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 08:10:19 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1519914173-31868-1-git-send-email-frederic.konrad@adacore.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <947159f3-c182-641a-d9cc-e994c7d5ac8e@twiddle.net>
Date: Thu, 1 Mar 2018 08:10:14 -0800
MIME-Version: 1.0
In-Reply-To: <1519914173-31868-1-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] sparc: fix leon3 casa instruction when
 MMU is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk

On 03/01/2018 06:22 AM, KONRAD Frederic wrote:
>     There is an other way to do that: emiting the instruction with a
>     MMU_PHYS_IDX when the MMU is disabled. I can switch to that if it's a
>     prefered method.

Yes, that would be preferred.

r~
