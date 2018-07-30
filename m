Received: from eggs.gnu.org ([2001:4830:134:3::10]:39549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fkDG5-0002NY-7s
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:51:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fkDG4-0003ld-9T
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:51:05 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fkDG4-0003l5-2z
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 14:51:04 -0400
Received: by mail-qt0-x244.google.com with SMTP id t5-v6so13241953qtn.3
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 11:51:03 -0700 (PDT)
References: <20180705200813.2033-1-danielhb413@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <1c0932e0-0b43-28ad-1b4b-41a68b5b8f86@gmail.com>
Date: Mon, 30 Jul 2018 15:50:56 -0300
MIME-Version: 1.0
In-Reply-To: <20180705200813.2033-1-danielhb413@gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 0/3] wakeup-from-suspend and
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
Cc: ehabkost@redhat.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com

Ping

On 07/05/2018 05:08 PM, Daniel Henrique Barboza wrote:
> changes in v8:
> - created 'query-current-machine' API to hold the wakeup-suspend-support
>    flag
> - wake-up flag now considers the --no-acpi config option for PC archs
> - fixes in patch 3 proposed by Markus.
> Previous series link:
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04234.html
>
> Daniel Henrique Barboza (3):
>    qmp: query-current-machine with wakeup-suspend-support
>    qga: update guest-suspend-ram and guest-suspend-hybrid descriptions
>    qmp hmp: Make system_wakeup check wake-up support and run state
>
>   hmp.c                   |  5 ++++-
>   include/sysemu/sysemu.h |  1 +
>   qapi/misc.json          | 29 ++++++++++++++++++++++++++++-
>   qga/qapi-schema.json    | 12 ++++++------
>   qmp.c                   | 11 ++++++++++-
>   vl.c                    | 30 ++++++++++++++++++++++++++++++
>   6 files changed, 79 insertions(+), 9 deletions(-)
>
