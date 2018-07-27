Received: from eggs.gnu.org ([2001:4830:134:3::10]:45045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4cX-0008Tb-AX
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4cW-0002Fg-AH
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:25:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46776 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj4cV-0002F7-NK
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:25:32 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-5-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d7bd8493-8853-0ebf-73bc-558150dae788@redhat.com>
Date: Fri, 27 Jul 2018 10:25:30 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 04/23] libqtest: Clean up how we read
 the QMP greeting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org

On 07/27/2018 10:13 AM, Markus Armbruster wrote:
> qtest_init() still uses the qtest_qmp_discard_response(s, "") hack to
> receive the greeting, even though we have qtest_qmp_receive() since
> commit 66e0c7b187e.  Put it to use.
> 
> Bonus: gets rid of an empty format string.  A step towards
> compile-time format string checking without triggering
> -Wformat-zero-length.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/libqtest.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
