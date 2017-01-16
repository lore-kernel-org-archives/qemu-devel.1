Received: from eggs.gnu.org ([2001:4830:134:3::10]:48132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cT0r1-0002JU-00
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 01:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cT0qx-0001kt-Tv
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 01:33:19 -0500
Received: from [45.249.212.189] (port=2379 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cT0qs-0001Mi-K8
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 01:33:15 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Mon, 16 Jan 2017 06:32:16 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA192515@DGGEMA505-MBX.china.huawei.com>
References: <1484375301-159804-1-git-send-email-longpeng2@huawei.com>
In-Reply-To: <1484375301-159804-1-git-send-email-longpeng2@huawei.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] cryptodev: setiv only when really need
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: longpeng <longpeng2@huawei.com>
Cc: "Wubin (H)" <wu.wubin@huawei.com>, "Zhoujian (jay, Euler)" <jianjay.zhou@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

>
> From: longpeng
> Sent: Saturday, January 14, 2017 2:28 PM
> To: Gonglei (Arei)
> Cc: Wubin (H); Zhoujian (jay, Euler); qemu-devel@nongnu.org; longpeng
> Subject: [PATCH] cryptodev: setiv only when really need
>=20
> ECB mode cipher doesn't need IV, if we setiv for it then qemu
> crypto API would report "Expected IV size 0 not **", so we should
> setiv only when the cipher algos really need.
>=20
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  backends/cryptodev-builtin.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
Queued.

Thanks,
-Gonglei
