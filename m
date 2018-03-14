Received: from eggs.gnu.org ([2001:4830:134:3::10]:60508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ew6DA-0006vY-Mf
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 09:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1ew6D7-0001fh-Fs
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 09:12:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52956
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1ew6D7-0001fN-9I
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 09:12:53 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2ED970W120562
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 09:12:52 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gq445s3y4-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Mar 2018 09:12:51 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 14 Mar 2018 09:12:51 -0400
References: <20180219141259.26526-1-danielhb@linux.vnet.ibm.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed, 14 Mar 2018 10:12:46 -0300
MIME-Version: 1.0
In-Reply-To: <20180219141259.26526-1-danielhb@linux.vnet.ibm.com>
Content-Language: en-US
Message-Id: <eebc1ad7-2191-d9cc-81fd-5fefa9e3b1c8@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/2] qmp: 'wakeup-suspend-support' in
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
Cc: mdroth@linux.vnet.ibm.com, armbru@redhat.com, dgilbert@redhat.com, Eric Blake <eblake@redhat.com>

Ping

On 02/19/2018 11:12 AM, Daniel Henrique Barboza wrote:
> v5:
> - removed a paragraph in the recently added qemu_register_wakeup_notifier
> comment that was added. That paragraph was adding too much in-depth
> information about the current design of the system_wakeup, making it
> harder to understand the whole point (suggested by Mike Roth).
> - previous version link:
> https://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg00879.html
>
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
>
> Daniel Henrique Barboza (2):
>    qmp: adding 'wakeup-suspend-support' in query-target
>    qga: update guest-suspend-ram and guest-suspend-hybrid descriptions
>
>   arch_init.c             |  1 +
>   include/sysemu/sysemu.h |  1 +
>   qapi-schema.json        |  4 +++-
>   qga/qapi-schema.json    | 14 ++++++++++----
>   vl.c                    | 21 +++++++++++++++++++++
>   5 files changed, 36 insertions(+), 5 deletions(-)
>
