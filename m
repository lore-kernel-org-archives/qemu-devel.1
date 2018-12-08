Received: from eggs.gnu.org ([2001:4830:134:3::10]:55915)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <jaap@jcz.nl>)
	id 1gVYMA-0008Na-5R
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 03:53:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jaap@jcz.nl>) id 1gVYM6-0007LW-VY
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 03:53:02 -0500
Received: from [2a01:7c8:fffd:340:5054:ff:fefb:99] (port=42753
	helo=mail.jcz.nl)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jaap@jcz.nl>) id 1gVYM6-0007Gb-PC
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 03:52:58 -0500
Reply-To: jaap@jcz.nl
References: <20181207155911.12710-1-peter.maydell@linaro.org>
From: Jaap Crezee <jaap@jcz.nl>
Message-ID: <8a142e35-44af-194b-01ad-9e9a9f3c9369@jcz.nl>
Date: Sat, 8 Dec 2018 09:47:50 +0100
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

Hi all,

On 12/7/18 4:59 PM, Peter Maydell wrote:
> Jaap: could you test whether this patch fixes the issue you
> were seeing, please?

I have applied the patch and started my test tool against it. It will need some time as I have also seen cases where it only failed after 600 reboots.
My testtool logs into the VM over ssh and reboots it. Meanwhile it will check the device going offline and coming back online again and starts over
(including a random wait).

I will keep you updated. Thanks!

Jaap
