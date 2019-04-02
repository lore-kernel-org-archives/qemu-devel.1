Received: from eggs.gnu.org ([209.51.188.92]:50214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hBP1q-00031C-7l
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 15:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hBP1p-0007zk-B4
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 15:25:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hBP1o-0007x2-RE
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 15:25:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so18098035wrq.8
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 12:25:00 -0700 (PDT)
References: <20190402161900.7374-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6f392ee5-d2c6-36b3-b2e2-6ec704d51277@redhat.com>
Date: Tue, 2 Apr 2019 21:24:58 +0200
MIME-Version: 1.0
In-Reply-To: <20190402161900.7374-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/3] acpi: More trace points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com

On 4/2/19 6:18 PM, Markus Armbruster wrote:
> I wrote these patches to help me debug an unplug failure.  I expect
> them to be helpful for others, too.

Appreciated.

FYI I have a WiP branch where I use existing tracepoints to check events
order and timing (using Avocado).

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Markus Armbruster (3):
>   acpi/piix4: Convert debug printf()s to trace events
>   acpi/pcihp: Convert debug printf()s to trace events
>   acpi/pcihp: Add a few more trace points related to unplug
> 
>  hw/acpi/pcihp.c      | 32 +++++++++++++++-----------------
>  hw/acpi/piix4.c      | 14 +++-----------
>  hw/acpi/trace-events | 16 ++++++++++++++++
>  3 files changed, 34 insertions(+), 28 deletions(-)
> 
