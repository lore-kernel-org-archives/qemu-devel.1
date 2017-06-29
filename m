Received: from eggs.gnu.org ([2001:4830:134:3::10]:49470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQbni-0005BH-9Z
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dQbne-0006qT-E7
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 11:56:14 -0400
References: <20170629150308.22766-1-f4bug@amsat.org>
	<20170629150308.22766-3-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e2dba5c3-ab08-f4c4-3b1f-7bd82d093399@redhat.com>
Date: Thu, 29 Jun 2017 17:56:00 +0200
MIME-Version: 1.0
In-Reply-To: <20170629150308.22766-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/5] MAINTAINERS: update KVM entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>, Yang Zhong <yang.zhong@intel.com>
Cc: qemu-trivial@nongnu.org

On 29.06.2017 17:03, Philippe Mathieu-Daud=C3=A9 wrote:
> moved in 92229a57 to accel/
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 06006fc7df..86a08c5aac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -273,8 +273,8 @@ Overall
>  M: Paolo Bonzini <pbonzini@redhat.com>
>  L: kvm@vger.kernel.org
>  S: Supported
> -F: kvm-*
>  F: */kvm.*

While you're at it ... what's the */kvm.* good for nowadays? Was this
though for the target-*/kvm.c files? If so, we should update this to
target/*/kvm* instead.

> +F: accel/kvm/
>  F: include/sysemu/kvm*.h

Maybe also add an entry for scripts/kvm ?

 Thomas
