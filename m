Received: from eggs.gnu.org ([2001:4830:134:3::10]:40672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gJQy0-0002KF-Kj
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:34:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gJQxx-0000T0-GR
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:34:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gJQxx-0000QZ-9Y
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:33:57 -0500
Received: by mail-wr1-f65.google.com with SMTP id x12-v6so7416168wrw.8
	for <qemu-devel@nongnu.org>; Sun, 04 Nov 2018 14:33:57 -0800 (PST)
References: <20181104112424.18663-1-stefanha@redhat.com>
	<20181104112424.18663-7-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2c858c4a-ffb5-997f-1274-3aab0b211c50@redhat.com>
Date: Sun, 4 Nov 2018 23:33:54 +0100
MIME-Version: 1.0
In-Reply-To: <20181104112424.18663-7-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 6/8] pc-testdev: use HTTPS git URL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <jcody@redhat.com>, cohuck@redhat.com, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 4/11/18 12:24, Stefan Hajnoczi wrote:
> When you clone the repository without previous commit history, 'git://'
> doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
> since the client verifies the server certificate.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   hw/misc/pc-testdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/misc/pc-testdev.c b/hw/misc/pc-testdev.c
> index 697eb88c97..0aee04f231 100644
> --- a/hw/misc/pc-testdev.c
> +++ b/hw/misc/pc-testdev.c
> @@ -32,7 +32,7 @@
>    * -kernel /home/lmr/Code/virt-test.git/kvm/unittests/msr.flat
>    *
>    * Where msr.flat is one of the KVM unittests, present on a separate repo,
> - * git://git.kernel.org/pub/scm/virt/kvm/kvm-unit-tests.git
> + * https://git.kernel.org/pub/scm/virt/kvm/kvm-unit-tests.git
>   */
>   
>   #include "qemu/osdep.h"
> 
