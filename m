Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784B2C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF1020787
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF1020787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTho0-0000rf-Ea
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jThR3-0006O4-Am
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jThPc-0008HP-01
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:47:13 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:38027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jThPb-000873-Fg
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:45:43 -0400
Received: from player688.ha.ovh.net (unknown [10.108.54.133])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 821721D4F87
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 09:45:32 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id A2A2E11C61FC4;
 Wed, 29 Apr 2020 07:45:24 +0000 (UTC)
Subject: Re: [RFC PATCH] qom: Implement qom-get HMP command
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200407114449.482532-1-clg@kaod.org>
 <20200427191908.GO2923@work-vm>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <15d2025e-2950-4a91-2926-830b3006c4c0@kaod.org>
Date: Wed, 29 Apr 2020 09:45:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427191908.GO2923@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3502674610242489105
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedriedvgdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=87.98.165.38; envelope-from=clg@kaod.org;
 helo=6.mo2.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 03:45:32
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 87.98.165.38
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 9:19 PM, Dr. David Alan Gilbert wrote:
> * Cédric Le Goater (clg@kaod.org) wrote:
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>
>> Reimplement it based on qmp_qom_get() to avoid converting QObjects back
>> to strings.
> 
> <blows dust off patch>
> I'd love to see this or something similar in;  what does it's output
> look like for structures - I think that was the main problem people
> complained about last time, although IMHO even a version that couldn't
> do structures nicely would be better than nothing.

Should we merge this patch then ? 

C. 


