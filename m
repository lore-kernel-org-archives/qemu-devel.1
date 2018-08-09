Received: from eggs.gnu.org ([2001:4830:134:3::10]:33669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnq0a-0003Pj-63
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 14:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnq0W-0000Ey-90
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 14:50:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47876 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fnq0W-0000Ef-4v
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 14:50:00 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-19-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d2dd81e0-c8d0-a934-d750-c8b97e8010cf@redhat.com>
Date: Thu, 9 Aug 2018 13:49:56 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-19-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/56] json: Revamp lexer documentation
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
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/json-lexer.c | 80 +++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 71 insertions(+), 9 deletions(-)
> 

> + *
> + * [Numbers:]

Worth also calling out:

[Objects:]
       object = begin-object [ member *( value-separator member ) ]
                end-object

       member = string name-separator value
[Arrays:]
    array = begin-array [ value *( value-separator value ) ] end-array

so as to completely cover the RFC grammar?

> + *
> + * Extensions over RFC 7159:
> + * - Extra escape sequence in strings:
> + *   0x27 (apostrophe) is recognized after escape, too
> + * - Single-quoted strings:
> + *   Like double-quoted strings, except they're delimited by %x27
> + *   (apostrophe) instead of %x22 (quotation mark), and can't contain
> + *   unescaped apostrophe, but can contain unescaped quotation mark.
> + * - Interpolation:
> + *   interpolation = %((l|ll|I64)[du]|[ipsf])

Not in your series, but we recently discussed adding %% (only inside 
strings); coupled with enforcing that all other interpolation occurs 
outside of strings.  I guess we can update this comment at that time.

> + *
> + * Note:
> + * - Input must be encoded in UTF-8.
> + * - Decoding and validating is left to the parser.
>    */
>   
>   enum json_lexer_state {
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
