Received: from eggs.gnu.org ([209.51.188.92]:35375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNIAt-0003tf-2A
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNIAn-0004zP-ML
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:31:27 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45777)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNIAk-0004uE-Tv
	for qemu-devel@nongnu.org; Sun, 05 May 2019 10:31:23 -0400
Received: by mail-pg1-x541.google.com with SMTP id i21so5119466pgi.12
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 07:31:18 -0700 (PDT)
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-2-mark.cave-ayland@ilande.co.uk>
	<fc4d6169-12d4-3fd8-f85a-262135a62b93@linaro.org>
	<98ba8d01-dbab-ecde-ffbd-bb46efb29215@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9059f977-6ffa-e701-6c1b-2f8d8cca2c64@linaro.org>
Date: Sun, 5 May 2019 07:31:14 -0700
MIME-Version: 1.0
In-Reply-To: <98ba8d01-dbab-ecde-ffbd-bb46efb29215@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/14] target/ppc: remove getVSR()/putVSR()
 from fpu_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 5/5/19 2:27 AM, Mark Cave-Ayland wrote:
> I've spent a bit of time today going through the functions and it seems that all
> functions which have an xt parameter, minus a couple of the TEST macros, require the
> result to be calculated in a local variable first.
> 
> I think the best solution is still to remove getVSR()/putVSR() but replace them with
> macros for copying and zeroing like this:
> 
>     #define VSRCPY(d, s) (memcpy(d, s, sizeof(ppc_vsr_t)))
>     #define VSRZERO(d)   (memset(d, 0, sizeof(ppc_vsr_t)))

Local variable, yes.  But I see no reason for macros.

  ppc_vsr_t res = { };
  ...
  *xt = res;


r~
