Received: from eggs.gnu.org ([2001:4830:134:3::10]:35145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqh1u-0005Yl-2m
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:51:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqh1q-0000Yy-Tm
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:51:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58788 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqh1p-0000Xz-3G
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 11:51:09 -0400
References: <20180817150559.16243-1-armbru@redhat.com>
	<20180817150559.16243-6-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5150f7dd-d6f7-d09d-6881-6d45f097cf21@redhat.com>
Date: Fri, 17 Aug 2018 10:51:06 -0500
MIME-Version: 1.0
In-Reply-To: <20180817150559.16243-6-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/60] qmp-test: Cover syntax and
 lexical errors
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
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Might be worth mentioning the addition of qtest_qmp_send_raw() in the 
commit message body.

>   tests/libqtest.c | 17 +++++++++++++++++
>   tests/libqtest.h | 11 +++++++++++
>   tests/qmp-test.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 68 insertions(+), 1 deletion(-)
> 

> +/**
> + * qtest_qmp_send_raw:
> + * @s: #QTestState instance to operate on.
> + * @fmt...: text to send, formatted like sprintf()
> + *
> + * Sends text to the QMP monitor verbatim.  Need not be valid JSON;
> + * this is useful for negative tests.
> + */
> +void qtest_qmp_send_raw(QTestState *s, const char *fmt, ...)
> +    GCC_FMT_ATTR(2, 3);
> +

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
