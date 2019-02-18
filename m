Received: from eggs.gnu.org ([209.51.188.92]:53559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqiR-0008T4-LC
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:44:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqiP-0006fI-Uh
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:44:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gvqiN-0006cL-HW
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:44:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so530138wmg.2
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 13:44:35 -0800 (PST)
References: <1550503897-31141-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1550503897-31141-4-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2b062422-8421-9fb9-bb37-79ce45f593ee@redhat.com>
Date: Mon, 18 Feb 2019 22:44:33 +0100
MIME-Version: 1.0
In-Reply-To: <1550503897-31141-4-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/7] tests/tcg: target/mips: Change
 directory name 'bit-counting' to 'bit-count'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, peter.maydell@linaro.org, amarkovic@wavecomp.com, aurelien@aurel32.net

On 2/18/19 4:31 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Change directory name 'bit-counting' to 'bit-count'. This is just for
> cosmetic and consistency sake. This was the only subdirectory in MSA
> test directory that uses ending 'ing'.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_b.c | 0
>  tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_d.c | 0
>  tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_h.c | 0
>  tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_w.c | 0
>  tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_b.c | 0
>  tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_d.c | 0
>  tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_h.c | 0
>  tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_w.c | 0
>  tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_b.c | 0
>  tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_d.c | 0
>  tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_h.c | 0
>  tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_w.c | 0
>  12 files changed, 0 insertions(+), 0 deletions(-)
>  rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_b.c (100%)
>  rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_d.c (100%)
>  rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_h.c (100%)
>  rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nloc_w.c (100%)
>  rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_b.c (100%)
>  rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_d.c (100%)
>  rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_h.c (100%)
>  rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_nlzc_w.c (100%)
>  rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_b.c (100%)
>  rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_d.c (100%)
>  rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_h.c (100%)
>  rename tests/tcg/mips/user/ase/msa/{bit-counting => bit-count}/test_msa_pcnt_w.c (100%)
> 
> diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
> similarity index 100%
> rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_b.c
> rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_b.c
> diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
> similarity index 100%
> rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_d.c
> rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_d.c
> diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
> similarity index 100%
> rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_h.c
> rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_h.c
> diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
> similarity index 100%
> rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nloc_w.c
> rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_nloc_w.c
> diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
> similarity index 100%
> rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_b.c
> rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_b.c
> diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
> similarity index 100%
> rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_d.c
> rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_d.c
> diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
> similarity index 100%
> rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_h.c
> rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_h.c
> diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
> similarity index 100%
> rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_nlzc_w.c
> rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_nlzc_w.c
> diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_b.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
> similarity index 100%
> rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_b.c
> rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_b.c
> diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_d.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
> similarity index 100%
> rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_d.c
> rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_d.c
> diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_h.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
> similarity index 100%
> rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_h.c
> rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_h.c
> diff --git a/tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_w.c b/tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
> similarity index 100%
> rename from tests/tcg/mips/user/ase/msa/bit-counting/test_msa_pcnt_w.c
> rename to tests/tcg/mips/user/ase/msa/bit-count/test_msa_pcnt_w.c
> 
