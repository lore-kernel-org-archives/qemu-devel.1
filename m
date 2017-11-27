Received: from eggs.gnu.org ([2001:4830:134:3::10]:48795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eJRVL-0001cD-16
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 17:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eJRVG-00080J-3A
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 17:03:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1eJRVF-000809-Pk
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 17:03:50 -0500
References: <CAFEAcA-b9oDkPfZbntWfhWSv1HOnbUf75p_xB_tF74h_NBGPmw@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <791b0b92-a232-bf63-bd12-0e663c19175c@redhat.com>
Date: Mon, 27 Nov 2017 17:03:47 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-b9oDkPfZbntWfhWSv1HOnbUf75p_xB_tF74h_NBGPmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU Summit 2017: minutes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>



On 11/23/2017 11:31 AM, Peter Maydell wrote:
> As usual, during this year's KVM Forum we also held the
> QEMU Summit, which is where the more active subsystem
> maintainers meet up for a discussion of various maintenance
> and other project issues. As usual, none of this is set-in-stone
> decisions; further input and discussion on-list is welcome.
> 
> 
> 
> qemu.org hosting update:
>  * Rackspace announced they were ending our free sponsorship, and it would
>    be too expensive to stay with them at their charged rates
>  * We were planning to migrate to hosting with a consultancy company
>    who offered to host us
>  * However subsequently to the Summit Rackspace had a change of heart and
>    are extending the free hosting indefinitely, so we will stay with them
>    (at least for now)
>  * CDN sponsorship would help us split off downloads, which are the
>    bulk of our bandwidth use
> 
> qemu-next:
>  * Problem 1: Contributors cannot get patches merged during freeze
>    (bad experience)
>  * Problem 2: Block layer subtrees have high chance of conflict towards
>    end of freeze
>  * Peter Maydell: ...but the block layer seems to be about the only
>    area with any significant conflict problems currently
>  * Markus Armbruster: Problem 1 is solved if maintainers keep their own
>    -next trees
>  * Paolo Bonzini: Maintaining -next could slow down or create work for
>    -freeze (e.g. who does backports)
>  * Action: Maintainers mustn't tell submitters to go away just because
>    we're in a release freeze (it's up to them whether they prefer to
>    maintain a "-next" tree for their subsystem with patches queued for
>    the following release, or track which patches they've accepted
>    some other way)
>  * We're not going to have an official project-wide "-next" tree, though

Maybe we ought to have a single block-next tree if we're the main source
of that problem. We already more-or-less do with Kevin's tree, but the
tree with the most patches likely to conflict can change depending on
the week (Kevin? Max? Stefan?)

this decentralization works well for us in general when master is open,
but maybe is a source of frustration for drive-by contributors when
master is closed.

Is there room for a block-layer meta-maintainer to pull and test from
all the different sublayers before passing it onward and upward, or does
that just create more problems than it solves?

> 
> Firmware blobs:
>  * Gerd Hoffmann: Most users don't use firmware blobs from QEMU repo (they
>    get them from distros), blobs are becoming larger and bloating
>    download size
>  * QEMU now has a /usr/lib/qemu-firmware path where it can load firmware
>  * Alex Graf: Even though many distros recompile blobs, some blobs are
>    hard to recompile so they are shipped without recompilation
>  * Paolo Bonzini: pc-bios/ blobs which have sources in the QEMU tree
>    need to stay in the QEMU repo (ie pc-bios/{optionrom,s390-ccw,spapr-rtas})
>  * Peter Maydell: Unlikely that adding entire UEFI source tree to QEMU
>    repo makes sense, but on the other hand we'd like our from-source
>    users to be able to run UEFI on ARM and x86 boards
>  * Some firmware blobs need lockstep updates with QEMU (eg sparc openbios,
>    likely others), so having them in a separate repo is awkward
>  * No clear solution at the moment -- would somebody like to volunteer to
>    post a proposal to the list (or just try to capture the requirements)?
> Security bug handling:
>  * Daniel Berrange: QEMU doesn't document security bugs fixed in last
>    release (required by CII Best Practices)
>  * Peter Maydell: Currently we effectively delegate providing an actual
>    secure QEMU usable in production to distros -- we don't do prompt
>    releases with security fixes in
>  * Stefan Hajnoczi: Stable tree makes sense if distros can share backporting
>    work, if distros are not using the same QEMU point release then the
>    stable release tends to be not used much
>  * Action: Daniel Berrange will propose process for recording CVEs
> 
> QEMU Summit Inclusion:
>  * Paolo Bonzini: Currently top contributors plus a set of people with
>    responsibilities (e.g. -stable maintainer, qemu.org system administrators)
>    are invited.  Should we open the summit to anyone who is interested?
>  * Peter Maydell: Adding more people may make discussion unwieldy -- we
>    would probably need to make the process more formal with proposed agenda
>    items having a defined desired decision or outcome attached. (But that
>    might be a good idea anyway!)
>  * Peter Maydell: Do the Kernel Summit or Device Tree Summit provide
>    anything we can learn from? Perhaps we should take a step back and
>    ask why we're doing this anyway...
>  * Cornelia Huck: Birds of a Feather sessions could be connected with QEMU
>    Summit to discuss maintainer topics
>  * No action
> 

Do you grab representatives from top contributing companies? Might help
lessen the RH-centricity of things which might increase the rate of
patchflow.

> Continuous Integration:
>  * Christian Borntraeger: qemu-iotests have broken a lot, they should be
>    run before patches are merged

This, rather unfortunately, is a huge testing burden. I try to make sure
I do it for everything I submit, but for the volume of block patches it
really does rely CI. The more we add (to our pitifully sparse iotesting,
I might add) the longer it takes. Ensuring per-patch testing begins to
take prohibitively long.

Perhaps per-pull or per-merge becomes more feasible. Maybe if we do
implement a block-next amalgam we'd be able to batch our testing on a
weekly basis.

>  * Peter Maydell: If it isn't tested by "make check" then it isn't tested:
>    so if something is regularly regressing then it needs to be added to
>    "make check".

Is this tenable long term? We can't conceivably state that we will never
test things that aren't in "make check" -- we ought to have different
tiers, at least. The full testing suite should run for RC tags at least,
but it's not feasible (I think?) to run the entire battery of tests on
every commit... but that shouldn't stop us from running them /sometimes/...

>  * Peter Maydell: Personal build test scripts are being used on qemu.git,
>    looking for help to generalize them so others can do the same build
>    testing. (Likely to be awkward since half of it is machines I have
>    personal login access to and wouldn't want/be able to give others
>    access to.)
>  * Action: Stefan Hajnoczi to ask Fam Zheng about status of qemu-iotests
>    in patchew
> 
> Deprecation Cycle:
>  * Daniel Berrange: Current policy gives a 2 release grace period before
>    features are removed
>  * Markus Armbruster: Sometimes it's painful to keep features that are
>    costly to maintain for 2 releases, can we make exceptions to the policy?
>  * Daniel Berrange: It's important to stick to the policy so users (e.g.
>    management tools) have time to adapt
>  * There seems to be some scope for limiting deprecation policy for some
>    areas of code
> 
> thanks
> -- PMM
>
