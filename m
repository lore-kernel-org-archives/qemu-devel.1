Received: from eggs.gnu.org ([2001:4830:134:3::10]:44488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dxM3i-0000Zq-Bn
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 19:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dxM3g-00033g-Gw
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 19:48:05 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:43512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dxM3g-000333-8Y
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 19:48:04 -0400
Received: by mail-wr0-x22b.google.com with SMTP id a43so19127695wrc.0
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 16:48:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1788278d-9437-34a0-4a17-d7914d459f77@redhat.com>
References: <cover.1506384414.git.alistair.francis@xilinx.com>
	<e9eb34b7a508fbe3b89bb8b8aa8141f018871081.1506384414.git.alistair.francis@xilinx.com>
	<1788278d-9437-34a0-4a17-d7914d459f77@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 27 Sep 2017 16:47:42 -0700
Message-ID: <CAFEAcA_G8Md3k6EAqoN1=GCcXoCq_8vAUZ_qjOZp5GbnnfmcrA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v1 1/8] Replace all occurances
 of __FUNCTION__ with __func__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-arm <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alistair Francis <alistair23@gmail.com>, Yongbok Kim <yongbok.kim@imgtec.com>, "open list:X86" <xen-devel@lists.xenproject.org>, John Snow <jsnow@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 26 September 2017 at 06:32, Eric Blake <eblake@redhat.com> wrote:
> On 09/25/2017 07:08 PM, Alistair Francis wrote:
>> diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
>> index 58005b6619..32687afced 100644
>> --- a/hw/arm/nseries.c
>> +++ b/hw/arm/nseries.c
>> @@ -463,7 +463,7 @@ static uint32_t mipid_txrx(void *opaque, uint32_t cmd, int len)
>>      uint8_t ret;
>>
>>      if (len > 9) {
>> -        hw_error("%s: FIXME: bad SPI word width %i\n", __FUNCTION__, len);
>> +        hw_error("%s: FIXME: bad SPI word width %i\n", __func__, len);
>
> Not this patch's problem, but it would probably be simpler if hw_error()
> were a macro that automatically prefixed __func__, rather than making
> every caller have to supply it themselves.

I'm not sure there's a great deal of benefit to that change, because
use of hw_error() in new code is rarely correct (it does an abort()
so it should never be used for guest-triggered conditions, which is
about the only time that you might be interested in a guest register
dump rather than just asserting). Most of its existing uses are in
crufty old device models.

thanks
-- PMM
