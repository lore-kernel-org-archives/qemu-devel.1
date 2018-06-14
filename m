Received: from eggs.gnu.org ([2001:4830:134:3::10]:43260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTO71-000186-Gk
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 05:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fTO6v-0001Pk-RH
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 05:00:11 -0400
Date: Thu, 14 Jun 2018 09:59:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180614085954.GM6355@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1528879723-24675-1-git-send-email-eric.auger@redhat.com>
	<1528879723-24675-10-git-send-email-eric.auger@redhat.com>
	<8bf1bccc-b32a-9982-6123-b644c41a96d3@redhat.com>
	<33a3fa10-bf1a-45cd-73bd-403cbd8d4792@redhat.com>
	<fbd7ea65-8f3e-bda3-1bb6-09b3b67d2543@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fbd7ea65-8f3e-bda3-1bb6-09b3b67d2543@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 9/9] hw/arm/virt: Add virt-3.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, wei@redhat.com, drjones@redhat.com, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, christoffer.dall@arm.com, zhaoshenglong@huawei.com

On Thu, Jun 14, 2018 at 10:56:20AM +0200, Laszlo Ersek wrote:
> Hi Eric,
> 
> On 06/14/18 08:27, Auger Eric wrote:
> > Hi Laszlo,
> > 
> > On 06/13/2018 11:05 PM, Laszlo Ersek wrote:
> >> On 06/13/18 10:48, Eric Auger wrote:
> >>
> >>> PATCH: merge of ECAM and VCPU extension
> >>> - Laszlo reviewed the ECAM changes but I dropped his R-b
> >>>   due to the squash
> >>
> >> Was there any particular reason why the previous patch set (with only
> >> the ECAM enlargement) couldn't be merged first? To be honest I'm not
> >> super happy when my R-b is dropped for non-technical reasons; it seems
> >> like wasted work for both of us.
> >>
> >> Obviously if there's a technical dependency or some other reason why
> >> committing the ECAM enlargement in separation would be *wrong*, that's
> >> different. Even in that case, wouldn't it be possible to keep the
> >> initial virt-3.0 machtype addition as I reviewed it, and then add the
> >> rest in an incremental patch?
> > 
> > Sorry about that. My fear was about migration. We would have had 2 virt
> > 3.0 machine models not supporting the same features. While bisecting
> > migration we could have had the source using the high mem ECAM and the
> > destination not supporting it. So I preferred to avoid this trouble by
> > merging the 2 features in one patch. However I may have kept your R-b
> > restricting its scope to the ECAM stuff.
> 
> to my understanding, it is normal to *gradually* add new properties
> during the development cycle, to the new machine type of the upcoming
> QEMU release. To my understanding, it's not expected that migration work
> between development snapshots built from git. What matters is that two
> official releases, specifying the same machine type, enable the user to
> migrate a guest between them (in forward direction).
> 
> In every release, so many new features are introduced that it's
> impossible to introduce the new machine type with all the compat knobs
> added at once. Instead, the new machine type is introduced when the
> first feature that requires a compat knob is added to git. All other
> such features extend the compat knobs gradually, during the development
> cycle. Until the new official release is made (which contains all the
> compat knobs for all the new features), the new machine type simply
> doesn't exist, as far as the public is concerned, so it cannot partake
> in migration either.
> 
> This is my understanding anyway.

That is correct - there is ZERO expectation of migration / ABI stability
between arbitrary GIT snapshots, only official releases.  Prior to the
first release including it, a versioned machine type can be changed
arbitrarily.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
