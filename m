Received: from eggs.gnu.org ([209.51.188.92]:40133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1guhH1-0005Wj-Mj
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1guhGz-00072g-Ud
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:27:38 -0500
References: <20181218115615.1499-1-philmd@redhat.com>
	<20181218115615.1499-2-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a6acfd6f-52f2-1e45-52e4-81920f5949ee@redhat.com>
Date: Fri, 15 Feb 2019 18:27:08 +0100
MIME-Version: 1.0
In-Reply-To: <20181218115615.1499-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 01/12] MAINTAINERS: Add missing entries
 to the X86 section (AMD SEV)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>, Cornelia Huck <cohuck@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Luc Michel <luc.michel@greensocs.com>, Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On 18/12/2018 12.56, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Moved from TCG to KVM section
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 83c127f0d6..771b1c7b94 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -392,7 +392,9 @@ M: Marcelo Tosatti <mtosatti@redhat.com>
>  L: kvm@vger.kernel.org
>  S: Supported
>  F: target/i386/kvm.c
> +F: include/sysemu/sev.h

Shouldn't this then include target/i386/sev.c, too?

>  F: scripts/kvm/vmxcap
> +F: docs/amd-memory-encryption.txt

 Thomas
