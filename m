Received: from eggs.gnu.org ([2001:4830:134:3::10]:34489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnRKH-0007i5-6t
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnRKD-0007zk-8Y
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:24:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dnRKD-0007zE-1S
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 11:24:09 -0400
References: <20170831035306.29170-1-f4bug@amsat.org>
	<20170831035306.29170-2-f4bug@amsat.org>
	<be9ca245-f1af-e78a-aa12-c479e59b2985@redhat.com>
	<800abf63-db3f-78c7-0580-8d86479fdf5a@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5c9b4445-4870-a99f-058b-6de82959b302@redhat.com>
Date: Thu, 31 Aug 2017 17:23:55 +0200
MIME-Version: 1.0
In-Reply-To: <800abf63-db3f-78c7-0580-8d86479fdf5a@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] serial: add serial_chr_nonnull() to
 use the null backend when none provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>

On 31.08.2017 17:20, Philippe Mathieu-Daud=C3=A9 wrote:
> On 08/31/2017 02:19 AM, Thomas Huth wrote:
>> On 31.08.2017 05:53, Philippe Mathieu-Daud=C3=A9 wrote:
> [...]>> +Chardev *serial_chr_nonnull(Chardev *chr)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 static int serial_id;
>>> +=C2=A0=C2=A0=C2=A0 char *label;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 label =3D g_strdup_printf("discarding-serial%d", =
serial_id++);
>>> +=C2=A0=C2=A0=C2=A0 chr =3D qemu_chr_new(label, "null");
>>
>> That looks wrong - you're ignoring the input parameter and always open
>> the "null" device? Shouldn't there be a "if (chr) return chr;" in fron=
t
>> of this?
>=20
> You right. I had this correct in my first patch when this code was
> embedded, I then failed at extracting as another function :/
>=20
>>
>>> +=C2=A0=C2=A0=C2=A0 assert(chr);
>>> +=C2=A0=C2=A0=C2=A0 g_free(label);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return chr;
>>> +}
>>
>> =C2=A0 Thomas
>>
>> PS: I think you should also merge the two patches together, they are
>> small enough.
>=20
> Ok.

Well, I wrote that comment about merging the two patches together when I
was thinking that your series consists of only two patches (since I've
only been CC:-ed on the first two patches). So please simply ignore that
suggestion :-)

 Thomas
