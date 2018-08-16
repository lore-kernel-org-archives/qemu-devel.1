Received: from eggs.gnu.org ([2001:4830:134:3::10]:33751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqIb0-0006yK-Pv
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:45:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqIat-0008A2-5B
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:45:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqIas-00087l-MF
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:45:43 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-52-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fbe4443d-5c86-70dc-4d81-cd882283782e@redhat.com>
Date: Thu, 16 Aug 2018 08:45:32 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-52-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 51/56] json: Eliminate lexer state IN_ERROR
 and pseudo-token JSON_MIN
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
>   include/qapi/qmp/json-lexer.h | 10 ++++------
>   qobject/json-lexer.c          | 18 ++++++++----------
>   2 files changed, 12 insertions(+), 16 deletions(-)
> 

> @@ -335,8 +334,7 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
>               json_message_process_token(lexer, lexer->token, JSON_ERROR,
>                                          lexer->x, lexer->y);
>               g_string_truncate(lexer->token, 0);
> -            new_state = lexer->start_state;
> -            lexer->state = new_state;
> +            lexer->state = lexer->start_state;

Does this simplification belong in an earlier patch?

Otherwise,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
