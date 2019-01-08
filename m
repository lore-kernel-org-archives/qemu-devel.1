Received: from eggs.gnu.org ([209.51.188.92]:35392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggplN-0003JT-P8
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:41:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggplM-0006NA-9G
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:41:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggplL-0005gQ-A9
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:41:39 -0500
Date: Tue, 8 Jan 2019 12:41:13 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190108114113.2kzkelv5sguubkk7@sirius.home.kraxel.org>
References: <20190103132605.49476-1-liq3ea@163.com>
	<0cecbd74-2fe7-6bda-d92e-f7ba8e912800@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0cecbd74-2fe7-6bda-d92e-f7ba8e912800@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] usb: dev-mtp: fix memory leak in error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Li Qiang <liq3ea@163.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org

On Thu, Jan 03, 2019 at 02:38:25PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 1/3/19 2:26 PM, Li Qiang wrote:
> > Spotted by Coverity: CID 1397074
> >=20
>=20
> Gerd, if you take this, can you add:
>=20
> Fixes: c52d46e041b

Done. Thanks for looking up.

cheers,
  Gerd
