Received: from eggs.gnu.org ([2001:4830:134:3::10]:49262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fDb21-0005aQ-1c
	for qemu-devel@nongnu.org; Tue, 01 May 2018 15:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fDb1w-00072V-Di
	for qemu-devel@nongnu.org; Tue, 01 May 2018 15:33:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34336 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fDb1w-00072G-7s
	for qemu-devel@nongnu.org; Tue, 01 May 2018 15:33:40 -0400
References: <20180419164642.9536-1-f4bug@amsat.org>
	<20180419164642.9536-5-f4bug@amsat.org>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <91f13b8a-c3ef-53da-efe5-87b938bec810@redhat.com>
Date: Tue, 1 May 2018 15:33:34 -0400
MIME-Version: 1.0
In-Reply-To: <20180419164642.9536-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 4/7] qemu.py: Avoid deprecated
 tempfile.mktemp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair23@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>



On 04/19/2018 12:46 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> We already have secure temporary directory created with tempfile.mkdtem=
p().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  scripts/qemu.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/qemu.py b/scripts/qemu.py
> index 379767b62f..26c4b1fd3b 100644
> --- a/scripts/qemu.py
> +++ b/scripts/qemu.py
> @@ -201,7 +201,8 @@ class QEMUMachine(object):
> =20
>          chardev =3D 'socket,id=3Dconsole,{address},server,nowait'
>          if console_address is None:
> -            console_address =3D tempfile.mktemp()
> +            console_address =3D os.path.join(self._temp_dir,
> +                                           self._name + "-console.sock=
")
>              chardev =3D chardev.format(address=3D'path=3D%s' %
>                                       console_address)
>          elif isinstance(console_address, tuple):
>=20

Acked-by: Cleber Rosa <crosa@redhat.com>
