Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1988C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C13B20737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P5mo/rBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C13B20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOi4u-0006FL-Gd
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 09:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37533)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOi49-0005Zc-CY
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOi48-0006Hc-3M
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:26:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59783
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOi48-0006Ga-0D
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586957215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AL8vBG+2n01lIbF9Ym9y3P0wwWeku/fOqpRZyWXFcdQ=;
 b=P5mo/rBhf5Xa2xEsiwMlpgfWZZC9nZpKZKufwqAFhTDavrk+8a1P8ZTfXm98+hmrqe2fLN
 0nYxNDyq7A02bbSxcw2HQEEiso3VtvRTzf6r6ZIVuUDBw2qcsQvYciE93q8FVxvp5SWa1Z
 O33z4swlH3JQM2cdScAsEoBSxp7Roys=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-jaoH6akQN0Cg_HUEDLBEBg-1; Wed, 15 Apr 2020 09:26:53 -0400
X-MC-Unique: jaoH6akQN0Cg_HUEDLBEBg-1
Received: by mail-ed1-f72.google.com with SMTP id i10so2932613edk.13
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 06:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Be2k0OydmFrOaikRfvY3JXMAAqrzKvI+flBCw+25uiE=;
 b=AXTe/g94UnDUbgsfVaHkgarK/0wdzwNn/OVsDs8SkofSx7drm+Oh+OUWOxCwOqVSO9
 +ZAV1HgYLlHEZUN0IvlMv1x1SkhYINcNT0R8Y0NO6JIL8dMmZjKYwo+Ne2G7c879ccEN
 7b214kQ3vM2hTg8ST5fkB+4VxiNVt2uM8pOrsynWlpKOxt7YIA4Y2MtsIZkyqxdH+W1n
 sfJTDxOBZIMtYYdHgXs0Ht2LYgtYYmtc6yceGf9iu58iTQ1rY9/cbQjajMf+SX188+x6
 aZ+L1+vCxXlYcJuZEm7jb69tGpbj+MNbZPOkEFU3/Q4ETtufG2GrwauLIwKDgDngziZV
 XyHw==
X-Gm-Message-State: AGi0PuZppoHSltJd+uTgRjtm0IOO+++FP3bpFQ2u4PW2vHinGIde/r2c
 BL/rJ2JBI7bh/hvAwm+nqUa2C9vtxLsfKGQ7mTPph8uhJS08guC1BIq0DZxzahYWNp1e2A/+KBh
 pdB+39ZCLLEEpFu8=
X-Received: by 2002:a17:906:4308:: with SMTP id
 j8mr4717783ejm.261.1586957210726; 
 Wed, 15 Apr 2020 06:26:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypIDs6QYdqOUVLlBv50a/DLWqrakuRr/MzwBso1H36vORa7luWmop2uMA+gUy+Fq3HuGBC/jeA==
X-Received: by 2002:a17:906:4308:: with SMTP id
 j8mr4717758ejm.261.1586957210473; 
 Wed, 15 Apr 2020 06:26:50 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b18sm1141944edw.58.2020.04.15.06.26.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2020 06:26:49 -0700 (PDT)
Subject: Re: [PATCH v2 13/16] nvme: factor out namespace setup
To: Klaus Birkelund Jensen <its@irrelevant.dk>
References: <20200415130159.611361-1-its@irrelevant.dk>
 <20200415130159.611361-14-its@irrelevant.dk>
 <b05fdbb7-2f74-be05-e108-36b14abce0be@redhat.com>
 <20200415132004.zei3gqxg5l6r5c6y@apples.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <075d6fbf-f4a0-fa71-f8c0-978b262b5d63@redhat.com>
Date: Wed, 15 Apr 2020 15:26:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200415132004.zei3gqxg5l6r5c6y@apples.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Beata Michalska <beata.michalska@linaro.org>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Javier Gonzalez <javier.gonz@samsung.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/15/20 3:20 PM, Klaus Birkelund Jensen wrote:
> On Apr 15 15:16, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 4/15/20 3:01 PM, Klaus Jensen wrote:
>>> From: Klaus Jensen <k.jensen@samsung.com>
>>>
>>> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
>>> ---
>>>    hw/block/nvme.c | 46 ++++++++++++++++++++++++++--------------------
>>>    1 file changed, 26 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
>>> index d5244102252c..2b007115c302 100644
>>> --- a/hw/block/nvme.c
>>> +++ b/hw/block/nvme.c
>>> @@ -1358,6 +1358,27 @@ static void nvme_init_blk(NvmeCtrl *n, Error **e=
rrp)
>>>                                      false, errp);
>>>    }
>>> +static void nvme_init_namespace(NvmeCtrl *n, NvmeNamespace *ns, Error =
**errp)
>>> +{
>>> +    int64_t bs_size;
>>> +    NvmeIdNs *id_ns =3D &ns->id_ns;
>>> +
>>> +    bs_size =3D blk_getlength(n->conf.blk);
>>> +    if (bs_size < 0) {
>>> +        error_setg_errno(errp, -bs_size, "could not get backing file s=
ize");
>>> +        return;
>>> +    }
>>> +
>>> +    n->ns_size =3D bs_size;
>>> +
>>> +    id_ns->lbaf[0].ds =3D BDRV_SECTOR_BITS;
>>> +    id_ns->nsze =3D cpu_to_le64(nvme_ns_nlbas(n, ns));
>>> +
>>> +    /* no thin provisioning */
>>> +    id_ns->ncap =3D id_ns->nsze;
>>> +    id_ns->nuse =3D id_ns->ncap;
>>> +}
>>> +
>>>    static void nvme_realize(PCIDevice *pci_dev, Error **errp)
>>>    {
>>>        NvmeCtrl *n =3D NVME(pci_dev);
>>> @@ -1365,7 +1386,6 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
>>>        Error *err =3D NULL;
>>>        int i;
>>> -    int64_t bs_size;
>>>        uint8_t *pci_conf;
>>>        nvme_check_constraints(n, &err);
>>> @@ -1376,12 +1396,6 @@ static void nvme_realize(PCIDevice *pci_dev, Err=
or **errp)
>>>        nvme_init_state(n);
>>> -    bs_size =3D blk_getlength(n->conf.blk);
>>> -    if (bs_size < 0) {
>>> -        error_setg(errp, "could not get backing file size");
>>> -        return;
>>> -    }
>>> -
>>>        nvme_init_blk(n, &err);
>>>        if (err) {
>>>            error_propagate(errp, err);
>>> @@ -1394,8 +1408,6 @@ static void nvme_realize(PCIDevice *pci_dev, Erro=
r **errp)
>>>        pci_config_set_class(pci_dev->config, PCI_CLASS_STORAGE_EXPRESS)=
;
>>>        pcie_endpoint_cap_init(pci_dev, 0x80);
>>> -    n->ns_size =3D bs_size / (uint64_t)n->num_namespaces;
>>
>> Valid because currently 'n->num_namespaces' =3D 1, OK.
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>  =20
> Thank you for the reviews Philippe and the suggesting that I split up
> the series :)

No prob, thanks for the quick fixes. Let's see if Keith is happy with=20
v2. Personally I don't have anymore comments.

>=20
> I'll get the v1.3 series ready next.
>=20

Cool. What really matters (to me) is seeing tests. If we can merge tests=20
(without multiple namespaces) before the rest of your series, even=20
better. Tests give reviewers/maintainers confidence that code isn't=20
breaking ;)

Regards,

Phil.


