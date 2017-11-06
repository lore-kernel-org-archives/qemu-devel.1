Received: from eggs.gnu.org ([2001:4830:134:3::10]:56121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBfLV-0002nv-2j
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBfLU-00085j-2K
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:13:37 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:56433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eBfLT-00085A-SP
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:13:36 -0500
Received: by mail-wm0-x22b.google.com with SMTP id z3so13347875wme.5
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 03:13:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0686ba45-7a77-f5b0-537d-07e2c3438e5e@redhat.com>
References: <1508772937-21054-1-git-send-email-eric.auger@redhat.com>
	<1508772937-21054-2-git-send-email-eric.auger@redhat.com>
	<CAFEAcA81ogq6py71ejK7JD52A8LrQz1v92M1HZPCfPVBZy1vww@mail.gmail.com>
	<0686ba45-7a77-f5b0-537d-07e2c3438e5e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Nov 2017 11:13:14 +0000
Message-ID: <CAFEAcA8_yta5s9rsfahqBVBJfqAE_LpU2tmuQz3kcn33OfHsmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2 1/4] hw/intc/arm_gicv3_its: Don't abort on
 table save failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, wanghaibin.wang@huawei.com, Vijay Kilari <vijay.kilari@gmail.com>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, wu.wubin@huawei.com, qemu-stable <qemu-stable@nongnu.org>

On 6 November 2017 at 10:09, Auger Eric <eric.auger@redhat.com> wrote:
> Hi Peter,
>
> On 02/11/2017 13:53, Peter Maydell wrote:
>> On 23 October 2017 at 16:35, Eric Auger <eric.auger@redhat.com> wrote:
>>> The ITS is not fully properly reset at the moment. Caches are
>>> not emptied.
>>>
>>> After a reset, in case we attempt to save the state before
>>> the bound devices have registered their MSIs and after the
>>> 1st level table has been allocated by the ITS driver
>>> (device BASER is valid), the first level entries are still
>>> invalid. If the device cache is not empty (devices registered
>>> before the reset), vgic_its_save_device_tables fails with -EINVAL.
>>> This causes a QEMU abort().
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Reported-by: wanghaibin <wanghaibin.wang@huawei.com>
>>>
>>> ---
>>>
>>> this patch would deserve being cc'ed stable (2.10)
>>> This goes along with patches 1-5 of
>>> [PATCH v5 00/10] vITS Migration fixes and reset, candidate
>>> for being cc'ed stable
>>> ---
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> We could/should put this patch into qemu now, right (it's
>> the rest of the series that's RFC) ?
>
> Yes that's correct.

OK. I have applied 1/4 (and none of the rest) to target-arm.next,
with a cc-stable annotation.

thanks
-- PMM
