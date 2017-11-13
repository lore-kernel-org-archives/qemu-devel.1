Received: from eggs.gnu.org ([2001:4830:134:3::10]:49840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eE9xw-0002W5-7U
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 03:19:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eE9xt-0002px-3Z
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 03:19:36 -0500
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:39103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eE9xs-0002pX-SV
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 03:19:33 -0500
Received: by mail-wm0-x229.google.com with SMTP id l8so7490501wmg.4
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 00:19:32 -0800 (PST)
References: <1510343626-25861-1-git-send-email-cota@braap.org>
	<1510343626-25861-2-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ecaff279-4255-5a7d-a209-971892fc2f1f@linaro.org>
Date: Mon, 13 Nov 2017 09:19:27 +0100
MIME-Version: 1.0
In-Reply-To: <1510343626-25861-2-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 2.11 1/5] qom: move
 CPUClass.tcg_initialize to a global
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On 11/10/2017 08:53 PM, Emilio G. Cota wrote:
> 55c3cee ("qom: Introduce CPUClass.tcg_initialize", 2017-10-24)
> introduces a per-CPUClass bool that we check so that the target CPU
> is initialized for TCG only once. This works well except when
> we end up creating more than one CPUClass, in which case we end
> up incorrectly initializing TCG more than once, i.e. once for
> each CPUClass.

... more than one CPUClass for a given translator.

Ideally, cortex-r5 and cortex-a53 would have a common parent class which would
hold all of the bits that are common between them, including the translator.

That said,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
