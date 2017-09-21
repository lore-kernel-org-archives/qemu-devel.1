Received: from eggs.gnu.org ([2001:4830:134:3::10]:33765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dvAZg-0005Kq-4l
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:08:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dvAZe-0000rZ-VO
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:08:04 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38153)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dvAZe-0000pm-PI
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 19:08:02 -0400
Received: by mail-wm0-x243.google.com with SMTP id x17so6405476wmd.5
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 16:08:02 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <c270c470-fad7-b8ea-b445-c975d3c3c432@adacore.com>
References: <cover.1504656490.git.alistair.francis@xilinx.com>
	<16cf589bc0c0431fbba6bbed8d1a50b49d24e867.1504656490.git.alistair.francis@xilinx.com>
	<c270c470-fad7-b8ea-b445-c975d3c3c432@adacore.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 21 Sep 2017 16:07:31 -0700
Message-ID: <CAKmqyKNp8KVBfr6HJLQ24ew3eFFtTQuiwqeAEv1EycDh-yBUpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v1 2/2] netduino2: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Mon, Sep 11, 2017 at 4:56 AM, KONRAD Frederic
<frederic.konrad@adacore.com> wrote:
>
>
> On 09/06/2017 02:12 AM, Alistair Francis wrote:
>>
>> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
>> ---
>>
>>   hw/arm/netduino2.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
>> index 3cfe332dd1..accca344fd 100644
>> --- a/hw/arm/netduino2.c
>> +++ b/hw/arm/netduino2.c
>> @@ -43,8 +43,13 @@ static void netduino2_init(MachineState *machine)
>>     static void netduino2_machine_init(MachineClass *mc)
>>   {
>> +    const char *val = "cortex-m3";
>> +
>>       mc->desc = "Netduino 2 Machine";
>>       mc->init = netduino2_init;
>> +
>> +    mc->valid_cpu_types = g_array_new(false, false, sizeof(char *));
>> +    g_array_append_val(mc->valid_cpu_types, val);
>>   }
>
>
> Hi Alistair,
>
> Nice idea! Why not adding an helper function which take a const
> char** in argument?

Thanks Fred.

I'm going to send a v2 with just that :)

Thanks,
Alistair

>
> Fred
>
>>     DEFINE_MACHINE("netduino2", netduino2_machine_init)
>>
>
