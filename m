Received: from eggs.gnu.org ([2001:4830:134:3::10]:35768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fuLKc-0001M5-Lm
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 13:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fuLKZ-0004lJ-B1
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 13:29:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44072 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fuLKZ-0004l6-59
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 13:29:35 -0400
References: <20180827070021.11931-1-armbru@redhat.com>
	<20180827070021.11931-6-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2f5517a3-bb02-c7e7-cebc-315fbf8bd89b@redhat.com>
Date: Mon, 27 Aug 2018 12:29:31 -0500
MIME-Version: 1.0
In-Reply-To: <20180827070021.11931-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/6] json: Eliminate lexer state IN_ERROR
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

On 08/27/2018 02:00 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/json-lexer.c      | 9 +++++----
>   qobject/json-parser-int.h | 8 ++++----
>   2 files changed, 9 insertions(+), 8 deletions(-)

> -
>   typedef enum json_token_type {
> -    JSON_MIN = 100,
> -    JSON_LCURLY = JSON_MIN,
> +    JSON_ERROR = 0,             /* must be zero, see json_lexer[] */
> +    /* Gap for lexer states */
> +    JSON_LCURLY = 100,
> +    JSON_MIN = JSON_LCURLY,

In an earlier version of this type of cleanup, you swapped the IN_ and 
JSON_ values and eliminated the gap, to make the overall table more 
compact (no storage wasted on any of the states in the gap between the two).

https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg01178.html

Is it still worth trying to minimize the gap between the two sequences, 
even if you now no longer swap them in order?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
