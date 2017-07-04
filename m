Received: from eggs.gnu.org ([2001:4830:134:3::10]:60546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dSDrO-0001rr-RW
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 22:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dSDrL-0001V8-PJ
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 22:46:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:9154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dSDrL-0001Jy-Fx
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 22:46:39 -0400
Date: Tue, 4 Jul 2017 10:46:22 +0800
From: Zhong Yang <yang.zhong@intel.com>
Message-ID: <20170704024622.GA3534@yangzhon-Virtual>
References: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
	<1499076743-15477-7-git-send-email-yang.zhong@intel.com>
	<9eed0ab9-f388-7daa-2e2a-4f891c973e0a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eed0ab9-f388-7daa-2e2a-4f891c973e0a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/15] kvmvapic: remove tcg related code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, anthony.xu@intel.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com, qemu-devel@nongnu.org

On Mon, Jul 03, 2017 at 04:28:00PM +0200, Paolo Bonzini wrote:
> 
> 
> On 03/07/2017 12:12, Yang Zhong wrote:
> > Since Paolo's below patch has fixed A20 issue
> > commit bbfa326fc8028e275eddf8c9965c2a1b59405b2e
> > target/i386: enable A20 automatically in system management mod
> 
> How is this patch related to kvmvapic?  It fixes a bug with vapic
> disabled, but it's not a reason to disable kvmvapic.
> 
> Paolo
> 
  Hello Paolo,

  In that time, in order to verify the tcg code is not useful in kvmvapic.c 
  file, we disabled the kvmvapic rom in the seabios and use the tcg accelator 
  to boot guest image, we found this A20 bug.

  Once this A20 bug has been fixed, we can use the tcg to bootup the guest
  image without kvmvapic rom, which show the tcg code in kvmvapic is not useful.
  This is reason why i removed the tcg code replace of using tcg_enabled() to check
  the tcg code in kvmvapic.c. thanks!

  Regards,

  Yang  
  

> > The tcg code in kvmvapic.c is NOT useful, those code need remove.
> > 
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > ---
> >  hw/i386/kvmvapic.c | 24 ------------------------
> >  1 file changed, 24 deletions(-)
