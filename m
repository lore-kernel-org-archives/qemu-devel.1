Received: from eggs.gnu.org ([2001:4830:134:3::10]:35458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyd9a-0007NY-1k
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:47:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eyd9W-0000QI-W7
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:47:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47944 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eyd9W-0000Py-Rj
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:47:38 -0400
References: <20180321065506.21091-1-peterx@redhat.com>
	<20180321065506.21091-2-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4aeb55f4-ec7b-1be2-e188-2e0f8e424184@redhat.com>
Date: Wed, 21 Mar 2018 07:47:35 -0500
MIME-Version: 1.0
In-Reply-To: <20180321065506.21091-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] tests: let qapi-schema tests detect oob
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, Markus Armbruster <armbru@redhat.com>

On 03/21/2018 01:55 AM, Peter Xu wrote:
> The allow_oob parameter was passed in but not used in tests.  Now
> reflect that in the tests, so we need to touch up other command testers
> with that new change.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tests/qapi-schema/doc-good.out          |  4 ++--
>   tests/qapi-schema/ident-with-escape.out |  2 +-
>   tests/qapi-schema/indented-expr.out     |  4 ++--
>   tests/qapi-schema/qapi-schema-test.out  | 18 +++++++++---------
>   tests/qapi-schema/test-qapi.py          |  4 ++--
>   5 files changed, 16 insertions(+), 16 deletions(-)
> 

> +++ b/tests/qapi-schema/test-qapi.py
> @@ -45,8 +45,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
>                         gen, success_response, boxed, allow_oob):
>           print('command %s %s -> %s' % \
>                 (name, arg_type and arg_type.name, ret_type and ret_type.name))
> -        print('   gen=%s success_response=%s boxed=%s' % \
> -              (gen, success_response, boxed))
> +        print('   gen=%s success_response=%s boxed=%s oob=%s' % \
> +              (gen, success_response, boxed, allow_oob))

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
