Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCDEC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248B52064C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248B52064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ipxe.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyF5o-0008RJ-8e
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 09:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcb30@ipxe.org>) id 1jyF4B-0007tp-I6
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:45:51 -0400
Received: from blyat.fensystems.co.uk
 ([2a05:d018:a4d:6403:2dda:8093:274f:d185]:59096)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcb30@ipxe.org>) id 1jyF49-0003uV-0G
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 09:45:51 -0400
Received: from dolphin.home (unknown
 [IPv6:2a00:23c6:5495:5e00:beee:7bff:fe8d:f03d])
 by blyat.fensystems.co.uk (Postfix) with ESMTPSA id 73D2C42B4C;
 Wed, 22 Jul 2020 13:45:44 +0000 (UTC)
Subject: Re: [ipxe-devel] https booting
From: Michael Brown <mcb30@ipxe.org>
To: Gerd Hoffmann <kraxel@redhat.com>, ipxe-devel@lists.ipxe.org,
 qemu-devel@nongnu.org
References: <20200722120827.dq72uabrk26nllra@sirius.home.kraxel.org>
 <73923bb0-0a75-d8f1-fa49-87994e5354db@ipxe.org>
Message-ID: <9c8f7d87-ba80-fc06-7204-19bb219de68a@ipxe.org>
Date: Wed, 22 Jul 2020 14:45:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <73923bb0-0a75-d8f1-fa49-87994e5354db@ipxe.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a05:d018:a4d:6403:2dda:8093:274f:d185;
 envelope-from=mcb30@ipxe.org; helo=blyat.fensystems.co.uk
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 09:45:46
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/07/2020 14:21, Michael Brown wrote:
>> After looking at https://ipxe.org/cfg/crosscert I'm not convinced this
>> is a good idea though.  This would likely put quite some load to
>> ca.ipxe.org.  Also that machine becomes a single point of failure for
>> worldwide ipxe https boot, and looking through the mailing list I've
>> seen we already had (at least) two outages this year.
> 
> The crosscert fetches are static files (with iPXE including a query 
> string only for debugging purposes), and it should be fairly 
> straightforward for me to switch to hosting them in AWS S3 or 
> equivalent.  The ca.ipxe.org domain is not used for anything else so 
> could be pointed at a new hosting infrastructure with no disruption or 
> code changes.

I've created https://github.com/ipxe/ipxe/issues/126 to track this part 
of the development work.  Please feel free to review the issue and add 
anything you think might be relevant.

Thanks,

Michael

