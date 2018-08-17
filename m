Received: from eggs.gnu.org ([2001:4830:134:3::10]:47141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqhXi-00037t-AY
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqhXe-0005lN-M8
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:24:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48578 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqhXd-0005kc-GZ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:24:01 -0400
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-11-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fc153b3a-be75-d5c4-d66e-68ddd42f1b22@redhat.com>
Date: Fri, 17 Aug 2018 11:23:58 -0500
MIME-Version: 1.0
In-Reply-To: <20180817150559.16243-11-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 10/60] check-qjson: Consolidate partly
 redundant string tests
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

On 08/17/2018 10:05 AM, Markus Armbruster wrote:
> simple_string() and single_quote_string() have become redundant with
> escaped_string(), except fot embedded single and double quotes.

s/fot/for/

> Replace them by a test that covers just that.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/check-qjson.c | 64 ++++++++++-----------------------------------
>   1 file changed, 14 insertions(+), 50 deletions(-)
> 
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
