Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FF3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD5E2078D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+ZI9PwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD5E2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxj3-0008A9-Pv
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kAxhk-0006le-C5
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kAxhi-0001S9-Pf
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598457073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FDsZZDwBuZEt91uslfr7PZRxjVEDvu6DXCN5Lt1pMTw=;
 b=e+ZI9PwK/pjuMc91ado9ZrnvGGa85Sea3j70+E8LuLVvMDeTh6GGGoJ1xKzC1rzbX8bQ4t
 QOYiiEXpVJB6gDyiVsgR8rTrjU8VJJdutnxlKZkJec/yO5JXa/zwP+U7xu5p4+rQwGAJf9
 CrGVdxsatE7F51OQ+w82VaQyxQ/Zsmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-VraJttoROq23Gp98WqnoPg-1; Wed, 26 Aug 2020 11:51:09 -0400
X-MC-Unique: VraJttoROq23Gp98WqnoPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C154E87309E;
 Wed, 26 Aug 2020 15:51:08 +0000 (UTC)
Received: from [10.10.112.89] (ovpn-112-89.rdu2.redhat.com [10.10.112.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B4AD80925;
 Wed, 26 Aug 2020 15:51:07 +0000 (UTC)
Subject: Re: Contributor wanting to get started with simple contributions
To: Rohit Shinde <rohit.shinde12194@gmail.com>, Thomas Huth <thuth@redhat.com>
References: <CA+Ai=tAypbso9yMy0jtyzbeHCweQ1FPgDaJ8=bXxFvBA6pZyLA@mail.gmail.com>
 <CA+Ai=tBJqLB7yDbd-kqzDhr+d+65K9r3DQsZrB2kGi9wF8BaiA@mail.gmail.com>
 <2d69f1ac-df97-9d70-d2e2-e9cf27cf9b0c@redhat.com>
 <CA+Ai=tCk-XX7yogRu=zoKxDv7okRHXibbnT9OoMs8XpHs9yDkA@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a50f47d2-f5c6-49c0-779f-dfcaf05df5f9@redhat.com>
Date: Wed, 26 Aug 2020 11:51:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+Ai=tCk-XX7yogRu=zoKxDv7okRHXibbnT9OoMs8XpHs9yDkA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.239, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: crosa@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/26/20 11:00 AM, Rohit Shinde wrote:
> Hey Thomas,
> 
> I didn't really have any specific questions. I wanted to know if there 
> was any part of qemu that I could contribute to. Qemu is overwhelmingly 
> vast and without some pointers, I felt very lost.

Yeah, it can be hard to get started.

What are your interests in programming/development, any specific types 
of coding you like doing more than others? What draws you to the QEMU in 
particular? Is there something you'd like to see QEMU do that it doesn't 
today, or something you feel like you are particularly suited to doing?

If I can figure out what brought you here, maybe I can direct you to 
some projects that might benefit from your attention. [Apart from the 
Python stuff, which we are discussing elsewhere in another thread.]

Some topic areas:

- Emulation (TCG)
- Virtualization (KVM)
- Esoteric/Legacy architecture/device emulation
- Optimization (Network, Storage, CPU)
- Regression/Acceptance Testing
- Fuzzing
- Configuration
- Deployment
- Continuous Integration
- Accessibility, Ease-of-use
- Build systems & tooling
- Development process
- SDK/API development


If you have any specific knowledge in areas that aren't Linux on x86, 
there are likely areas of QEMU that could benefit from your knowledge. 
We are always looking for people to help maintain and develop code 
intended for other architectures on other platforms.

--js


