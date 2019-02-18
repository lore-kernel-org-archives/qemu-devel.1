Received: from eggs.gnu.org ([209.51.188.92]:46997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gvq42-0007Gh-5l
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:02:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gvq41-00069p-8u
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:02:58 -0500
References: <d5dc1bda-6b43-cbd6-3faa-69bb0ae45af4@howtolinux.de>
From: John Snow <jsnow@redhat.com>
Message-ID: <2c817163-f940-98f9-ad6e-5da1f70baf99@redhat.com>
Date: Mon, 18 Feb 2019 15:54:58 -0500
MIME-Version: 1.0
In-Reply-To: <d5dc1bda-6b43-cbd6-3faa-69bb0ae45af4@howtolinux.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Please help corrupt filesystem image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Marx <copymaster@howtolinux.de>, qemu-devel@nongnu.org
Cc: Qemu-block <qemu-block@nongnu.org>



On 2/16/19 10:54 PM, Alexander Marx wrote:
> Dear List!
>=20
> I have a big problem and hope you can help me.
> I built a new windows 2016 domain with virtual servers. 2 dc and 9 rds
> hosts.
> I was nearly finished with the setup and ready to migrate the users fro=
m
> old to new domain.
>=20
> Then i had to restart the physical servers. Unfortunately 1 dc and 2 rd=
s
> hosts could not be startet anymore.
> Error says:
>=20
> qemu-img: Could not open 'vm-150-disk-0.qcow2': Could not read qcow2
> header: Input/output error
>=20
> Even worst, a qemu-img check=C2=A0 also gave that error. and i was not =
able
> to do anything i found in the internet to fix it.
> always that error or the qemu-img could not determine the format.
>=20
> Is there a chance to fix these images? What can i do?
>=20
> I have no backup because the domain was not fully configured. But if i
> have to rebuild the whole domain, i will need several weeks for it.
> Any help is appreciated.
>=20
> Thank you
>=20
> Alex
>=20

What versions of QEMU were you running?
What filesystem were these images stored on?
What happened at the time of the corruption, is there some detail that
might help explain the nature of the corruption? Did you shut down the
physical host while the VMs were still running?

There may not be a way to recover these images, but we should probably
make sure that your configuration isn't unsafe to prevent this kind of
problem in the future.
