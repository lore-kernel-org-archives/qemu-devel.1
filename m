Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D26CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B1B8206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 18:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="coGzbmaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B1B8206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jguMB-0002Z5-9x
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 14:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jguLB-0001pp-Rn
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:11:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49900
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jguLA-0003z1-GT
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 14:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591294303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tfj/jKDQxhQHKBt/5CBGWZz+nBrrqMNlPcG++Gi61BM=;
 b=coGzbmaHrhpI8FO9uoIeXj2QTtPTMl+K78asbi9Cw/woQjf/tkA/iRz6pTTqR85p/j1frv
 syb0NxTOq+4CIQcM0plM+ZabZSd/NuWb9ODp7VNd55T8fQkg39kW/dZrkpiTHdhvWzPhp7
 YB+40KXbQJU6S27g3Vad/pdpg8NQNMw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-Ax5YnWg3PredI7nq7TKUPw-1; Thu, 04 Jun 2020 14:11:41 -0400
X-MC-Unique: Ax5YnWg3PredI7nq7TKUPw-1
Received: by mail-wm1-f70.google.com with SMTP id j128so2229188wmj.6
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 11:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tfj/jKDQxhQHKBt/5CBGWZz+nBrrqMNlPcG++Gi61BM=;
 b=cM0kjJCSu0jUso9Z0U0dwgkO+gSBnVIrQY2OaZ6cUb1eYwWqo+KwYuRvtv5WwPMF31
 7C5tLL93dQttvifUSVlDg3xFzL9YAOKEYiK7qAaQDjJv1kJz12Q1KRw52TCLp/5u2KGh
 a51o4hS+4TKtmk3hBn8l56hyqlObGAWAbhr3iajuYjg6HjJiBE2dz7PjTeuymKtNQtGX
 RhxItYNgLDa2X9oa4qYzNOqHCd0aREb4ww66yrXrTON196vJhM8dltP9QgP+018zm0f4
 wB2jPp3QsuQURSc4ibz3VKfyD1/eoyFsPWbVUEdSEhcGqf+R+W60YlijLyRu1FELjZ/A
 OW8w==
X-Gm-Message-State: AOAM532wWPvxYVppG7Vk+aaGz3d9Y1uV1t0QwrTmYQPI6nh3TiREBCrt
 HR4K8SoenjrVRUZcET0WgwxveMriI8Cu/QG3XCI+OXWuPvMxpHHCiaZwCXw7fqgeutdEJgS3tLE
 uGdgLMjC9iEt3IBc=
X-Received: by 2002:a7b:cb13:: with SMTP id u19mr5105736wmj.86.1591294300395; 
 Thu, 04 Jun 2020 11:11:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwb8U9SXLf4UeK9rpLHo7Ycy1/1Ka7Gw/u4m3i07onqjBUJRZ/OGhGm+Rzl3ZhE51JV0O8jg==
X-Received: by 2002:a7b:cb13:: with SMTP id u19mr5105725wmj.86.1591294300157; 
 Thu, 04 Jun 2020 11:11:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb?
 ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
 by smtp.gmail.com with ESMTPSA id c16sm8971595wrx.4.2020.06.04.11.11.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 11:11:39 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] exec/cpu: Cleanups around "exec/hwaddr.h"
 (reserved to system-mode)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200526172427.17460-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <525ebf16-1265-e403-54b6-e1168d84e4f4@redhat.com>
Date: Thu, 4 Jun 2020 20:11:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200526172427.17460-1-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 13:58:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/05/20 19:24, Philippe Mathieu-Daudé wrote:
> The 'hwaddr' type declared in "exec/hwaddr.h" is meant for
> system-mode emulation only.
> This series is a preparatory cleanup to allow later poisoning
> it in user-mode code.
> 
> Missing review: patche 7
> - target/s390x: Restrict system-mode declarations
> 
> Maybe PPC/S390X maintainers can take their patches and let
> the rest to Paolo, or he can take all the series. They are
> not dependents.
> 
> Since v1:
> - Do not poison hwaddr type
> - Addressed Cornelia & David review comments
> - Added R-b/A-b
> 
> $ git backport-diff -u v1
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream patch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respectively
> 
> 001/7:[----] [--] 'sysemu/accel: Restrict machine methods to system-mode'
> 002/7:[----] [--] 'sysemu/tcg: Only declare tcg_allowed when TCG is available'
> 003/7:[----] [--] 'sysemu/hvf: Only declare hvf_allowed when HVF is available'
> 004/7:[----] [--] 'target/ppc: Restrict PPCVirtualHypervisorClass to system-mode'
> 005/7:[----] [--] 'target/s390x: Only compile decode_basedisp() on system-mode'
> 006/7:[0002] [FC] 'target/s390x/helper: Clean ifdef'ry'
> 007/7:[0005] [FC] 'target/s390x: Restrict system-mode declarations'
> 
> Supersedes: <20200509130910.26335-1-f4bug@amsat.org>
> 
> Philippe Mathieu-Daudé (7):
>   sysemu/accel: Restrict machine methods to system-mode
>   sysemu/tcg: Only declare tcg_allowed when TCG is available
>   sysemu/hvf: Only declare hvf_allowed when HVF is available
>   target/ppc: Restrict PPCVirtualHypervisorClass to system-mode
>   target/s390x: Only compile decode_basedisp() on system-mode
>   target/s390x/helper: Clean ifdef'ry
>   target/s390x: Restrict system-mode declarations
> 
>  include/sysemu/accel.h          |  2 ++
>  include/sysemu/hvf.h            |  6 +++---
>  include/sysemu/tcg.h            |  2 +-
>  target/ppc/cpu.h                |  4 ++--
>  target/ppc/kvm_ppc.h            | 22 +++++++++++-----------
>  target/s390x/internal.h         | 16 +++++++++++-----
>  target/ppc/translate_init.inc.c |  4 ++++
>  target/s390x/helper.c           |  5 -----
>  8 files changed, 34 insertions(+), 27 deletions(-)
> 

Queued all, thanks.

Paolo


