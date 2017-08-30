Received: from eggs.gnu.org ([2001:4830:134:3::10]:54146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnBDn-0004V7-95
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnBDm-0005RZ-9b
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:12:27 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dnBDm-0005RF-24
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:12:26 -0400
Received: by mail-wm0-x22d.google.com with SMTP id u126so17860755wmg.1
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 15:12:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b35860a5f4377883fd2c2942bdb524d279a91de9.1504116039.git.alistair.francis@xilinx.com>
References: <b35860a5f4377883fd2c2942bdb524d279a91de9.1504116039.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 30 Aug 2017 23:12:04 +0100
Message-ID: <CAFEAcA9N2dx6feVbw0BJ_xbs9czjJvmOCZfoOjf4ddpVk4ikbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 1/1] target/xtensa: Use the pre-defined
 MEMTXATTRS_UNSPECIFIED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <alistair23@gmail.com>

On 30 August 2017 at 19:02, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> Instead of using the hardcoded (MemTxAttrs){0} for no memory attributes
> let's use the already defined MEMTXATTRS_UNSPECIFIED macro instead.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>
>  target/xtensa/op_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
> index 519fbeddd6..3d990c0caa 100644
> --- a/target/xtensa/op_helper.c
> +++ b/target/xtensa/op_helper.c
> @@ -1025,11 +1025,11 @@ void HELPER(ule_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
>  uint32_t HELPER(rer)(CPUXtensaState *env, uint32_t addr)
>  {
>      return address_space_ldl(env->address_space_er, addr,
> -                             (MemTxAttrs){0}, NULL);
> +                             MEMTXATTRS_UNSPECIFIED, NULL);
>  }
>
>  void HELPER(wer)(CPUXtensaState *env, uint32_t data, uint32_t addr)
>  {
>      address_space_stl(env->address_space_er, addr, data,
> -                      (MemTxAttrs){0}, NULL);
> +                      MEMTXATTRS_UNSPECIFIED, NULL);
>  }

Might be worth noting in the commit that this is technically
a change of behaviour, because MEMTXATTRS_UNSPECIFIED
sets the 'unspecified' field to 1 whereas {0} doesn't.
I don't think anything actually checks that field, though.

thanks
-- PMM
