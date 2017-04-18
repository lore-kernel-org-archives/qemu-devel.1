Received: from eggs.gnu.org ([2001:4830:134:3::10]:60744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d0U05-0006Ep-R8
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d0U03-00016a-4w
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:21:01 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:36782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d0U02-00016N-Uy
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 10:20:59 -0400
Received: by mail-pf0-x22e.google.com with SMTP id 194so42450215pfv.3
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 07:20:58 -0700 (PDT)
Date: Tue, 18 Apr 2017 23:20:55 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170418142055.GB2599@lianli.shorne-pla.net>
References: <cover.1492384862.git.shorne@gmail.com>
	<fb69c137317a365dcb549dfef1ecd2fbff48e92c.1492384862.git.shorne@gmail.com>
	<6914f9b7-ece1-973d-2210-871b71319ae0@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6914f9b7-ece1-973d-2210-871b71319ae0@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 2/7] target/openrisc: add shutdown logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, openrisc@lists.librecores.org

On Tue, Apr 18, 2017 at 12:52:52AM -0700, Richard Henderson wrote:
> On 04/16/2017 04:23 PM, Stafford Horne wrote:
> > In openrisc simulators we use hooks like 'l.nop 1' to cause the
> > simulator to exit.  Implement that for qemu too.
> > 
> > Reported-by: Waldemar Brodkorb <wbx@openadk.org>
> > Signed-off-by: Stafford Horne <shorne@gmail.com>
> 
> As I said the first time this was posted: This is horrible.
> 
> If you want to do something like this, it needs to be buried under a special
> run mode like -semihosting.

Understood,  I will revise this.  I didnt know this was posted before.

> >          case 0x01:    /* l.nop */
> >              LOG_DIS("l.nop %d\n", I16);
> > +            {
> > +                TCGv_i32 arg = tcg_const_i32(I16);
> > +                gen_helper_nop(arg);
> > +            }
> 
> You also really really must special-case l.nop 0 so that it doesn't generate
> a function call.  Just think of all the extra calls you're adding for every
> delay slot that couldn't be filled.

Yeah, that makes sense.  Ill add that for l.nop 0.

-Stafford

> 
> r~
