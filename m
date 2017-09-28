Received: from eggs.gnu.org ([2001:4830:134:3::10]:53383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dxhRt-0004TA-FQ
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 18:38:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dxhRs-0005Pu-Jk
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 18:38:29 -0400
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_G8Md3k6EAqoN1=GCcXoCq_8vAUZ_qjOZp5GbnnfmcrA@mail.gmail.com>
References: <cover.1506384414.git.alistair.francis@xilinx.com>
	<e9eb34b7a508fbe3b89bb8b8aa8141f018871081.1506384414.git.alistair.francis@xilinx.com>
	<1788278d-9437-34a0-4a17-d7914d459f77@redhat.com>
	<CAFEAcA_G8Md3k6EAqoN1=GCcXoCq_8vAUZ_qjOZp5GbnnfmcrA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 28 Sep 2017 15:37:55 -0700
Message-ID: <CAKmqyKM9e2R2f3BorZJ9R1XMaAwNRxvCEPGrSm3Jh=O=PnJ-_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v1 1/8] Replace all occurances
 of __FUNCTION__ with __func__
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Yongbok Kim <yongbok.kim@imgtec.com>, "open list:X86" <xen-devel@lists.xenproject.org>, John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
List-ID: <qemu-devel.nongnu.org>

On Wed, Sep 27, 2017 at 4:47 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 26 September 2017 at 06:32, Eric Blake <eblake@redhat.com> wrote:
>> On 09/25/2017 07:08 PM, Alistair Francis wrote:
>>> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
>>> index 58005b6619..32687afced 100644
>>> --- a/hw/arm/nseries.c
>>> +++ b/hw/arm/nseries.c
>>> @@ -463,7 +463,7 @@ static uint32_t mipid_txrx(void *opaque, uint32_t cmd, int len)
>>>      uint8_t ret;
>>>
>>>      if (len > 9) {
>>> -        hw_error("%s: FIXME: bad SPI word width %i\n", __FUNCTION__, len);
>>> +        hw_error("%s: FIXME: bad SPI word width %i\n", __func__, len);
>>
>> Not this patch's problem, but it would probably be simpler if hw_error()
>> were a macro that automatically prefixed __func__, rather than making
>> every caller have to supply it themselves.
>
> I'm not sure there's a great deal of benefit to that change, because
> use of hw_error() in new code is rarely correct (it does an abort()
> so it should never be used for guest-triggered conditions, which is
> about the only time that you might be interested in a guest register
> dump rather than just asserting). Most of its existing uses are in
> crufty old device models.

Ok, another excuse to leave it out :)

Thanks,
Alistair

>
> thanks
> -- PMM
