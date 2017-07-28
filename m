Received: from eggs.gnu.org ([2001:4830:134:3::10]:35771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dazIC-00040N-6J
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dazI8-0000Ls-RE
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 03:02:36 -0400
References: <20170728053610.15770-1-f4bug@amsat.org>
	<20170728053610.15770-8-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <36f410cd-ef86-aa08-9922-5cbd1e565a54@redhat.com>
Date: Fri, 28 Jul 2017 09:02:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170728053610.15770-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/47] MAINTAINERS: add missing entry for
 vfio/ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 28.07.2017 07:35, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddf6f3f6d8..69987b5e5b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1029,6 +1029,7 @@ S: Supported
>  F: hw/vfio/ccw.c
>  F: hw/s390x/s390-ccw.c
>  F: include/hw/s390x/s390-ccw.h
> +F: linux-headers/linux/vfio_ccw.h

Again a linux-header ... I don't think we need an entry for this in
MAINTAINERS since the file is maintained in the Linux kernel instead.

 Thomas
