Received: from eggs.gnu.org ([2001:4830:134:3::10]:34874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnlRh-0000ud-7u
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnlRd-0001mS-6L
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:57:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50640 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fnlRd-0001mG-0i
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:57:41 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-9-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c045c1b3-8f75-9078-85db-9b1a5dcca447@redhat.com>
Date: Thu, 9 Aug 2018 08:57:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-9-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/56] check-qjson: Streamline
 escaped_string()'s test strings
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

On 08/08/2018 07:02 AM, Markus Armbruster wrote:
> Merge a few closely related test strings, and drop a few redundant
> ones.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/check-qjson.c | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 

>       } test_cases[] = {
> -        { "\\b", "\b" },
> -        { "\\f", "\f" },
> -        { "\\n", "\n" },
> -        { "\\r", "\r" },
> -        { "\\t", "\t" },
> -        { "/", "/" },
> -        { "\\/", "/", .skip = 1 },
> -        { "\\\\", "\\" },
> -        { "\\\"", "\"" },
> -        { "hello world \\\"embedded string\\\"",
> -          "hello world \"embedded string\"" },
> -        { "hello world\\nwith new line", "hello world\nwith new line" },
> +        { "\\b\\f\\n\\r\\t\\\\\\\"", "\b\f\n\r\t\\\"" },
> +        { "\\/\\'", "/'", .skip = 1 },

Aha - this adds coverage of the escaped ' not present in 7/56. (Still 
nothing about the unescaped versions of ' or " with correct quoting).

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
