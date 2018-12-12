Received: from eggs.gnu.org ([2001:4830:134:3::10]:53407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gX6Ob-0002fn-1U
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:25:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gX6OW-0001ia-48
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:25:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gX6OU-0001gC-4P
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:25:51 -0500
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-23-git-send-email-pbonzini@redhat.com>
	<f999872d-d940-7093-3c4c-f245e27c803f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <217295f3-ca0e-af08-face-08144088e27d@redhat.com>
Date: Wed, 12 Dec 2018 16:25:41 +0100
MIME-Version: 1.0
In-Reply-To: <f999872d-d940-7093-3c4c-f245e27c803f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 22/71] tests/libqos: sdhci driver and
 interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 12/12/18 15:35, Philippe Mathieu-Daud=C3=A9 wrote:
>> +}
>> +
>> +static void qsdhci_register_nodes(void)
>> +{
>> +    QPCIAddress addr =3D {
>> +        .devfn =3D QPCI_DEVFN(4, 0),
>> +        .vendor_id =3D PCI_VENDOR_ID_REDHAT,
>> +        .device_id =3D PCI_DEVICE_ID_REDHAT_SDHCI,
>> +    };
>> +
>> +    QOSGraphEdgeOptions opts =3D {
>> +        .extra_device_opts =3D "addr=3D04.0",
> Shouldn't this be formatted from the previous QPCIAddress?
>=20

Maybe, but there isn't a way to couple the two for now.  A device
address allocator is on the todo list. :)

Paolo
