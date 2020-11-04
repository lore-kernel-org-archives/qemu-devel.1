Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35D9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9902E207BB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 21:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Krz5/Ue/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9902E207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaQ5N-0004ib-Hn
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 16:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaQ4R-0004Hb-St
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 16:11:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaQ4P-00042n-7q
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 16:11:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604524311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnaWdBNA4qUU6UPjoA7hAkYCZVQ9H4SLeiQOJHnJ2XE=;
 b=Krz5/Ue/1zwmnJN6Xhqf5lWEBeFTtFenY6gU6t8KZsKG218xbcxsYy1yT3FsWeSA3KP1j2
 Y0Mihw/sYMXpiw75ab1fmiJNmcxXVIMSftbyWp9OwGP1F0/JQpftJ28iGkvIayBkOq0I2E
 8XRsHNOluxg9bG/KMaPCH1MHs/Aa8pM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-uc7cLVY-NkyheXMxbv5ebw-1; Wed, 04 Nov 2020 16:11:49 -0500
X-MC-Unique: uc7cLVY-NkyheXMxbv5ebw-1
Received: by mail-wm1-f72.google.com with SMTP id b68so1035815wme.5
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 13:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CnaWdBNA4qUU6UPjoA7hAkYCZVQ9H4SLeiQOJHnJ2XE=;
 b=Ix7/70RSHPKVon1ax/dVs4nNSFEj4Ke0r09ggL83nZM/mOA9LqaZsF0QcFeMsarW8l
 yONQ4Rpaih1tnMY+GpNLWCev8i3vEVDk5+o/V8FEMP4NA8TkJp3AqVbBiHqvFIx0ETY6
 VrLHTYE3KmL6B2e3aLxDMP4idO8yVpjUfsSAVqC3p8sPvbzBjLrK5EtpmjllALezZSIc
 sb1PbkjqFNsYCwXfWYXHpIFSlW/zqEEhf12oYHN6g+wvaz/KXNblMJhB+6wwW3wom/R3
 PQ/JHdK/qdMmER288qG2NcQCpa9X0rcstaRpnoN9+czjtD4kWfkoGpxMB15F5OwQCEL0
 aIKQ==
X-Gm-Message-State: AOAM530/8pYGss75lDrpo+n0Pak/Xz9XS8V1aak4q4fIz3BzwZ/vYa6V
 nGwUxxBbBnzPC58CV0A05a7oufyhFZpHF1JYYq6j6i2OM4KRjxlLdPoWm4QwyLLfaKWZOLnz6Oe
 +xOSu8r+7jXOp+3U=
X-Received: by 2002:a1c:e442:: with SMTP id b63mr423669wmh.10.1604524308453;
 Wed, 04 Nov 2020 13:11:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8aWp4sa3fyCGwKy93PhvLbyq4VzSbwHhXbchgIyteCEOr575HtJeg6ubeoLurL1enhaqHpw==
X-Received: by 2002:a1c:e442:: with SMTP id b63mr423645wmh.10.1604524308191;
 Wed, 04 Nov 2020 13:11:48 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id c17sm3811136wml.14.2020.11.04.13.11.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 13:11:47 -0800 (PST)
Subject: Re: [PATCH v9 2/8] fw_cfg: Write the extra roots into the fw_cfg
To: Laszlo Ersek <lersek@redhat.com>, Jiahui Cen <cenjiahui@huawei.com>,
 qemu-devel@nongnu.org
References: <20201103120157.2286-1-cenjiahui@huawei.com>
 <20201103120157.2286-3-cenjiahui@huawei.com>
 <dadc89f2-bff2-358a-b15d-1302018286a5@redhat.com>
 <25c7d6a0-98e4-6287-2da3-bbdf9836fb95@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6b40ba03-0e3b-6773-68d2-469c378c2894@redhat.com>
Date: Wed, 4 Nov 2020 22:11:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <25c7d6a0-98e4-6287-2da3-bbdf9836fb95@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: xieyingtai@huawei.com, peter.maydell@linaro.org, berrange@redhat.com,
 mst@redhat.com, xiexiangyou@huawei.com, shannon.zhaosl@gmail.com,
 miaoyubo@huawei.com, Gerd Hoffmann <kraxel@redhat.com>, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Laszlo,

On 11/4/20 9:05 PM, Laszlo Ersek wrote:
> +Phil, +Gerd
> 
> On 11/04/20 20:54, Laszlo Ersek wrote:
>> +Marcel
>>
>> On 11/03/20 13:01, Jiahui Cen wrote:
>>> From: Yubo Miao <miaoyubo@huawei.com>
>>>
>>> Write the extra roots into the fw_cfg, therefore the uefi could
>>> get the extra roots. Only if the uefi knows there are extra roots,
>>> the config space of devices behind the root could be obtained.
>>>
>>> Signed-off-by: Yubo Miao <miaoyubo@huawei.com>
>>> Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
>>> ---
>>>  hw/arm/virt.c              |  8 ++++++++
>>>  hw/i386/pc.c               | 18 ++----------------
>>>  hw/nvram/fw_cfg.c          | 20 ++++++++++++++++++++
>>>  include/hw/nvram/fw_cfg.h  |  2 ++
>>>  include/hw/pci/pcie_host.h |  4 ++++
>>>  5 files changed, 36 insertions(+), 16 deletions(-)
> 
> I realize I never reacted to this patch before (and we're at v9), so you
> might not welcome my feedback at this point.
> 
> The explanation why I've only reacted now is the following: there's an
> agreement between Phil and myself that Phil handles fw_cfg reviews
> primarily, and I review only (or almost only) Phil's patches for fw_cfg.
> Furthermore, all versions of this particular patch, as far as I can see,
> CC'd me but not Phil. So Phil never knew to look, and I never checked
> (this being an fw_cfg patch, per subject line) beyond the author being
> Phil or not.

I noticed this patch yesterday too (by luck looking at the cover).
Since we are in freeze, I tagged it for review but postponed it for
in 2 or 3 weeks. Sorry for not mentioning that I would review this
later on the list.

> The solution is of course to use the get_maintainer.pl script for
> determining reviewers, and adding them with "Cc:" tags to the commit
> message. (You also missed Marcel at the least; see my previous
> response.) git-send-email is supposed to adhere to those "Cc:" tags.
> 
> The reason I've looked now is... I guess I was too tired to remember our
> agreement with Phil.
> 
> Thanks
> Laszlo
> 


