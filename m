Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01E6C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 20:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629812080A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 20:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUR6ybbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 629812080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMzzy-0005P4-D0
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 16:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kMzz4-0004kZ-98
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 16:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kMzz2-0003c3-08
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 16:42:53 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601325771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dzRuR1clS5sxZOMNaCqXzAEyTsOvIMgFPg9/RmlPoSE=;
 b=DUR6ybbuFfhDTFf5RwVMmMmaf1C6QN83QvmdF1oBml25yJDLvxwOgIorFcaA2FONO1A2lh
 NxpwYVmoblGKnFiE7YIJgIE2zieBPMoGzaNsTM8JHVuSgDZqT4vu0yNOUhbRxI9kQsulV3
 wq36Wo5mx93gcdlG55hIkkHkhrlkuck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-xHFhgS-bMqKGk83LkhqJQw-1; Mon, 28 Sep 2020 16:42:49 -0400
X-MC-Unique: xHFhgS-bMqKGk83LkhqJQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8289801ADF;
 Mon, 28 Sep 2020 20:42:47 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C5A85C1BD;
 Mon, 28 Sep 2020 20:42:47 +0000 (UTC)
Date: Mon, 28 Sep 2020 16:42:46 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v4 2/2] Mark Icelake-Client CPU models deprecated
Message-ID: <20200928204246.GG3717385@habkost.net>
References: <1600758855-80046-1-git-send-email-robert.hu@linux.intel.com>
 <1600758855-80046-2-git-send-email-robert.hu@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <1600758855-80046-2-git-send-email-robert.hu@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com, robert.hu@intel.com,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 22, 2020 at 03:14:15PM +0800, Robert Hoo wrote:
> Going to obsolete Icelake-Client CPU models in the future.
> 
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> ---
> Change log
> v4:
> Deprecation note is general now. More detailed information is moved to
> docs/system/deprecated.rst.
> 
> v3:
> Obsolete in v5.2 --> v5.3.
> 
> ---
>  docs/system/deprecated.rst |  6 ++++++
>  target/i386/cpu.c          | 10 +++++++---
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 0cb8b01..5dc2ff3 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -329,6 +329,12 @@ The ``compat`` property used to set backwards compatibility modes for
>  the processor has been deprecated. The ``max-cpu-compat`` property of
>  the ``pseries`` machine type should be used instead.
>  
> +``Icelake-Client`` CPU Model (since 3.1)
> +''''''''''''''''''''''''''''''''''''''''
> +
> +``Icelake-Client`` CPU Models are deprecated. Use ``Icelake-Server`` CPU
> +Models instead.
> +
>  System emulator devices
>  -----------------------
>  
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 323c7e3..5566356 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3358,10 +3358,13 @@ static X86CPUDefinition builtin_x86_defs[] = {
>          .xlevel = 0x80000008,
>          .model_id = "Intel Core Processor (Icelake)",
>          .versions = (X86CPUVersionDefinition[]) {
> -            { .version = 1 },
> +            {
> +                .version = 1,
> +                .note = "Deprecated"
> +            },
>              {
>                  .version = 2,
> -                .note = "no TSX",
> +                .note = "no TSX, Deprecated",
>                  .alias = "Icelake-Client-noTSX",
>                  .props = (PropValue[]) {
>                      { "hle", "off" },
> @@ -3370,7 +3373,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
>                  },
>              },
>              { /* end of list */ }
> -        }
> +        },
> +        .deprecation_note = "Deprecated. Use Icelake-Server instead."

This results in the following message:

  qemu-system-x86_64: warning: CPU model Icelake-Client-x86_64-cpu is deprecated -- Deprecated. Use Icelake-Server instead.

There's no need to say "deprecate" twice.

I'm changing it to "use Icelake-Server instead" and queueing on x86-next.
Thanks!


>      },
>      {
>          .name = "Icelake-Server",
> -- 
> 1.8.3.1
> 

-- 
Eduardo


