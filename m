Received: from eggs.gnu.org ([2001:4830:134:3::10]:33614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRU5W-0005cZ-97
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 21:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dRU5V-0004NS-KL
	for qemu-devel@nongnu.org; Sat, 01 Jul 2017 21:54:14 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865922142.17063.17637554632892697681.stgit@frigg.lan>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5e3f1bec-5597-172b-1ec0-0a823a4960b0@twiddle.net>
Date: Sat, 1 Jul 2017 18:54:05 -0700
MIME-Version: 1.0
In-Reply-To: <149865922142.17063.17637554632892697681.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v11 29/29] target/arm: [tcg] Port to
 generic translation framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/28/2017 07:13 AM, Lluís Vilanova wrote:
> @@ -11377,6 +11385,9 @@ static void aarch64_trblock_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>               break;
>           }
>       }
> +
> +    /* Functions above can change dc->pc, so re-align db->pc_next */
> +    dc->base.pc_next = dc->pc;
>   }
>   
>   static void aarch64_trblock_disas_log(const DisasContextBase *dcbase,

Surely this belonged in a previous patch.


>      DisasContext dc1, *dc = &dc1;

Drop the dc1 thing.

> +    translate_block(
> +#ifdef TARGET_AARCH64
> +        ARM_TBFLAG_AARCH64_STATE(tb->flags) ?
> +        &aarch64_translator_ops :
>  #endif
> +        &arm_translator_ops,

It would be nicer to avoid the ifdef within the parameter list.
Maybe pull the ops pointer computation to a separate statement.


r~
