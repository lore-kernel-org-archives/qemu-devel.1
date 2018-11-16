Received: from eggs.gnu.org ([2001:4830:134:3::10]:43710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <etienne.duble@imag.fr>) id 1gNhG6-0004YQ-Qa
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <etienne.duble@imag.fr>) id 1gNhG1-0006et-V1
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:46:18 -0500
Received: from zm-mta-out-1.u-ga.fr ([152.77.200.56]:43317)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <etienne.duble@imag.fr>)
	id 1gNhG0-0006ch-3S
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 11:46:13 -0500
References: <04fcf478-29c3-67be-74bb-fd26975fe441@imag.fr>
	<20181116154136.GA19765@flamenco>
From: =?UTF-8?Q?Etienne_Dubl=c3=a9?= <etienne.duble@imag.fr>
Message-ID: <ace60b30-2987-cf59-8d5b-29692a7a049a@imag.fr>
Date: Fri, 16 Nov 2018 17:46:09 +0100
MIME-Version: 1.0
In-Reply-To: <20181116154136.GA19765@flamenco>
Content-Language: fr
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu-user performance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 16/11/2018 16:41, Emilio G. Cota wrote:
> There's a recent paper that implements something similar to what you
> propose:
>
>    "A General Persistent Code Caching Framework for Dynamic Binary
>    Translation (DBT)", ATC'16
>    https://www.usenix.org/system/files/conference/atc16/atc16_paper-wan=
g.pdf
Interesting. Thanks for the link.

> Note that in that paper they compare against HQEMU, and not against
> upstream QEMU. I presume they chose HQEMU because it spends
> more effort than QEMU in trying to generate better code for hot
> code paths (they use LLVM in a separate thread for those), which
> means that code generation can be a bottleneck for some workloads
> (e.g. SPEC's gcc or perlbench).
>
> QEMU, on the other hand, generates much simpler code, and as a result
> it is rare to find workloads where code generation is a bottleneck.
> (You can measure this with perf top in your system; make sure you
> configured QEMU with --disable-strip to keep the symbols after
> "make install".)
> So until QEMU gets some sort of "hot code optimization" that makes
> translation more expensive, there's little point in implementing
> persistent code caching for it.
I see.

> As an aside, what QEMU version are you running? Performance has
> improved quite a bit (particularly for integer workloads) in the
> last couple of years, e.g. see the perf improvements from v2.6 to
> v2.11 here:
>    https://imgur.com/a/5P5zj
Various versions.
I am the tech leader of WalT project (https://walt-project.liglab.fr/)=20
which allows to build network experimentation testbeds. Nodes are either=20
Raspberry Pi boards, or any PC booted with our custom USB key, or=20
virtual devices (based on kvm). We package OS of nodes as docker images.=20
This allows to easily share them (handy for experiment reproducibility),=20
and to let users easily create/modify such an OS. When the user wants to=20
modify the docker image of a raspberry pi board, this is where qemu=20
comes in. So actually the qemu version we have in the image depends when=20
it was first built.
I did not know the performance improvement has been so important in=20
these last years.
Thanks.
Etienne

--=20
Etienne Dubl=C3=A9
CNRS / LIG - B=C3=A2timent IMAG
700 avenue Centrale - 38401 St Martin d'H=C3=A8res
Bureau 426 - Tel 0457421431
