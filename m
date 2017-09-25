Received: from eggs.gnu.org ([2001:4830:134:3::10]:53424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1dwY2y-00067M-MU
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:24:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1dwY2x-0003Y6-W0
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:24:00 -0400
MIME-Version: 1.0
In-Reply-To: <10a9c31a-5bd1-5915-4b82-1c3cf9cd8bbd@redhat.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-9-andrew.smirnov@gmail.com>
	<10a9c31a-5bd1-5915-4b82-1c3cf9cd8bbd@redhat.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Mon, 25 Sep 2017 11:23:56 -0700
Message-ID: <CAHQ1cqHdsmA4zRBh7=VHU8v5Xn1K+D2bsOWkQivs7iuOw7GRBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/17] imx_fec: Add support for multiple Tx
 DMA rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: "open list:ARM" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Fri, Sep 22, 2017 at 12:33 AM, Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2017=E5=B9=B409=E6=9C=8819=E6=97=A5 03:50, Andrey Smirnov wrote:
>>
>> More recent version of the IP block support more than one Tx DMA ring,
>> so add the code implementing that feature.
>>
>> Cc: Peter Maydell<peter.maydell@linaro.org>
>> Cc: Jason Wang<jasowang@redhat.com>
>> Cc:qemu-devel@nongnu.org
>> Cc:qemu-arm@nongnu.org
>> Cc:yurovsky@gmail.com
>> Signed-off-by: Andrey Smirnov<andrew.smirnov@gmail.com>
>> ---
>>   hw/net/imx_fec.c         | 97
>> +++++++++++++++++++++++++++++++++++++++---------
>>   include/hw/net/imx_fec.h | 23 +++++++++++-
>>   2 files changed, 101 insertions(+), 19 deletions(-)
>
>
> Is there a register for driver to know about the version? (Looks like I
> didn't find it).

I haven't seen anything of the sort in the datasheet and, since Linux
driver relies on DT for that information, I am inclined to think
there's none.

Thanks,
Andrey Smirnov
