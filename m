Received: from eggs.gnu.org ([2001:4830:134:3::10]:51408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWO2c-0000LW-69
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gWNs2-0007Ok-Rz
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:53:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39052)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gWNs2-0007OJ-L6
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:53:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id t27so10985503wra.6
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:53:22 -0800 (PST)
References: <20181207165103.3992-1-philmd@redhat.com>
	<20181207165103.3992-3-philmd@redhat.com>
	<0f7d8556-168d-491d-433b-801837afb0dc@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <603b0a83-e4d3-8dad-232d-cd95f7bb281e@redhat.com>
Date: Mon, 10 Dec 2018 16:53:20 +0100
MIME-Version: 1.0
In-Reply-To: <0f7d8556-168d-491d-433b-801837afb0dc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] hw/smbios: Restrict access to
 "smbios_ipmi.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Corey Minyard <minyard@acm.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On 12/10/18 4:00 PM, Laszlo Ersek wrote:
> On 12/07/18 17:51, Philippe Mathieu-Daudé wrote:
>> All the consumers of "smbios_ipmi.h" are located in hw/smbios/.
> 
> I tried to verify this statement by grepping the tree for
> "smbios_ipmi.h". There were zero hits. Please use the more precise
> pathname "hw/smbios/ipmi.h". (I can't suggest just "ipmi.h", because
> that isn't unique.)

I did not notice I used the post-patch pathname, thanks.

> 
> With this update:
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> 
> Thanks,
> Laszlo
