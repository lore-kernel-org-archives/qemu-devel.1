Received: from eggs.gnu.org ([2001:4830:134:3::10]:47828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eHRQ2-0002wa-55
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 04:34:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1eHRQ1-0007Jp-3i
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 04:34:10 -0500
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:34957
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1eHRQ0-0007JK-US
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 04:34:09 -0500
References: <1510140763-18256-1-git-send-email-frederic.konrad@adacore.com>
	<1510140763-18256-2-git-send-email-frederic.konrad@adacore.com>
	<CAFEAcA87vxBQsh4HH-3saV1jN=xJOJ7MAbjhCVxD6ry7gNvAAQ@mail.gmail.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <96705ba7-9db5-51b6-77ad-177f537b2dcb@adacore.com>
Date: Wed, 22 Nov 2017 10:34:05 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA87vxBQsh4HH-3saV1jN=xJOJ7MAbjhCVxD6ry7gNvAAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.12 1/2] cadence_ttc: extract
 CadenceTTCState to a new header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>



On 11/21/2017 07:41 PM, Peter Maydell wrote:
> On 8 November 2017 at 11:32, KONRAD Frederic
> <frederic.konrad@adacore.com> wrote:
>> We want to add this model to the xlnx-zynqmp board so let's make
>> CadenceTTCState available in an header file.
>>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>> ---
>>   hw/timer/cadence_ttc.c         | 35 +-----------------------
>>   include/hw/timer/cadence_ttc.h | 61 ++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 62 insertions(+), 34 deletions(-)
>>   create mode 100644 include/hw/timer/cadence_ttc.h
>>
>> diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
>> index 03f5b9c..bb4a5ef 100644
>> --- a/hw/timer/cadence_ttc.c
>> +++ b/hw/timer/cadence_ttc.c
>> @@ -16,9 +16,7 @@
>>    * with this program; if not, see <http://www.gnu.org/licenses/>.
>>    */
>>
>> -#include "qemu/osdep.h"
>> -#include "hw/sysbus.h"
>> -#include "qemu/timer.h"
>> +#include "hw/timer/cadence_ttc.h"
> 
> Something's gone wrong here. osdep.h should always be the first
> header in any .c file, and it should never be included by any
> other .h file.
> 
> thanks
> -- PMM
> 

Hi Peter,

Thanks for your input. I'll fix that.

Fred
