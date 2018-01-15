Received: from eggs.gnu.org ([2001:4830:134:3::10]:55378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb2Ak-0003dI-36
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb2Ag-0005wB-Ug
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:39:22 -0500
Received: from mail-qk0-x22c.google.com ([2607:f8b0:400d:c09::22c]:38659)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb2Ag-0005vq-PU
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:39:18 -0500
Received: by mail-qk0-x22c.google.com with SMTP id j185so16242740qkc.5
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 02:39:18 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180115102621.9183-1-berrange@redhat.com>
	<20180115102621.9183-4-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <32aedef8-60b3-5fb7-90e8-4964ff26f3e8@amsat.org>
Date: Mon, 15 Jan 2018 07:39:13 -0300
MIME-Version: 1.0
In-Reply-To: <20180115102621.9183-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 03/13] qapi: Use OrderedDict from
 standard library if available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 01/15/2018 07:26 AM, Daniel P. Berrange wrote:
> The OrderedDict class appeared in the 'collections' module
> from python 2.7 onwards, so use that in preference to our
> local backport if available.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/qapi.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 5ef50317ca..7ec2e00b2c 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -18,7 +18,10 @@ import os
>  import re
>  import string
>  import sys
> -from ordereddict import OrderedDict
> +try:
> +    from collections import OrderedDict
> +except:
> +    from ordereddict import OrderedDict
>  
>  builtin_types = {
>      'null':     'QTYPE_QNULL',
> 
