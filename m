Received: from eggs.gnu.org ([2001:4830:134:3::10]:41884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gJR1a-0004eT-L1
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gJR1U-0004hE-TJ
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:37:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gJR1P-0003lu-Au
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 17:37:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so7459516wre.1
	for <qemu-devel@nongnu.org>; Sun, 04 Nov 2018 14:37:24 -0800 (PST)
References: <20181104112424.18663-1-stefanha@redhat.com>
	<20181104112424.18663-3-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <510dfe45-427f-6ae1-d546-a035776a4c2e@redhat.com>
Date: Sun, 4 Nov 2018 23:37:21 +0100
MIME-Version: 1.0
In-Reply-To: <20181104112424.18663-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/8] get_maintainer: use 'https://'
 instead of 'git://'
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

Hi Stefan,

On 4/11/18 12:24, Stefan Hajnoczi wrote:
> When you clone the repository without previous commit history, 'git://'
> doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
> since the client verifies the server certificate.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   scripts/get_maintainer.pl | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 43fb5f512f..fc7275b9e2 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -1376,7 +1376,7 @@ sub vcs_exists {
>   	warn("$P: No supported VCS found.  Add --nogit to options?\n");
>   	warn("Using a git repository produces better results.\n");
>   	warn("Try latest git repository using:\n");
> -	warn("git clone git://git.qemu.org/qemu.git\n");
> +	warn("git clone https//git.qemu.org/git/qemu.git\n");

You missed the ':' in the scheme. Once fixed:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>   	$printed_novcs = 1;
>       }
>       return 0;
> 
