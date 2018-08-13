Received: from eggs.gnu.org ([2001:4830:134:3::10]:56713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpEs3-0001a0-1g
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fpErz-0007sc-VK
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:35:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40232 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fpErz-0007sO-Ol
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 11:34:59 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-37-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <136beab4-6228-d267-5cfe-e3946020b276@redhat.com>
Date: Mon, 13 Aug 2018 10:34:55 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-37-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 36/56] json: Rename token JSON_ESCAPE &
 friends to JSON_INTERPOL
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
> The JSON parser optionally supports interpolation.  The code calls it
> "escape".  Awkward, because it uses the same term for escape sequences
> within strings.  The latter usage is consistent with RFC 7159 "The
> JavaScript Object Notation (JSON) Data Interchange Format" and ISO C.
> Call the former "interpolation" instead.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/qmp/json-lexer.h |  2 +-
>   qobject/json-lexer.c          | 64 +++++++++++++++++------------------
>   qobject/json-parser.c         |  8 ++---
>   3 files changed, 37 insertions(+), 37 deletions(-)

Mechanical, and a worthwhile name change.

Reviewed-by: Eric Blake <eblake@redhat.com>

Bike-shedding: Would INTERP (short for interpolate) be any more legible 
than INTERPOL (which I first read as short for 'international police')?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
