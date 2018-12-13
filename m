Received: from eggs.gnu.org ([2001:4830:134:3::10]:49895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXa7Z-0002En-9F
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 18:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gXa7V-000784-E3
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 18:10:21 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gXa7T-000725-Ug
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 18:10:17 -0500
Received: by mail-oi1-x242.google.com with SMTP id y23so3077816oia.4
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 15:10:15 -0800 (PST)
References: <20181213115503.24188-1-alex.bennee@linaro.org>
	<20181213115503.24188-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <46dd9943-1d30-ed87-d68b-8f501b7ac8fd@linaro.org>
Date: Thu, 13 Dec 2018 17:10:05 -0600
MIME-Version: 1.0
In-Reply-To: <20181213115503.24188-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/2] target/arm: defer setting up of
 aarch64 gdb until arm_cpu_realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: mark.rutland@arm.com, Peter Maydell <peter.maydell@linaro.org>, Omair Javaid <omair.javaid@linaro.org>, ard.biesheuvel@linaro.org, qemu-arm@nongnu.org

On 12/13/18 5:55 AM, Alex Bennée wrote:
> If we setup earlier we miss the parsing of the aarch64 state of the
> CPU. If the user has booted up with:
> 
>   qemu-system-aarch64 -cpu host,aarch64=off -enable-kvm
> 
> we end up presenting an aarch64 view of the world via the gdbstub and
> hilarity ensues.
> 
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Omair Javaid <omair.javaid@linaro.org>
> ---
>  include/hw/arm/arm.h |  2 ++
>  target/arm/cpu.c     |  4 ++++
>  target/arm/cpu64.c   | 20 +++++++++++++++-----
>  3 files changed, 21 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
