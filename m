Received: from eggs.gnu.org ([2001:4830:134:3::10]:47519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cavVU-0000ov-Hv
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:27:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cavVR-0004LL-W1
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:27:48 -0500
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:34115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cavVR-0004LC-Ry
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 21:27:45 -0500
Received: by mail-io0-x243.google.com with SMTP id c80so11548629iod.1
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 18:27:44 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170123021748.13170-1-rth@twiddle.net>
	<20170123021748.13170-19-rth@twiddle.net>
	<CAFEAcA_YbHYSL4hS7_K3rA9VTU+eYmE7CG+dSgnTB+GKOnPRLw@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <caf325cb-1bba-8baf-9942-d63e30a4dd8c@twiddle.net>
Date: Mon, 6 Feb 2017 18:27:28 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_YbHYSL4hS7_K3rA9VTU+eYmE7CG+dSgnTB+GKOnPRLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 18/26] target-hppa: Add framework and enable
 compilation
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

On 01/30/2017 05:49 AM, Peter Maydell wrote:
>> +    case 35:
>> +        env->iaoq_b = val;
>
> Is this a missing "break;" or a missing "/* fall through */" ?

Yep, thanks.


r~
