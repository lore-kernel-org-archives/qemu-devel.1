Received: from eggs.gnu.org ([209.51.188.92]:60514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghKrL-0001We-Om
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 15:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghKrH-0007TY-FY
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 15:53:55 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ghKrH-0007R0-8y
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 15:53:51 -0500
Received: by mail-pg1-x542.google.com with SMTP id d72so3810862pga.9
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 12:53:50 -0800 (PST)
References: <20190108163008.7006-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ebfdc4ad-3f40-a09b-ba40-db18ac5a6484@linaro.org>
Date: Thu, 10 Jan 2019 07:53:41 +1100
MIME-Version: 1.0
In-Reply-To: <20190108163008.7006-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] tcg: support heterogenous CPU clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Emilio G . Cota" <cota@braap.org>

On 1/9/19 3:30 AM, Peter Maydell wrote:
> Peter Maydell (4):
>   hw/arm/xlx-zynqmp: Realize cluster after putting RPUs in it
>   qom/cpu: Add cluster_index to CPUState
>   accel/tcg: Add cluster number to TCG TB hash
>   gdbstub: Simplify gdb_get_cpu_pid() to use cpu->cluster_index

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
