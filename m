Received: from eggs.gnu.org ([209.51.188.92]:43862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0aPJ-0003xp-St
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:20:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h0aPJ-0005mt-1j
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:20:33 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h0aPI-0005lG-Kf
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 18:20:32 -0500
Received: by mail-pf1-x441.google.com with SMTP id q17so1588601pfh.10
	for <qemu-devel@nongnu.org>; Sun, 03 Mar 2019 15:20:32 -0800 (PST)
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
	<20190303172343.13406-3-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <975e69cd-d956-dda0-8955-8b864f5a496f@linaro.org>
Date: Sun, 3 Mar 2019 15:20:28 -0800
MIME-Version: 1.0
In-Reply-To: <20190303172343.13406-3-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/8] target/ppc: introduce single
 vsrl_offset() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 3/3/19 9:23 AM, Mark Cave-Ayland wrote:
> Instead of having multiple copies of the offset calculation logic, move it to a
> single vsrl_offset() function.
> 
> This commit also renames the existing get_vsr()/set_vsr() functions to
> get_vsrl()/set_vsrl() which better describes their purpose.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/cpu.h                    |  7 ++++++-
>  target/ppc/translate/vsx-impl.inc.c | 12 ++++++------
>  2 files changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
