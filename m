Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD85C2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 12:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 015CE206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 12:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfCjXl5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 015CE206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY71h-0005nl-Oy
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 08:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kY70L-0005Md-5B
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:26:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kY70J-0003ag-62
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 08:26:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603974365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1UHVOXMcOLM2KzmXH74xiQeErVDqZAD6FIBToTVz340=;
 b=ZfCjXl5NdhE0nyFdm0Qk6/gPSe2Vgc+citP5mJ9VIjZfGG4GkvPoF6js5rcBXFukMJFS32
 qxpy6iz6jbx4wDg4eRnrTvvnVqu+YVv6pNNYNxdMGPuJedAqYI1nA07MVOdQxgeSYocNli
 koS72tc8vVdtahEWsiIQ2IQViVOVbOA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-6wF5JOQjOp-Mo9zDgyGL6A-1; Thu, 29 Oct 2020 08:26:03 -0400
X-MC-Unique: 6wF5JOQjOp-Mo9zDgyGL6A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 527C818C9F51;
 Thu, 29 Oct 2020 12:26:02 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-114.ams2.redhat.com [10.36.113.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 824EA1002C01;
 Thu, 29 Oct 2020 12:25:57 +0000 (UTC)
Subject: Re: [PATCH v2 8/8] configure: add [lm32|unicore32]-softmmu to
 deprecation logic
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200915134317.11110-1-alex.bennee@linaro.org>
 <20200915134317.11110-9-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <599acb88-ab14-c8c7-5ba6-6526b6e7c629@redhat.com>
Date: Thu, 29 Oct 2020 13:25:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200915134317.11110-9-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.261, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/09/2020 15.43, Alex Bennée wrote:
> While we are at it move the few places where they are into the
> deprecation build bucket.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure      | 2 +-
>  .gitlab-ci.yml | 9 +++++----
>  .shippable.yml | 2 +-
>  3 files changed, 7 insertions(+), 6 deletions(-)

 Hi Alex,

I noticed that these deprecated targets do not show up in the
output of "configure --help" at all anymore:

 --target-list=LIST       set target list (default: build everything)
                           Available targets: aarch64-softmmu alpha-softmmu 
                           arm-softmmu avr-softmmu cris-softmmu hppa-softmmu 
                           i386-softmmu m68k-softmmu microblazeel-softmmu 
                           microblaze-softmmu mips64el-softmmu mips64-softmmu 
                           mipsel-softmmu mips-softmmu moxie-softmmu 
                           nios2-softmmu or1k-softmmu ppc64-softmmu ppc-softmmu 
                           riscv32-softmmu riscv64-softmmu rx-softmmu 
                           s390x-softmmu sh4eb-softmmu sh4-softmmu 
                           sparc64-softmmu sparc-softmmu tricore-softmmu 
                           x86_64-softmmu xtensaeb-softmmu xtensa-softmmu 
                           aarch64_be-linux-user aarch64-linux-user 
                           alpha-linux-user armeb-linux-user arm-linux-user 
                           cris-linux-user hppa-linux-user i386-linux-user 
                           m68k-linux-user microblazeel-linux-user 
                           microblaze-linux-user mips64el-linux-user 
                           mips64-linux-user mipsel-linux-user mips-linux-user 
                           mipsn32el-linux-user mipsn32-linux-user 
                           nios2-linux-user or1k-linux-user ppc64le-linux-user 
                           ppc64-linux-user ppc-linux-user riscv32-linux-user 
                           riscv64-linux-user s390x-linux-user sh4eb-linux-user 
                           sh4-linux-user sparc32plus-linux-user 
                           sparc64-linux-user sparc-linux-user 
                           x86_64-linux-user xtensaeb-linux-user 
                           xtensa-linux-user

The text "default: build everything" is now also not accurate anymore.
How is a user who is still interested in these targets supposed to find
the right --target-list parameters now?

 Thomas


