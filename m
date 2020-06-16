Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEC5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 20:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80F162078D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 20:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=trystan.org header.i=@trystan.org header.b="vY78hm1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80F162078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=trystan.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlIAR-0006pn-L6
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 16:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trystan@trystan.org>)
 id 1jlEyC-0005FS-KT
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:01:56 -0400
Received: from egyptian.birch.relay.mailchannels.net ([23.83.209.56]:36674)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <trystan@trystan.org>)
 id 1jlEy6-0005g0-Re
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:01:56 -0400
X-Sender-Id: a2hosting|x-authuser|trystan@trystan.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id F08A97E1263
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 17:01:06 +0000 (UTC)
Received: from mi3-ss7.a2hosting.com
 (100-96-7-20.trex.outbound.svc.cluster.local [100.96.7.20])
 (Authenticated sender: a2hosting)
 by relay.mailchannels.net (Postfix) with ESMTPA id F01F87E1847
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 17:01:05 +0000 (UTC)
X-Sender-Id: a2hosting|x-authuser|trystan@trystan.org
Received: from mi3-ss7.a2hosting.com (mi3-ss7.a2hosting.com [68.66.200.202])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
 by 0.0.0.0:2500 (trex/5.18.8); Tue, 16 Jun 2020 17:01:06 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: a2hosting|x-authuser|trystan@trystan.org
X-MailChannels-Auth-Id: a2hosting
X-Lettuce-Cure: 56c8aa8d5a416a2a_1592326866336_2612979313
X-MC-Loop-Signature: 1592326866335:211987831
X-MC-Ingress-Time: 1592326866310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=trystan.org
 ; s=default;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
 Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ansJe1LyADT4jaNRdjcUr4egWZkVeLOQymTZUbBRiqc=; b=vY78hm1/rwnDKIcCPSTyCzRyBv
 rT25YWWk0nxTYHAGiKvk6TaysUl5aT2g9tme7Sj+IP9CKm0zUzuPPF0SGx1+FKrnFV/vhD6sAzaQW
 gdicSn57F530QtK2eO/nAxdXW4/kb4OEHFgXK/s7Z1Fm3RrKQDUBrQeinfEGnIh0O74mpvLd8VPmh
 Hjpg4oWFV5indzB58Jw/SR3co4d0h/HDUXCA0NwPs0flQejt7EwmlutWjgqtHIe7Jm77JiqIDmzvJ
 8IRr9u1qpbr0V0SGaKskezlLNw5zMzm2tF2fj0SLtgNqkuasmv89/QEuyzrv7ysdpPbTReXJeZuUF
 QpQ7lQQw==;
Received: from 75-172-35-133.tukw.qwest.net ([75.172.35.133]:61712
 helo=[192.168.0.4])
 by mi3-ss7.a2hosting.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <trystan@trystan.org>) id 1jlExN-0005fE-0p
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:01:05 -0400
To: qemu-devel@nongnu.org
From: Trystan Larey-Williams <trystan@trystan.org>
Subject: Accessing the Metal graphics API with OSX as VM client
Message-ID: <74a0626c-182c-2a55-2528-9fbcd3085950@trystan.org>
Date: Tue, 16 Jun 2020 10:01:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AuthUser: trystan@trystan.org
Received-SPF: none client-ip=23.83.209.56; envelope-from=trystan@trystan.org;
 helo=egyptian.birch.relay.mailchannels.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 13:01:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 16 Jun 2020 16:26:05 -0400
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

Hi all,

I'm trying to get a sense of where QEMU headed in terms of supporting 
Apple's Metal API. Apple will likely be removing OpenGL support entirely 
from OSX, perhaps as early as the next major release of OSX in Sep/Oct. 
Information on support for graphics acceleration on an OSX client using 
Metal instead of OpenGL seems non-existent. From the QEMU documentation 
I gather there are a few ways to 'pass through' a device natively to the 
VM. Would this be the only way to currently access Metal on OSX? Has 
anyone actually tried this?

Thanks,
Trystan




