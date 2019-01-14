Received: from eggs.gnu.org ([209.51.188.92]:55491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gizmb-0000yS-NE
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:47:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gizma-0002VK-SV
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:47:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gizma-0002Sx-MW
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:47:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so22342630wrr.0
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 02:47:52 -0800 (PST)
References: <20190111082043.31412-1-bsd@redhat.com>
	<20190111104414.dlzzbc7djkn2va2f@sirius.home.kraxel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d6168907-ed94-887a-5133-8f1ff395e6fc@redhat.com>
Date: Mon, 14 Jan 2019 11:47:49 +0100
MIME-Version: 1.0
In-Reply-To: <20190111104414.dlzzbc7djkn2va2f@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2 v2] Break down the MTP write operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Bandan Das <bsd@redhat.com>
Cc: qemu-devel@nongnu.org

On 1/11/19 11:44 AM, Gerd Hoffmann wrote:
> On Fri, Jan 11, 2019 at 03:20:41AM -0500, Bandan Das wrote:
>> v2:
>>   Rebased on top of master and retested
> 
> Thanks.  Added to usb queue.

Hi Gerd, did you update MTP_WRITE_BUF_SZ as suggested by Eric?

+#include "qemu/units.h"

...

-#define MTP_WRITE_BUF_SZ  512000
+#define MTP_WRITE_BUF_SZ  (512 * KiB)
