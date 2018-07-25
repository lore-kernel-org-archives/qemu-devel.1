Received: from eggs.gnu.org ([2001:4830:134:3::10]:46335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fiJCJ-0004Ad-90
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:47:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fiJCG-0005IO-Ag
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:47:19 -0400
Date: Wed, 25 Jul 2018 13:47:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180725124700.GF12855@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
	<CAHmQWvDu+P26Y5CJfcQ=1_9C=hej_B8w7dLMbmuOmCV-+pYOJQ@mail.gmail.com>
	<20180725114404.6g335n3rfjt23hjc@kamzik.brq.redhat.com>
	<CAFEAcA8wi2QV9cVg_Hp=8MYw_zfxvVciR2CbRZiGJNiQNPdHqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8wi2QV9cVg_Hp=8MYw_zfxvVciR2CbRZiGJNiQNPdHqg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jones <drjones@redhat.com>, Hongbo Zhang <hongbo.zhang@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Wed, Jul 25, 2018 at 01:19:09PM +0100, Peter Maydell wrote:
> On 25 July 2018 at 12:44, Andrew Jones <drjones@redhat.com> wrote:
> > On Wed, Jul 25, 2018 at 06:46:59PM +0800, Hongbo Zhang wrote:
> >> For Armv7, there is one typical platform 'vexpress', but for Armv8, no
> >
> > Wasn't the vexpress model designed for a specific machine?
> 
> Yes.
> 
> > Namely for
> > Arm's simulator?
> 
> No.
> 
> > Is the vexpress model really something typical among
> > all the Armv7 platforms?
> 
> No.
> 
> "Vexpress" is a model specifically of a development board
> produced by Arm (the versatile express). It's useful if you
> want to run code that runs on that devboard, but (as with
> most of the devboards we model), it's not necessarily ideal,
> because it has all the limitations of the real hardware it's
> modelling (in this case the big ones are limited memory, no PCI).
> The hardware it models is also quite old now (maybe 7 or 8 years)
> and it's not really "typical" of anything. (In the primarily
> embedded space where most v7 CPUs are there's not really anything
> that could be described as "typical" anyway: everything is
> different.)
> 
> For most people who just want to run Linux on an emulated v7 CPU,
> I would recommend the "virt" board, for the same reasons I
> recommend it for v8 cores.
> 
> >> such typical one, the 'virt' is typically for running workloads, one
> >> example is using it under OpenStack.
> >> So a 'typical' one for Armv8 is needed for firmware and OS
> >> development, similar like 'vexpress' for Armv7.
> >
> > What is a "typical" Armv8 machine? What will a typical Armv8 machine be in
> > two years?
> >
> > Note, I'm not actually opposed to the current definition (because I don't
> > really have one myself). I'm just opposed to hard coding one.
> 
> AIUI the aim here is to provide an emulated platform that is
> set up in the way that server-style armv8 machines are
> recommended to be set up, so it can be used as a testbed and
> demonstration for the firmware/OS software stack. The hope
> is that following "best practices" results in a "typical"
> machine :-)  But the word "typical" is probably not really
> very helpful here...
> 
> I would expect that in the future we'd want this machine type
> to evolve with the recommendations for how to build server
> platform hardware, which might indeed be different in two years,
> since it would be the development platform for writing/testing
> the firmware/OS stack for that two-years-time hardware.

Would iut make any sense to call the machine  "refplatform"  or "refboard"
to indicate it is a generic reference platform, not specifically following
any particular real impl, albeit influence by the sbsa spec.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
