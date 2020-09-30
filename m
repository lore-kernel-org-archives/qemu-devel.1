Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C566CC47420
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F88207FB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 17:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPpGuFqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F88207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNfiy-000122-Ns
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 13:17:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kNfhd-0000CN-Dm
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 13:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kNfha-0001Kq-EV
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 13:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601486137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNz6z8dNe8IoTGzC98adMIE5GYiYquBV3UMu3a1MBy4=;
 b=fPpGuFqLwZ09D+WsjHntwXeSDMk5svVMiDzS31g79Efn7UQXfhzbGuZMbXaE/dtQ5g5Blv
 sEDega132SoxAQr9MW+mkqzbJIQYbVkMvFDWGh4Ewn8DoNWmfQXdZu5xbtsrNl4nzRpK18
 AZDASnquon7dQLbZrX2jYIgGrpNgwvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-to0K7CuKMXmU7dEzfQT9HQ-1; Wed, 30 Sep 2020 13:15:32 -0400
X-MC-Unique: to0K7CuKMXmU7dEzfQT9HQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA8B01040C21;
 Wed, 30 Sep 2020 17:15:30 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58A5F5C1CF;
 Wed, 30 Sep 2020 17:15:30 +0000 (UTC)
Date: Wed, 30 Sep 2020 13:15:29 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v3 00/11] user-mode: Prune build dependencies (part 3)
Message-ID: <20200930171529.GR3717385@habkost.net>
References: <20200930164949.1425294-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200930164949.1425294-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:31:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 30, 2020 at 06:49:38PM +0200, Philippe Mathieu-Daudé wrote:
> This is the third part of a series reducing user-mode
> dependencies. By stripping out unused code, the build
> and testing time is reduced (as is space used by objects).

I'm queueing patches 2-9 on machine-next.  Thanks!

Markus, Eric: I can merge the QAPI patches (1, 11) if I get an
Acked-by.

I'll send separate comments on patch 10.

> 
> Part 3:
> - Extract code not related to user-mode from hw/core/qdev-properties.c
> - Reduce user-mode QAPI generated files
> 
> Since v2:
> - Fixed UuidInfo placed in incorrect json
> - Rebased on Meson
> - Include X86CPUFeatureWord unmerged from part 2
> 
> Since v1:
> - Addressed Richard and Paolo review comments
> 
> Patches missing review: QAPI ones :)
> - #1  'qapi: Restrict query-uuid command to block code'
> - #11 'qapi: Restrict code generated for user-mode'
> 
> Green CI: https://gitlab.com/philmd/qemu/-/pipelines/196505787
> 
> v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg688879.html
> v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg688486.html
> 
> Philippe Mathieu-Daudé (11):
>   qapi: Restrict query-uuid command to block code
>   hw/core/qdev-properties: Use qemu_strtol() in set_mac() handler
>   hw/core/qdev-properties: Use qemu_strtoul() in set_pci_host_devaddr()
>   hw/core/qdev-properties: Fix code style
>   hw/core/qdev-properties: Export enum-related functions
>   hw/core/qdev-properties: Export qdev_prop_enum
>   hw/core/qdev-properties: Export some integer-related functions
>   hw/core/qdev-properties: Extract system-mode specific properties
>   hw/core: Add qdev stub for user-mode
>   target/i386: Restrict X86CPUFeatureWord to X86 targets
>   qapi: Restrict code generated for user-mode
> 
>  qapi/block.json                  |  30 ++
>  qapi/machine-target.json         |  45 ++
>  qapi/machine.json                |  72 ---
>  hw/core/qdev-prop-internal.h     |  30 ++
>  include/hw/qdev-properties.h     |   1 +
>  block/iscsi.c                    |   2 +-
>  hw/core/qdev-properties-system.c | 687 ++++++++++++++++++++++++++++-
>  hw/core/qdev-properties.c        | 735 ++-----------------------------
>  stubs/qdev-system.c              |  24 +
>  stubs/uuid.c                     |   2 +-
>  target/i386/cpu.c                |   2 +-
>  target/i386/feature-stub.c       |  23 +
>  qapi/meson.build                 |  51 ++-
>  stubs/meson.build                |   5 +-
>  target/i386/meson.build          |   1 +
>  15 files changed, 915 insertions(+), 795 deletions(-)
>  create mode 100644 hw/core/qdev-prop-internal.h
>  create mode 100644 stubs/qdev-system.c
>  create mode 100644 target/i386/feature-stub.c
> 
> -- 
> 2.26.2
> 

-- 
Eduardo


