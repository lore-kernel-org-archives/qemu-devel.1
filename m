Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED52C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:41:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D8B20729
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwMao7WJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D8B20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYWWt-00036O-GS
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kYWVA-0001oa-J0
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43264)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kYWV8-00021b-OF
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604072377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+JL/AXiTfPCByujUJcVx224wjo4Vtqb2Hih44hRK31s=;
 b=hwMao7WJmmf+VJErVWkvpaYK1gmUPPV8wTltANbzJQ4a9kfdrPROGhwOfQKGFKk7uvWFI+
 ka3kgDnXDXd2ArMfmQdz0yp0xCKtOFh8fAMWkvk+mVCYyd4Dj2j2fKW5iksoDkH8CMuR0x
 2kH82PDTdWwGkhy2B2AX7kKD29nVO2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-tcOczcZdO6OvU2hSfUXoww-1; Fri, 30 Oct 2020 11:39:35 -0400
X-MC-Unique: tcOczcZdO6OvU2hSfUXoww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5290064089
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 15:39:34 +0000 (UTC)
Received: from [10.10.118.238] (ovpn-118-238.rdu2.redhat.com [10.10.118.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE12B1000320;
 Fri, 30 Oct 2020 15:39:30 +0000 (UTC)
Subject: Re: Migrating to the gitlab issue tracker
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <bda4f471-8ed6-3832-29ac-279a6d3bb7cc@redhat.com>
 <20201030091636.GD307361@stefanha-x1.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <71783050-4984-9ad4-f24a-6440490f6d21@redhat.com>
Date: Fri, 30 Oct 2020 11:39:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201030091636.GD307361@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 5:16 AM, Stefan Hajnoczi wrote:
> On Thu, Oct 29, 2020 at 12:01:27PM -0400, John Snow wrote:
>> In experimenting with my mirror on gitlab though, I was unable to find a way
>> to configure it to send issue tracker notifications to the email list. A
>> move to gitlab would likely mean, then:
>>
>> 1. The cessation of (automatic) issue tracker mails to the list
> 
> A bot could do this.
> 

Yes, but someone would have to write it, and we'd have to host it 
somewhere. It might not worth be doing.

>> 2. The loss of the ability to update the issue tracker by replying to said
>> emails
> 
> This is too bad. It's something I liked about Launchpad.
> 

However, if you subscribe to the issue tracker using your gitlab 
account, you can reply to the emails you get to update the tracker that way!

https://gitlab.com/qemu-project/qemu and click the little bell near 
un/star and fork; click "custom" and subscribe to issue events.

>> 3. Anyone listed in MAINTAINERS would be expected to have a gitlab account
>> in order to interact with the issue tracker.
> 
> Maintainers should start running pull requests through the GitLab CI
> anyway, so this is probably okay.
> 

Sounds like the consensus so far, yes.

> Stefan
> 


