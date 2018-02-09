Received: from eggs.gnu.org ([2001:4830:134:3::10]:46753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFz7-0006Xo-Gj
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:13:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekFz6-0000Es-D0
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:13:29 -0500
Received: from mail-it0-x22b.google.com ([2607:f8b0:4001:c0b::22b]:39779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekFz6-0000ES-7e
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 16:13:28 -0500
Received: by mail-it0-x22b.google.com with SMTP id c80so12295312itb.4
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 13:13:28 -0800 (PST)
References: <20180209165810.6668-1-peter.maydell@linaro.org>
	<20180209165810.6668-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6c4531a2-7e80-b808-011a-dc0c8db3a640@linaro.org>
Date: Fri, 9 Feb 2018 13:13:24 -0800
MIME-Version: 1.0
In-Reply-To: <20180209165810.6668-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/11] target/arm: Migrate v7m.other_sp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 02/09/2018 08:58 AM, Peter Maydell wrote:
> In commit abc24d86cc0364f we accidentally broke migration of
> the stack pointer value for the mode (process, handler) the CPU
> is not currently running as. (The commit correctly removed the
> no-longer-used v7m.current_sp flag from the VMState but also
> deleted the still very much in use v7m.other_sp SP value field.)
> 
> Add a subsection to migrate it again. (We don't need to care
> about trying to retain compatibility with pre-abc24d86cc0364f
> versions of QEMU, because that commit bumped the version_id
> and we've since bumped it again a couple of times.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/machine.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
