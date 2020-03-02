Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08841C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB5922B48
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 18:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="amAObi8I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB5922B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pa2-0007kX-2t
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 13:14:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j8pZN-0007Bw-E5
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j8pZL-0005fp-VG
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:13:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47141
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j8pZL-0005fP-RL
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 13:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583172811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MSmFVNTeYLhn7dj+tTc2RREsPhLPBBM6IDVQ/g2BuqY=;
 b=amAObi8I3cFOaqRlabBo4t4P2OUNWhjlRxoJRk6TiqwHWKe2EQF2nyMJhmkaUBn43KzoAx
 EQuOpnaQlHfb1kYwZvwdSwMNMFBhJYsmX0kXE5UFLPHQBiVxFIdj0rTD9u4jZKNMj6+BD1
 Q8YvKa3NxMPOC0QDxGSCMTLzBjldjmk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-qRQirk2bNzG2lv16DhJMeg-1; Mon, 02 Mar 2020 13:13:29 -0500
X-MC-Unique: qRQirk2bNzG2lv16DhJMeg-1
Received: by mail-wr1-f70.google.com with SMTP id b12so3347wro.4
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 10:13:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MSmFVNTeYLhn7dj+tTc2RREsPhLPBBM6IDVQ/g2BuqY=;
 b=MiKeIHPiuyP9z/neXczdgJzz1I9VgDdeC8eoj4wDJ5+koxrh8vps06iawtrv74JeSC
 UpI6lR08gn+ogeHVHc7EI4EIZg8H9cGXS+UhsS3rshkH4pMZYp9ZXGWs8/08HgZVBy/p
 iOubjoSDQ4vvKGwsnr4VEnHzlQxa3bW4ysG/n2Mhe3JAp9bzhH2butUdhl/l1Zn1yZOo
 a08eOOxqQHN793Ms+NvUNTwh7XrBsYYkNU+tnR2NHQ3TYON1NJ1FHxPcFObsuyvnRV0E
 GAaXZUv8PlWUxGZ/h1QcfiJrPkJAojepepi4G0OG7yI+cLYvMBaNCvmcrg3BCvn50Zkt
 F1Qg==
X-Gm-Message-State: ANhLgQ2NilQozLfajwyFP4GEuOWgkcrCMs60LQOJ2qh9nlUEIWzJgnXm
 zF13cmcZ6Xk9liN/5Eb/zdv5dzy650ilAs80XZDTDLK9ZjRV2Q9OPHTlVzcVBQfkfb25fVEyaWv
 htnCqDXOK5kK+/N8=
X-Received: by 2002:adf:cc82:: with SMTP id p2mr772056wrj.11.1583172808524;
 Mon, 02 Mar 2020 10:13:28 -0800 (PST)
X-Google-Smtp-Source: ADFU+vv32ls8mJw0lNhUWUWqknvf2ph0CNe3DyKy321LQUjVjv+pHp0GH2f0P+zL1DDulMSggtzi7A==
X-Received: by 2002:adf:cc82:: with SMTP id p2mr772037wrj.11.1583172808301;
 Mon, 02 Mar 2020 10:13:28 -0800 (PST)
Received: from [192.168.178.40] ([151.30.85.6])
 by smtp.gmail.com with ESMTPSA id e1sm14745429wrx.90.2020.03.02.10.13.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 10:13:27 -0800 (PST)
Subject: Re: [PATCH v4 3/4] Introduce the NVMM impl
To: Kamil Rytarowski <n54@gmx.com>, rth@twiddle.net, ehabkost@redhat.com,
 slp@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
 max@m00nbsd.net, jmcneill@invisible.ca
References: <20200206115731.13552-1-n54@gmx.com>
 <20200206213232.1918-1-n54@gmx.com> <20200206213232.1918-4-n54@gmx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e85f03be-60bc-2852-7856-91790ba5958b@redhat.com>
Date: Mon, 2 Mar 2020 19:13:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200206213232.1918-4-n54@gmx.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On 06/02/20 22:32, Kamil Rytarowski wrote:
> +get_qemu_vcpu(CPUState *cpu)
> +{
> +    return (struct qemu_vcpu *)cpu->hax_vcpu;
> +}

Please make hax_vcpu a void * and rename it to "accel_data".

> +    nseg->attrib.g = __SHIFTOUT(attrib, DESC_G_MASK);

> +        __SHIFTIN((uint32_t)nseg->attrib.g, DESC_G_MASK);

What are __SHIFTOUT and __SHIFTIN?

> 
> +    if (qcpu->int_window_exit) {

Should it assert the condition in the "if" below?

> +        return false;
> +    }
> +
> +    if (qcpu->int_shadow || !(env->eflags & IF_MASK)) {
> +        struct nvmm_x64_state *state = vcpu->state;
> +
> +        /* Exit on interrupt window. */
> +        nvmm_vcpu_getstate(mach, vcpu, NVMM_X64_STATE_INTR);
> +        state->intr.int_window_exiting = 1;
> +        nvmm_vcpu_setstate(mach, vcpu, NVMM_X64_STATE_INTR);

... and should this set qcpu->int_window_exit?

> +
> +        return false;
> +    }

Have you tried running kvm-unit-tests?

> +
> +    /* Needed, otherwise infinite loop. */
> +    current_cpu->vcpu_dirty = false;

Can you explain this?

> +        break;
> +    default: /* More MSRs to add? */
> +        val = 0;

I would add at least MSR_IA32_TSC.

> 
> +
> +        if (qcpu->stop) {
> +            cpu->exception_index = EXCP_INTERRUPT;
> +            qcpu->stop = false;
> +            ret = 1;
> +            break;
> +        }
> +
> +        nvmm_vcpu_pre_run(cpu);
> +
> +        if (atomic_read(&cpu->exit_request)) {
> +            qemu_cpu_kick_self();
> +        }
> +

This is racy without something like KVM's immediate_exit mechanism.
This should be fixed in NVMM.

Paolo


