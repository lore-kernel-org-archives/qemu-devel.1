Received: from eggs.gnu.org ([2001:4830:134:3::10]:49261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHo3R-00017Y-8E
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHo3N-00075G-3K
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:48:53 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHo3M-00072T-Jq
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:48:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id 74-v6so7712227wrb.13
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 03:48:47 -0700 (PDT)
References: <20181030093031.10131.17221.stgit@pasha-VirtualBox>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f37c22d1-3530-ef0a-21a6-7e4637163438@linaro.org>
Date: Wed, 31 Oct 2018 10:48:44 +0000
MIME-Version: 1.0
In-Reply-To: <20181030093031.10131.17221.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/ppc: fix mtmsr instruction for
 icount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, agraf@suse.de, david@gibson.dropbear.id.au

On 10/30/18 9:30 AM, Pavel Dovgalyuk wrote:
> This patch fixes processing of mtmsr instructions in icount mode.
> In this mode writing to interrupt/peripheral state is controlled
> by can_do_io flag. This flag must be set explicitly before helper
> function invocation.
> 
> Signed-off-by: Maria Klimushenkova <maria.klimushenkova@ispras.ru>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>  target/ppc/translate.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
