Received: from eggs.gnu.org ([2001:4830:134:3::10]:39674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1e5Xe0-0003VP-41
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1e5Xdv-000797-8p
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:47:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1e5Xdv-00077r-2K
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 09:47:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6831F883C5
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 13:47:17 +0000 (UTC)
References: <20171018095807.101406-1-marcel@redhat.com>
	<69cefa98-5681-5b12-719c-e13fcba969c4@redhat.com>
	<9d4b1fa8-e670-556b-278d-4993ad41b512@redhat.com>
	<1508418225.18146.1.camel@redhat.com>
	<d231ac0a-bb7d-78aa-ddb4-8048cc7bdfd8@redhat.com>
	<1508482525.18146.6.camel@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <f58bd55b-5a32-bbe1-90e6-79c5b1036355@redhat.com>
Date: Fri, 20 Oct 2017 16:47:01 +0300
MIME-Version: 1.0
In-Reply-To: <1508482525.18146.6.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/pci-host: Fix x86 Host Bridges 64bit
 PCI hole
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, Igor Mammedov <imammedo@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi Gerd,

On 20/10/2017 9:55, Gerd Hoffmann wrote:
>    Hi,
>=20
>>> commit message says:
>>>
>>> <quote>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0It turns out that some 32 bit windows =
guests crash
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if 64 bit PCI hole size is >2G.
>>> </quote>
>>>
>>> Why this suddenly isn't a problem any more?
>>>
>>
>> I suppose it is, so we need a way to turn it "off".
>=20
> Or have machine types behave differently, i.e. give q35 a large 64bit
> hole and leave pc as-is.
>=20
> Devices with that large bars are most likely pci express anyway ...
>=20

Agreed

>> This is how I started, however Eduardo and (and maybe Michael ?)
>> where against letting the upper management software to deal with
>> such a low low level detail. They simply can't take such a decision.
>> This is why the property you mentioned is not ever linked
>> in code anywhere! It is simply not implemented and not used.
>=20
> Makes sense.
>=20
> BTW:  Is it safe to just assume 40 bits physical is going to work?  My
> workstation:
>=20
> model name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: Intel(R) Core(TM) i7-77=
00K CPU @ 4.20GHz
> address sizes=C2=A0=C2=A0=C2=A0: 39 bits physical, 48 bits virtual
>=20
> Does this imply ept is limited 39 bits physical too?
>=20

The guest will still run with 40 bits physical!
(judging the code anyway, I hope I am wrong)

Then, the stakes are not so big, the Guest kernel will disregard
the 64bit hole since is not CPU addressable and go on.
At least Linux does it, but I think Win10 also can leave with that.

Thanks,
Marcel

> cheers,
>    Gerd
>=20
