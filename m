Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7098C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 19:00:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB9A206E3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 19:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMMU76Uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB9A206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcCOq-0006Fr-3R
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 14:00:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kcCNh-0005NI-4g
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:59:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kcCNe-0003gz-NR
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 13:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604948345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dY5Mo7Jg/MTQUsb8LmxT0/H9ocHfuBeBd6pm3B7H5o=;
 b=PMMU76UypMxEshBTQy/yPnSK3cIsD7mOm+dzz33QhDkWiOhRouv/xhHO+RqufjQKH8BWTO
 UIDDcsM2mhq5CCnTajVKBOJK/0xtxIxbGRcVULL+QHOwf3OPMoNxR1JNa9tNZuc8uYzbMs
 lQiGORuZTszj/B365tldXWgJDSvttXE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-7Dp8mH2TO6GVfdaNjW_Gcg-1; Mon, 09 Nov 2020 13:59:04 -0500
X-MC-Unique: 7Dp8mH2TO6GVfdaNjW_Gcg-1
Received: by mail-wm1-f69.google.com with SMTP id t201so147344wmt.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 10:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5dY5Mo7Jg/MTQUsb8LmxT0/H9ocHfuBeBd6pm3B7H5o=;
 b=V7mBJ8agjgnPi8COl1AgeIfC8QaJfMgfTX0dJlZJp9gSKiFeW0WuSvW9r6cMSRdCYi
 Ubc4PPbchmwM3NfcZTXCIyrgSoqKuZFC9FMt9oVOHgTp8DgZB7WkZM+3HNQxBU2KwQ1t
 noH2CDLWhp5pJpyZ3pH864P8OD/c5OGzRunbX1NozDpuZMRJZDdTjTDS9nSouQkyi+Uv
 JahufmE8xYoeO8Jv9PfyC3z1rCSHSzqqhPq2FSszVjSDVcOSO8FCvWi/JsfJUI838pyB
 vHSxCoJUt0QC/8RF2WqLDLxaV6Z2mgYdEmEXhJICFa76hYofSbcmUYSm1DEk87GIC10c
 hg4Q==
X-Gm-Message-State: AOAM532CNUoC/T+tM31Mr7B7Qnh+ZT3xdqJqygaCJTvYTHnHkY9bmF47
 N0z0F22Dpx7BV6AjgsY3ijOhLxxxx7NAiD/RTjKgRB/5CJGiUoMNVX5hirutJXzhYKy8CWFx6FK
 ywKzYsDwgHWcRFC4=
X-Received: by 2002:a5d:670f:: with SMTP id o15mr2335237wru.204.1604948342418; 
 Mon, 09 Nov 2020 10:59:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9+uN1IsiH39NBIN9jxALb+AtwvWcbmQ63ONJF9KBTlUWUsI6m9vgvHY0NIBG8Mf/CIeiwWw==
X-Received: by 2002:a5d:670f:: with SMTP id o15mr2335222wru.204.1604948342234; 
 Mon, 09 Nov 2020 10:59:02 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id c185sm331000wma.44.2020.11.09.10.59.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 10:59:01 -0800 (PST)
To: Markus Armbruster <armbru@redhat.com>
References: <20201109133931.979563-1-pbonzini@redhat.com>
 <20201109133931.979563-5-pbonzini@redhat.com>
 <87wnyu4gf9.fsf@dusky.pond.sub.org>
 <736a0053-83b9-3510-82ad-99ea59ea00fe@redhat.com>
 <87a6vq4bqj.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/6] qemu-option: clean up id vs. list->merge_lists
Message-ID: <e6fbdb7a-c352-bb81-1dad-7f19c704b108@redhat.com>
Date: Mon, 9 Nov 2020 19:59:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <87a6vq4bqj.fsf@dusky.pond.sub.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/20 19:38, Markus Armbruster wrote:
>> They are never qemu_opts_find'd with non-NULL id, so I'd say they are.
> 
> We also need to check qemu_opts_foreach().

Using qemu_opts_foreach means that e.g. -name id=... was not ignored 
unlike -M id=....  However, it will be an error now.  We have to check 
if the callback or its callees use the opt->id

Reminder of how the affected options are affected:

reopen_opts in qemu-io-cmds.c	qemu_opts_find(&reopen_opts, NULL)

empty_opts in qemu-io.c		qemu_opts_find(&empty_opts, NULL)

qemu_rtc_opts			qemu_find_opts_singleton("rtc")

qemu_machine_opts		qemu_find_opts_singleton("machine")

qemu_boot_opts			
	QTAILQ_FIRST(&qemu_find_opts("bootopts")->head)

qemu_name_opts			qemu_opts_foreach->parse_name
				parse_name does not use id

qemu_mem_opts			qemu_find_opts_singleton("memory")

qemu_icount_opts		qemu_opts_foreach->do_configuree_icount
				do_configure_icount->icount_configure
				icount_configure does not use id

qemu_smp_opts
	qemu_opts_find(qemu_find_opts("smp-opts"), NULL)

qemu_spice_opts			QTAILQ_FIRST(&qemu_spice_opts.head)

To preempt your question, I can add this in the commit message.  Anyway 
I think it's relatively self-explanatory for most of these that they do 
not need "id".

>> - merge_lists = false: singleton opts with NULL id; non-NULL id fails
>
> Do you mean merge_lists = true here, and ...
> 
>> - merge_lists = true: always return new opts; non-NULL id fails if dup
>
> ... = false here?

Of course.  1-1 in the brain fart competition.

Paolo


