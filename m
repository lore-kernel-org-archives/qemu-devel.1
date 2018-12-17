Received: from eggs.gnu.org ([2001:4830:134:3::10]:33751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYwDx-00072B-VR
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:58:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gYwDt-0000r6-R4
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:58:33 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:43222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gYwDt-0000pv-BU
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 11:58:29 -0500
Received: by mail-pl1-x643.google.com with SMTP id gn14so6404358plb.10
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 08:58:28 -0800 (PST)
References: <20181217122405.18732-1-mark.cave-ayland@ilande.co.uk>
	<20181217122405.18732-8-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <36820305-1771-7ff2-805b-7111d3abddf4@linaro.org>
Date: Mon, 17 Dec 2018 08:58:25 -0800
MIME-Version: 1.0
In-Reply-To: <20181217122405.18732-8-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 7/9] target/ppc: move FP and VMX
 registers into aligned vsr register array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

On 12/17/18 4:24 AM, Mark Cave-Ayland wrote:
> -            cpu_fprintf(f, " %016" PRIx64, *((uint64_t *)&env->fpr[i]));
> +            cpu_fprintf(f, " %016" PRIx64, *((uint64_t *)&env->vsr[i].u64[0]));

There's no longer a need for a cast.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
