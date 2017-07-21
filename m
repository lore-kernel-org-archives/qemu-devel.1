Received: from eggs.gnu.org ([2001:4830:134:3::10]:54242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYgbl-0005v1-IB
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dYgbi-0000tk-Ek
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:41:17 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44175)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dYgbi-0000te-Aj
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 18:41:14 -0400
Date: Fri, 21 Jul 2017 18:41:13 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170721224113.GK10809@flamenco>
References: <20170715094243.28371-1-rth@twiddle.net>
	<20170715094243.28371-27-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170715094243.28371-27-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v14 26/34] target/arm: [tcg] Port to tb_stop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, vilanova@ac.upc.edu, alex.bennee@linaro.org, crosthwaite.peter@gmail.com, pbonzini@redhat.com

On Fri, Jul 14, 2017 at 23:42:35 -1000, Richard Henderson wrote:
> From: Lluís Vilanova <vilanova@ac.upc.edu>
> 
> Incrementally paves the way towards using the generic instruction translation
> loop.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> Message-Id: <150002534291.22386.13499916738708680298.stgit@frigg.lan>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
(snip)
> @@ -12135,6 +12063,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>          default:
>              /* FIXME: Single stepping a WFI insn will not halt the CPU. */
>              gen_singlestep_exception(dc);
> +            break;
>          case DISAS_NORETURN:
>              break;
>          }

See my comment to patch 4.

Otherwise,
Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
