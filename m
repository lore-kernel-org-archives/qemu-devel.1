Received: from eggs.gnu.org ([2001:4830:134:3::10]:50461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRkDP-0002if-JS
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRkDM-0007G5-Gc
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:35:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRkDM-0007F8-B4
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:35:08 -0500
Date: Thu, 12 Jan 2017 16:35:05 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170112183505.GR3565@thinpad.lan.raisama.net>
References: <1484032051-11619-1-git-send-email-he.chen@linux.intel.com>
	<20170112171029.GD27893@thinpad.lan.raisama.net>
	<f08d7b7b-6fdb-73bf-b569-4c8b77b2345a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f08d7b7b-6fdb-73bf-b569-4c8b77b2345a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] x86: add AVX512_VPOPCNTDQ features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: He Chen <he.chen@linux.intel.com>, qemu-devel@nongnu.org, He Chen <he.chen@intel.com>, Richard Henderson <rth@twiddle.net>

On Thu, Jan 12, 2017 at 07:18:20PM +0100, Paolo Bonzini wrote:
> On 12/01/2017 18:10, Eduardo Habkost wrote:
> > On Tue, Jan 10, 2017 at 03:07:31PM +0800, He Chen wrote:
> >> AVX512_VPOPCNTDQ: Vector POPCNT instructions for word and qwords.
> >> variable precision.
> >>
> >> Signed-off-by: He Chen <he.chen@linux.intel.com>
> >> ---
> >>  target/i386/cpu.c | 2 +-
> >>  target/i386/cpu.h | 1 +
> >>  2 files changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index b0640f1..ae900b5 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -435,7 +435,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> >>              NULL, "avx512vbmi", "umip", "pku",
> >>              "ospke", NULL, NULL, NULL,
> >>              NULL, NULL, NULL, NULL,
> >> -            NULL, NULL, NULL, NULL,
> >> +            NULL, NULL, "vpopcntdq", NULL,
> > 
> > The patches I see on linux-kernel use the "avx512_vpopcntdq"
> > name. Why not use "avx512-vpopcntdq" in QEMU to avoid confusion?
> 
> Or without the dash too, for consistency with avx512vbmi.

I would agree if Linux was consistent and used "avx512vpopcntdq"
instead of "avx512_vpopcntdq". But if Linux choose to use
"avx512_vpopcntdq", I would like to use a compatible name in
QEMU.

Other software components are likely to use the same flag names
as Linux. If we use a different name, they will need to manually
translate the Linux names to QEMU names.

-- 
Eduardo
