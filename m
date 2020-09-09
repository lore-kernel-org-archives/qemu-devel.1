Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B2AC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7269121532
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="EZ6RM4Db"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7269121532
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG3yD-0001B1-Dv
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 13:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kG3xO-0008OM-DG
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:32:30 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:43471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kG3xL-0003CM-HP
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=1/QgqKFp/jCdNUqku7CFaofwtuN6ZuTQA/r4wJj4m24=; b=EZ6RM4DbuvNYBjZOIjN5nL5Hwq
 saccp/m+3Mk6ZRJfRdG8ILn7F0pZ0VFg2xWN4j3WENMpl0ClLMvtg0S1B5wXvkvKc1W4aY5SHGrkV
 MCTseiZwJe22hmZvf1UiIl/isYhJ4IWmVJRldbtTSnqWE8CehNmtjaGbUUS6j1ZU5B2qKnyeJPEWA
 3tmUJYadynj1dkaWYjoBmnHC4+ziS8YE16TgraVaiXY1UVHkab2tw+eo6qsSPPIK0xQ4IqLSZ1YNW
 ABeNdpQBMlg2Wg9bRr2sFYxLAORMWckmSeUn/DbsnzJaDZUNQinAsGgLu5XrQL6gr0+zMEa8nwn5S
 2xQvqiVw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 G 3 <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Liviu Ionescu <ilg@livius.net>
Subject: Re: [RFC] QEMU as Xcode project on macOS
Date: Wed, 09 Sep 2020 19:32:21 +0200
Message-ID: <13443969.F0S6BcH2UH@silver>
In-Reply-To: <CAFEAcA8Wgbqm15DB1YLXBzQJwNeZjKGcdLFHe8G4FS6YT5Tcmw@mail.gmail.com>
References: <2764135.D4k31Gy3CM@silver>
 <CAFEAcA8Wgbqm15DB1YLXBzQJwNeZjKGcdLFHe8G4FS6YT5Tcmw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 13:32:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mittwoch, 9. September 2020 15:30:09 CEST Peter Maydell wrote:
> On Wed, 9 Sep 2020 at 13:56, Christian Schoenebeck
>=20
> <qemu_oss@crudebyte.com> wrote:
> > I've recently been thinking about how feasible a stripped down Xcode
> > project for QEMU would be, i.e. you just get the QEMU sources, click on
> > qemu.xcodeproj, Cmd + B, done. No extra installation, no configure,
> > nothing.
> How would this work? Can you have an XCode project that just
> says "to build this program we will run configure and make" ?

You can run shell scripts. There are two main mechanisms in Xcode for that,=
=20
one is "Build phases" where you can define shell code being executed for an=
=20
individual "target" (e.g. a lib/app being built), which shell to be used (e=
=2Eg.=20
sh, zsh, bash, python), the actual shell code to be executed, and optionall=
y a=20
list of output files (e.g. .c files) said to be generated by the shell code=
=20
which then in turn are compiled by Xcode according to their file type:

https://www.mokacoding.com/blog/better-build-phase-scripts/

Limitation: the precise list of generated output files needs to be specifie=
d=20
to the Xcode project if they need to be compiled. So you cannot let the she=
ll=20
script dynamically tell Xcode "here are the source files I generated: [...]=
=20
compile them please".

=46or that reason there is a 2nd mechanism in Xcode called "Build Rules", w=
hich=20
basically allow you defining custom source file types, so e.g. Xcode would =
run=20
a shell script for every source file that ends with "*.foo", the shell scri=
pt=20
would then generate for each one of them e.g. a .c file, which then would i=
n=20
turn be compiled by Xcode with clang.

In this example somebody auto generates .c files from .css files (sorry, du=
sty=20
screenshots, but it's still the same thing):

https://www.cocoanetics.com/2012/02/xcode-build-rules/

> We definitely don't want to have two parallel mechanisms for
> specifying how to build QEMU, because they'll just get out of sync.

Sure, the Xcode project file should be auto generated for that reason,=20
otherwise it's DOA.

> > each individually on macOS. Or right, you could alternatively "just
> > install" them from Homebrew, MacPorts, Fink. But no matter which soluti=
on
> > you choose, it easily ends up in a mess (conflicts, misbehaviours) on
> > macOS to install libs and apps globally. And I think that's the problem
> > why there are currently relatively little contribution for QEMU coming
> > from devs on macOS. Because you don't want to install things globally on
> > a macOS system, it's simply not working well there as it does with Linux
> > distros.
>=20
> My experience with homebrew has been pretty good overall.
> If there's a better way to handle OSX hosts that doesn't
> require us to carry around all our dependencies (which is
> impractical) that would be interesting to investigate.

It probably depends on how many and which FOSS projects you compiled on Mac.
I no longer install from Homebrew and co, nor do I "pip install" things for=
=20
the same reasons. And AFAICS other devs on Mac made similar experiences.

Plus I am used to FOSS projects having more issues on Mac then on Linux. If=
=20
it's an Xcode generated app that crashes, then Xcode automatically opens th=
e=20
precise crashed lib's source file in the editor, along with the stacktrace,=
=20
you fix the bug, click on "Run" and that's it. Without Xcode that would be=
=20
like 45 mins just for recompiling the relevant dependencies.

On Mittwoch, 9. September 2020 15:40:05 CEST Daniel P. Berrang=E9 wrote:
> Ideally any xcode setup would just invoke whatever our standard
> build tools are IMHO, so it has zero possibility of introducing
> new build problems.

Then you would not win anything on Mac. The problematic on macOS is that Ap=
ple=20
froze many standard FOSS tools that switched to GPL3. So by default you jus=
t=20
have e.g. GNU make 3.81 (2006), Bash 3.2.57 (2007), ...  unless you start t=
o=20
manually install them (e.g. from Homebrew & Co). And being forced to use Me=
son=20
on Mac with all its Python dependencies does not make it easier.

IMO the Xcode project file would ideally be auto generated from the existin=
g=20
build infrastructure (e.g. Meson) and the scripts that are still required t=
o=20
be run by Xcode should be able to work with the old versions of build tools=
=20
installed on a standard macOS system.

On Mittwoch, 9. September 2020 15:41:02 CEST Thomas Huth wrote:
> On 09/09/2020 14.56, Christian Schoenebeck wrote:
> > I've recently been thinking about how feasible a stripped down Xcode
> > project for QEMU would be, i.e. you just get the QEMU sources, click on
> > qemu.xcodeproj, Cmd + B, done. No extra installation, no configure,
> > nothing.
> Meson seems to have some exporter for Xcode according to
> https://mesonbuild.com/IDE-integration.html ... maybe you can harness
> that feature somehow?

Good to know, thanks! I'll give it a try.

> > The question is, and I don't have the big picture of QEMU yet to judge
> > that, how much is auto generated for QEMU i.e. with custom scripts that
> > would probably destroy this plan? There are these trace calls that are
> > auto generated, is there more like the TCG part for instance?
>=20
> Yes, I think we generate code in a couple of places, e.g. the code in
> target/s390x/ uses a "gen-features" helper to generate some code. So
> implementing a separate Xcode project that does not use the main build
> files does not sound very appealing.

It's probably not that relevant how many files are generated, but more how=
=20
many scripts approximately are generating these. If you just need to instal=
l=20
like two dozens of shell hooks into the Xcode project, then Ok, that's=20
manageable, if it's rather like hundreds or even thousands of script hooks,=
=20
that would make the whole thing probably unrealistic, unless Meson's allege=
dly=20
built-in Xcode feature already does a very great job. ;-)

On Mittwoch, 9. September 2020 16:40:10 CEST Programmingkid wrote:
> I think the solution to this problem is to switch over the CMake
> (https://en.wikipedia.org/wiki/CMake). It is a build system that lets you
> specify how you want to build software. There are many targets available
> including 'make' and an Xcode project file.

Well, the project just switched to Meson. It's probably not likely that the=
re=20
will be another build system switch any time soon I guess. But who knows,=20
maybe Meson already does a good job on Xcode, or if not, maybe Meson could =
be=20
fixed. We'll see.

Best regards,
Christian Schoenebeck



