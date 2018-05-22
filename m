Received: from eggs.gnu.org ([2001:4830:134:3::10]:45452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLA1Q-0001je-5M
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fLA1M-0002TH-Us
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:20:24 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180521140402.23318-1-peter.maydell@linaro.org>
	<20180521140402.23318-9-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7433b2e8-9ca0-47fa-250c-8f5fe5ccd7ee@twiddle.net>
Date: Tue, 22 May 2018 09:20:17 -0700
MIME-Version: 1.0
In-Reply-To: <20180521140402.23318-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/27] Make MemoryRegion valid.accepts
 callback take a MemTxAttrs argument
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
> add MemTxAttrs as an argument to the MemoryRegion valid.accepts
> callback. We'll need this for subpage_accepts().
> 
> We could take the approach we used with the read and write
> callbacks and add new a new _with_attrs version, but since there
> are so few implementations of the accepts hook we just change
> them all.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
