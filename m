Received: from eggs.gnu.org ([2001:4830:134:3::10]:36897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAXm5-00026x-5S
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAXm0-0006Nx-To
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:28:41 -0400
Received: from 2.mo178.mail-out.ovh.net ([46.105.39.61]:42997)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fAXm0-0006NM-MZ
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 05:28:36 -0400
Received: from player737.ha.ovh.net (unknown [10.109.120.44])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id B9DA214B5F
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 11:28:34 +0200 (CEST)
References: <20180423064020.25434-1-clg@kaod.org>
	<CAFEAcA-LtNpGTV08jvK4i5C5i64WjM5gMB4zGr8P4fkVSkNH7g@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <53691cbf-08bf-e3f7-22d3-601a279aa08a@kaod.org>
Date: Mon, 23 Apr 2018 11:28:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-LtNpGTV08jvK4i5C5i64WjM5gMB4zGr8P4fkVSkNH7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] timer/aspeed: fix vmstate version id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>

On 04/23/2018 11:12 AM, Peter Maydell wrote:
>> diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
>> index 50acbf530a3a..7df19bd9df91 100644
>> --- a/hw/timer/aspeed_timer.c
>> +++ b/hw/timer/aspeed_timer.c
>> @@ -498,8 +498,8 @@ static const VMStateDescription vmstate_aspeed_timer = {
>>
>>  static const VMStateDescription vmstate_aspeed_timer_state = {
>>      .name = "aspeed.timerctrl",
>> -    .version_id = 1,
>> -    .minimum_version_id = 1,
>> +    .version_id = 2,
>> +    .minimum_version_id = 2,
>>      .fields = (VMStateField[]) {
>>          VMSTATE_UINT32(ctrl, AspeedTimerCtrlState),
>>          VMSTATE_UINT32(ctrl2, AspeedTimerCtrlState),
> Wouldn't it be simpler to just fix the incorrect value in
> the VMSTATE_STRUCT_ARRAY(timers, AspeedTimerCtrlState,
> line ?

Yes. Also. 

Or bring back all the version ids to 1, as we never supported 
migration before.

Thanks,

C.
