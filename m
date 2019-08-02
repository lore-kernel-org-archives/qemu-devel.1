Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80B6C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D6621871
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D6621871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htXW4-0001Xm-UA
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 09:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49455)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1htXVY-0000lU-Ov
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:22:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1htXVQ-0002vq-SJ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:22:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54281)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1htXVM-0002qH-U9
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:21:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so67925127wme.4
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 06:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p/Ya6od2cptpCPaQbPq8FsyWMNNTXuDTm/vysTIknKk=;
 b=Dp93Lz4UyosUuDPaDcEFfwambdcgcsB5zJ9/RP17BG3+HaamFv2iciKUAjLdh9+Msh
 ggOPjm1ZOcBH5AYdbv4tCAFqhySQvK0+HHcp0UmMtekNfmhO9D7rtlVbTSfrx/hIBYkF
 QuORXTqDHPMuyIWWa2ZFIXtiH7N7fFl25Av2YuaEZY0/So8TN4U3BxMzRbdkzcSVs29v
 KxB7PJ59F7llZsarVHzbLFmBOk9MC5y0LnuYkwg/TLIgL3gBCXwY+Fv9bk8J0w+VvbIw
 c64rDamq3Qe5dZTgLqoGO15xX8WUE4YAL7VOZ3MPCX+aEiWvEvjMoUvGnOytIMrQiM7k
 6mEg==
X-Gm-Message-State: APjAAAUKIHIMvXeN5kvSqNXwox6MUGSO/N2aAD0HzRrNxqrOP3TKIxMH
 D72/d38Sfpm4ov9PDMMMmB+3BQw14eM=
X-Google-Smtp-Source: APXvYqw5q/xk3r+eSFp+mP/E9B5T7ft3wPiyeF7zJ1q/Icp7hxKjPDZhX9neJBtULyOx5ptRwMWddQ==
X-Received: by 2002:a1c:a8d7:: with SMTP id r206mr4620782wme.47.1564752115655; 
 Fri, 02 Aug 2019 06:21:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4013:e920:9388:c3ff?
 ([2001:b07:6468:f312:4013:e920:9388:c3ff])
 by smtp.gmail.com with ESMTPSA id w7sm88145791wrn.11.2019.08.02.06.21.54
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 06:21:54 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-28-armbru@redhat.com>
 <10eeb125-0acd-330a-28f1-50efe82b2fe5@redhat.com>
 <87ef23iu5y.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0462d0a9-b6ef-1969-84a4-40273728a534@redhat.com>
Date: Fri, 2 Aug 2019 15:21:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87ef23iu5y.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH 27/28] sysemu: Move the VMChangeStateEntry
 typedef to qemu/typedefs.h
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/08/19 15:16, Markus Armbruster wrote:
> * VMChangeStateEntry and the three functions using it, obviously, along
>   with VMChangeStateHandler.
> 
> * vm_state_notify(), because it belongs to the above.
> 
> * The runstate_FOO() functions, because they're named like the new
>   header?
> 
> * vm_stop(), vm_stop_force_state(), vmstop_requested(),
>   vmstop_requested, because they use RunState?
> 
> * The remaining vm_FOO(), because they're closely related to vm_stop()?
> 
> * Everything else from qemu_exit_preconfig_request() to
>   qemu_remove_exit_notifier(), along with WakeupReason?

Yes, that could be an idea, but not qemu_add/remove_exit_notifier.

Paolo

