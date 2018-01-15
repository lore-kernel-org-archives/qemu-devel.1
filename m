Received: from eggs.gnu.org ([2001:4830:134:3::10]:55961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb2CO-0005Di-Ng
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:41:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb2CL-0006tj-IF
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:41:04 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:41606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb2CL-0006tU-DP
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:41:01 -0500
Received: by mail-qk0-x243.google.com with SMTP id l29so6645664qkj.8
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 02:41:01 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180115102621.9183-1-berrange@redhat.com>
	<20180115102621.9183-8-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9ea0efef-7d0f-d557-7d2e-2e03a8c8fd37@amsat.org>
Date: Mon, 15 Jan 2018 07:40:56 -0300
MIME-Version: 1.0
In-Reply-To: <20180115102621.9183-8-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 07/13] qapi: ensure stable sort ordering
 when checking QAPI entities
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
> Some early python 3.x versions will have different default
> ordering when calling the 'values()' method on a dict, compared
> to python 2.x and later 3.x versions. Explicitly sort the items
> to get a stable ordering.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scripts/qapi.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index b6a7b5139f..6266447eb0 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -1678,7 +1678,7 @@ class QAPISchema(object):
>                  assert False
>  
>      def check(self):
> -        for ent in self._entity_dict.values():
> +        for (name, ent) in sorted(self._entity_dict.items()):
>              ent.check(self)
>  
>      def visit(self, visitor):
> 
