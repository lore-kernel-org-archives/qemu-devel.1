Received: from eggs.gnu.org ([2001:4830:134:3::10]:37845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cE38q-0001gC-MV
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cE38n-00081W-Ls
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:57:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cE38n-00081O-DV
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 18:57:49 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DA21C0567B5
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 23:57:48 +0000 (UTC)
Date: Mon, 5 Dec 2016 21:57:45 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161205235745.GJ13060@thinpad.lan.raisama.net>
References: <1480713496-11213-1-git-send-email-ehabkost@redhat.com>
	<1480713496-11213-16-git-send-email-ehabkost@redhat.com>
	<df0f3ade-bd09-58a0-ac83-3775d4ab7c6c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <df0f3ade-bd09-58a0-ac83-3775d4ab7c6c@redhat.com>
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

On Mon, Dec 05, 2016 at 07:18:47PM +0100, David Hildenbrand wrote:
> Am 02.12.2016 um 22:18 schrieb Eduardo Habkost:
> > The query-cpu-model-expand QMP command needs at least one static
> > model, to allow the "static" expansion mode to be implemented.
> > Instead of defining static versions of every CPU model, define a
> > "base" CPU model that has absolutely no feature flag enabled.
> >=20
>=20
> Introducing separate ones makes feature lists presented to the user much
> shorter (and therefore easier to maintain). But I don't know how libvirt
> wants to deal with models on x86 in the future.

I understand that having a larger set of static models would make
expansions shorter. But I worry that by defining a complete set
of static models on x86 would require extra maintenance work on
the QEMU side with no visible benefit for libvirt.

I would like to hear from libvirt developers what they think. I
still don't know what they plan to use the type=3Dstatic expansion
results for.

>=20
> How long is the static expansion on a recent intel CPU?

CPU model "Broadwell" returns 165 entries on return.model.props:

(QEMU) query-cpu-model-expansion type=3Dstatic model=3D{"name":"Broadwell"}
{"return": {"migration-safe": true, "model": {"name": "base", "props": {"pf=
threshold": false, "pku": false, "rtm": true, "tsc-deadline": true, "xstore=
-en": false, "tsc-scale": false, "abm": true, "ia64": false, "kvm-mmu": fal=
se, "xsaveopt": true, "tce": false, "smep": true, "fpu": true, "xcrypt": fa=
lse, "clflush": true, "flushbyasid": false, "kvm-steal-time": false, "lm": =
true, "tsc": true, "adx": true, "fxsr": true, "tm": false, "xgetbv1": false=
, "xstore": false, "vme": false, "vendor": "GenuineIntel", "arat": true, "d=
e": true, "aes": true, "pse": true, "ds-cpl": false, "tbm": false, "sse": t=
rue, "phe-en": false, "f16c": true, "ds": false, "mpx": false, "tsc-adjust"=
: false, "avx512f": false, "avx2": true, "pbe": false, "cx16": true, "avx51=
2pf": false, "movbe": true, "perfctr-nb": false, "ospke": false, "avx512ifm=
a": false, "stepping": 2, "sep": true, "sse4a": false, "avx512dq": false, "=
avx512-4vnniw": false, "xsave": true, "pmm": false, "hle": true, "est": fal=
se, "xop": false, "smx": false, "monitor": false, "avx512er": false, "apic"=
: true, "sse4.1": true, "sse4.2": true, "pause-filter": false, "lahf-lm": t=
rue, "kvm-nopiodelay": false, "acpi": false, "mmx": true, "osxsave": false,=
 "pcommit": false, "mtrr": true, "clwb": false, "dca": false, "pdcm": false=
, "xcrypt-en": false, "3dnow": false, "invtsc": false, "tm2": false, "hyper=
visor": true, "kvmclock-stable-bit": false, "fxsr-opt": false, "pcid": true=
, "lbrv": false, "avx512-4fmaps": false, "svm-lock": false, "popcnt": true,=
 "nrip-save": false, "avx512vl": false, "x2apic": true, "kvmclock": false, =
"smap": true, "family": 6, "min-level": 13, "dtes64": false, "ace2": false,=
 "fma4": false, "xtpr": false, "avx512bw": false, "nx": true, "lwp": false,=
 "msr": true, "ace2-en": false, "decodeassists": false, "perfctr-core": fal=
se, "pge": true, "pn": false, "fma": true, "nodeid-msr": false, "cx8": true=
, "mce": true, "avx512cd": false, "cr8legacy": false, "mca": true, "pni": t=
rue, "rdseed": true, "osvw": false, "fsgsbase": true, "model-id": "Intel Co=
re Processor (Broadwell)", "cmp-legacy": false, "kvm-pv-unhalt": false, "rd=
tscp": true, "mmxext": false, "cid": false, "vmx": false, "ssse3": true, "e=
xtapic": false, "pse36": true, "min-xlevel": 2147483656, "ibs": false, "avx=
": true, "syscall": true, "umip": false, "invpcid": true, "bmi1": true, "bm=
i2": true, "vmcb-clean": false, "erms": true, "cmov": true, "misalignsse": =
false, "clflushopt": false, "pat": true, "3dnowprefetch": true, "rdpid": fa=
lse, "pae": true, "wdt": false, "skinit": false, "pmm-en": false, "phe": fa=
lse, "3dnowext": false, "lmce": false, "ht": false, "pdpe1gb": false, "kvm-=
pv-eoi": false, "npt": false, "xsavec": false, "pclmulqdq": true, "svm": fa=
lse, "sse2": true, "ss": false, "topoext": false, "rdrand": true, "avx512vb=
mi": false, "kvm-asyncpf": false, "xsaves": false, "model": 61}}, "static":=
 true}}


--=20
Eduardo
