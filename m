Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB16C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 09:14:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 807BF2222E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 09:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2VVyacb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 807BF2222E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSzLS-00073g-BG
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 05:14:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSzKn-0006UQ-GW
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 05:14:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSzKk-0005DI-By
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 05:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602753240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i7W98Rmr4j4mY/yHy835QNdYKekY+ZmgrEWIZtvx8hM=;
 b=Y2VVyacbvY5lTjgsHCaQhJxwAnoCVO341IIuhUOtbiqhqw5v4QFQqbPTORiKalS9vMYSD/
 51ZaDjbJgKOF3AAAzXmD998YqNaWXPAdiWt07ta6BhVXC9sAUebknFK1PclJyJ126Sn1k6
 F0seV9xlBIAN5ejwG/kTaF7/HocX5Sg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-A4DZlP2ENoSIzSW1eXq0jA-1; Thu, 15 Oct 2020 05:13:58 -0400
X-MC-Unique: A4DZlP2ENoSIzSW1eXq0jA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2845981CAFC;
 Thu, 15 Oct 2020 09:13:57 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-212.ams2.redhat.com [10.36.112.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B01026FEE8;
 Thu, 15 Oct 2020 09:13:45 +0000 (UTC)
Subject: Re: [PULL 00/10] migration queue
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20201008191046.272549-1-dgilbert@redhat.com>
 <CAFEAcA-U2BjAne57Zn7c4_J97NAZSYzzy6r59iVeGmtgfD3APg@mail.gmail.com>
 <20201014200138.GB133059@xz-x1>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <821ef4ae-1e66-02b9-d9ae-567005aa7c2f@redhat.com>
Date: Thu, 15 Oct 2020 11:13:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201014200138.GB133059@xz-x1>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Juan Quintela <quintela@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>, zhengchuan@huawei.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/10/2020 22.01, Peter Xu wrote:
> On Sun, Oct 11, 2020 at 07:29:25PM +0100, Peter Maydell wrote:
>>> Migration:
>>>   Dirtyrate measurement API cleanup
>>>   Postcopy recovery fixes
>>>
>>> Virtiofsd:
>>>   Missing qemu_init_exec_dir call
>>>   Support for setting the group on socket creation
>>>   Stop a gcc warning
>>>   Avoid tempdir in sandboxing
>>
>> This seems to hang in 'make check' trying to run
>> tests/qtest/migration-test on s390x and ppc, ie
>> the big-endian hosts.
> 
> Hi, Peter,
> 
> Do you know what's the page size on both platforms?

s390x uses 4k page size by default. Only huge-pages are different.

> I'm also trying to find a s390x host to give it a shot.  However I decided to
> also ask this loud so it might be even faster.

Easiest way to test on s390x is likely to use Travis. If you have already an
github or gitlab account, you can simply clone the qemu repository there and
add Travis (from the Marketplace in Github, not sure how it exactly works
with Gitlab) to your cloned repo. If you then push commits to a branch,
Travis should trigger automatically, including runs on s390x, see e.g.:

 https://travis-ci.com/github/huth/qemu/jobs/399317194

 HTH,
  Thomas


