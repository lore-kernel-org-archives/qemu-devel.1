Received: from eggs.gnu.org ([2001:4830:134:3::10]:49249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1da3WW-00055C-5I
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1da3WS-0002Ba-41
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:21:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1da3WR-0002BO-Tc
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:21:28 -0400
References: <20170725150951.16038-1-ldoktor@redhat.com>
	<20170725150951.16038-3-ldoktor@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <57520d2b-c04c-ccc0-8bb5-5331217efe86@redhat.com>
Date: Tue, 25 Jul 2017 13:14:25 -0400
MIME-Version: 1.0
In-Reply-To: <20170725150951.16038-3-ldoktor@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/10] qemu|qtest: Avoid dangerous
 arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, armbru@redhat.com, apahim@redhat.com, f4bug@amsat.org, mreitz@redhat.com



On 07/25/2017 11:09 AM, Luk=C3=A1=C5=A1 Doktor wrote:
> The list object is mutable in python and potentially might modify other
> object's arguments when used as default argument. Reproducer:
>=20
>      >>> vm1 =3D QEMUMachine("qemu")
>      >>> vm2 =3D QEMUMachine("qemu")
>      >>> vm1._wrapper.append("foo")
>      >>> print vm2._wrapper
>      ['foo']
>=20
> In this case the `args` is actually copied so it would be safe to keep
> it, but it's not a good practice to keep it. The same issue applies in
> inherited qtest module.
>=20

ohh, grr, this trips me up in Python all the time. Definitely best to=20
remove such usages where possible.

> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>
