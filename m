Received: from eggs.gnu.org ([209.51.188.92]:53616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hE0CJ-0003A3-M6
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:30:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hE0CI-0000QX-BT
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:30:35 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hE0CF-0000Pe-H4
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:30:32 -0400
Received: by mail-pl1-x642.google.com with SMTP id b3so154191plr.7
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 16:30:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20190118213122.22865-1-richard.henderson@linaro.org>
	<20190118213122.22865-48-richard.henderson@linaro.org>
	<86bae9b3-75c8-64df-92d1-b4efc35b646c@vivier.eu>
	<c1dc5dbc-cbc7-16a3-9d14-c93b52c362fd@vivier.eu>
	<2004b6c4-0aea-f535-d2bc-80d5c14537be@linaro.org>
Message-ID: <d0735945-f5de-5ddc-327a-53eaec40d0d1@linaro.org>
Date: Tue, 9 Apr 2019 13:30:26 -1000
MIME-Version: 1.0
In-Reply-To: <2004b6c4-0aea-f535-d2bc-80d5c14537be@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 48/49] linux-user: Split out ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

On 4/9/19 1:15 PM, Richard Henderson wrote:
> On 2/13/19 3:46 AM, Laurent Vivier wrote:
>> In fact it happens with sid, with ppc64 too, but not with m68k and sh4.
>>
>> And only with "unshare --pid --fork".
>>
>> Without "unshare", the result is:
>>
>>   Unsupported ioctl: cmd=0x80047476
>>   bash: cannot set terminal process group (11507): Function not implemented
>>   bash: no job control in this shell
>>   Unsupported ioctl: cmd=0x80087467
>>   Unsupported ioctl: cmd=0x80087467
>>   Unsupported ioctl: cmd=0x802c7415
> 
> I'm just now getting back to this, and cannot replicate the issue

... Oh nevermind.  I should be expecting no "unsupported" at all, since that's
what we get with master.


r~
