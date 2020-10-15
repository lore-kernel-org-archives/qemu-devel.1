Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09401C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:04:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 476E820797
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSJ2IpME"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476E820797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT7cG-0007NH-36
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT7Zn-00065D-CO
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42281)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kT7Zk-0001xt-Qd
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602784922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mag/Kcm/YoTzcvdAz05eCoVI8A8FD2AuRXcNnSFNPZI=;
 b=QSJ2IpMEP6EIQwMMZtFbf21UOeDzab4b6FT9//9YZtW7EgEzSegWT2HEbbzIMqjRJ1OJrJ
 DSQ76/OSmDc0tf0kWKhsl/02K8kxJNdZ9q0Uuud55cz4JvjI2PMjy+hlesig4TtBYZ6j4P
 5LpBnqx5ZgkrdOUrWbEeNJBfCmYRTqQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-8tC8ChJVPuSRFibeYtRqDg-1; Thu, 15 Oct 2020 14:02:01 -0400
X-MC-Unique: 8tC8ChJVPuSRFibeYtRqDg-1
Received: by mail-wr1-f70.google.com with SMTP id v5so30483wrr.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 11:01:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Mag/Kcm/YoTzcvdAz05eCoVI8A8FD2AuRXcNnSFNPZI=;
 b=l79TLcRZ8J6l2eRShqPskX25HVP/YYwkFiHpB3HoYKHja/infCe36zTEzgZwnNr7s8
 2+IzYqbHfWQToCKawDnbKDKf8sLNFPseNRiqC4SzFJqP+urBv5+ZWFqlspmIryUIsarh
 ny7zBLH5KXZSrTxoC/iRdGGqMraedpCPf5Vo7sLjFpq4pc57GhXV39jaKE5s4cFxR2Yp
 90sEf9d0tssvaznCfcMe5Vc+4dyQgLWV0x/1+dBLVir2C/d2YNPG13Hur31Zsbq5KF7E
 okk9F+L5kNBd0sPB5gKqWX9q38lBfMKyg+5jgYbQeBG0voqMJ20e/5+59VBsyMdMBb4N
 8EMQ==
X-Gm-Message-State: AOAM530b/Q6j+pri//ZzIeuMsfQIBbOrX07hHK2TZxUic6/Cfw7VPR3n
 PuJcv+i/RrVOrY48YXtZkfbgo6yJEMlRvAsUqVjkZ03w6FBR2T5+svKfLQfdqftaF+d81VHj6zP
 CyDbMz+x2w7s5p1k=
X-Received: by 2002:adf:eac6:: with SMTP id o6mr6046144wrn.117.1602784918930; 
 Thu, 15 Oct 2020 11:01:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHOEoV2N0xa+Wl8cmGuiyeKeKCwOjsoehUK367fV9FRRRocdCj1qR2jYvbUblt4t9jqUyLvQ==
X-Received: by 2002:adf:eac6:: with SMTP id o6mr6046091wrn.117.1602784918551; 
 Thu, 15 Oct 2020 11:01:58 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id l1sm57584wrb.1.2020.10.15.11.01.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2020 11:01:57 -0700 (PDT)
Subject: Re: [RFC 0/5] NVMe passthrough: Support 64kB page host
To: Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, stefanha@redhat.com,
 fam@euphon.net, alex.williamson@redhat.com
References: <20201015115252.15582-1-eric.auger@redhat.com>
 <0a1ae4dd-064b-49c5-0669-04219646f616@redhat.com>
 <d3ba4c98-67b8-0d38-378a-805fb02b3d40@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <920515f6-aae8-41fa-007a-701bdd6cdf1c@redhat.com>
Date: Thu, 15 Oct 2020 20:01:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <d3ba4c98-67b8-0d38-378a-805fb02b3d40@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/20 6:15 PM, Auger Eric wrote:
> Hi Philippe,
> 
> On 10/15/20 3:49 PM, Philippe Mathieu-Daudé wrote:
>> On 10/15/20 1:52 PM, Eric Auger wrote:
>>> This series allows NVMe passthrough on aarch64 with 64kB page host.
>>> Addresses and sizes of buffers which are VFIO DMA mapped are
>>> aligned with the host page size.
>>>
>>> nvme_register_buf() path is taken care of in this series
>>> but it does not seem to prevent the use case from working.
>>>
>>> Best Regards
>>>
>>> Eric
>>>
>>> This series can be found at:
>>> https://github.com/eauger/qemu/tree/nvme_64k_rfc
>>>
>>> This was tested on ARM only.
>>>
>>> Eric Auger (5):
>>>     block/nvme: use some NVME_CAP_* macros
>>>     block/nvme: Change size and alignment of IDENTIFY response buffer
>>>     block/nvme: Change size and alignment of queue
>>>     block/nvme: Change size and alignment of prp_list_pages
>>>     block/nvme: Align iov's va and size on host page size
>>
>> Since it is easier for me to rebase on top of your series,
>> I'm including it in my work (fixing the checkpatch errors)
>> and will repost block/nvme/ patches altogether.
> 
> There should be one warning (line exceeding 80 chars) but no error. I
> can easily rebase/respin if you prefer.

Yes, warnings, no error. No need to respin.

> 
> Thanks
> 
> Eric
>>
>> Regards,
>>
>> Phil.
>>
>>
> 


