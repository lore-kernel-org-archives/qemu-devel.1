Received: from eggs.gnu.org ([2001:4830:134:3::10]:45560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4PNt-0005GW-Ft
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 06:13:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4PNq-0001wM-Cg
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 06:13:49 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:33337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d4PNq-0001w8-70
	for qemu-devel@nongnu.org; Sat, 29 Apr 2017 06:13:46 -0400
Received: by mail-pg0-x235.google.com with SMTP id y4so20686273pge.0
	for <qemu-devel@nongnu.org>; Sat, 29 Apr 2017 03:13:45 -0700 (PDT)
Date: Sat, 29 Apr 2017 19:13:41 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170429101341.GF2724@lianli.shorne-pla.net>
References: <20170428211018.2927-1-shorne@gmail.com>
	<ad616d4e-a6fc-c8e3-9698-ad57762ac035@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad616d4e-a6fc-c8e3-9698-ad57762ac035@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH] target/openrisc: Support non-busy idle
 state using PMR SPR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Development <qemu-devel@nongnu.org>

On Sat, Apr 29, 2017 at 11:32:52AM +0200, Richard Henderson wrote:
> On 04/28/2017 11:10 PM, Stafford Horne wrote:
> > +            raise_exception(cpu, EXCP_HLT);
> 
> One minor tweak -- EXCP_HALTED.
> 
> HLT is, in theory, i386 specific.  Not that you'd have noticed a difference.
> FWIW, I've just found the same error in target/alpha.

Oh, I didnt notice that.

> Otherwise,
> 
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> 

Thanks,

-Stafford
