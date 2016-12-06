Received: from eggs.gnu.org ([2001:4830:134:3::10]:37370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cEF60-0002Bs-53
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:43:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cEF5v-0005uj-RT
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:43:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cEF5v-0005uT-JZ
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:43:39 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8628E6DDED
	for <qemu-devel@nongnu.org>; Tue,  6 Dec 2016 12:43:38 +0000 (UTC)
Date: Tue, 6 Dec 2016 10:43:36 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161206124336.GL13060@thinpad.lan.raisama.net>
References: <1480713496-11213-1-git-send-email-ehabkost@redhat.com>
	<1480713496-11213-16-git-send-email-ehabkost@redhat.com>
	<df0f3ade-bd09-58a0-ac83-3775d4ab7c6c@redhat.com>
	<20161205235745.GJ13060@thinpad.lan.raisama.net>
	<862e80d2-d0f9-668f-d6ed-b25712a220c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <862e80d2-d0f9-668f-d6ed-b25712a220c1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 15/17] target-i386: Define static
 "base" CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, Jiri Denemark <jdenemar@redhat.com>

On Tue, Dec 06, 2016 at 10:32:48AM +0100, David Hildenbrand wrote:
[...]
> >=20
> > I would like to hear from libvirt developers what they think. I
> > still don't know what they plan to use the type=3Dstatic expansion
> > results for.
> >=20
> > >=20
> > > How long is the static expansion on a recent intel CPU?
> >=20
> > CPU model "Broadwell" returns 165 entries on return.model.props:
> >=20
> > (QEMU) query-cpu-model-expansion type=3Dstatic model=3D{"name":"Broadwe=
ll"}
>=20
> > {"return": {"migration-safe": true, "model": {"name": "base", "props": =
{"pfthreshold": false, "pku": false, "rtm": true, "tsc-deadline": true, "xs=
tore-en": false, "tsc-scale": false, "abm": true, "ia64": false, "kvm-mmu":=
 false, "xsaveopt": true, "tce": false, "smep": true, "fpu": true, "xcrypt"=
: false, "clflush": true, "flushbyasid": false, "kvm-steal-time": false, "l=
m": true, "tsc": true, "adx": true, "fxsr": true, "tm": false, "xgetbv1": f=
alse, "xstore": false, "vme": false, "vendor": "GenuineIntel", "arat": true=
, "de": true, "aes": true, "pse": true, "ds-cpl": false, "tbm": false, "sse=
": true, "phe-en": false, "f16c": true, "ds": false, "mpx": false, "tsc-adj=
ust": false, "avx512f": false, "avx2": true, "pbe": false, "cx16": true, "a=
vx512pf": false, "movbe": true, "perfctr-nb": false, "ospke": false, "avx51=
2ifma": false, "stepping": 2, "sep": true, "sse4a": false, "avx512dq": fals=
e, "avx512-4vnniw": false, "xsave": true, "pmm": false, "hle": true, "est":=
 false, "xop": false, "smx": false, "monitor": false, "avx512er": false, "a=
pic": true, "sse4.1": true, "sse4.2": true, "pause-filter": false, "lahf-lm=
": true, "kvm-nopiodelay": false, "acpi": false, "mmx": true, "osxsave": fa=
lse, "pcommit": false, "mtrr": true, "clwb": false, "dca": false, "pdcm": f=
alse, "xcrypt-en": false, "3dnow": false, "invtsc": false, "tm2": false, "h=
ypervisor": true, "kvmclock-stable-bit": false, "fxsr-opt": false, "pcid": =
true, "lbrv": false, "avx512-4fmaps": false, "svm-lock": false, "popcnt": t=
rue, "nrip-save": false, "avx512vl": false, "x2apic": true, "kvmclock": fal=
se, "smap": true, "family": 6, "min-level": 13, "dtes64": false, "ace2": fa=
lse, "fma4": false, "xtpr": false, "avx512bw": false, "nx": true, "lwp": fa=
lse, "msr": true, "ace2-en": false, "decodeassists": false, "perfctr-core":=
 false, "pge": true, "pn": false, "fma": true, "nodeid-msr": false, "cx8": =
true, "mce": true, "avx512cd": false, "cr8legacy": false, "mca": true, "pni=
": true, "rdseed": true, "osvw": false, "fsgsbase": true, "model-id": "Inte=
l Core Processor (Broadwell)", "cmp-legacy": false, "kvm-pv-unhalt": false,=
 "rdtscp": true, "mmxext": false, "cid": false, "vmx": false, "ssse3": true=
, "extapic": false, "pse36": true, "min-xlevel": 2147483656, "ibs": false, =
"avx": true, "syscall": true, "umip": false, "invpcid": true, "bmi1": true,=
 "bmi2": true, "vmcb-clean": false, "erms": true, "cmov": true, "misalignss=
e": false, "clflushopt": false, "pat": true, "3dnowprefetch": true, "rdpid"=
: false, "pae": true, "wdt": false, "skinit": false, "pmm-en": false, "phe"=
: false, "3dnowext": false, "lmce": false, "ht": false, "pdpe1gb": false, "=
kvm-pv-eoi": false, "npt": false, "xsavec": false, "pclmulqdq": true, "svm"=
: false, "sse2": true, "ss": false, "topoext": false, "rdrand": true, "avx5=
12vbmi": false, "kvm-asyncpf": false, "xsaves": false, "model": 61}}, "stat=
ic": true}}
> >=20
> >=20
>=20
> Wow, yes that was the reason for me to introduce abstractions on s390x. B=
ut
> here the plan was to use the epansion directly when indication the
> "host" model to the user. Having something like "Broadwell-base"+/- a
> handful of features is just easier to handle than "base" with 165 feature
> flags. But as we don't know what libvirt plans are (they could use that
> interface on x86 to do feature detection only and convert to models
> themselves), I also have no idea what would be best in the context of x86
> cpu models.

In the case of x86, libvirt already has their own database of
"static" CPU models in /usr/share/libvirt/cpu_map.xml. Maybe
providing our own set of static CPU models would be helpful if
they want to get rid of their database. But I'm not sure if:
1) they want to do that in the near future; 2) how easily they
could keep compatibility with their existing model names while
doing that.

--=20
Eduardo
