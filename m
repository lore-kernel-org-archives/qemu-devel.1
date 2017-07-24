Received: from eggs.gnu.org ([2001:4830:134:3::10]:43557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dZaHX-0003Op-Hu
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1dZaHS-0008Em-Kv
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:08:07 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:33152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1dZaHS-0008EA-Gs
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:08:02 -0400
Received: by mail-ua0-f178.google.com with SMTP id 80so74540213uas.0
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 03:08:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170721121206.63bcbffd@nial.brq.redhat.com>
References: <1500629531-184026-1-git-send-email-imammedo@redhat.com>
	<CABdb736GdDK_Kxa4u_eCt=1qiV0Hn69NfrvofJTFgaXJzx1gow@mail.gmail.com>
	<20170721121206.63bcbffd@nial.brq.redhat.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon, 24 Jul 2017 12:07:59 +0200
Message-ID: <CABdb734pB_DHeZ=NRp4DOP=fiXz-+wN=DX5fx2hUuo-u=4HJFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] pc: acpi: force FADT rev1 for old i440fx
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Programmingkid <programmingkidx@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Phil Dennis-Jordan <lists@philjordan.eu>

On Fri, Jul 21, 2017 at 12:12 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Fri, 21 Jul 2017 11:54:20 +0200
> Ladi Prosek <lprosek@redhat.com> wrote:
>
>> On Fri, Jul 21, 2017 at 11:32 AM, Igor Mammedov <imammedo@redhat.com> wrote:
>> > w2k used to boot on QEMU until we bumped revision of FADT to rev3
>> > (commit 77af8a2b hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve guest OS support.)
>> >
>> > Considering that w2k is ancient and long time EOLed, leave default
>> > rev3 but make pc-i440fx-2.9 and older machine types to force rev1
>> > so old setups won't break (w2k could boot).
>> >
>> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>> > ---
>> > CC: Programmingkid <programmingkidx@gmail.com>
>> > CC: Phil Dennis-Jordan <lists@philjordan.eu>
>> > CC: "Michael S. Tsirkin" <mst@redhat.com>
>> >
>> > Only compile test since I don't have w2k to test with
>>
>> Confirming that Windows 2000 boots with this patch and -machine pc-i440fx-2.9.
> Ladi,
>
> Could you to try find out reason why w2k doesn't boot?

The FADT table must be 134 bytes or less. The revision number does not
matter and neither does the checksum.

This is experimental data, I haven't been able to find the offending code.

>>
>> Tested-by: Ladi Prosek <lprosek@redhat.com>
>
