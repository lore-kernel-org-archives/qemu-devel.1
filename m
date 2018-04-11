Received: from eggs.gnu.org ([2001:4830:134:3::10]:35050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f6Ide-0005jH-1A
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f6IdZ-0006vh-LA
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:30:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60901)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f6IdZ-0006r8-AP
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 12:30:21 -0400
Date: Wed, 11 Apr 2018 12:30:16 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180411163016.GB4480@flamenco>
References: <1523038800-2494-1-git-send-email-cota@braap.org>
	<1523038800-2494-7-git-send-email-cota@braap.org>
	<a95ec4d4-72f7-486d-4123-a7bd4740cf03@linaro.org>
	<20180410142332.GA22989@flamenco>
	<c6a08977-5340-1aa3-9ae1-0656a5240507@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6a08977-5340-1aa3-9ae1-0656a5240507@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 06/17] target/mips: convert to
 DisasJumpType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On Wed, Apr 11, 2018 at 09:27:57 +1000, Richard Henderson wrote:
> On 04/11/2018 12:23 AM, Emilio G. Cota wrote:
> >          case DISAS_STOP:
> > -            gen_goto_tb(&ctx, 0, ctx.pc);
> > +            tcg_gen_lookup_and_goto_ptr();
> 
> You need to write ctx.pc back to the pc first, e.g.
> 
>     gen_save_pc(ctx.pc);
>     tcg_gen_lookup_and_goto_ptr();

Thanks, fixed now.

		Emilio
