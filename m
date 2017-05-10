Received: from eggs.gnu.org ([2001:4830:134:3::10]:40921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8LW2-00015O-9m
	for qemu-devel@nongnu.org; Wed, 10 May 2017 02:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d8LW1-00069P-Ae
	for qemu-devel@nongnu.org; Wed, 10 May 2017 02:54:30 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d8LW1-00068z-4J
	for qemu-devel@nongnu.org; Wed, 10 May 2017 02:54:29 -0400
Date: Wed, 10 May 2017 08:54:18 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170510065418.xtnoiy2osgkexwpf@aurel32.net>
References: <20170506111431.12548-1-aurelien@aurel32.net>
	<20170506111431.12548-10-aurelien@aurel32.net>
	<a98c67f8-3c5c-b68d-beea-f1972bb3dc0d@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a98c67f8-3c5c-b68d-beea-f1972bb3dc0d@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v2 09/14] target/sh4: optimize
 gen_store_fpr64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On 2017-05-09 14:09, Richard Henderson wrote:
> On 05/06/2017 04:14 AM, Aurelien Jarno wrote:
> > +    tcg_gen_extrl_i64_i32(cpu_fregs[reg + 1], t);
> > +    tcg_gen_extrh_i64_i32(cpu_fregs[reg], t);
> 
> This is
> 
>   tcg_gen_extr_i64_i32(cpu_fregs[reg + 1], cpu_fregs[reg], t);
> 

Good catch, thanks.

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
