Received: from eggs.gnu.org ([2001:4830:134:3::10]:44463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drdc8-0002HM-0U
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 01:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1drdc4-0000Ue-2H
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 01:20:00 -0400
References: <20170911110037.6567-1-lvivier@redhat.com>
	<0c996e65-fc92-6553-7f27-188d42c2235b@redhat.com>
	<201906370.13293029.1505191977177.JavaMail.zimbra@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b5c1a560-b2b3-104a-dd51-eb47399ed1be@redhat.com>
Date: Tue, 12 Sep 2017 07:19:46 +0200
MIME-Version: 1.0
In-Reply-To: <201906370.13293029.1505191977177.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hmp: fix "dump-quest-memory" segfault (ppc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Miroslav Rezanina <mrezanin@redhat.com>, Wei Huang <wei@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 12.09.2017 06:52, Miroslav Rezanina wrote:
> 
> 
> ----- Original Message -----
>> From: "Thomas Huth" <thuth@redhat.com>
>> To: "Laurent Vivier" <lvivier@redhat.com>, qemu-devel@nongnu.org
>> Cc: "David Gibson" <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, "Dr . David Alan Gilbert"
>> <dgilbert@redhat.com>, "Miroslav Rezanina" <mrezanin@redhat.com>
>> Sent: Monday, September 11, 2017 4:36:01 PM
>> Subject: Re: [PATCH] hmp: fix "dump-quest-memory" segfault (ppc)
>>
>> On 11.09.2017 13:00, Laurent Vivier wrote:
>>> Commit fd5d23babf (hmp: fix "dump-quest-memory" segfault)
>>> fixes the problem for i386, do the same for ppc.
>>>
>>> Running QEMU with
>>>     qemu-system-ppc64 -M none -nographic -m 256
>>> and executing
>>>     dump-guest-memory /dev/null 0 8192
>>> results in segfault
>>>
>>> Fix by checking if we have CPU.
[...]
> 
> We need similar fix for aarch64 too.

Yes, Laurent already posted a v2 which includes a patch for ARM, too:

https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02586.html

 Thomas
