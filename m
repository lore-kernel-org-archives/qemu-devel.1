Received: from eggs.gnu.org ([2001:4830:134:3::10]:50127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1djlOD-0001MT-Pa
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1djlO8-0000pi-9e
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:01:05 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:37133)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1djlO8-0000n1-2F
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 08:01:00 -0400
Received: by mail-wr0-x230.google.com with SMTP id z91so95600582wrc.4
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 05:00:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170818191534.GE3108@localhost.localdomain>
References: <20170818190943.23858-1-ehabkost@redhat.com>
	<20170818191534.GE3108@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Aug 2017 13:00:38 +0100
Message-ID: <CAFEAcA-7-4qA1pitGt3ys5wMs+0Ut9dKW3yUjMt8V4r2hQ=bAw@mail.gmail.com>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 18 August 2017 at 20:15, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Fri, Aug 18, 2017 at 04:09:43PM -0300, Eduardo Habkost wrote:
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
>
> I just re-read the schedule wiki page and noticed 2017-08-22 is
> "release _or_ tag -rc4".  Does this mean including this patch
> would slip the schedule for 1 week?

Yes; we have a few patches of the "include this if we're doing
an rc4 anyway" variety, but currently nothing that would mean
we need to do an rc4.

> In that case, I don't think this patch should block the release
> and cause a schedule slip.  We can simply change the NUMA RAM
> assignment algorithm in pc-2.11 and keep the old one in pc-2.10.

OK.

thanks
-- PMM
