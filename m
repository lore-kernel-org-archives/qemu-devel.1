Received: from eggs.gnu.org ([2001:4830:134:3::10]:34959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnlSC-0001AS-GD
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:58:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1fnlS8-0001tv-7g
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:58:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37604 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1fnlS8-0001tg-0r
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:58:12 -0400
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-6-e.emanuelegiuseppe@gmail.com>
	<f5a3c33f-f459-806c-1465-3b5415a5ccc1@redhat.com>
	<a848be63-1cde-3fe4-ad6a-5d56104f5590@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <75a9b0a8-bdb4-489e-c4fc-0538e14343b0@redhat.com>
Date: Thu, 9 Aug 2018 15:58:07 +0200
MIME-Version: 1.0
In-Reply-To: <a848be63-1cde-3fe4-ad6a-5d56104f5590@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/34] tests/qgraph: sdhci driver and
 interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele <e.emanuelegiuseppe@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 09/08/2018 15:27, Emanuele wrote:
>=20
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 QSDHCI_PCI *spci =3D (QSDHCI_PCI *)obj;
>>> +=C2=A0=C2=A0=C2=A0 qpci_device_enable(&spci->dev);
>>> +}
>>> +
>>> +static void sdhci_destroy(QOSGraphObject *obj)
>> "sdhci_pci_destructor()"?
> In general, I called the constructor name=C2=A0 *_create, so in theory =
to
> keep it consistent the destructor should be *_destroy, no?

Yes, but the field name in QOSGraphObject is "destructor".

You have:

    obj.get_device =3D XXX_get_device;
    obj.get_driver =3D XXX_get_driver;
    obj.start_hw   =3D XXX_start_hw;

So we can expect:

   obj.destructor =3D XXX_destructor;

Thanks,
Laurent
