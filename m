Received: from eggs.gnu.org ([2001:4830:134:3::10]:41967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cLy5m-0002CM-HO
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:11:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cLy5l-0004pt-Mm
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:11:26 -0500
Received: from smtp5-g21.free.fr ([2a01:e0c:1:1599::14]:33458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1cLy5l-0004pH-FN
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:11:25 -0500
References: <87inqavlzj.fsf@mail.parknet.co.jp>
	<feca54b3-9c38-4ce7-4edc-b1f9f88fb7a1@reactos.org>
	<87fuletg61.fsf@mail.parknet.co.jp>
	<f8044f23-52ef-89f8-5ca7-b27de2989cc7@reactos.org>
	<8737h9xidn.fsf@mail.parknet.co.jp>
	<87mvfhw3i0.fsf_-_@mail.parknet.co.jp>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <7bc68d55-1d6c-ee2c-7c19-4f1e128afd1e@reactos.org>
Date: Tue, 27 Dec 2016 21:11:07 +0100
MIME-Version: 1.0
In-Reply-To: <87mvfhw3i0.fsf_-_@mail.parknet.co.jp>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] ps2: Fix lost scancodes by recent
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>

Le 27/12/2016 =E0 20:55, OGAWA Hirofumi a =E9crit :
>
> With "ps2: use QEMU qcodes instead of scancodes", key handling was
> changed to qcode base. But all scancodes are not converted to new one.
>
> This adds some missing qcodes/scancodes what I found in using.
>
> [set1 and set3 are from <hpoussin@reactos.org>]
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


Reviewed-by: Herv=E9 Poussineau <hpoussin@reactos.org>
