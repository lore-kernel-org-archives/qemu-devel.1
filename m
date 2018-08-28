Received: from eggs.gnu.org ([2001:4830:134:3::10]:33129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fukEi-0004bY-LW
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 16:05:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1fuk4z-0004dn-JQ
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:55:12 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:43738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <danielhb413@gmail.com>)
	id 1fuk4z-0004cT-Ad
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:55:09 -0400
Received: by mail-qt0-x242.google.com with SMTP id g53-v6so3161198qtg.10
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 12:55:09 -0700 (PDT)
References: <20180705200813.2033-1-danielhb413@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <4b2460c7-962b-83be-0b1e-4ed9ccc29708@gmail.com>
Date: Tue, 28 Aug 2018 16:55:04 -0300
MIME-Version: 1.0
In-Reply-To: <20180705200813.2033-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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
