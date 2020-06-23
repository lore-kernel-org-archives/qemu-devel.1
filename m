Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090CEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:08:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C66F220706
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 17:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqlyQESR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C66F220706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnmPH-00054H-W6
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 13:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56630)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jnmOf-0004fH-9R
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:07:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28592
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jnmOb-0004JC-W8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 13:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592932060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=RDTSq0k8O9nLzFHtMDnrEPQkr5s+IiZtw9n3KqPBnRg=;
 b=BqlyQESRpogUm15Alc24w/fmAPnVls7MNSFIVIwq9K2Ncb4wmDD7ZDqjXMcpoxCVc5mWX6
 MS5TwWtIhc+rPqI6NlqFcZTJfVcMCCZ+eEvzRacCIRf/9ALD8K272+AFou0gLw06GyrkAh
 HhhcY4qEsQ5qJf+C1wcCVfVvTjiap4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-Y0twkY04MgKf5y-Tw_nlQQ-1; Tue, 23 Jun 2020 13:07:36 -0400
X-MC-Unique: Y0twkY04MgKf5y-Tw_nlQQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E021805EE4;
 Tue, 23 Jun 2020 17:07:35 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-149.ams2.redhat.com [10.36.112.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF04B10027B5;
 Tue, 23 Jun 2020 17:07:24 +0000 (UTC)
Subject: Re: [PATCH] Revert "tests/migration: Reduce autoconverge initial
 bandwidth"
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200623145506.439100-1-mst@redhat.com>
 <3554a068-ba6f-0aa0-38b4-b6dca3069630@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5d3c4773-5aa2-e80d-68c7-a94eac8a7422@redhat.com>
Date: Tue, 23 Jun 2020 19:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3554a068-ba6f-0aa0-38b4-b6dca3069630@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/06/2020 17.39, Philippe Mathieu-Daudé wrote:
> On 6/23/20 4:56 PM, Michael S. Tsirkin wrote:
>> This reverts commit 6d1da867e65f ("tests/migration: Reduce autoconverge initial bandwidth")
>> since that change makes unit tests much slower for all developers, while it's not
>> a robust way to fix migration tests. Migration tests need to find
>> a more robust way to discover a reasonable bandwidth without slowing
>> things down for everyone.
> 
> Please also mention we can do this since 1de8e4c4dcf which allow
> marked the s390x job as "unstable" and allow it to fail.
> 
> But if nobody is going to look at it, instead lets disable
> it until someone figure out the issue:
> 
> -- >8 --
> diff --git a/.travis.yml b/.travis.yml
> index 74158f741b..364e67b14b 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -507,6 +507,7 @@ jobs:
> 
>      - name: "[s390x] Clang (disable-tcg)"
>        arch: s390x
> +      if: false # Temporarily disabled due to issue testing migration
> (see commit 6d1da867e65).
>        dist: bionic
>        compiler: clang
>        addons:

Sorry, but that looks wrong. First, the disable-tcg test does not run
the qtests at all. So this is certainly the wrong location here. Second,
if just one of the qtests is failing, please only disable that single
failing qtest and not the whole test pipeline.

 Thanks,
  Thomas


