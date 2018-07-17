Received: from eggs.gnu.org ([2001:4830:134:3::10]:37387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffVqh-0005Wz-Ht
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ffVqg-0000my-NN
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:41:27 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:41548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ffVqg-0000lz-Hf
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:41:26 -0400
Received: by mail-oi0-x243.google.com with SMTP id k12-v6so4266238oiw.8
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:41:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180717173716.h2bhmmco7uoj2nvp@toto>
References: <1531839343-13828-1-git-send-email-thuth@redhat.com>
	<20180717173716.h2bhmmco7uoj2nvp@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jul 2018 20:41:05 +0100
Message-ID: <CAFEAcA9=RNAjyiN5PT8cxU_rUk9ZGcSSJ2c4uW-V3VC+3SbLNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/microblaze/xlnx-zynqmp-pmu: Fix
 introspection problem in 'xlnx, zynqmp-pmu-soc'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair@alistair23.me>

On 17 July 2018 at 18:37, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> On Tue, Jul 17, 2018 at 04:55:43PM +0200, Thomas Huth wrote:
>> Valgrind complains:
>>
>> echo "{'execute':'qmp_capabilities'} {'execute':'device-list-properties'," \
>>  "'arguments':{'typename':'xlnx,zynqmp-pmu-soc'}}" \
>>  "{'execute': 'human-monitor-command', " \
>>  "'arguments': {'command-line': 'info qtree'}}" | \
>>  valgrind -q microblazeel-softmmu/qemu-system-microblazeel -M none,accel=qtest -qmp stdio
>> [...]
>> ==13605== Invalid read of size 8
>> ==13605==    at 0x2AC69A: qdev_print (qdev-monitor.c:686)
>> ==13605==    by 0x2AC69A: qbus_print (qdev-monitor.c:719)
>> ==13605==    by 0x2591E8: handle_hmp_command (monitor.c:3446)
>>
>> Use the new object_initialize_child() and sysbus_init_child_obj() to
>> fix the issue.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>
>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>
> Peter, could you pick this up for 3.0? Or do you want a pull request?

It's missed rc1 but I'll put it in via target-arm.next for rc2.

thanks
-- PMM
