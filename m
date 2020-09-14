Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24FDC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 20:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4589F206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 20:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4KSrwwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4589F206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHvHU-0005M2-1i
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 16:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kHvGH-0004uS-7z
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 16:39:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kHvGE-0005qF-K1
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 16:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600115976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JH92gT1SksPFCkxIBnfILRuDSdgllFNgFVP+vSZWLZU=;
 b=S4KSrwwYsmEknAwl/X1RHAY7NHQC+I1tY7kqWmqf1eo/GCcm2b69BKtXZiSJFsV/IkqRVi
 q7tGxxL+gW3tcaYLLdaO2njstBXr3IhOBqFqXwJy2vMAR5i06eF++uJhtng2xfYQzKasL9
 KB2sv76a024IBeESuttLMJnLSiPKg4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-UmmuljMqMl6pocYh1HZsqQ-1; Mon, 14 Sep 2020 16:39:33 -0400
X-MC-Unique: UmmuljMqMl6pocYh1HZsqQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17E281091066;
 Mon, 14 Sep 2020 20:39:32 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-5.ams2.redhat.com [10.36.112.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0E167EEDA;
 Mon, 14 Sep 2020 20:39:29 +0000 (UTC)
Subject: Re: [PATCH v2] tests/qtest/qmp-cmd-test: Use inclusive language
To: Claudio Fontana <cfontana@suse.de>
References: <20200914163755.42618-1-thuth@redhat.com>
 <db2a53e2-f976-2a68-3039-d119fa41405a@suse.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <525bd67e-4e39-90b2-64bc-bfcd5c187749@redhat.com>
Date: Mon, 14 Sep 2020 22:39:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <db2a53e2-f976-2a68-3039-d119fa41405a@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 15:06:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 philmd@redhat.com, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/09/2020 18.51, Claudio Fontana wrote:
> It seems to me that "blacklist" is a very commonly used technical term,
> and expresses the concept more precisely.
> 
> I am not sure what "inclusive language" is or what relationship it has with technical work on QEMU.

See e.g.: https://itsfoss.com/linux-kernel-inclusive-code/

Even the Linux kernel folks are trying to avoid the terms in new code:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=master#n322

 HTH,
  Thomas


> Thanks,
> 
> Claudio
> 
> On 9/14/20 6:37 PM, Thomas Huth wrote:
>> We simply want to ignore certain queries here, so let's rather
>> use the term 'ignore' to express this intention.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2: Changed naming according to suggestions
>>
>>  tests/qtest/qmp-cmd-test.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)


