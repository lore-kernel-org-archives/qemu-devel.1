Received: from eggs.gnu.org ([2001:4830:134:3::10]:57441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1g9a1a-0004j9-A3
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:12:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1g9a1Z-0001Ce-4B
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:12:58 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831]:33967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1g9a1Y-0001Bx-NQ
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 14:12:56 -0400
Received: by mail-qt1-x831.google.com with SMTP id o17-v6so6008514qtr.1
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 11:12:56 -0700 (PDT)
References: <20180918185246.18109-1-danielhb413@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <59eedc06-3c8d-a0e0-fd64-f2514decab44@gmail.com>
Date: Mon, 8 Oct 2018 15:12:51 -0300
MIME-Version: 1.0
In-Reply-To: <20180918185246.18109-1-danielhb413@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 0/3] wakeup-from-suspend and
 system_wakeup changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, ehabkost@redhat.com, armbru@redhat.com, mst@redhat.com, imammedo@redhat.com

ping

On 9/18/18 3:52 PM, Daniel Henrique Barboza wrote:
> changes in v9, all proposed by Mike Roth:
> - added a new 'qemu_register_wakeup_support' to be called by the wake-up
>    implementations to register the support in vl.c (patch 1)
> - changed versions from 3.0.0 to 3.1.0 (patch 1)
> - added back the 'qemu_system_wakeup_request' call that was removed by
> mistake in the previous version (patch 3)
> - Previous series link:
> https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg01675.html
>
>
> Daniel Henrique Barboza (3):
>    qmp: query-current-machine with wakeup-suspend-support
>    qga: update guest-suspend-ram and guest-suspend-hybrid descriptions
>    qmp hmp: Make system_wakeup check wake-up support and run state
>
>   hmp.c                   |  5 ++++-
>   hw/acpi/core.c          |  1 +
>   include/sysemu/sysemu.h |  2 ++
>   qapi/misc.json          | 29 ++++++++++++++++++++++++++++-
>   qga/qapi-schema.json    | 12 ++++++------
>   qmp.c                   | 10 ++++++++++
>   vl.c                    | 19 +++++++++++++++++++
>   7 files changed, 70 insertions(+), 8 deletions(-)
>
