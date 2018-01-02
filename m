Received: from eggs.gnu.org ([2001:4830:134:3::10]:58103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWWMr-0008V7-Fy
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:53:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWWMn-00020h-8F
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:53:13 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:60376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWWMm-00020C-Um
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 18:53:09 -0500
References: <20180102011032.30056-1-laurent@vivier.eu>
	<20180102011032.30056-9-laurent@vivier.eu>
	<9ca4c6cb-0a15-de72-b303-d05354dbda93@linaro.org>
	<bd1a6b92-c328-3b47-e32c-addfccec7c75@vivier.eu>
	<a672c1c9-5a8c-8831-489d-06b69382b5e3@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <cfb91ac3-c027-2c56-80fa-772ee68c08c6@vivier.eu>
Date: Wed, 3 Jan 2018 00:53:04 +0100
MIME-Version: 1.0
In-Reply-To: <a672c1c9-5a8c-8831-489d-06b69382b5e3@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 08/17] target/m68k: add move16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

Le 03/01/2018 à 00:49, Richard Henderson a écrit :
> On 01/02/2018 10:42 AM, Laurent Vivier wrote:
>> Le 02/01/2018 à 17:50, Richard Henderson a écrit :
>>> On 01/01/2018 05:10 PM, Laurent Vivier wrote:
>>>> +    mode = (insn >> 3) & 7;
>>>> +
>>>> +    if (mode & 4) {
>>>
>>> Looks like mode should equal 4 as well.
>>>
>>
>> Yes, you're right. I will replace the line by:
>>
>> +    if (mode == 4) {
> 
> Well, not quite.  Surely,
> 
>   if (mode & 4) {
>     if (mode != 4) {
>       illegal opcode

I've split the instruction in two parts to manage the illegal opcode in
the opcode table.

Thanks,
Laurent
