Received: from eggs.gnu.org ([2001:4830:134:3::10]:57656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHrAm-0000eA-HO
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHrAi-0000Cs-GL
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:08:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gHrAi-0008W3-7K
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 10:08:36 -0400
Date: Wed, 31 Oct 2018 11:08:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181031140812.GH3902@habkost.net>
References: <20181031004550.15410-1-ehabkost@redhat.com>
	<20181031004550.15410-5-ehabkost@redhat.com>
	<b155bd2d-59e0-62f8-4928-3e938127816a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b155bd2d-59e0-62f8-4928-3e938127816a@redhat.com>
Subject: Re: [Qemu-devel] [PULL 4/7] x86: Data structure changes to support
 MSR based features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Robert Hoo <robert.hu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Oct 31, 2018 at 08:24:10AM -0500, Eric Blake wrote:
> On 10/30/18 7:45 PM, Eduardo Habkost wrote:
> > From: Robert Hoo <robert.hu@linux.intel.com>
> > 
> > Add FeatureWordType indicator in struct FeatureWordInfo.
> > Change feature_word_info[] accordingly.
> > Change existing functions that refer to feature_word_info[] accordingly.
> > 
> > Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> > Message-Id: <1539578845-37944-3-git-send-email-robert.hu@linux.intel.com>
> > [ehabkost: fixed hvf_enabled() case]
> 
> Eduardo, this is missing your S-o-b, which is odd for a pull request.

Ouch, my mistake.  I have just pushed a new tag with the same
tree.

The following changes since commit a2e002ff7913ce93aa0f7dbedd2123dce5f1a9cd:

  Merge remote-tracking branch 'remotes/vivier2/tags/qemu-trivial-for-3.1-pull-request' into staging (2018-10-30 15:49:55 +0000)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to 09b9ee643f90ef95e30e594df2a3c83ccaf75b1f:

  i386: Add PKU on Skylake-Server CPU model (2018-10-30 21:14:43 -0300)

----------------------------------------------------------------
x86 queue, 2018-10-30

* MSR-based feature support for
  MSR_IA32_ARCH_CAPABILITIES bits (Robert Hoo)
* Cascadelake-Server CPU model (Tao Xu)
* Add PKU on Skylake-Server CPU model (Tao Xu)
* Correct cpu_x86_cpuid(0xd) (Sebastian Andrzej Siewior)
* Remove dead code (Peter Maydell)

----------------------------------------------------------------

Peter Maydell (1):
  target/i386: Remove #ifdeffed-out icebp debugging hack

Robert Hoo (3):
  kvm: Add support to KVM_GET_MSR_FEATURE_INDEX_LIST and KVM_GET_MSRS
    system ioctl
  x86: Data structure changes to support MSR based features
  x86: define a new MSR based feature word --
    FEATURE_WORDS_ARCH_CAPABILITIES

Sebastian Andrzej Siewior (1):
  i386: correct cpu_x86_cpuid(0xd)

Tao Xu (2):
  i386: Add new model of Cascadelake-Server
  i386: Add PKU on Skylake-Server CPU model

 include/hw/i386/pc.h    |  10 +-
 include/sysemu/kvm.h    |   2 +
 target/i386/cpu.h       |   8 ++
 target/i386/cpu.c       | 279 ++++++++++++++++++++++++++++++++--------
 target/i386/kvm.c       |  91 +++++++++++++
 target/i386/translate.c |   6 -
 6 files changed, 333 insertions(+), 63 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140


-- 
Eduardo
