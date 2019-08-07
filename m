Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39279C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD9A421BF6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="p6ennENR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD9A421BF6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNrW-0000p6-7l
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53773)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <damien.hedde@greensocs.com>) id 1hvNqx-0008Fa-M4
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1hvNqw-000314-Jc
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:27:51 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:58808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1hvNqs-0002xH-5c; Wed, 07 Aug 2019 11:27:46 -0400
Received: from [172.16.11.117] (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPSA id EC3B796F51;
 Wed,  7 Aug 2019 15:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1565191665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h7lZm82hPeFXdiuA9kDLc9kVj83kGNIjYR0pBvnH5gw=;
 b=p6ennENRvOK9M8ngecsDohdeLyNmzOukYnxBMF4S3vN5ScMdLO3ODx2IPlGGOtc7e0F63T
 ynBfdzmF+BR9lQECHXN2YQxKVgjYt0d/AaqKgJSPqgPU4g58UYYadnH/4mwxpd5sore7Sn
 bImjfLi21OMb2QFWLGT52BgaopMYQCY=
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-7-damien.hedde@greensocs.com>
 <CAFEAcA_PdOUTFAHBWxEvWLa1oP0BCMNs1zBJo-DV3OjrMLpPkA@mail.gmail.com>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <aa5be9e7-8754-8bab-fc90-b5f712647aa1@greensocs.com>
Date: Wed, 7 Aug 2019 17:27:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_PdOUTFAHBWxEvWLa1oP0BCMNs1zBJo-DV3OjrMLpPkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1565191665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h7lZm82hPeFXdiuA9kDLc9kVj83kGNIjYR0pBvnH5gw=;
 b=lOp4JXJqqkVXNCqKFHSocH6PpogmzsEcwShpdA1Vz0F/1hVkly7f/ZnlCvOICgw8Tsw4Fx
 mOik0k61pbcHY2FLKc9zCQ0z8BMWD1dlAGCk/scpyFIZwP9Dl7UVpjQ+5BecJD9jekNOGD
 V0tth8GCh3Wi72J5DkOy3k464tXO8SU=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1565191665; a=rsa-sha256; cv=none;
 b=p0UBGVu+v6MAB/H8enTgws4FSVzQhtAHcfAfjWVQwBYWuq2Xm3byDtVojG6e6osR37huLG
 NsbjVMwQx1AlViJLRj8sNoxYVYhsy4Lk/gxT944RM5DWgaCttB/bLNTrU/2vEQr32lSxNi
 x/3gyVKHKqcn0DMQ3eH3o8p1LjpOPH8=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH v3 06/33] add the vmstate description for
 device reset state
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/7/19 4:54 PM, Peter Maydell wrote:
> On Mon, 29 Jul 2019 at 15:58, Damien Hedde <damien.hedde@greensocs.com> wrote:
>>
>> It contains the resetting counter and cold flag status.
>>
>> At this point, migration of bus reset related state (counter and cold/warm
>> flag) is handled by parent device. This done using the post_load
>> function in the vmsd subsection.
>>
>> This is last point allow to add an initial support of migration with part of
>> qdev/qbus tree in reset state under the following condition:
>> + time-lasting reset are asserted on Device only
>>
>> Note that if this condition is not respected, migration will succeed and
>> no failure will occurs. The only impact is that the resetting counter
>> of a bus may lower afer a migration.
>>
>> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> 
> 
>> +const struct VMStateDescription device_vmstate_reset = {
>> +    .name = "device_reset",
>> +    .version_id = 0,
>> +    .minimum_version_id = 0,
>> +    .needed = device_vmstate_reset_needed,
>> +    .post_load = device_vmstate_reset_post_load,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT32(resetting, DeviceState),
>> +        VMSTATE_BOOL(reset_is_cold, DeviceState),
>> +        VMSTATE_END_OF_LIST()
>> +    },
>> +};
>> -
> 
> Forgot to ask -- why don't we migrate the hold_needed flags?

The flag is only used to keep the info between executing the init
and hold phases. We can't interrupt the code in between since this
mess is during resettable_assert_reset method which is atomic.
I can add a comment to explain that.

> 
> thanks
> -- PMM
> 

