Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94A1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 22:00:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72771207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 22:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LIXcYSXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72771207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8W8C-0000GB-MY
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 18:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8W7J-0008IC-CZ
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 17:59:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k8W7H-0003Qe-4I
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 17:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597874369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JCcZCaLjBxyW342ExBCRoQ7WxHHLmFlno5Xizj1sBc0=;
 b=LIXcYSXcB+gOeWJQ+IPgdWGBnp2irBUI5A6X/5cRShM5xzMkPO5HB9j/+L30NJbtx7U7fB
 UBKWM2szR81xy0PTjuz7iajNwxufIbNH2w9EWj0Dp7qqQgioCRzPwUS2wh42QV+J+sXt3F
 THakeytPYil+eFaFibnMGqoKEWwo1uU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-nYt9OtQeMgqbUnLS_OngDg-1; Wed, 19 Aug 2020 17:59:23 -0400
X-MC-Unique: nYt9OtQeMgqbUnLS_OngDg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDF9A186A573;
 Wed, 19 Aug 2020 21:59:22 +0000 (UTC)
Received: from [10.3.112.136] (ovpn-112-136.phx2.redhat.com [10.3.112.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82EFD7A40B;
 Wed, 19 Aug 2020 21:59:22 +0000 (UTC)
Subject: Re: [PULL v7 000/151] Meson-based build system
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200819213203.17876-1-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3689e853-b267-a553-a78f-d906618512db@redhat.com>
Date: Wed, 19 Aug 2020 16:59:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819213203.17876-1-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 10:07:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/20 4:32 PM, Paolo Bonzini wrote:
> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
> 
>    Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git tags/for-upstream

Unrelated to the pull request proper, but I note in MAINTAINERS that you 
have listed:

T: git https://github.com/bonzini/qemu.git scsi-next

Have you switched to gitlab as your personal mirroring preference, and 
if so, should MAINTAINERS be updated?

> 
> for you to fetch changes up to 2eddb3c65821dce76433d5da6f3e6419349d1b77:
> 
>    docs: convert build system documentation to rST (2020-08-19 16:13:30 -0400)
> 
> v6->v7:
> * new patch to preserve compatibility symlinks from previous binary locations
> * fixed cut-and-paste error in linux-user/mips/meson.build
> * preserve compatibility check-block target even if no block tests are defined

FWIW: I haven't done any review or testing of the earlier iterations of 
this series.  But since it will be landing soon, I merged this tag to an 
incremental build tree that was previously sitting on a finished 5.1 
build (sources in qemu/, VPATH build in qemu/build/), typed 'make' then 
'make check', and everything finished successfully at least for my 
typical setup.  So good job on getting this massive rewrite in while 
still preserving at least the common 'make' interface.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


