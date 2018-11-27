Received: from eggs.gnu.org ([2001:4830:134:3::10]:57707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gRa8o-00053x-QN
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1gRa8k-0005v8-Ei
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 04:58:50 -0500
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 27 Nov 2018 09:58:40 +0000
Message-ID: <BN6PR2201MB12517471D0B4ADEE146C1414C6D00@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <20181125205000.10324-1-philmd@redhat.com>
	<20181125205000.10324-8-philmd@redhat.com>,
	<19bfc512-65ac-9968-3930-8b423efde241@redhat.com>
In-Reply-To: <19bfc512-65ac-9968-3930-8b423efde241@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH for-3.1 07/25] MAINTAINERS: Add a missing
 entry for the Fulong 2E machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, Stefan Markovic <smarkovic@wavecomp.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

I like better the patch that Thomas linked to. I think Philippe should have=
 included Thomas' patch, rather than creating new, overlapping, patches. Co=
nfusion about straitforward things! Aleksandar

________________________________________
From: Thomas Huth <thuth@redhat.com>
Sent: Tuesday, November 27, 2018 10:49:27 AM
To: Philippe Mathieu-Daud=E9; Aleksandar Markovic; Stefan Markovic
Cc: qemu-devel@nongnu.org; qemu-trivial@nongnu.org
Subject: Re: [PATCH for-3.1 07/25] MAINTAINERS: Add a missing entry for the=
 Fulong 2E machine

On 2018-11-25 21:49, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa17e9bbd3..81a22b2ccf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -864,6 +864,7 @@ R: Stefan Markovic <smarkovic@wavecomp.com>
>  S: Odd Fixes
>  F: hw/mips/mips_fulong2e.c
>  F: hw/isa/vt82c686.c
> +F: hw/pci-host/bonito.c
>
>  F: include/hw/isa/vt82c686.h

Please remove the empty line between bonito.c and vt82c686.h - or we
could use my patch here from last Thursday instead:

 https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg04526.html

 Thomas
