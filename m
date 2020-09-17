Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540E3C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF7820707
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 18:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtrJdCQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF7820707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIyHE-00039L-Ce
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 14:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIyEV-0001cv-Uv
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 14:02:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIyEQ-0005w4-Aa
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 14:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600365723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3LCMQMaZcSnfxJzpPH8ta8EZYnP+a6CA5WrFOekIX50=;
 b=DtrJdCQzFYa3i6C4azLH3OT3bRe9TTCuVNK2VxJXAMYRdjquI146tXJ3m50rApi370ppbt
 7lx4rzP5zStWnDBEiyXZWoB8PpE9uA4yQdqxmZaqJJFIiy2r0SPuWg6ZL7DdkodYbyyrrI
 +foxmermZU1snrOqtUuNVeTkq5/IuNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-i0iUnOeMMZKjgqEZTsjbVw-1; Thu, 17 Sep 2020 14:02:01 -0400
X-MC-Unique: i0iUnOeMMZKjgqEZTsjbVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B8758B8C07;
 Thu, 17 Sep 2020 18:02:00 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6AC160BEC;
 Thu, 17 Sep 2020 18:01:59 +0000 (UTC)
Date: Thu, 17 Sep 2020 14:01:58 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v3 2/2] Mark Icelake-Client CPU models deprecated
Message-ID: <20200917180158.GT7594@habkost.net>
References: <1600245434-63021-1-git-send-email-robert.hu@linux.intel.com>
 <1600245434-63021-2-git-send-email-robert.hu@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <1600245434-63021-2-git-send-email-robert.hu@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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

On Wed, Sep 16, 2020 at 04:37:14PM +0800, Robert Hoo wrote:
> Going to obsolete Icelake-Client CPU models in the future.
> 
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> ---
> Change log
> v3:
> Obsolete in v5.2 --> v5.3.
> 
>  target/i386/cpu.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 9cb82b7..15c1c00 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -3467,7 +3467,12 @@ static X86CPUDefinition builtin_x86_defs[] = {
>          .xlevel = 0x80000008,
>          .model_id = "Intel Core Processor (Icelake)",
>          .versions = (X86CPUVersionDefinition[]) {
> -            { .version = 1 },
> +            {
> +                .version = 1,
> +                .deprecated = true,
> +                .note = "Deprecated. Will be obsoleted in v5.3. Please use "
> +                        "'Icelake-Server-v1' CPU model",

What's the difference between "deprecated" and "obsoleted"?

> +            },
>              {
>                  .version = 2,
>                  .note = "no TSX",
> @@ -3477,6 +3482,9 @@ static X86CPUDefinition builtin_x86_defs[] = {
>                      { "rtm", "off" },
>                      { /* end of list */ }
>                  },
> +                .deprecated = true,
> +                .note = "Deprecated. Will be obsoleted in v5.3. Please use "
> +                        "'Icelake-Server-v2' CPU model",
>              },
>              { /* end of list */ }
>          }
> -- 
> 1.8.3.1
> 

-- 
Eduardo


