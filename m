Received: from eggs.gnu.org ([2001:4830:134:3::10]:47914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ch9m4-0005ZO-6w
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:54:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ch9m0-0005C7-W3
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:54:40 -0500
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:35931)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ch9m0-0005Bq-QH
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 01:54:36 -0500
Received: by mail-pg0-x232.google.com with SMTP id s67so7679686pgb.3
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 22:54:36 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487914949-1294-1-git-send-email-bobby.prani@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <af5cae9b-c4b5-6f5f-08d1-27152cc597aa@twiddle.net>
Date: Fri, 24 Feb 2017 17:54:29 +1100
MIME-Version: 1.0
In-Reply-To: <1487914949-1294-1-git-send-email-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] mttcg/i386: Patch instruction using
 async_safe_* framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 02/24/2017 04:42 PM, Pranith Kumar wrote:
> In mttcg, calling pause_all_vcpus() during execution from the
> generated TBs causes a deadlock if some vCPU is waiting for exclusive
> execution in start_exclusive(). Fix this by using the aync_safe_*
> framework instead of pausing vcpus for patching instructions.
>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Peter Maydell <peter.maydell@linaro.org>
> CC: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  hw/i386/kvmvapic.c | 82 ++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 52 insertions(+), 30 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
