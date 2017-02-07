Received: from eggs.gnu.org ([2001:4830:134:3::10]:41898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cb9Ml-0005vV-Ip
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:15:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cb9Mi-0003KZ-CH
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:15:43 -0500
Received: from greensocs.com ([193.104.36.180]:45650)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cb9Mi-0003EX-3E
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:15:40 -0500
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
	<1485424060-12217-7-git-send-email-fred.konrad@greensocs.com>
	<CAFEAcA8uOHb3aUWOcM+Ok_fDiECOfLtx2d2TZp7naKJBcf6+nQ@mail.gmail.com>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <55608520-614a-f88a-6b24-e98f9fd41859@greensocs.com>
Date: Tue, 7 Feb 2017 18:15:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8uOHb3aUWOcM+Ok_fDiECOfLtx2d2TZp7naKJBcf6+nQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 06/10] docs: add qemu-clock documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>, Mark Burton <mark.burton@greensocs.com>

On 02/07/2017 05:13 PM, Peter Maydell wrote:
> On 26 January 2017 at 09:47,  <fred.konrad@greensocs.com> wrote:
>> From: KONRAD Frederic <fred.konrad@greensocs.com>
>>
>> This adds the qemu-clock documentation.
>>
>> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
>>
>> V1 -> V2:
>>   * Fixed in accordance with the changes in the previous patches.
>> ---
>>  docs/clock.txt | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 108 insertions(+)
>>  create mode 100644 docs/clock.txt
> 
> Could we have a simple example of what you need to do if you are:
>  * a device providing a clock source of some kind

The fixed clock in patch 7 might be helpful for that.
Maybe I can just point to it in the documentation?

>  * a device that takes a clock input and has one or more
>    clock outputs which are configured by that device (for
>    frequency, on/off, etc)
>  * a device that consumes a clock

The CRF is doing that. Maybe I can add a simpler testcase device to
build a make check for that?

Fred

> 
> please? I think that would help make it more concrete how you
> need to use these things.
> 
> thanks
> -- PMM
> 
