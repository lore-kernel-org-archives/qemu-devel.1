Received: from eggs.gnu.org ([2001:4830:134:3::10]:46571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1duN4x-0008Cv-2t
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1duN4v-0005El-Tc
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:17:03 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:37145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1duN4v-0005Bh-N6
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:17:01 -0400
Received: by mail-wm0-x243.google.com with SMTP id f4so369106wmh.4
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 11:17:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8wBR6R9FNgmg0YAPuVVxjj5Ls_xEoS1VZ8OdxjJK1mrA@mail.gmail.com>
References: <20170918215719.16415-1-f4bug@amsat.org>
	<CAFEAcA8wBR6R9FNgmg0YAPuVVxjj5Ls_xEoS1VZ8OdxjJK1mrA@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Sep 2017 11:16:29 -0700
Message-ID: <CAKmqyKNL_dFehZn5QAHSG0Q2cgNbNZGWsdHDcmQg4stBZ8H4Rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] vl.c: add is_system_on_chip flag to
 force board default cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Sep 19, 2017 at 2:03 AM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
> On 18 September 2017 at 22:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>> add a property to restrict the CPU for SoCs once on machine creation and=
 avoid
>> duplicate code in each board.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> Based-on: 1505318697-77161-6-git-send-email-imammedo@redhat.com
>>
>>  include/hw/boards.h |  3 +++
>>  vl.c                | 11 +++++++++++
>>  2 files changed, 14 insertions(+)
>>
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 6b67adaef6..20dc0a0ab9 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -129,6 +129,8 @@ typedef struct {
>>   *    specifies default CPU_TYPE, which will be used for parsing target
>>   *    specific features and for creating CPUs if CPU name wasn't provid=
ed
>>   *    explicitly at CLI
>> + * @is_system_on_chip:
>> + *    If true, board does not support other CPUs than default_cpu_type.
>
> Being an SoC isn't the only reason a board might only support one
> CPU type (perhaps it just never existed with other than a single
> CPU soldered into it), so maybe a different name?

I don't think this makes a lot of sense. There are some SoCs that are
basically the same besides the CPU. I think a list of possible CPUs
makes more sense for machines. That way the list can be used for every
machine and not just machines with a single CPU. If your SoC only
supports one CPU then you only describe one, but if you want others
you can list others.

Thanks,
Alistair

>
> thanks
> -- PMM
>
