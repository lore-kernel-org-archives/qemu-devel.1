Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C4AC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 20:34:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 253A221D6C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 20:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnXnIySz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253A221D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW3lQ-0000OO-SA
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 16:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kW3kr-0008JY-JB
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 16:33:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45306)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1kW3kp-0006a7-8e
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 16:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603485217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JjlIW9wQg1A4Y9WMEdL7IeCk1Hfj4WtDNTvL/XPZr+0=;
 b=HnXnIySzrDfvRcFn2YXXrMk2Aa6Fgwnw6D8d2OX9FHo46B7BPWG7WZKciaOxnj0qFmsClw
 fOLe1mVa0G+uHhBCVQ4CmLgSTNANxoBQfg44V622+tS+Tyyq2A7w60ImQMZlQwuSgFnjOz
 njs3MAgsUE3GTpHC4yzowQLC8t0I2Bo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-rxo7Ola9P6SJUhBPI2EL-Q-1; Fri, 23 Oct 2020 16:33:34 -0400
X-MC-Unique: rxo7Ola9P6SJUhBPI2EL-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED6401868400;
 Fri, 23 Oct 2020 20:33:32 +0000 (UTC)
Received: from [10.3.113.7] (ovpn-113-7.phx2.redhat.com [10.3.113.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 650D71002388;
 Fri, 23 Oct 2020 20:33:32 +0000 (UTC)
To: Daniele Buono <dbuono@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Subject: Re: [PATCH v2 0/6] Add support for Control-Flow Integrity
Message-ID: <947e698f-a582-956d-5b42-1dee6442f15d@redhat.com>
Date: Fri, 23 Oct 2020 15:33:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023200645.1055-1-dbuono@linux.vnet.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 02:46:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/23/20 3:06 PM, Daniele Buono wrote:
> v2: Several months (and structural changes in QEMU) have passed since v1.
> While the spirit of the patch is similar, the implementation is changed
> in multiple points, and should address most if not all the comments
> received in v1.

> 5) Most of the logic to enable CFI goes in the configure, since it's
> just a matter of checking for dependencies and incompatible options.
> However, I had to disable CFI checks for a few TCG functions.
> This can only be done through a blacklist file. I added a file in the
> root of QEMU, called cfi-blacklist.txt for such purpose. I am open to
> suggestions on where the file should go, and I am willing to become the
> maintainer of it, if deemed necessary.

In the meantime, we have commits like:

commit b199c682f1f0aaee22b2170a5fb885250057eec2
Author: Philippe Mathieu-Daudé <philmd@redhat.com>
Date:   Thu Sep 10 09:01:31 2020 +0200

    target/i386/kvm: Rename host_tsx_blacklisted() as host_tsx_broken()

    In order to use inclusive terminology, rename host_tsx_blacklisted()
    as host_tsx_broken().

which may help you in coming up with a more appropriate name for the new
file.

> 
>  MAINTAINERS                   |   5 +
>  accel/tcg/cpu-exec.c          |   9 ++
>  configure                     | 214 ++++++++++++++++++++++++++++++++++
>  include/qemu/sanitizers.h     |  22 ++++
>  meson.build                   |   3 +
>  plugins/core.c                |  25 ++++
>  plugins/loader.c              |   5 +
>  tcg/tci.c                     |   5 +
>  tests/check-block.sh          |  18 +--
>  tests/qtest/fuzz/fork_fuzz.ld |  12 +-
>  util/main-loop.c              |   9 ++
>  util/oslib-posix.c            |   9 ++
>  12 files changed, 328 insertions(+), 8 deletions(-)
>  create mode 100644 include/qemu/sanitizers.h

although I don't see a new file by that name here, so perhaps the v1
overview is now stale?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


