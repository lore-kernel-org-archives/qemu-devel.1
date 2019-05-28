Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E88C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 05:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1C620883
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 05:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1C620883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57243 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVUHG-00039Y-Cg
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 01:03:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVUGH-0002qd-Vm
	for qemu-devel@nongnu.org; Tue, 28 May 2019 01:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hVUGG-000363-VL
	for qemu-devel@nongnu.org; Tue, 28 May 2019 01:02:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44780)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hVUGG-00035h-Qs; Tue, 28 May 2019 01:02:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B0E8CC1306E5;
	Tue, 28 May 2019 05:02:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0413D60D5E;
	Tue, 28 May 2019 05:02:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 8C5AA1138648; Tue, 28 May 2019 07:02:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
References: <51df31ee-54a1-d7be-bef4-71ae003b8811@redhat.com>
	<3fab9e76-53ad-2de7-45df-eb69c8604709@redhat.com>
	<016edc53-278e-cc58-0061-d2c5de80afd2@de.ibm.com>
	<1ddf0d83-ce0c-f1c9-065d-ff88ddb9293b@redhat.com>
	<60d1bf3d-659c-d199-6592-d3659702d754@redhat.com>
	<d38b05af-effc-97a1-0b4a-a0d44a13f769@de.ibm.com>
	<CAFEAcA9K+d+LM5SfDrX0Ljwq8zWQdmJAM4R4cdHhF+tM1F13LQ@mail.gmail.com>
	<87v9xw1gi4.fsf@dusky.pond.sub.org>
	<CAFEAcA-eCdmqgM1vSd2Ju4j9mqnrMZ_Knr4oQEsczLM4Wq_Pdw@mail.gmail.com>
Date: Tue, 28 May 2019 07:02:43 +0200
In-Reply-To: <CAFEAcA-eCdmqgM1vSd2Ju4j9mqnrMZ_Knr4oQEsczLM4Wq_Pdw@mail.gmail.com>
	(Peter Maydell's message of "Mon, 27 May 2019 19:55:51 +0100")
Message-ID: <87ftozf9xo.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 28 May 2019 05:02:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] hw/s390x/ipl: Dubious use of qdev_reset_all_fn
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x <qemu-s390x@nongnu.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 27 May 2019 at 08:52, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>> > Suggestions for how to restructure reset so this doesn't
>> > happen are welcome... "reset follows the bus hierarchy"
>> > works well in some places but is a bit weird in others
>> > (for SoC containers and the like "follow the QOM
>> > hierarchy" would make more sense, but I have no idea
>> > how to usefully transition to a model where you could
>> > say "for these devices, follow QOM tree for reset" or
>> > what an API for that would look like).
>>
>> Here's a QOM composition tree for the ARM virt machine (-nodefaults
>> -device e1000) as visible in qom-fuse under /machine, with irq and
>> qemu:memory-region ommitted for brevity:
>
> virt is a bit of an outlier because as a purely-virtual
> machine it has no "SoC" -- it's just a bag of devices
> at the machine level. It would be interesting to
> also look at a machine that's emulating something
> closer to real hardware (eg one of the aspeed machines,
> or mps2-an521).

Can do.

>> Observations:
>>
>> * Composition tree root machine's containers are not in the qtree.
>>
>> * Composition tree node cortex-a15-arm-cpu is not in the qtree.  That's
>>   because it's not a qdev (in QOM parlance: not a TYPE_DEVICE).
>
> Hmm? The Arm CPUs all subclass CPUClass, which subclasses
> DeviceState. The CPU is a qdev, but it is not in the qtree because
> it does not have a bus it can live on.

You're right.

>> Now let me ramble a bit on reset.
>
> Thanks for this -- I have put this on my list to
> think through in detail next week.

Sounds good.

