Received: from eggs.gnu.org ([2001:4830:134:3::10]:58801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faB0I-0007O4-7o
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faB0E-0000x3-RN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:25:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41720 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1faB0E-0000wX-LO
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 22:25:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4117B402346D
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 02:25:14 +0000 (UTC)
References: <20180702162218.13678-1-armbru@redhat.com>
	<20180702162218.13678-25-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <19f8de9c-17a0-98d1-1298-eed4996898de@redhat.com>
Date: Mon, 2 Jul 2018 21:25:13 -0500
MIME-Version: 1.0
In-Reply-To: <20180702162218.13678-25-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 24/32] qmp: Replace monitor_json_emitter{,
 raw}() by qmp_{queue, send}_response()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

On 07/02/2018 11:22 AM, Markus Armbruster wrote:
> monitor_json_emitter() and monitor_json_emitter_raw() are
> unnecessarily general: they can send arbitrary JSON values, even
> though we only ever use them for QMP, which may send only JSON
> objects.
> 
> Specialize the argument from QObject * to QDict *, and rename to
> qmp_queue_response(), qmp_send_response().
> 
> All callers but one lose an upcast.  The lone exception gains a
> downcast; the next commit will get rid of it.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   monitor.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)
> 

Reviewed-by: Eric Blake <eblake@redhat.com>

And the new names are easier to tell apart.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
