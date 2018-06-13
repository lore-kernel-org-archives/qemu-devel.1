Received: from eggs.gnu.org ([2001:4830:134:3::10]:45866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTAiS-0006R5-RH
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:41:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTAiO-0005Tx-SK
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:41:56 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTAiO-0005Of-OL
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:41:52 -0400
Received: by mail-qk0-x244.google.com with SMTP id q70-v6so2142708qke.1
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 11:41:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180530184156.15634-1-crosa@redhat.com>
	<20180530184156.15634-6-crosa@redhat.com>
	<a8ec6474-707b-8272-7a79-a842f11d2f7f@amsat.org>
	<20180613183041.GF24764@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <00bbd06d-09f4-0cf1-7ac2-8dcf6ec3cf0a@amsat.org>
Date: Wed, 13 Jun 2018 15:41:47 -0300
MIME-Version: 1.0
In-Reply-To: <20180613183041.GF24764@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 5/5] Acceptance tests: add Linux kernel
 boot and console checking test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amador Pahim <amador@pahim.org>

On 06/13/2018 03:30 PM, Eduardo Habkost wrote:
> On Wed, May 30, 2018 at 05:57:52PM -0300, Philippe Mathieu-Daudé wrote:
> [...]
>>> +class BootLinuxConsole(Test):
>>> +    """
>>> +    Boots a x86_64 Linux kernel and checks that the console is operational
>>> +    and the kernel command line is properly passed from QEMU to the kernel
>>> +
>>> +    :avocado: enable
>>> +    :avocado: tags=x86_64
>>
>> Can you move tags=x86_64 to the test() method?
> 
> I'm queueing this patch as is, as the tag here seems harmless.  A
> follow-up patch will be required if you want to move the tag.

No problem!
