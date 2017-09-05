Received: from eggs.gnu.org ([2001:4830:134:3::10]:58385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpBKL-0001Ok-P8
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpBKG-0000nE-VF
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:43:29 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:32855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpBKG-0000mC-PA
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:43:24 -0400
Received: by mail-wr0-x233.google.com with SMTP id a43so7821172wrc.0
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 03:43:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170905033501.GS22515@lemon.lan>
References: <20170717023824.18796-1-famz@redhat.com>
	<20170905033501.GS22515@lemon.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 11:43:03 +0100
Message-ID: <CAFEAcA9bDh7c5WtUb+2qCFk0baj+=M2VvkYr1HW+1w=jqFRN=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 0/6] arm: Make use of DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 5 September 2017 at 04:35, Fam Zheng <famz@redhat.com> wrote:
> Hi,
>
> Ping for 2.11.
>
> Peter, what do you think?
>
> On Mon, 07/17 10:38, Fam Zheng wrote:
>> This is the arm part that was left out from:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04006.html
>>
>> Make use of the new DEFINE_PROP_LINK, in favor of open coded the
>> object_property_add_link. The advantage of it is the property now get reflected
>> in the info qtree output, for a bit more introspectability.
>>
>> Fam Zheng (6):
>>   armv7m: Convert bitband.source-mamory to DEFINE_PROP_LINK
>>   armv7m: Convert armv7m.memory to DEFINE_PROP_LINK
>>   gicv3: Convert to DEFINE_PROP_LINK
>>   xlnx_zynqmp: Convert to DEFINE_PROP_LINK
>>   xilinx_axienet: Convert to DEFINE_PROP_LINK
>>   xilinx_axidma: Convert to DEFINE_PROP_LINK

These look OK, but they've fallen out of the 'patches' cache.
There's a typo in the subject of the bitband one: should
be "memory", not "mamory". Can you fix that, add the reviewed-bys
and resend the series, please, and I'll put it in my queue?

thanks
-- PMM
