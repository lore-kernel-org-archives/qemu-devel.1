Received: from eggs.gnu.org ([2001:4830:134:3::10]:58689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1edYQQ-00072Y-Av
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 04:29:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1edYQM-0003Cf-CY
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 04:29:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1edYQM-0003CE-2j
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 04:29:54 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0M9TMq4056996
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 04:29:52 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fnd55gk57-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 04:29:51 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 22 Jan 2018 04:29:50 -0500
References: <20180105130314.26026-1-danielhb@linux.vnet.ibm.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 22 Jan 2018 07:29:45 -0200
MIME-Version: 1.0
In-Reply-To: <20180105130314.26026-1-danielhb@linux.vnet.ibm.com>
Content-Language: en-US
Message-Id: <e4a1e020-0e2a-965f-d4fb-5990eecd7913@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/2] qmp: 'wakeup-suspend-support' in
 query-target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, dgilbert@redhat.com

Ping

On 01/05/2018 11:03 AM, Daniel Henrique Barboza wrote:
> v4:
> - added a comment in 'qemu_register_wakeup_notifier' about the effects
> of adding a wakeup notifier without proper suspend/wakeup support in the
> logic of the new wakeup-suspend-support flag, as suggested by Mike Roth
> - previous version link:
> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg00358.html
>
> v3:
> - added a "(since 2.12)" notation in the new flag, as suggested by
> Eric Blake
> - added a "backwards compatible" note in the commit msg
> - previous version link:
> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg00093.html
>
> v2:
> - changed the approach based on v1 discussions: instead of a new API, add
> the required flag in QMP query-target
> - dropped patch 2 since query-target does not have an HMP counterpart
> - previous version link:
> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00889.html
>
> Daniel Henrique Barboza (2):
>    qmp: adding 'wakeup-suspend-support' in query-target
>    qga: update guest-suspend-ram and guest-suspend-hybrid descriptions
>
>   arch_init.c             |  1 +
>   include/sysemu/sysemu.h |  1 +
>   qapi-schema.json        |  4 +++-
>   qga/qapi-schema.json    | 14 ++++++++++----
>   vl.c                    | 29 +++++++++++++++++++++++++++++
>   5 files changed, 44 insertions(+), 5 deletions(-)
>
