Received: from eggs.gnu.org ([2001:4830:134:3::10]:42237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnlqA-0007Ey-Bp
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fnlq6-0006mb-TT
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:23:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40006 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fnlq6-0006lX-NW
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:22:58 -0400
References: <20180808120334.10970-1-armbru@redhat.com>
	<20180808120334.10970-14-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f5177225-43c7-ad41-9ac5-b8dac76b51e3@redhat.com>
Date: Thu, 9 Aug 2018 09:22:57 -0500
MIME-Version: 1.0
In-Reply-To: <20180808120334.10970-14-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/56] check-qjson: Fix utf8_string() to
 test all invalid sequences
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
> Some of utf8_string()'s test_cases[] contain multiple invalid
> sequences.  Testing that qobject_from_json() fails only tests we
> reject at least one invalid sequence.  That's incomplete.
> 
> Additionally test each non-space sequence in isolation.
> 
> This demonstrates that the JSON parser accepts invalid sequences
> starting with \xC2..\xF4.  Add a FIXME comment.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/check-qjson.c | 33 ++++++++++++++++++++++++++++-----
>   1 file changed, 28 insertions(+), 5 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
