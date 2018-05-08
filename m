Received: from eggs.gnu.org ([2001:4830:134:3::10]:34732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fG4Ts-0006Zb-Ge
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:24:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fG4Tp-0008AT-Ah
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:24:44 -0400
References: <20180508151035.16774-1-f4bug@amsat.org>
	<20180508151035.16774-2-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0f2eb270-8541-05e3-bdba-4c294c057a39@redhat.com>
Date: Tue, 8 May 2018 17:24:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180508151035.16774-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/4] typedefs: Remove PcGuestInfo from
 qemu/typedefs.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S . Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>

On 08.05.2018 17:10, Philippe Mathieu-Daud=C3=A9 wrote:
> It is long gone since e4e8ba04c2007 ...
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/qemu/typedefs.h | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index a46b0b347b..325c72de33 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -62,7 +62,6 @@ typedef struct NetClientState NetClientState;
>  typedef struct NetFilterState NetFilterState;
>  typedef struct NICInfo NICInfo;
>  typedef struct NumaNodeMem NumaNodeMem;
> -typedef struct PcGuestInfo PcGuestInfo;
>  typedef struct PCIBridge PCIBridge;
>  typedef struct PCIBus PCIBus;
>  typedef struct PCIDevice PCIDevice;
>=20

No need to mark this patch as RFC - this is certainly a good idea.

Reviewed-by: Thomas Huth <thuth@redhat.com>
