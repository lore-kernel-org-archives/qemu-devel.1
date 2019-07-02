Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B70EC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349D92054F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 12:33:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349D92054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiHyu-0000YH-Eo
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 08:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47437)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hiHxW-000873-QQ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hiHxV-0002ZO-OE
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:32:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10123)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hiHxV-0002Xw-F9
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 08:32:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BC15A3082AF2;
 Tue,  2 Jul 2019 12:32:28 +0000 (UTC)
Received: from [10.36.116.95] (ovpn-116-95.ams2.redhat.com [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E201D5D9C3;
 Tue,  2 Jul 2019 12:32:27 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <156046151566.26543.17274661862206856605.stgit@gimli.home>
 <156046164094.26543.10016703921328261988.stgit@gimli.home>
 <CAFEAcA_nGMfUYpSiaw7xhRjacZQhY1U780ehA0UR0StyBwammg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <63a37329-f892-ed5f-4929-e40dac25b64d@redhat.com>
Date: Tue, 2 Jul 2019 14:32:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_nGMfUYpSiaw7xhRjacZQhY1U780ehA0UR0StyBwammg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 02 Jul 2019 12:32:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 3/3] vfio/common: Introduce
 vfio_set_irq_signaling helper
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 7/2/19 12:37 PM, Peter Maydell wrote:
> On Thu, 13 Jun 2019 at 22:51, Alex Williamson
> <alex.williamson@redhat.com> wrote:
>>
>> From: Eric Auger <eric.auger@redhat.com>
>>
>> The code used to assign an interrupt index/subindex to an
>> eventfd is duplicated many times. Let's introduce an helper that
>> allows to set/unset the signaling for an ACTION_TRIGGER,
>> ACTION_MASK or ACTION_UNMASK action.
>>
>> In the error message, we now use errno in case of any
>> VFIO_DEVICE_SET_IRQS ioctl failure.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> Reviewed-by: Li Qiang <liq3ea@gmail.com>
>> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> 
> Hi; coverity reports (CID 1402196) a possible unchecked return value
> in this code:
> 
> 
>> @@ -592,26 +550,10 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>>       * be re-asserted on unmask.  Nothing to do if already using QEMU mode.
>>       */
>>      if (vector->virq >= 0) {
>> -        int argsz;
>> -        struct vfio_irq_set *irq_set;
>> -        int32_t *pfd;
>> -
>> -        argsz = sizeof(*irq_set) + sizeof(*pfd);
>> -
>> -        irq_set = g_malloc0(argsz);
>> -        irq_set->argsz = argsz;
>> -        irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
>> -                         VFIO_IRQ_SET_ACTION_TRIGGER;
>> -        irq_set->index = VFIO_PCI_MSIX_IRQ_INDEX;
>> -        irq_set->start = nr;
>> -        irq_set->count = 1;
>> -        pfd = (int32_t *)&irq_set->data;
>> +        int32_t fd = event_notifier_get_fd(&vector->interrupt);
>>
>> -        *pfd = event_notifier_get_fd(&vector->interrupt);
>> -
>> -        ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
>> -
>> -        g_free(irq_set);
>> +        vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX, nr,
>> +                               VFIO_IRQ_SET_ACTION_TRIGGER, fd, NULL);
> 
> In vfp_msix_vector_release() we call vfio_set_irq_signaling(),
> but we don't check the returned error value, whereas in the other
> 7 places we call the function we do check. Is there some missing
> error handling here ?

the difference with the other calls is that we pass a NULL errp here so
we don't need to consume a potential error. Before the introduction of
vfio_set_irq_signaling we had an ioctl call whose returned value was not
tested either. So I think it properly translates what was done before.
It seems we are willingly not producing any error message in that case.
Alex, can you confirm?

Thanks

Eric
> 
> thanks
> -- PMM
> 

