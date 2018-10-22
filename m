Received: from eggs.gnu.org ([2001:4830:134:3::10]:44740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gEUwK-0002u2-Og
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 03:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gEUwG-0001MJ-T6
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 03:47:52 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:12238)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozhongyi@cmss.chinamobile.com>) id 1gEUwF-0001Ik-73
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 03:47:48 -0400
References: <20181015032642.16411-1-maozhongyi@cmss.chinamobile.com>
	<20181019080400.lu46ohp4qmpp4otr@sirius.home.kraxel.org>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <c51bf323-1135-364b-7d44-9e8742f37c4f@cmss.chinamobile.com>
Date: Mon, 22 Oct 2018 15:47:40 +0800
MIME-Version: 1.0
In-Reply-To: <20181019080400.lu46ohp4qmpp4otr@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] use object link instead of qdev
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

Hi, Gerd

On 10/19/18 4:04 PM, Gerd Hoffmann wrote:
> On Mon, Oct 15, 2018 at 11:26:39AM +0800, Mao Zhongyi wrote:
>> According to qdev-properties.h, properties of pointer type
>> should be avoid, so convert qdev property to link, Whilst we
>> are here, also update some hardcoded strings with already
>> defineded macros.
> 
> Patch series breaks "make check".

Already fixed it in v4, please review.

Thanks,
mao

> 
> cheers,
>    Gerd
> 
> 
