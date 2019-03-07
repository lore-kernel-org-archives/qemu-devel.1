Received: from eggs.gnu.org ([209.51.188.92]:38848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1vCW-0003AH-22
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1vCV-0004aQ-6Z
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:44:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1vCU-0004Zu-W3
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:44:51 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so9652931wmg.2
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 07:44:50 -0800 (PST)
References: <20190307145839.13128-1-philmd@redhat.com>
	<a7e51315-7b36-3bfd-9c78-296ba74614f7@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <62d9443b-2745-2094-738d-557f84e690b2@redhat.com>
Date: Thu, 7 Mar 2019 16:44:48 +0100
MIME-Version: 1.0
In-Reply-To: <a7e51315-7b36-3bfd-9c78-296ba74614f7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 0/4] tests: Allow use of Ports bash and
 GNU sed extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Kamil Rytarowski <n54@gmx.com>, Brad Smith <brad@comstyle.com>

On 3/7/19 4:27 PM, Thomas Huth wrote:
> On 07/03/2019 15.58, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
> 
> ? -----^
> 
> I could take the patch for tests/data/acpi/rebuild-expected-aml.sh
> through the qtests tree (if Michael or Igor don't want to take it), but
> the other patches are not related to qtests...

Oh I misread your tests/[qtest] MAINTAINERS entry, my bad!

Still I'm not sure what to do, it is a pain to split it again in 3
different v5 series.
It would have been way easier to have all the OpenBSD enter as a single
series. If we drop OpenBSD support in the next, these patches become
less relevant/important (until some weird OS like Haiku get in again),
so I'll wait to see what happens during the next dev cycle.

Thanks and sorry for sending that to you at first!

Phil.
