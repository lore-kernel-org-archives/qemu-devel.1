Received: from eggs.gnu.org ([2001:4830:134:3::10]:36773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fzjjC-00064e-RW
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fzjj7-0002li-A3
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:33:18 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fzjj7-0002kz-3P
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 10:33:13 -0400
Received: by mail-pl1-x642.google.com with SMTP id b12-v6so11416817plr.8
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 07:33:12 -0700 (PDT)
References: <20180905151927.8884-1-ehabkost@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0dd0910c-6120-a485-e0b0-c354bd4038cd@linaro.org>
Date: Tue, 11 Sep 2018 07:33:08 -0700
MIME-Version: 1.0
In-Reply-To: <20180905151927.8884-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Support
 --enable-capstone=internal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Danilo C. L. de Paula" <ddepaula@redhat.com>

On 09/05/2018 08:19 AM, Eduardo Habkost wrote:
> Currently there's no way to make configure not try to use the
> system-provided capstone library using pkgconfig.

Certainly there is.

> 
> Add support to --enable-capstone=internal option to make QEMU not
> use the system-provided library automatically.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  configure | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/configure b/configure
> index 58862d2ae8..34ed00f6d9 100755
> --- a/configure
> +++ b/configure
> @@ -1431,6 +1431,8 @@ for opt do
> +  --enable-capstone[=LOCATION]
> +                           Where to look for capstone library.
> +                           Supported options: internal, git, system

That's what "git" means here.


r~
