Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96D7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 05:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B318A2084C
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 05:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdQIDD6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B318A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeBSh-0005qc-Vn
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 01:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeBRr-0004KS-Vq
 for qemu-devel@nongnu.org; Thu, 28 May 2020 01:51:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22042
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeBRq-0001p4-19
 for qemu-devel@nongnu.org; Thu, 28 May 2020 01:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590645080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=oGeDFDC6EerjAZal9dE8yx388BxCYeCm/M6hz7oF2sk=;
 b=JdQIDD6+O/ynlvrxKi+ZC2//eVyR7xQ/ard4V5zngPigQJZq79o7KevTnI9c4m7lTZe+4z
 nZX57sBI0tyJsicErCrnmSfzfRQSCHn2r3CuDFI1ZSce2G1LBcNoZscteYi+r8jhWYKBKX
 OYepkmEGPSaN7t67+0v45X6ntG25am8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-H9TwMfbAN22kop1aiz5U0g-1; Thu, 28 May 2020 01:51:18 -0400
X-MC-Unique: H9TwMfbAN22kop1aiz5U0g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BB2F18A0721;
 Thu, 28 May 2020 05:51:17 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-213.ams2.redhat.com [10.36.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0E9C5D9EF;
 Thu, 28 May 2020 05:51:14 +0000 (UTC)
Subject: Re: [PATCH v3 0/3] RTISC-V: Remove deprecated ISA, CPUs and machines
To: Alistair Francis <alistair23@gmail.com>
References: <cover.1590533156.git.alistair.francis@wdc.com>
 <0c7494fe-f812-9ee4-6c35-bc1991d0aff2@redhat.com>
 <CAKmqyKOY0m0uZMLH1wcS=vaJqy-EEBG=Sm0t5uLaLt8u366Miw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <35fdd2c8-0951-07f4-2b4c-27e6da53d38c@redhat.com>
Date: Thu, 28 May 2020 07:51:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOY0m0uZMLH1wcS=vaJqy-EEBG=Sm0t5uLaLt8u366Miw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/05/2020 19.35, Alistair Francis wrote:
> On Wed, May 27, 2020 at 12:17 AM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 27/05/2020 00.47, Alistair Francis wrote:
>>>
>>>  include/hw/riscv/spike.h                      |   6 +-
>>>  target/riscv/cpu.h                            |   8 -
>>>  hw/riscv/spike.c                              | 217 ------------------
>>>  target/riscv/cpu.c                            |  30 ---
>>>  target/riscv/cpu_helper.c                     |  82 +++----
>>>  target/riscv/csr.c                            | 118 ++--------
>>>  .../riscv/insn_trans/trans_privileged.inc.c   |  18 +-
>>>  target/riscv/monitor.c                        |   5 -
>>>  target/riscv/op_helper.c                      |  17 +-
>>>  tests/qtest/machine-none-test.c               |   4 +-
>>>  10 files changed, 60 insertions(+), 445 deletions(-)
>>
>>  Hi,
>>
>> looking at the diffstat, I think you should also edit
>> ./docs/system/deprecated.rst according to your changes?
> 
> I'm not sure what I should edit there. These are already marked as
> deprecated, do I need to make a change when they are removed?

Yes, you should move the features to the "Recently removed features"
section at the end of the file. See e.g. commit b4983c570c7a5848c9df.

 Thomas


