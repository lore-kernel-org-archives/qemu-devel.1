Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65B8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE75520759
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEJtK2fO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE75520759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBNc-0000ei-0s
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqBMb-0000C1-Rb
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:11:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43788
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqBMX-0002sz-6Z
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593504686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BmJUFi6j+YSCHbwI264vJc+ODLeQgPUf/MV8f0Sfd6M=;
 b=BEJtK2fOzgKQEmcvDTGcNTYXTHED6M9uSQ9HknBsQ4U01kVsf4/Jab8A+KP7jjbKf/Vpq0
 PTqtVhTUvhV6Y4IEpG5FzaX5KYQoF535rmv8xKJRsZM/KnbWgU6sAo2yepcDIczmxFbcSK
 ox8uqg5welj934ZirxkyfFO5xwjD84M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-ytJP28TuMW6hIjKV5oR2aA-1; Tue, 30 Jun 2020 04:11:24 -0400
X-MC-Unique: ytJP28TuMW6hIjKV5oR2aA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BD85835B8E;
 Tue, 30 Jun 2020 08:11:23 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-46.ams2.redhat.com [10.36.112.46])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08E127BED9;
 Tue, 30 Jun 2020 08:11:21 +0000 (UTC)
Subject: Re: [PULL 00/63] riscv-to-apply queue
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, Alistair Francis
 <alistair23@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200626214410.3613258-1-alistair.francis@wdc.com>
 <CAFEAcA-8QejH-sFsP_rmKuYdYbQdYRjrHaNz4vLHzfYiSBCKYA@mail.gmail.com>
 <CAKmqyKNo9rPtbtqb1R3OFKH71geYjo0mZONNLxkL0Mg6bnb1Zw@mail.gmail.com>
 <544fb149-c920-b396-7297-f9688a744445@c-sky.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <29f57b2e-7d67-5da2-0ad0-0750e400a91c@redhat.com>
Date: Tue, 30 Jun 2020 10:11:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <544fb149-c920-b396-7297-f9688a744445@c-sky.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/06/2020 08.56, LIU Zhiwei wrote:
> 
> 
> On 2020/6/29 6:51, Alistair Francis wrote:
>> On Sun, Jun 28, 2020 at 7:30 AM Peter Maydell 
>> <peter.maydell@linaro.org> wrote:
>>> On Fri, 26 Jun 2020 at 22:53, Alistair Francis 
>>> <alistair.francis@wdc.com> wrote:
>>>> The following changes since commit 
>>>> 553cf5d7c47bee05a3dec9461c1f8430316d516b:
>>>>
>>>>    Merge remote-tracking branch 
>>>> 'remotes/pmaydell/tags/pull-target-arm-20200626' into staging 
>>>> (2020-06-26 18:22:36 +0100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>    git@github.com:alistair23/qemu.git 
>>>> tags/pull-riscv-to-apply-20200626-1
>>>>
>>>> for you to fetch changes up to 
>>>> b39d59434ea10649fdb9e0a339c30c76e38c5e17:
>>>>
>>>>    target/riscv: configure and turn on vector extension from command 
>>>> line (2020-06-26 14:22:15 -0700)
>>>>
>>>> ----------------------------------------------------------------
>>>> This PR contains two patches to improve PLIC support in QEMU.
>>>>
>>>> The rest of the PR is adding support for the v0.7.1 RISC-V vector
>>>> extensions. This is experimental support as the vector extensions are
>>>> still in a draft state.
>>>>
>>> Hi; I'm afraid this fails to build on PPC64 and s390x (ie
>>> our big-endian hosts):
> Hi Peter,
> 
> Do you mean you built the patch set on PPC64 or s390x and got errors in 
> the list? Or just a worry?
 >
> I have built the patch set on Ubuntu 18.04 X86-64. I don't know which 
> compile option
> will fails the compilation. If you compiled on Ubuntu x86-64, could you 
> show me the
> compile option?

The related code in your patch "target/riscv: add vector stride load and 
store instructions" is in a "#ifdef HOST_WORDS_BIGENDIAN" section, so of 
course this bug does not trigger on a x86 host. You could temporarily 
turn the "#ifdef HOST_WORDS_BIGENDIAN" into a "#if 1" to see whether you 
can then also reproduce the error on x86.

> As a note: I try to find a PPC64 for test, but I'm afraid it will be too 
> later.
> Is there an available  PPC64  machine in the community?

Maybe the easiest way to test your code on a big endian machine, too, is 
to get a github account, clone the QEMU repository there, and enable 
Travis for that repo. Then your code gets built on some non-x86 
architectures (including a big-endian s390x) as soon as you push it to 
the repo (see .travis.yml for details).

>>> /home/ubuntu/qemu/target/riscv/vector_helper.c: In function 
>>> ‘vext_clear’:
>>> /home/ubuntu/qemu/target/riscv/vector_helper.c: In function 
>>> ‘vext_clear’:
>>> /home/ubuntu/qemu/target/riscv/vector_helper.c:154:21: error: invalid
>>> operands to binary & (have ‘void *’ and ‘long long unsigned int’)
>>>           memset(tail & ~(7ULL), 0, part1);

You obviously must not use "&" with a pointer. I guess you have to cast 
to "uintptr_t" and back, or think of some other smart way to fix this.

  Thomas


