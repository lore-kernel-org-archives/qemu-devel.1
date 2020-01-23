Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03164C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:44:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C81C52253D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zn6JV1r4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81C52253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiPN-0008RM-02
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:44:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iuhya-0005D7-2h
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iuhyY-0007KA-HR
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:17:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44904
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iuhyY-0007Ec-9K
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:17:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579807028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hs/34wwrKTMaZiIef+KKkRxsLnhtqdfYoVIkNU6mp5o=;
 b=Zn6JV1r4U29xXStlzS+MSwlqMXYLENA/f1MflBpTVdhHhhp/Ny2gETP3kDDhW7ZERcxOzt
 swsSweH52/BD6BhTvJ30zlFgh2Rn6D3ezNACJyFSV7uqW9INRISJjzB8oA1z8bmlApII/D
 vT5DRVUvU4oA4ezZGuYyAwZWz6MNLG0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-QF1QO6j1MFeicya0MRUpyg-1; Thu, 23 Jan 2020 14:16:55 -0500
Received: by mail-wr1-f72.google.com with SMTP id v17so2348589wrm.17
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:16:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hs/34wwrKTMaZiIef+KKkRxsLnhtqdfYoVIkNU6mp5o=;
 b=aOJqJDUe/WL/8aIsJMCQ6dsic1SigPoUNNHbY1JgfWe2Ov5w1KDVd7E6KEAt4JoaIT
 nW1H9iTKveDoMorudFeQVfLToAKqKXGMgvhpn9uixw/w3Q2SEi3ePsBxMLLF2KMMstZh
 XmbDC5ps7IaXF8bmJ9/u3Go7ta/W2rDp2/Ox5xdjkv9XXh1BkDkTCK6VR1umMxS2cER+
 TMWdl/Zg3d8IEJTm90JzTCmRfayoRfBcQB5qu2RNzUX2dD8l0haRd2XjfQge7zFTdctk
 dx7hcfKS1hLMQobGM5Zz1a6EkU2/kjDQf3xV1PH/a6jgrpi8vXmh9iN+H5aInLNPtNAx
 4LkA==
X-Gm-Message-State: APjAAAW9cq0zaKDAE00bJ+4lMIsb23sDrAjVJIUKkKdzKQ1klQoSsMX9
 LIOrRFgMUrMTGyYMwA7xfvURCjujsv5PBrv5dkAvn5ImUJP7bh8aUsQ4+t76RRbP3i/fyT+FaJK
 dfQEHpVCU4xRIzpI=
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr5726632wmb.174.1579807014182; 
 Thu, 23 Jan 2020 11:16:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzk77xzwX8XwtpGMO+KJj0GckVJbFkjGlhF0YUWmwcL9P8sFYKrihn5dClnRd2vSAyoL2bEgA==
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr5726619wmb.174.1579807013980; 
 Thu, 23 Jan 2020 11:16:53 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059?
 ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
 by smtp.gmail.com with ESMTPSA id q3sm3699795wmc.47.2020.01.23.11.16.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2020 11:16:53 -0800 (PST)
Subject: Re: 5.0 release schedule proposal
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA-HPAXpeWcJOvyJM3hdFR86u4HyovAAB8qmoZaye-P3Vg@mail.gmail.com>
 <CAFEAcA-1QcPEVDodRFFKQ_WdSR-avKp2rZw39KFhO_hh3y=Lxg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0af55f81-3f48-c61d-ffbb-ddb77ef78ca7@redhat.com>
Date: Thu, 23 Jan 2020 20:16:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-1QcPEVDodRFFKQ_WdSR-avKp2rZw39KFhO_hh3y=Lxg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: QF1QO6j1MFeicya0MRUpyg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/01/20 16:55, Peter Maydell wrote:
> On Mon, 6 Jan 2020 at 15:29, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> Here's a suggested set of dates for the 5.0 release:
>>
>> 2020-03-17 softfreeze
>> 2020-03-24 hardfreeze/rc0
>> 2020-03-31 rc1
>> 2020-04-07 rc2
>> 2020-04-14 rc3
>> 2020-04-21 release, or rc4
>> 2020-04-28 release if we needed rc4
>>
>> (I'm at a conference week of 23-27 March, so possibly rc0
>> might get a little delayed if I'm not able to handle
>> pullreqs while away, but usually the big rush is for
>> softfreeze so I think this should be OK.)
>>
>> NB: Easter is 10th-13th April, so between rc2 and rc3.
>>
>> Any opinions/suggested tweaks/etc?
>>
>> Of course if somebody else wants to do this release cycle
>> they can set the dates :-)
> 
> Ping? Any opinions? In the absence of complaints I'll just
> go with this set of dates...

Looks good to me.

Paolo


