Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718B7C47256
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 05:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3841B206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 05:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8ovA+/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3841B206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVpwL-00087g-Bh
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 01:16:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVpvM-0007cI-KN
 for qemu-devel@nongnu.org; Tue, 05 May 2020 01:15:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34584
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVpvK-0004tg-DU
 for qemu-devel@nongnu.org; Tue, 05 May 2020 01:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588655717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iRwPHz35FVgqvxRub6RiX6DG8dJ4k0hxch4B5ZRTdbo=;
 b=C8ovA+/xx15lVNTeRMEbRk1mEkzoLe7uVt+3TzyU5adlBlpCJtOjHdGT2F9EyK0y+meeEH
 6DPkBsyrPyFoI4km+qQRUco8FYQmom7zlNLLjXYDlDURGr5ZK1cbJuxlp4NIASri/689Ls
 1aeQ30Ev1HIzuAgI8MaR5S3gnaUuEqE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-9m6g_NVmNLWVC7rZJVL_7g-1; Tue, 05 May 2020 01:15:15 -0400
X-MC-Unique: 9m6g_NVmNLWVC7rZJVL_7g-1
Received: by mail-wm1-f72.google.com with SMTP id j5so475000wmi.4
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 22:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iRwPHz35FVgqvxRub6RiX6DG8dJ4k0hxch4B5ZRTdbo=;
 b=SSS0/kxhPxaoXw+nW4uhKOOeZRUBlRkTiafLwpqvDITenKFj3vWcdVhABPkW5upKEe
 uha62xTOIooTZmxDjW+1JrIw2QwuRytqF3LhLoso8RqICfkQlYkM5nCIA/Dr/gtEH143
 qkLzM2jwpNL3cMnlOKD0IB9XHHkonR6ijUqx1n252Ti3Trq4kmO4WL3QSsW1IaPHry9l
 KsLHvBPV7Rf1FZAKdKAdpaO5WxCy1RUNxnPqXxDxGV3R5lZSAblOELxSpVk+3pGX8vUj
 wdfavl/CArY+1suC3T59s6U5S/tc0Uv+DOy0M2XhF1Dx/NXYN9Vz0LepshhDmrTSp6t6
 VlEg==
X-Gm-Message-State: AGi0PuZbMc3RsEk4+tIqxs4b34uQNGQSpFYjP0lVIav9tOgMIxegbp2O
 B9BPISchyULc+uidLPHzROqUqxe3TlptYEUjoI2A74pKyplSazg38P7T+GhEKRe+Jv8loW9wy25
 FiJmQPfN37KSaZ5w=
X-Received: by 2002:adf:82c1:: with SMTP id 59mr1400012wrc.377.1588655714506; 
 Mon, 04 May 2020 22:15:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypIxEA8y9xk4nGxA1Lo+KwhIXpBGTHpvfM1G8u2G76LQ+p2aDre9KO7yEDL7tNme7FI1JoEpeA==
X-Received: by 2002:adf:82c1:: with SMTP id 59mr1399978wrc.377.1588655714116; 
 Mon, 04 May 2020 22:15:14 -0700 (PDT)
Received: from [192.168.1.39] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id l5sm1766676wmi.22.2020.05.04.22.15.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 22:15:13 -0700 (PDT)
Subject: Re: [PATCH v4 00/18] nvme: factor out cmb/pmr setup
To: Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org
References: <20200422110152.397572-1-its@irrelevant.dk>
 <20200429054035.qjpyllea6ywnudc3@apples.localdomain>
 <20200505043131.rxpncynapnqomfji@apples.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e2f89c7b-c5f7-4eff-321b-19b122340e50@redhat.com>
Date: Tue, 5 May 2020 07:15:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505043131.rxpncynapnqomfji@apples.localdomain>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:39:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
 Klaus Jensen <k.jensen@samsung.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Javier Gonzalez <javier.gonz@samsung.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Klaus,

On 5/5/20 6:31 AM, Klaus Jensen wrote:
> On Apr 29 07:40, Klaus Jensen wrote:
>> On Apr 22 13:01, Klaus Jensen wrote:
>>> From: Klaus Jensen <k.jensen@samsung.com>
>>>
>>> Changes since v3
>>> ~~~~~~~~~~~~~~~~
>>> * Remove the addition of a new PROPERTIES macro in "nvme: move device
>>>    parameters to separate struct" (Philippe)
>>>
>>> * Add NVME_PMR_BIR constant and use it in PMR setup.
>>>
>>> * Split "nvme: factor out cmb/pmr setup" into
>>>    - "nvme: factor out cmb setup",
>>>    - "nvme: factor out pmr setup" and
>>>    - "nvme: do cmb/pmr init as part of pci init"
>>>    (Philippe)
>>>
>>>
>>> Klaus Jensen (18):
>>>    nvme: fix pci doorbell size calculation
>>>    nvme: rename trace events to pci_nvme
>>>    nvme: remove superfluous breaks
>>>    nvme: move device parameters to separate struct
>>>    nvme: use constants in identify
>>>    nvme: refactor nvme_addr_read
>>>    nvme: add max_ioqpairs device parameter
>>>    nvme: remove redundant cmbloc/cmbsz members
>>>    nvme: factor out property/constraint checks
>>>    nvme: factor out device state setup
>>>    nvme: factor out block backend setup
>>>    nvme: add namespace helpers
>>>    nvme: factor out namespace setup
>>>    nvme: factor out pci setup
>>>    nvme: factor out cmb setup
>>>    nvme: factor out pmr setup
>>>    nvme: do cmb/pmr init as part of pci init
>>>    nvme: factor out controller identify setup
>>>
>>>   hw/block/nvme.c       | 543 ++++++++++++++++++++++++------------------
>>>   hw/block/nvme.h       |  31 ++-
>>>   hw/block/trace-events | 180 +++++++-------
>>>   include/block/nvme.h  |   8 +
>>>   4 files changed, 429 insertions(+), 333 deletions(-)
>>>
>>> -- 
>>> 2.26.2
>>>
>>>
>>
>> Gentle bump on this.
>>
>> I apparently managed to screw up the git send-email this time, loosing a
>> bunch of CCs in the process. Sorry about that.
>>
> 
> Bumping again. I have not received any new comments on this.

My understanding is:
- this series goes via Kevin tree
- Kevin was waiting for Keith review (which occurred)
- Kevin tried to apply and asked for rebase
- Minor cosmetics changes on top (not logical)

> 
> I'm missing a couple of Reviewed-by's (they all carry Maxim's) on
> 
>    nvme: move device parameters to separate struct
>        I think this can also carry Philippe's Reviewed-by, since the only
>        change is the removal of the PROPERTIES macro.

I don't have this anymore in my mailbox, meaning I processed your 
series, likely giving a R-b.

> 
>    nvme: factor out cmb setup
>    nvme: factor out pmr setup
>    nvme: do cmb/pmr init as part of pci init
>        I think these could also carry Reviewed-by from Keith as well,
>        since the only change is also factoring out the PMR setup (which
>        was not there when Keith reviewed it) and the splitting into two
>        trivial patches per request from Philippe.

If respining a rebased v5 with all the previous tags added takes you 
<5min, I recommend you to do it, this will help Kevin. If you are 
comfortable with git-rebase and use git-publish, it can take you only 
2min :)

Looking forward for the next parts until the multiple namespace support!

Regards,

Phil.

> 
> 
> Thanks,
> Klaus
> 


