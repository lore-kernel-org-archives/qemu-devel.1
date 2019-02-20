Received: from eggs.gnu.org ([209.51.188.92]:34566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gwY3m-00076F-He
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 15:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gwY3l-0006qo-96
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 15:01:38 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gwY3l-0006W5-2K
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 15:01:37 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so18681207qtg.12
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 12:01:22 -0800 (PST)
Date: Wed, 20 Feb 2019 15:01:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190220150111-mutt-send-email-mst@kernel.org>
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-9-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190129175403.18017-9-philmd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 08/18] tests/bios-tables: Improve
 portability by searching bash in the $PATH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, Kamil Rytarowski <kamil@netbsd.org>

On Tue, Jan 29, 2019 at 06:53:53PM +0100, Philippe Mathieu-Daudé wrote:
> Bash is not always installed as /bin/bash. In particular on OpenBSD,
> the package installs it in /usr/local/bin.
> Use the 'env' shebang to search bash in the $PATH.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  tests/data/acpi/rebuild-expected-aml.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
> index bf9ba242ad..ff77a751c8 100755
> --- a/tests/data/acpi/rebuild-expected-aml.sh
> +++ b/tests/data/acpi/rebuild-expected-aml.sh
> @@ -1,4 +1,4 @@
> -#! /bin/bash
> +#! /usr/bin/env bash
>  
>  #
>  # Rebuild expected AML files for acpi unit-test
> -- 
> 2.20.1
