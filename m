Received: from eggs.gnu.org ([2001:4830:134:3::10]:42240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gJR2j-0006xe-RX
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gJR2e-0008WC-3k
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:38:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gJR2d-0008Qx-Rc
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:38:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so7460994wre.1
	for <qemu-devel@nongnu.org>; Sun, 04 Nov 2018 14:38:38 -0800 (PST)
References: <20181104112424.18663-1-stefanha@redhat.com>
	<20181104112424.18663-2-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <870a4d46-0044-bab9-38a6-a65714803d2e@redhat.com>
Date: Sun, 4 Nov 2018 23:38:35 +0100
MIME-Version: 1.0
In-Reply-To: <20181104112424.18663-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 1/8] README: use 'https://' instead of
 'git://'
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
> Reported-by: Jann Horn <jannh@google.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   README         | 4 ++--
>   pc-bios/README | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/README b/README
> index 49a9fd09cd..441c33eb2f 100644
> --- a/README
> +++ b/README
> @@ -54,7 +54,7 @@ Submitting patches
>   
>   The QEMU source code is maintained under the GIT version control system.
>   
> -   git clone git://git.qemu.org/qemu.git
> +   git clone https://git.qemu.org/git/qemu.git
>   
>   When submitting patches, one common approach is to use 'git
>   format-patch' and/or 'git send-email' to format & send the mail to the
> @@ -70,7 +70,7 @@ the QEMU website
>   
>   The QEMU website is also maintained under source control.
>   
> -  git clone git://git.qemu.org/qemu-web.git
> +  git clone https://git.qemu.org/git/qemu-web.git
>     https://www.qemu.org/2017/02/04/the-new-qemu-website-is-up/
>   
>   A 'git-publish' utility was created to make above process less
> diff --git a/pc-bios/README b/pc-bios/README
> index 90f0fa7aa7..b572e9eb00 100644
> --- a/pc-bios/README
> +++ b/pc-bios/README
> @@ -23,7 +23,7 @@
>     legacy x86 software to communicate with an attached serial console as
>     if a video card were attached.  The master sources reside in a subversion
>     repository at http://sgabios.googlecode.com/svn/trunk.  A git mirror is
> -  available at git://git.qemu.org/sgabios.git.
> +  available at https://git.qemu.org/git/sgabios.git.
>   
>   - The PXE roms come from the iPXE project. Built with BANNER_TIME 0.
>     Sources available at http://ipxe.org.  Vendor:Device ID -> ROM mapping:
> @@ -40,7 +40,7 @@
>   
>   - The u-boot binary for e500 comes from the upstream denx u-boot project where
>     it was compiled using the qemu-ppce500 target.
> -  A git mirror is available at: git://git.qemu.org/u-boot.git
> +  A git mirror is available at: https://git.qemu.org/git/u-boot.git
>     The hash used to compile the current version is: 2072e72
>   
>   - Skiboot (https://github.com/open-power/skiboot/) is an OPAL
> 
