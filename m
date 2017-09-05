Received: from eggs.gnu.org ([2001:4830:134:3::10]:59253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpH1X-000461-GE
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpH1R-00043A-Qt
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:48:26 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:33172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpH1R-00042w-K0
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:48:21 -0400
Received: by mail-pf0-x22c.google.com with SMTP id y68so8720966pfd.0
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 09:48:21 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-11-git-send-email-peter.maydell@linaro.org>
	<b59d3474-15e4-7f01-d4d7-8ca0fcfef6b5@linaro.org>
	<CAFEAcA_F-oRO0vT4d62G1vat9o0o9exPKfEXw_BykXnXZJEYgQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d80ba882-c00a-f10b-b8bc-8f6383e8cb74@linaro.org>
Date: Tue, 5 Sep 2017 09:48:17 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_F-oRO0vT4d62G1vat9o0o9exPKfEXw_BykXnXZJEYgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/20] nvic: Add NS alias SCS region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 09/05/2017 09:26 AM, Peter Maydell wrote:
> We don't map the hole. The container is 0x21000 in size, the normal
> nvic_sysregs region is 0x1000 at offset 0x0 (which will be 0xe000e000
> in the system address space), and the NS alias region
> is 0x1000 at offset 0x20000 (0xe002e000 in the system address space).
> There's nothing mapped in the hole in the container, so accesses
> there will busfault, as they will for other PPB accesses before or
> after the SCSes.

Ok, it's not wrong, but I still don't understand the need for the container.


r~
