Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFB4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 19:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A0020720
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 19:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A0020720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgraf.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqimo-0001tX-Iz
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 15:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>) id 1jqils-0001AS-7D
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 15:51:52 -0400
Received: from mail.csgraf.de ([188.138.100.120]:40106
 helo=zulu616.server4you.de) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <agraf@csgraf.de>) id 1jqilp-0000jd-IM
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 15:51:51 -0400
Received: from 38f9d3867b82.ant.amazon.com
 (ec2-3-122-114-9.eu-central-1.compute.amazonaws.com [3.122.114.9])
 by csgraf.de (Postfix) with ESMTPSA id 434CF39002CE;
 Wed,  1 Jul 2020 21:51:43 +0200 (CEST)
Subject: Re: [PATCH] scripts/get_maintainer: Use .ignoredmailmap to ignore
 invalid emails
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200629172716.20781-1-f4bug@amsat.org>
 <8616bdd8-34a9-f737-aa9d-f11d735cc0fe@redhat.com>
 <caee1217-867e-f2b3-68c6-3b3e87e926a9@amsat.org>
 <70e3b721-4515-352a-1f9a-0638ee19b784@redhat.com>
 <94527813-1a04-16d7-4449-f583b356a76e@amsat.org>
From: Alexander Graf <agraf@csgraf.de>
Message-ID: <394021c9-fdb0-5bf2-e0b0-28aeac0435d0@csgraf.de>
Date: Wed, 1 Jul 2020 21:51:42 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <94527813-1a04-16d7-4449-f583b356a76e@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=188.138.100.120; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 15:51:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 Paul Burton <paulburton@kernel.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 01.07.20 18:54, Philippe Mathieu-Daudé wrote:
> 
> +Pavel/Paul/Alexander
> 
> On 7/1/20 5:12 PM, Paolo Bonzini wrote:
>> On 01/07/20 17:07, Philippe Mathieu-Daudé wrote:
>>> $ cat .ignoredmailmap
>>> #
>>> # From man git-shortlog the forms are:
>>> #
>>> #  Proper Name <commit@email.xx>
>>> #  <proper@email.xx>
>>> #
>>> Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>> Caio Carrara <ccarrara@redhat.com>
>>> Yongbok Kim <yongbok.kim@mips.com>
>>> James Hogan <james.hogan@mips.com>
>>> Paul Burton <pburton@wavecomp.com>
>>> Alexander Graf <agraf@suse.de>
>>> Roy Franz <roy.franz@linaro.org>
>>> Dmitry Solodkiy <d.solodkiy@samsung.com>
>>> Evgeny Voevodin <e.voevodin@samsung.com>
>>> Serge Hallyn <serge.hallyn@ubuntu.com>
>>> Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>>>
>>
>> For at least Paul Burton, Pavel Dovgalyuk and Alex Graf we should just
>> use .mailmap, anyway I think the concept of the patch is okay.
> 
> Pavel has been using a GMail account, but seems to be back to
> ispras.ru, so it might have be a temporary failure (over few
> days although).
> 
> I can send a pair of patches for Paul and Alexander if they
> are OK. The others seem MIA.

Yes, please! I would appreciate if you could use agraf@csgraf.de for 
QEMU related work :).


Alex

