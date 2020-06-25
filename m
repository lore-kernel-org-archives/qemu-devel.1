Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCC9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B4D206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+NVwqe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B4D206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUpb-0000dW-Og
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joUoc-0007nX-Lp
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:33:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35904
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1joUoY-00041m-Na
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 12:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593102805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKdNKRk3Wwnzca2cPs/iDkvEID8dWFzLn4PD57EWYzs=;
 b=E+NVwqe9pkA+uGl/KuoPcBZLXp+BMinRuYRj85k6PNdJV785qfQX/ef14SyzKrxaL6MQUk
 HgoQ62fNb8tj7gukSPpZpPLMCRrZ3ix8s0QgbNvwnCR5AwKtU3OnOK5J5xLJWelScSE0Uj
 rBZgYsm5KvpmSXmtrb9gjuHQz2vVSi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-o_EJjWMKOMCRW9v5DAGZQg-1; Thu, 25 Jun 2020 12:33:18 -0400
X-MC-Unique: o_EJjWMKOMCRW9v5DAGZQg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D6A3800D5C;
 Thu, 25 Jun 2020 16:33:15 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 358C010016DA;
 Thu, 25 Jun 2020 16:33:15 +0000 (UTC)
Subject: Re: [PULL 00/31] Misc patches for 2020-06-24
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200624104917.375143-1-pbonzini@redhat.com>
 <CAFEAcA_qGeAaKbfRn4TsP4sAA-Q2XYjh+0o5s4p2dp5SN6Mirg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7d758cf2-4022-63f0-5110-2d7e5f23d572@redhat.com>
Date: Thu, 25 Jun 2020 11:33:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_qGeAaKbfRn4TsP4sAA-Q2XYjh+0o5s4p2dp5SN6Mirg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/25/20 10:50 AM, Peter Maydell wrote:
> On Wed, 24 Jun 2020 at 11:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> The following changes since commit 171199f56f5f9bdf1e5d670d09ef1351d8f01bae:
>>
>>    Merge remote-tracking branch 'remotes/alistair/tags/pull-riscv-to-apply-20200619-3' into staging (2020-06-22 14:45:25 +0100)
>>
>> are available in the Git repository at:
>>
>>    git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to 7fc58934d34e939489e20af4c97aeb095c1f2b20:
>>
>>    i386: Mask SVM features if nested SVM is disabled (2020-06-24 04:37:59 -0400)
>>
> 
> Hi; this has a 32-bit/64-bit format string issue, I'm afraid:
> 
> /Users/pm215/src/qemu-for-merges/exec.c:2383:32: error: format
> specifies type 'unsigned long' but the argument has type 'uint64_t'
> (aka 'unsigned long long') [-Werror,-Wformat]
>                     file_align, mr->align);
>                     ~~~~~~~~~~~~^~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/include/qapi/error.h:166:35: note:
> expanded from macro 'error_setg'
>                          (fmt), ## __VA_ARGS__)
>                           ~~~      ^~~~~~~~~~~
> 
> (It also had a trivial rebase conflict with master in hw/arm/virt.c.)

And since the pull request needs a respin, I'm hoping Paolo includes v5 
of my MIN/MAX patch (replacing the mojibake and other issues with v4 
used in this attempt):

https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg08384.html


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


