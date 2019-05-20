Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD4FC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAFD22081C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 10:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFD22081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33283 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSftN-0007D3-6G
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 06:51:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hSfsC-0006F7-ED
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:50:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hSfsB-0001pq-1r
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:50:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hSfsA-0001pW-RU
	for qemu-devel@nongnu.org; Mon, 20 May 2019 06:50:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id x64so12753987wmb.5
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 03:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=gRjUM+hiOYjJMWfzZ8S+aL0ir8nZDxwanCKno9zTP1w=;
	b=Tcg6DtpuRnhU6c7EyCHEeIzOFJ5RVm+BCdHTvall5yPSB58zF2SAU0dWoVRaf87/q5
	sH+JudfnIWXQnb7+SzvoFIFIiycCga2aldzqWhAW3iAZm/fkdLjgddpGS+Dt6o1UNNMI
	Mli4W/Ae6JU0Oe5Zp2mROQ3N/EqySqQLtFhh+6m+eyIXib0wNTjhLl3crINKcZTZDXFz
	ZsaTygI47lEbQEWI494hxUV/TjaRoOPNAS6sKhLPYOvneHS19V/Ljlqe8t3TZKsQuAAT
	7Kpcdyak1E4VuR3qWbDZS21BBsqEc3YXNulZE7OBJ8wKEqy5QQJUHEYNkhPMqLLwKrn7
	16hA==
X-Gm-Message-State: APjAAAVPaTGExQauB6xJwLt3Kmw4dVDEPEx2z6qh2Cxq1ZPLG9+l6ybq
	3PGu7mBdQACeJ3RGbDhPLGGIgQ==
X-Google-Smtp-Source: APXvYqxxiET87jPNHBZ0uNHS31qEfMNNbh2KQTKuLxQGJj4DZoA1cBwfViq0LYNxJXqkkajehfJyCA==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr23707829wmb.110.1558349425828; 
	Mon, 20 May 2019 03:50:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac04:eef9:b257:b844?
	([2001:b07:6468:f312:ac04:eef9:b257:b844])
	by smtp.gmail.com with ESMTPSA id
	d9sm21103748wro.26.2019.05.20.03.50.25
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 May 2019 03:50:25 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
References: <20190520030839.6795-1-peterx@redhat.com>
	<20190520030839.6795-13-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9558ee27-7d61-4afd-f4f3-ff726e8ce93d@redhat.com>
Date: Mon, 20 May 2019 12:50:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520030839.6795-13-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2 12/15] kvm: Support KVM_CLEAR_DIRTY_LOG
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/05/19 05:08, Peter Xu wrote:
> +    s->manual_dirty_log_protect =
> +        kvm_check_extension(s, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
> +    if (s->manual_dirty_log_protect) {
> +        ret = kvm_vm_enable_cap(s, KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2, 0, 1);
> +        if (ret) {
> +            warn_report("Trying to enable KVM_CAP_MANUAL_DIRTY_LOG_PROTECT "

Please use KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2 in the error too (and in
the commit message).

Paolo

> +                        "but failed.  Falling back to the legacy mode. ");
> +            s->manual_dirty_log_protect = false;
> +        }


