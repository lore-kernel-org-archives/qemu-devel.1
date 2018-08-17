Received: from eggs.gnu.org ([2001:4830:134:3::10]:48168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqhaY-00031O-KO
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqhaV-0007MQ-HF
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:27:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49106 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqhaV-0007MD-CI
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:26:59 -0400
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-20-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ed4edd34-86e5-377d-10e5-c629a8311fa6@redhat.com>
Date: Fri, 17 Aug 2018 11:26:56 -0500
MIME-Version: 1.0
In-Reply-To: <20180817150559.16243-20-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 19/60] json: Tighten and simplify
 qstring_from_escaped_str()'s loop
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
> Simplify loop control, and assert that the string ends with the
> appropriate quote (the lexer ensures it does).
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qobject/json-parser.c | 30 +++++++-----------------------
>   1 file changed, 7 insertions(+), 23 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
