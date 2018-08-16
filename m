Received: from eggs.gnu.org ([2001:4830:134:3::10]:51445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqI5P-0007nt-83
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqI5J-0000eJ-BC
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:13:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58894 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqI5J-0000dD-4k
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:13:05 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-46-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d044a6a7-2b11-0d2c-97ac-51643550adbe@redhat.com>
Date: Thu, 16 Aug 2018 08:12:59 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-46-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 45/56] json: Fix streamer not to ignore
 trailing unterminated structures
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
> json_message_process_token() accumulates tokens until it got the
> sequence of tokens that comprise a single JSON value (it counts curly
> braces and square brackets to decide).  It feeds those token sequences
> to json_parser_parse().  If a non-empty sequence of tokens remains at
> the end of the parse, it's silently ignored.  check-qjson.c cases
> unterminated_array(), unterminated_array_comma(), unterminated_dict(),
> unterminated_dict_comma() demonstrate this bug.
> 
> Fix as follows.  Introduce a JSON_END_OF_INPUT token.  When the
> streamer receives it, it feeds the accumulated tokens to
> json_parser_parse().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
Nice.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
