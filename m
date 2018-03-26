Received: from eggs.gnu.org ([2001:4830:134:3::10]:42780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0ZzJ-0002Gj-Lf
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 17:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0ZzG-00049K-Jf
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 17:49:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43234 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0ZzG-00048d-FH
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 17:49:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8F7F722D0
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 21:49:01 +0000 (UTC)
References: <20180326063901.27425-1-peterx@redhat.com>
	<20180326063901.27425-8-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dfd0feb4-d2c8-1c6f-40bc-b45e0258ef4e@redhat.com>
Date: Mon, 26 Mar 2018 16:48:57 -0500
MIME-Version: 1.0
In-Reply-To: <20180326063901.27425-8-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 7/8] tests: introduce
 qtest_init_with_qmp_format()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/26/2018 01:39 AM, Peter Xu wrote:
> It is abstracted from qtest_init_without_qmp_handshake(). It works just
> like qtest_init_without_qmp_handshake() but further it would allow the
> caller to specify the QMP parameter.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tests/libqtest.c | 14 +++++++++++---
>   tests/libqtest.h | 14 ++++++++++++++
>   2 files changed, 25 insertions(+), 3 deletions(-)
> 

> +    gchar *qmp_params;
>       const char *qemu_binary = qtest_qemu_binary();
>   
>       s = g_new(QTestState, 1);
>   
>       socket_path = g_strdup_printf("/tmp/qtest-%d.sock", getpid());
>       qmp_socket_path = g_strdup_printf("/tmp/qtest-%d.qmp", getpid());
> +    qmp_params = g_strdup_printf(qmp_format, qmp_socket_path);
>   

Memory leak of qmp_params.  Avoided in my rewrite to use bool instead of 
a format string.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
