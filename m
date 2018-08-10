Received: from eggs.gnu.org ([2001:4830:134:3::10]:57954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1foB4s-0002yx-PG
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1foB4r-0006Zo-PB
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:19:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49952 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1foB4r-0006ZU-IP
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:19:53 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-30-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0d4cf68c-a877-4429-8534-e21c41279541@redhat.com>
Date: Fri, 10 Aug 2018 12:19:52 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-30-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 29/56] check-qjson: Fix and enable
 utf8_string()'s disabled part
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
>   tests/check-qjson.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/tests/check-qjson.c b/tests/check-qjson.c
> index 3d3a3f105f..c8c0ad95a6 100644
> --- a/tests/check-qjson.c
> +++ b/tests/check-qjson.c
> @@ -750,15 +750,10 @@ static void utf8_string(void)
>               qobject_unref(str);
>               g_free(jstr);
>   
> -            /*
> -             * Parse @json_out right back
> -             * Disabled, because qobject_from_json() is buggy, and I can't
> -             * be bothered to add the expected incorrect results.
> -             * FIXME Enable once these bugs have been fixed.
> -             */
> -            if (0 && json_out != json_in) {
> +            /* Parse @json_out right back, unless it has replacements */
> +            if (!strstr(json_out, "\\uFFFD")) {
>                   str = from_json_str(json_out, &error_abort, j);
> -                g_assert_cmpstr(qstring_get_try_str(str), ==, utf8_out);
> +                g_assert_cmpstr(qstring_get_try_str(str), ==, utf8_in);
>               }
>           }
>       }
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
