Received: from eggs.gnu.org ([2001:4830:134:3::10]:42936)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <jaap@jcz.nl>)
	id 1gWGES-00056M-Ca
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 02:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jaap@jcz.nl>) id 1gWGEN-00049a-8u
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 02:44:00 -0500
Received: from [2a01:7c8:fffd:340:5054:ff:fefb:99] (port=39897
	helo=mail.jcz.nl)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jaap@jcz.nl>) id 1gWGEM-00047k-FI
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 02:43:55 -0500
Reply-To: jaap@jcz.nl
References: <20181207155911.12710-1-peter.maydell@linaro.org>
From: Jaap Crezee <jaap@jcz.nl>
Message-ID: <9f5f8952-d2fd-4799-4acf-8ce89273560a@jcz.nl>
Date: Mon, 10 Dec 2018 08:43:50 +0100
MIME-Version: 1.0
In-Reply-To: <20181207155911.12710-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: nl-NL
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cpus.c: Fix race condition in
 cpu_stop_current()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>

Hello all,

On 12/7/18 4:59 PM, Peter Maydell wrote:
> Jaap: could you test whether this patch fixes the issue you
> were seeing, please?


My test is going very well. With the patch applied, I have no longer been able to freeze/hang the VM. Currently at 7024 reboots and counting over
runtime 1 day 23 hours. I will start testing on my production environment as well.

Tested-by: Jaap Crezee <jaap@jcz.nl>


regards,


Jaap
