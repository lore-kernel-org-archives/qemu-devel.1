Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A860EC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:30:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF8420862
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:30:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF8420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49884 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZNb-0005o7-Iz
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 11:30:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQZMZ-0005CE-KV
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQZMV-0006vC-BC
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:29:05 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54266
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Dave.Martin@arm.com>) id 1hQZMU-0006t3-WD
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:29:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81B8C374;
	Tue, 14 May 2019 08:29:00 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.72.51.249])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29C313F703;
	Tue, 14 May 2019 08:28:59 -0700 (PDT)
Date: Tue, 14 May 2019 16:28:56 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190514152856.GO28398@e103592.cambridge.arm.com>
References: <20190418092841.fzrcegkbal7dpfcy@kamzik.brq.redhat.com>
	<20190418112610.GO13773@redhat.com>
	<877ebrmch2.fsf@dusky.pond.sub.org>
	<20190513184237.i2ha3ixvhjqzkn5q@kamzik.brq.redhat.com>
	<87bm05ab6c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87bm05ab6c.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.101.70
Subject: Re: [Qemu-devel] How do we do user input bitmap properties?
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
	Andrew Jones <drjones@redhat.com>,
	Daniel =?iso-8859-1?Q?P=2EBerrang=E9?= <berrange@redhat.com>,
	"dgilbert@redhat.com" <dgilbert@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"imammedo@redhat.com" <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 14, 2019 at 05:54:03AM +0100, Markus Armbruster wrote:
> Andrew Jones <drjones@redhat.com> writes:
>=20
> > On Thu, Apr 18, 2019 at 07:48:09PM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrang=E9 <berrange@redhat.com> writes:
> >>=20
> >> > On Thu, Apr 18, 2019 at 11:28:41AM +0200, Andrew Jones wrote:
> >> >> Hi all,
> >> >>=20
> >> >> First some background:
> >> >>=20
> >> >> For the userspace side of AArch64 guest SVE support we need to
> >> >> expose KVM's allowed vector lengths bitmap to the user and allow
> >> >> the user to choose a subset of that bitmap. Since bitmaps are a
> >> >> bit awkward to work with then we'll likely want to expose it as
> >> >> an array of vector lengths instead. Also, assuming we want to
> >> >> expose the lengths as number-of-quadwords (quadword =3D=3D 128 bi=
ts
> >> >> for AArch64 and vector lengths must be multiples of quadwords)
> >> >> rather than number-of-bits, then an example array (which will
> >> >> always be a sequence) might be
> >> >>=20
> >> >>  [ 8, 16, 32 ]
> >> >>=20
> >> >> The user may choose a subsequence, but only through truncation,
> >> >> i.e. [ 8, 32 ] is not valid, but [ 8, 16 ] is.
> >> >>=20
> >> >> Furthermore, different hosts may support different sequences
> >> >> which have the same maximum. For example, if the above sequence
> >> >> is for Host_A, then Host_B could be
> >> >>=20
> >> >>  [ 8, 16, 24, 32 ]
> >> >>=20
> >> >> The host must support all lengths in the sequence, which means
> >> >> that while Host_A supports 32, since it doesn't support 24 and
> >> >> we can only truncate sequences, we must use either [ 8 ] or
> >> >> [ 8, 16 ] for a compatible sequence if we intend to migrate
> >> >> between the hosts.
> >> >>=20
> >> >> Now to the $SUBJECT question:
> >> >>=20
> >> >> My feeling is that we should require the sequence to be
> >> >> provided on the command line as a cpu property. Something
> >> >> like
> >> >>=20
> >> >>   -cpu host,sve-vl-list=3D8:16
> >> >>=20
> >> >> (I chose ':' for the delimiter because ',' can't work, but
> >> >> if there's a better choice, then that's fine by me.)
> >> >>=20
> >> >> Afaict a property list like this will require a new parser,
> >>=20
> >> We had 20+ of those when I last counted.  Among the more annoying
> >> reasons CLI QAPIfication is hard[1].
> >>=20
> >> >> which feels a bit funny since it seems we should already
> >> >> have support for this type of thing somewhere in QEMU. So,
> >> >> the question is: do we? I see we have array properties, but
> >> >> I don't believe that works with the command line. Should we
> >> >> only use QMP for this? We already want some QMP in order to
> >> >> query the supported vector lengths. Maybe we should use QMP
> >> >> to set the selection too? But then what about command line
> >> >> support for developers? And if the property is on the command
> >> >> line then we don't have to add it to the migration stream.
> >> >
> >> > You should be able to use arrays from the CLI with QemuOpts by rep=
eating
> >> > the same option name many times, though I can't say it is a very
> >> > nice approach if you have many values to list as it gets very repe=
tative.
> >>=20
> >> Yes, this is one of the ways the current CLI does lists.  It's also =
one
> >> of the more annoying reasons CLI QAPIfication is hard[2].
> >>=20
> >> QemuOpts let the last param=3Dvalue win the stupidest way that could
> >> possibly work (I respect that): add to the front of the list, search=
 it
> >> front to back.
> >>=20
> >> Then somebody discovered that if you search the list manually, you c=
an
> >> see them all, and abuse that to get a list-valued param.  I'm sure t=
hat
> >> felt clever at the time.
> >>=20
> >> Another way to do lists the funky list feature of string input and o=
pts
> >> visitor.  Yet another annoying reason CLI QAPIfication is hard[3].
> >>=20
> >> We use the opts visitor's list feature for -numa node,cpus=3D...  Hm=
m,
> >> looks like we even combine it with the "multiple param=3Dvalue build=
 up a
> >> list" technique: -smp node,cpus=3D0-1,cpus=3D4-5 denotes [0,1,4,5].
> >>=20
> >> > That's the curse of not having a good CLI syntax for non-scalar da=
ta in
> >> > QemuOpts & why Markus believes we should switch to JSON for the CL=
I too
> >> >
> >> >      -cpu host,sve-vl=3D8,sve-vl=3D16
> >>=20
> >> We actually have CLI syntax for non-scalar data: dotted keys.  Dotte=
d
> >> keys are syntactic sugar for JSON.  It looks friendlier than JSON fo=
r
> >> simple cases, then gets uglier as things get more complex, and then =
it
> >> falls apart: it can't quite express all of JSON.
> >>=20
> >> Example: sve-vl.0=3D8,sve-vl.1=3D16
> >>     gets desugared into {"sve": [8, 16]}
> >>     if the QAPI schema has 'sve': ['int'].
> >>=20
> >> The comment at the beginning of util/keyval.c explains it in more
> >> detail.
> >>=20
> >> It powers -blockdev and -display.  Both options accept either JSON o=
r
> >> dotted keys.  If the option argument starts with '{', it's JSON.
> >> Management applications should stick to JSON.
> >>=20
> >>=20
> >> [1] Towards a more expressive and introspectable QEMU command line
> >> https://www.linux-kvm.org/images/f/f2/Armbru-qapi-cmdline_1.pdf
> >> Slide 34 "Backward compatibility" item 1
> >>=20
> >> [2] ibid, item 4
> >>=20
> >> [3] ibid, item 3
> >>
> >
> > Sorry I forgot to follow up to this earlier. I looked at the examples
> > provided and saw they were all for independent command line options,
> > rather than command line options like '-cpu' that then accepts additi=
onal
> > properties. I couldn't see how I could use ',' to separate array memb=
ers
> > when using properties or to use an array property input on the comman=
d
> > line.
>=20
> The argument of -cpu is parsed ad hoc.  Unlike QemuOpts and dotted keys=
,
> parse_cpu_option() doesn't seem to support escaping ','.  Not that
> escaping would be a user-friendly solution.
>=20
> >       In the end I opted to use a single uint64_t for a bitmap, as 64=
 is
> > big enough for now,
>=20
> Do you think it'll remain big enough?

The answer is "probably".

I didn't want to have to redesign the kernel ABI again if the
architecture busts this limit in future.

64 bits already goes beyond what the SVE architecture supports today.

But it would be preferable for QEMUs interface to have the same
arbitrary limit as the kernel, rather than a different arbitrary limit.

Depends how painful it is to support, I guess.

[...]

Cheers
---Dave

