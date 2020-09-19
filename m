Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51A2C43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 10:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A58521D42
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 10:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8rjrcUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A58521D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJZrk-0003h3-82
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 06:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kJZqr-00034C-7W
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 06:12:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44639
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kJZqn-0008VJ-TQ
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 06:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600510330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0vBMlPO26mG4Y2b/IgjR2syrRGxKeRiZhYnO6k6ZDeU=;
 b=F8rjrcUV65iDErF+BwXUG3VWESIXVq4KmlQSclZ3qQxry+4Z7xjCAVA1dxi4diwbOqOGfD
 tvdeb3d/kTwix/y5GvP//OkwK0TVrzGa+FFMgQ/vl0ZhRGTA3+yHLg8fbIzOVc917V3D9Z
 BJZ88J7a1sE1u3gAWyjkMW7I3yBMzeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-w4hNZrDMPNWZHzdlFjdqLg-1; Sat, 19 Sep 2020 06:12:06 -0400
X-MC-Unique: w4hNZrDMPNWZHzdlFjdqLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E01611074644;
 Sat, 19 Sep 2020 10:12:04 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-63.ams2.redhat.com [10.36.112.63])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25B6F73674;
 Sat, 19 Sep 2020 10:12:03 +0000 (UTC)
Subject: Re: [PULL 05/24] Simplify the .gitignore file
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200916114731.102080-1-thuth@redhat.com>
 <20200916114731.102080-6-thuth@redhat.com>
 <CAFEAcA-cr39jxB-AZV2Nb7jhN497RF66RTrf2eqsWxJ4Ad8F_w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <eb9ed18e-c792-eb85-d86e-43b62d28de6c@redhat.com>
Date: Sat, 19 Sep 2020 12:12:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-cr39jxB-AZV2Nb7jhN497RF66RTrf2eqsWxJ4Ad8F_w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 06:12:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/09/2020 19.33, Peter Maydell wrote:
> On Wed, 16 Sep 2020 at 12:47, Thomas Huth <thuth@redhat.com> wrote:
>>
>> Now that we always do out-of-tree builds (and the in-tree builds are
>> faked via a "build" directory), we can simplify out .gitignore file
>> quite a bit.
>>
>> Message-Id: <20200909080305.258961-1-thuth@redhat.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  .gitignore | 152 -----------------------------------------------------
>>  1 file changed, 152 deletions(-)
> 
> This change removed .pyc files from the set of things we
> ignore:
> 
>> -*.pyc
> 
> But the meson build still runs python scripts which live in
> the source tree, which means python still dumps its bytecode
> files in the source tree too, and they appear in 'git status' now:
> 
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 
>         docs/sphinx/__pycache__/
>         scripts/qapi/__pycache__/
>         scripts/tracetool/__pycache__/
>         scripts/tracetool/backend/__pycache__/
>         scripts/tracetool/format/__pycache__/
> 
> So I think we should put *.pyc back into .gitignore.

Ooops, you're right. I'll send a patch.

 Thomas


