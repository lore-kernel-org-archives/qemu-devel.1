Received: from eggs.gnu.org ([2001:4830:134:3::10]:53644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eEuzY-0004sa-IB
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 05:32:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eEuzU-0004nc-Ou
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 05:32:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eEuzU-0004mI-IH
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 05:32:20 -0500
Date: Wed, 15 Nov 2017 11:32:06 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171115113206.6c782c71@nial.brq.redhat.com>
In-Reply-To: <e718178a-e42d-ce5c-0037-d27c08a3990e@cn.fujitsu.com>
References: <1510626841-9928-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20171114163050.70c752bd@nial.brq.redhat.com>
	<e718178a-e42d-ce5c-0037-d27c08a3990e@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6] NUMA: Enable adding NUMA node implicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Thomas Huth <thuth@redhat.com>, Takao Indoh <indou.takao@jp.fujitsu.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, f4bug@amsat.org, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair23@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>, Izumi Taku <izumi.taku@jp.fujitsu.com>, Richard Henderson <rth@twiddle.net>

On Wed, 15 Nov 2017 09:29:22 +0800
Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:

> Hi Igor,
>=20
> [...]
> >> +            parse_numa_node(ms, &node, NULL); =20
> > I get build break here:
> >
> > numa.c:451:13: error: too few arguments to function =E2=80=98parse_numa=
_node=E2=80=99
> >              parse_numa_node(ms, &node, NULL);
> > =20
>=20
> In upstream tree, your commit
>=20
>    cc001888b780 ("numa: fixup parsed NumaNodeOptions earlier")
>=20
> removed a argument from parse_numa_node() recently. this definition
> of function becomes
>=20
> static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>                              Error **errp)
>=20
> this patch is based on the upstream tree, parse_numa_node() should have
> three arguments.
>=20
> I am not sure why you got this building failure log, can you tell me
> which branch did you test?
it looks like I've failed to update master branch and applied it to old mas=
ter,
so after refetching and applying it again build and tests passes.

(Sorry for  noise :/)

>=20
> Thanks,
> 	dou
>=20
>=20
>=20
