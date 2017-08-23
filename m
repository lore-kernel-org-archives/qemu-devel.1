Received: from eggs.gnu.org ([2001:4830:134:3::10]:54740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkXLf-00047M-7F
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dkXLZ-0005Un-Lb
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:13:39 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:37423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dkXLZ-0005UC-Dt
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 11:13:33 -0400
Received: by mail-wm0-x229.google.com with SMTP id b189so1086440wmd.0
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 08:13:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170823144734.0a5f920c@nial.brq.redhat.com>
References: <20170818190943.23858-1-ehabkost@redhat.com>
	<20170823144734.0a5f920c@nial.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 23 Aug 2017 16:13:11 +0100
Message-ID: <CAFEAcA8WoyX6NcLxJPqLb1h70sSAguXykriEXR04-pJNDUYXMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.10] numa: Move
 numa_legacy_auto_assign_ram to pc-i440fx-2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 23 August 2017 at 13:47, Igor Mammedov <imammedo@redhat.com> wrote:
> On Fri, 18 Aug 2017 16:09:43 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>
>> The 'm->numa_auto_assign_ram = numa_legacy_auto_assign_ram;' line
>> was supposed to be in pc_i440fx_2_9_machine_options() (see commit
>> 3bfe5716 "numa: equally distribute memory on nodes"), but the
>> merge commit adb354dd ("Merge remote-tracking branch
>> 'mst/tags/for_upstream' into staging") moved it to the
>> pc_i440fx_2_10_machine_options().
>>
>> Move the line back to pc_i440fx_2_9_machine_options().
>>
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>
>
> Peter,
>
> Could you merge this mis-merge fix as well for rc4?

Sure, applied to master.

thanks
-- PMM
