Received: from eggs.gnu.org ([2001:4830:134:3::10]:44977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fida9-0000m1-Vy
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 06:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fida7-00044q-01
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 06:33:18 -0400
Date: Thu, 26 Jul 2018 12:33:04 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180726103304.2ybxx35z7zy2engv@kamzik.brq.redhat.com>
References: <CAHmQWvDu+P26Y5CJfcQ=1_9C=hej_B8w7dLMbmuOmCV-+pYOJQ@mail.gmail.com>
	<20180725114404.6g335n3rfjt23hjc@kamzik.brq.redhat.com>
	<CAFEAcA8wi2QV9cVg_Hp=8MYw_zfxvVciR2CbRZiGJNiQNPdHqg@mail.gmail.com>
	<20180725124700.GF12855@redhat.com>
	<20180725125944.5nd5ydm4x4e3vvjw@kamzik.brq.redhat.com>
	<CAKv+Gu-pbJj59wH7wgZ6Uq+Uko9wYEBqSF=WaC3LL68CFkbxEw@mail.gmail.com>
	<20180725133810.gsgfu4x6emygu5o5@kamzik.brq.redhat.com>
	<CAKv+Gu_91nXP4TSvrLf0e8kfX5X3ZNPcmx5UzT1jf5A_rVj8pQ@mail.gmail.com>
	<20180725140824.vnkejw5emkxwktaz@kamzik.brq.redhat.com>
	<CAHmQWvDY6hb7-a2X8e7CbJ=vhHKni1RUwSH4C7quccGTOZxm+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAHmQWvDY6hb7-a2X8e7CbJ=vhHKni1RUwSH4C7quccGTOZxm+w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
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
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Thu, Jul 26, 2018 at 05:46:23PM +0800, Hongbo Zhang wrote:
> On 25 July 2018 at 22:08, Andrew Jones <drjones@redhat.com> wrote:
> > On Wed, Jul 25, 2018 at 03:46:01PM +0200, Ard Biesheuvel wrote:
> >> On 25 July 2018 at 15:38, Andrew Jones <drjones@redhat.com> wrote:
> >> > On Wed, Jul 25, 2018 at 03:03:40PM +0200, Ard Biesheuvel wrote:
> >> >> On 25 July 2018 at 14:59, Andrew Jones <drjones@redhat.com> wrote=
:
> >> >> > On Wed, Jul 25, 2018 at 01:47:00PM +0100, Daniel P. Berrang=E9 =
wrote:
> >> >> >> Would iut make any sense to call the machine  "refplatform"  o=
r "refboard"
> >> >> >> to indicate it is a generic reference platform, not specifical=
ly following
> >> >> >> any particular real impl, albeit influence by the sbsa spec.
> >> >> >>
> >> >> >
> >> >> > That would indeed stop me from whining about a machine model wi=
th an
> >> >> > 'sbsa' name not strictly implementing a minimal SBSA machine :-=
)
> >> >> >
> >> >>
> >> >> I still don't get why only a minimal machine is worth considering=
,
> >> >> given that a real-world minimal SBSA machine is not capable of do=
ing
> >> >> anything useful.
> >> >
> >> > One definition of an SBSA machine can be quite different than anot=
her.
> >> > If we only hard code the required [useless] base, but also provide=
 a
> >> > readconfig for the rest, then we get a useful machine without loss=
 of
> >> > flexibility.
> >> >
> >> > That flexibility comes at the cost of platform-bus code (since we =
need
> >> > to add devices to the system bus) and a less concise command line.=
 The
> >> > platform-bus code may indeed be too expensive for this purpose, bu=
t
> >> > we may need to see patches to be sure. I understand the desire to =
have
> >> > a shorter command line, but this is QEMU :)
> >> >
> >>
> >> My concern is not the QEMU side. It is the code that we will need to
> >> add to UEFI and ARM-TF to deal with the dynamic nature of the
> >> underlying platform. That code has no counterpart in real world
> >> hardware, but will surely turn up in production firmware nonetheless
> >> if we end up having to add that to our SBSA reference codebase.
> >
> > It sounds like there's already some sort of informal SBSA reference
> > instance specification that UEFI and ARM-TF intend to support. If
> > that instance specification were slightly more formal, i.e. documente=
d
> > somewhere and given a more descriptive name (not just 'sbsa'), then
> > I think it would be a lot more palatable to hard code those specifica=
tions
> > directly into a QEMU machine model of the same name.
> >
> Root cause is requirement. This platform and virt serve different use c=
ases.

Never any disagreement there. I'm just disagreeing with how you're naming
one instance of an SBSA platform with the very generic name of 'sbsa'.

>=20
> As to command line and readconfig, my opinion is they are suitable for
> change slightly some base/typical platforms, not for change one to

Yes, command line and readconfig are suitable for changing a base
platform. That's why your new machine model should be a *base* platform,
not a specific platform with hard coded peripheral selections.

Thanks,
drew
