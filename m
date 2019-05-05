Received: from eggs.gnu.org ([209.51.188.92]:41037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNIfT-0007OS-AS
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNIfS-0000ZJ-Dz
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:03:07 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:42437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNIfS-0000YX-55
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:03:06 -0400
Received: by mail-pf1-x431.google.com with SMTP id 13so5051306pfw.9
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 08:03:05 -0700 (PDT)
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-6-mark.cave-ayland@ilande.co.uk>
	<784adbd2-0447-9d01-cff8-e7234f9d9679@linaro.org>
	<ca2255e7-79cd-2ef1-5ddf-89edac2ba959@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <08ada731-8295-1295-a196-2f456f6de40f@linaro.org>
Date: Sun, 5 May 2019 08:03:02 -0700
MIME-Version: 1.0
In-Reply-To: <ca2255e7-79cd-2ef1-5ddf-89edac2ba959@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/14] target/ppc: introduce
 GEN_VSX_HELPER_X2 macro to fpu_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 5/5/19 2:57 AM, Mark Cave-Ayland wrote:
> For reference the culprits here is helper_xscvqpdp(). But again if you agree that it
> makes sense to create separate gen/helper functions then I can remove the opcode
> later on in the series.

Yes.  Or indeed in a completely separate series.


r~
