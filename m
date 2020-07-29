Return-Path: <SRS0=FCxk=BI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FC1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 20:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7106D2074B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2020 20:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSAFQwoH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7106D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0sYG-0006BN-RA
	for qemu-devel@archiver.kernel.org; Wed, 29 Jul 2020 16:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0sXR-0005ka-MX
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 16:18:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56011
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0sXP-0002Rp-8M
 for qemu-devel@nongnu.org; Wed, 29 Jul 2020 16:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596053934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PyXcwuJ+azQx4hkJkNyvOy5xVM8W4oMJEqU5DoFD7AM=;
 b=dSAFQwoH5FybghOywCZOaQQ6NxRiHVLgI5kli1Du09ZO3xuRDtoMyDYPRrzcR8RrE48EcY
 SRCDkd4tIh95N3gVYfPM++ilwW1Vqhb/57qm9iSL3cQiowksmLP8U6roFadz5c2JDl5mqA
 ih7oznbADB0k/a+FsY6Okq8kXzSppeI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-3gdiEBPINSuIDcjuKqvTtw-1; Wed, 29 Jul 2020 16:18:47 -0400
X-MC-Unique: 3gdiEBPINSuIDcjuKqvTtw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1A761902EA7;
 Wed, 29 Jul 2020 20:18:46 +0000 (UTC)
Received: from [10.3.114.255] (ovpn-114-255.phx2.redhat.com [10.3.114.255])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C1B061100;
 Wed, 29 Jul 2020 20:18:46 +0000 (UTC)
Subject: Re: qemu repo lockdown message for a WHPX PR
To: Sunil Muthuswamy <sunilmut@microsoft.com>, Paolo Bonzini
 <bonzini@gnu.org>, Peter Maydell <peter.maydell@linaro.org>
References: <SN4PR2101MB08805B8E85196354ACA49B54C0730@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <SN4PR2101MB088065186D10AC74BE9721BDC0700@SN4PR2101MB0880.namprd21.prod.outlook.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4164d89a-9009-2ee3-3dc4-da3edeff4ab7@redhat.com>
Date: Wed, 29 Jul 2020 15:18:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <SN4PR2101MB088065186D10AC74BE9721BDC0700@SN4PR2101MB0880.namprd21.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 09:17:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/29/20 3:05 PM, Sunil Muthuswamy wrote:
> Adding Peter Maydell as well.
> 
>> -----Original Message-----
>> From: Sunil Muthuswamy
>> Sent: Tuesday, July 28, 2020 12:20 PM
>> To: Paolo Bonzini <bonzini@gnu.org>
>> Cc: qemu-devel@nongnu.org
>> Subject: qemu repo lockdown message for a WHPX PR
>>
>> Hey Paolo,
>>
>> Following your suggestion of creating PRs for WHPX changes, I tried creating a PR https://github.com/qemu/qemu/pull/95
>>
>> But, I am getting repo-lockdown message. What do I need to do differently?

Are you trying to submit a patch?  If so, we prefer submissions to the 
mailing list rather than via github pull requests:

https://wiki.qemu.org/Contribute/SubmitAPatch

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


