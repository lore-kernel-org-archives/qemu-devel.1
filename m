Received: from eggs.gnu.org ([2001:4830:134:3::10]:43602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIYwV-0005QI-7V
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gIYht-00050a-3v
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:37:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gIYhs-0004u6-Qv
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 08:37:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id r10-v6so1833075wrv.6
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 05:37:39 -0700 (PDT)
References: <20181102085800.21860-1-philmd@redhat.com>
	<20181102110734.GE7521@dhcp-200-186.str.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6d96d96b-21f7-d5fc-9313-8ede0f6a745c@redhat.com>
Date: Fri, 2 Nov 2018 13:37:36 +0100
MIME-Version: 1.0
In-Reply-To: <20181102110734.GE7521@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] qemu/units: Move out QCow2 specific
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>, Leonid Bloch <lbloch@janustech.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>

Hi Kevin,

On 2/11/18 12:07, Kevin Wolf wrote:
> Am 02.11.2018 um 09:58 hat Philippe Mathieu-Daudé geschrieben:
>> This definitions are QCow2 specific, there is no need to expose them
>> in the global namespace.
>>
>> This partially reverts commit 540b8492618eb.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> If we don't want this globally, I think we also don't want it in qcow2.

I only see this definitions used by block/qcow2.h (b6a95c6d1007).

Per 540b8492618eb description "This is needed when a size has to be 
stringified" but I can't find other code requiring these definitions in 
the codebase.

> Or at least reduce it to only those constants that qcow2 actually uses.

Fine by me, I'll let Leonid opine first.

Regards,

Phil.
