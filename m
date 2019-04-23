Received: from eggs.gnu.org ([209.51.188.92]:33352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3pC-0000S6-B3
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJ3pB-0007ee-4V
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:23:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJ3pA-0007bA-TH
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:23:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so22193932wrx.9
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 15:23:35 -0700 (PDT)
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<20190423212246.3542-2-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <76b8bb16-2e71-c41f-0d4a-79f6df059092@redhat.com>
Date: Wed, 24 Apr 2019 00:23:33 +0200
MIME-Version: 1.0
In-Reply-To: <20190423212246.3542-2-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] qapi: SupportStatusInfo struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: mprivozn@redhat.com, Markus Armbruster <armbru@redhat.com>

Hi Eduardo,

On 4/23/19 11:22 PM, Eduardo Habkost wrote:
> This struct will be used to represent support and deprecation
> status of QEMU features.

Excellent idea!

> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  qapi/common.json | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/qapi/common.json b/qapi/common.json
> index 99d313ef3b..b59d0dc66b 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -193,3 +193,27 @@
>               'ppc64', 'riscv32', 'riscv64', 's390x', 'sh4',
>               'sh4eb', 'sparc', 'sparc64', 'tricore', 'unicore32',
>               'x86_64', 'xtensa', 'xtensaeb' ] }
> +
> +##
> +# @SupportStatusInfo:
> +#
> +# Information on support status of a given feature
> +# (e.g. machine type)

Hopefully it is generic, we can use it for devices too.

> +#
> +# @deprecated: if true, the given feature is deprecated and may be removed
> +#              in future versions of QEMU according to the QEMU deprecation
> +#              policy.
> +#
> +# @status-message: Human readable message describing support status
> +#                  of the feature.
> +#
> +# @suggested-alternative: Optional.  Suggested alternative for a deprecated
> +#                         feature.  For machine types, this should be the name
> +#                         of an available machine-type.
> +#
> +# Since: 4.1
> +##
> +{ 'struct': 'SupportStatusInfo',
> +  'data': { 'deprecated': 'bool',
> +            '*status-message': 'str',

This one shouldn't be optional IMHO, we should enforce developpers to
give a reason for their deprecation.

With this argument not optional:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +            '*suggested-alternative': 'str' } }
> 
