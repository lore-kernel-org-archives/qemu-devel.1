Received: from eggs.gnu.org ([2001:4830:134:3::10]:35874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fdFwL-0000pJ-81
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fdFwI-0003R7-3y
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:17:57 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:44599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fdFwH-0003Qh-Sg
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:17:54 -0400
Received: by mail-ed1-x541.google.com with SMTP id d17-v6so7251196eds.11
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 07:17:53 -0700 (PDT)
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180711140054.GL31228@stefanha-x1.localdomain>
From: Emanuele <e.emanuelegiuseppe@gmail.com>
Message-ID: <647e9b9b-d206-e9af-02b2-e6bb732dc3ea@gmail.com>
Date: Wed, 11 Jul 2018 16:17:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180711140054.GL31228@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/7] Qtest driver framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 07/11/2018 04:00 PM, Stefan Hajnoczi wrote:

> On Mon, Jul 09, 2018 at 11:11:29AM +0200, Emanuele Giuseppe Esposito wrote:
>> Basic framework steps are the following:
>> - All nodes and edges are created in their respective machine/driver/test files
>> - The framework starts QEMU and asks for a list of available drivers
>>    and machines
> QEMU doesn't know about qtest drivers.  Does "drivers" mean "devices"
> (i.e. qemu -device \?) and they have a 1:1 correspondence with qtest
> drivers?
Yes, they are QEMU devices, it was a typo.
Not all qtest drivers are mapped with the QEMU devices, though. In fact, 
for now all drivers "contained" or "produced" by other nodes are not 
QEMU devices.

The others (machines and nodes that "consume"), are mapped to QEMU using 
the
{ "execute": "qom-list-types", "arguments" : { "implements" : "device" } }
for "consume" and
{ "execute": "query-machines" }
for machines.

With "consume" I mean in situation like "node X" ---> consumes --> "node 
Y",
"X" should be in the output of qom-list-types query.
> The concept of qgraph makes sense.  Ease of use and documentation will
> be critical to gain adoption.  The extra complexity makes it hard for
> people writing and running tests, so it's important that it's clear
> which tests will get run and why (or why not).
I am trying to document and makes it as easy and clean as possible :)
