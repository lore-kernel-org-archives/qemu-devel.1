Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E67C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B9C20658
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 09:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CpEMWlzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B9C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXf3-0002HK-QS
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 05:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jVXeE-0001RC-1G
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:44:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32709
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jVXeD-0001AO-CJ
 for qemu-devel@nongnu.org; Mon, 04 May 2020 05:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588585464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+vJKrys71nHVm5Pac1wgC46hBpR+k+G6dkpJPpiL+E4=;
 b=CpEMWlzo5EkS4O768E1Ftez0JPDDpmMZsPIRCZAu2Sg6oGzQjOKpVUgexqiMDGaqHDgfax
 xILqi9KzqsTK3JMEOERLFwgpXDdBDVjVEzIPVEXQFFMODAape3EdGuwacGULzkdS+GAf+a
 60skH5gCvUSMu6ynZV/1mybn9JZjCD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-EbT8znIOMfa6nyUhw1HpOA-1; Mon, 04 May 2020 05:44:21 -0400
X-MC-Unique: EbT8znIOMfa6nyUhw1HpOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5173C8014D9;
 Mon,  4 May 2020 09:44:19 +0000 (UTC)
Received: from [10.36.112.58] (ovpn-112-58.ams2.redhat.com [10.36.112.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B22510002AA;
 Mon,  4 May 2020 09:44:12 +0000 (UTC)
Subject: Re: [PATCH v4 0/7] ARM virt: Add NVDIMM support
To: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20200421125934.14952-1-shameerali.kolothum.thodi@huawei.com>
 <20200504011252-mutt-send-email-mst@kernel.org>
 <CAFEAcA-nkbCZNj0dbVgcN4ajRVx-N0Yvy5OEFuRewJyRGWfjxg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ba8879f2-8eee-0830-c2d2-80f9d266c89d@redhat.com>
Date: Mon, 4 May 2020 11:44:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-nkbCZNj0dbVgcN4ajRVx-N0Yvy5OEFuRewJyRGWfjxg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 01:14:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Linuxarm <linuxarm@huawei.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Xu Wei <xuwei5@hisilicon.com>, prime.zeng@hisilicon.com,
 Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 5/4/20 11:29 AM, Peter Maydell wrote:
> On Mon, 4 May 2020 at 06:13, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Tue, Apr 21, 2020 at 01:59:27PM +0100, Shameer Kolothum wrote:
>>> This series adds NVDIMM support to arm/virt platform.
>>> The series reuses some of the patches posted by Eric
>>> in his earlier attempt here[1].
>>>
>>> This series previously had few fixes to qemu in general
>>> which were discovered while adding nvdimm support to arm/virt.
>>> Those were sent out seperately[2] and are now part of Qemu.
>>
>>
>> Mostly ACPI stuff so I can merge it if I get an ack for ARM side.
> 
> Happy for you to take it; all the arm-specific bits have
> been reviewed by various people (thanks!) so here's my
> 
> Acked-by: Peter Maydell <peter.maydell@linaro.org>

Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> 
> I notice that checkpatch complains a lot about
> 
> ERROR: Do not add expected files together with tests, follow
> instructions in tests/qtest/bios-tables-test.c: both
> tests/qtest/bios-tables-test-allowed-diff.h and
> tests/qtest/bios-tables-test.c found
> 
> Does that need fixing, or is the checkpatch test wrong?
> 
> thanks
> -- PMM
> 


