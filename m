Received: from eggs.gnu.org ([209.51.188.92]:33108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gitHl-0001s3-Pq
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 22:51:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gitHk-00022z-T6
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 22:51:37 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17718
	helo=sender1.zoho.com.cn) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fam@euphon.net>) id 1gitHj-0001ur-L6
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 22:51:36 -0500
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Fam Zheng <fam@euphon.net>
In-Reply-To: <20190109135917.GP3998@redhat.com>
Date: Mon, 14 Jan 2019 11:50:08 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3EA5405-A5EE-4E77-8C77-A67398756B96@euphon.net>
References: <20181031025712.18602-1-famz@redhat.com>
	<4f6eb24d-fe13-cbf3-907e-6b3e566e33f4@comstyle.com>
	<20181114095807.GB22784@magic> <20190109135504.GA12179@redhat.com>
	<20190109135917.GP3998@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Fam Zheng <famz@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Brad Smith <brad@comstyle.com>, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org



> On Jan 9, 2019, at 21:59, Daniel P. Berrang=C3=A9 =
<berrange@redhat.com> wrote:
>=20
> On Wed, Jan 09, 2019 at 01:55:04PM +0000, Daniel P. Berrang=C3=A9 =
wrote:
>> On Wed, Nov 14, 2018 at 05:58:07PM +0800, Fam Zheng wrote:
>>> On Sun, 11/11 18:20, Brad Smith wrote:
>>>> ping.
>>>=20
>>> Queued. Will send a pull request soon.
>>=20
>> ping, this seems to have got lost, and is blocking us deleting SDL =
1.2
>> support from QEMU.
>=20
> Sigh, never mind, I found the PR is here:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00732.html

I had to drop it from the queue because Peter didn=E2=80=99t like the =
QEMU version requirement (for the slirp tftp parameters). :(

What is the blocker for delete SDL 1.2? Is it breaking tests/vm/openbsd? =
If so maybe we can add =E2=80=94disable-sdl to its configure command.

Fam

>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    =
https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            =
https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    =
https://www.instagram.com/dberrange :|
>=20
