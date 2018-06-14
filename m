Received: from eggs.gnu.org ([2001:4830:134:3::10]:34051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fTNHC-0003OC-8N
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fTNH9-0001N5-4S
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:06:38 -0400
Date: Thu, 14 Jun 2018 10:06:33 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180614013510.GD3042@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1806141003570.19899@zero.eik.bme.hu>
References: <cover.1528935420.git.balaton@eik.bme.hu>
	<c1ca5bce109e674d0cc7ed46bbcaa41863a6319c.1528935420.git.balaton@eik.bme.hu>
	<20180614013510.GD3042@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v3 7/9] sm501: Implement i2c part for
 reading monitor EDID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Peter Maydell <peter.maydell@linaro.org>

On Thu, 14 Jun 2018, David Gibson wrote:
> On Thu, Jun 14, 2018 at 02:17:00AM +0200, BALATON Zoltan wrote:
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> Again needs a commit message expanding on what this is and why it's
> useful.

What else need to be explained apart from that SM501 has an i2c part which 
is used to access EDID info of attached monitor. But this is what the 
commit title already says. This patch implements that so far not emulated 
part of the chip.

> [snip]
>>  static const VMStateDescription vmstate_sm501_sysbus = {
>>      .name = TYPE_SYSBUS_SM501,
>> -    .version_id = 1,
>> -    .minimum_version_id = 1,
>> +    .version_id = 2,
>> +    .minimum_version_id = 2,
>>      .fields = (VMStateField[]) {
>>          VMSTATE_STRUCT(state, SM501SysBusState, 1,
>>                         vmstate_sm501_state, SM501State),
>
> Additionally, since you're changing the migration stream, you need to
> point out that this is not used in any machine types which support
> cross-version migration.

AFAIK it is only used in SH4 and PPC sam460ex.
