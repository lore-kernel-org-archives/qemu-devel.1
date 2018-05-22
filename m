Received: from eggs.gnu.org ([2001:4830:134:3::10]:49394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLAEY-0006tK-1Y
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:33:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLAEV-0008Or-EZ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:33:58 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-11-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2a4bb406-4e0d-24a8-612a-b166f3b8b2b7@twiddle.net>
Date: Tue, 22 May 2018 09:33:52 -0700
MIME-Version: 1.0
In-Reply-To: <20180521140402.23318-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/27] Make flatview_translate() take a
 MemTxAttrs argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 05/21/2018 07:03 AM, Peter Maydell wrote:
> As part of plumbing MemTxAttrs down to the IOMMU translate method,
> add MemTxAttrs as an argument to flatview_translate(); all its
> callers now have attrs available.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
