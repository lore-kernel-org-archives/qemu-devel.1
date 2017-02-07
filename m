Received: from eggs.gnu.org ([2001:4830:134:3::10]:33543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cb2Oh-0001Wy-Rr
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cb2Oe-0005b8-PL
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:49:15 -0500
Received: from greensocs.com ([193.104.36.180]:35081)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cb2Oe-0005b2-IH
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 04:49:12 -0500
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
	<1485424060-12217-3-git-send-email-fred.konrad@greensocs.com>
	<6b974238-ab18-8bd5-ffe7-6f07627f59f3@kaod.org>
	<5850976f-7e05-dbcf-3fdf-cf9d11038b3d@greensocs.com>
	<682b8d3a-bf00-012e-a79e-434358d181bb@kaod.org>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <3ba3245f-6b03-affe-6fee-d80ecabd3d39@greensocs.com>
Date: Tue, 7 Feb 2017 10:49:10 +0100
MIME-Version: 1.0
In-Reply-To: <682b8d3a-bf00-012e-a79e-434358d181bb@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 02/10] qemu-clk: allow to add a clock to
 a device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.burton@greensocs.com, qemu-devel@nongnu.org, alistair.francis@xilinx.com

On 02/07/2017 10:31 AM, C=E9dric Le Goater wrote:
> On 02/07/2017 10:22 AM, Frederic Konrad wrote:
>>> I see how these routines are used in patch 10/10. But if we were
>>> open coding device CRF_APB, I don't think we would need them at
>>> all and it would make the code a little simple IMHO.
>> What do you mean by open coding?
>=20
> I mean to externalize the definition of the objects in a=20
> header file.=20
>=20
> Then you can replace the type 'Object *' of the attribute=20
> holding a reference to an instance by a non pointer type.
>=20
> Anyhow, I think we need to replace object_new() by=20
> object_initialize() for QOM, and so we need to expose a=20
> little more the object internals.=20

Ok got you.

I'll take a look.

Thanks,
Fred

>=20
> Thanks,
>=20
> C.
>=20
>=20
