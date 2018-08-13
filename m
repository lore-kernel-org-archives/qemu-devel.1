Received: from eggs.gnu.org ([2001:4830:134:3::10]:42629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpFpM-0003UX-33
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpFpH-0000NG-Eu
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:36:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37256 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fpFpH-0000N7-68
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 12:36:15 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-43-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e56b43c7-cd9c-d0bb-62ff-265858405ca9@redhat.com>
Date: Mon, 13 Aug 2018 11:36:13 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-43-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 42/56] json: Improve names of lexer states
 related to numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

On 08/08/2018 07:03 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/json-lexer.c | 38 +++++++++++++++++++-------------------
>   1 file changed, 19 insertions(+), 19 deletions(-)

> @@ -228,8 +228,8 @@ static const uint8_t json_lexer[][256] =  {
>           ['"'] = IN_DQ_STRING,
>           ['\''] = IN_SQ_STRING,
>           ['0'] = IN_ZERO,
> -        ['1' ... '9'] = IN_NONZERO_NUMBER,
> -        ['-'] = IN_NEG_NONZERO_NUMBER,
> +        ['1' ... '9'] = IN_DIGITS,
> +        ['-'] = IN_SIGN,
>           ['{'] = JSON_LCURLY,
>           ['}'] = JSON_RCURLY,
>           ['['] = JSON_LSQUARE,
> @@ -255,8 +255,8 @@ static const uint8_t json_lexer[][256] =  {
>           ['"'] = IN_DQ_STRING,
>           ['\''] = IN_SQ_STRING,
>           ['0'] = IN_ZERO,
> -        ['1' ... '9'] = IN_NONZERO_NUMBER,
> -        ['-'] = IN_NEG_NONZERO_NUMBER,
> +        ['1' ... '9'] = IN_DIGITS,
> +        ['-'] = IN_SIGN,

If you take my advice in the earlier patch about not repeating this list 
for IN_INTERPOL_START, you'll have an easy-to-resolve conflict here.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
