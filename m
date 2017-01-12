Received: from eggs.gnu.org ([2001:4830:134:3::10]:48015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRiMT-0007fS-M0
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:36:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRiMR-0005uP-Ta
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:36:25 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRiMR-0005uJ-PL
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 11:36:23 -0500
Received: by mail-qk0-x241.google.com with SMTP id u25so3432212qki.2
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 08:36:23 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170112154731.1028-1-alex.bennee@linaro.org>
	<20170112154731.1028-3-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <75c7dce2-f65f-39a2-f311-850072d39472@twiddle.net>
Date: Thu, 12 Jan 2017 08:36:19 -0800
MIME-Version: 1.0
In-Reply-To: <20170112154731.1028-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] cpu_common_reset: wrap TCG specific
 code in tcg_enabled()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org

On 01/12/2017 07:47 AM, Alex Bennée wrote:
> Both the cpu->tb_jmp_cache and SoftMMU TLB structures are only used
> when running TCG code so we might as well skip them for anything else.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  qom/cpu.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
