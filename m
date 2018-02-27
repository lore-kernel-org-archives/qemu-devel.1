Received: from eggs.gnu.org ([2001:4830:134:3::10]:40439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqnIf-00009n-JW
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:00:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqnIc-0006GN-Kf
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:00:41 -0500
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:36126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eqnIc-0006Fh-Da
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:00:38 -0500
Received: by mail-pf0-x22a.google.com with SMTP id 68so146173pfx.3
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 14:00:38 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-18-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <98d79ce8-3ab0-3c3e-f4ef-9ad381015daf@linaro.org>
Date: Tue, 27 Feb 2018 14:00:34 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/19] hw/misc/iotkit-secctl: Add remaining
 simple registers
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

On 02/20/2018 10:03 AM, Peter Maydell wrote:
> +    case A_BRGINTEN:
> +        s->brginten = value & 0xffff;
> +        break;

Looks to me like bits 0-15 are read-only 0x0000,
so, that 0xffff should be 0xffff0000.


r~
