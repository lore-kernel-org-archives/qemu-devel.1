Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C374C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F2B22276
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTEZr0KK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F2B22276
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQsPQ-0008UT-R1
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 09:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQsOa-0007uk-Ul
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQsOX-0007M6-GC
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602249912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KAgktXEx3NaZtyyZCrF4aprF5W6Wd+DS4VAOjYum3+Q=;
 b=XTEZr0KK1zdLtAqPXM65nHEOFMlpaQhqUb7INb8LyWATEC7izrVwccPucrLw80o6cPkppj
 jcKBlmqE2EorK2uJt0ZBiOCqscfvwU6hCKFjZDEwCExa4sS4gUOXISXg38lKbOa94hDUob
 Ki9tSNHz5Jitu6Oa11V6Fg/d3cJ/JWQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-UkbilAJOMMuURQSXOQU4aQ-1; Fri, 09 Oct 2020 09:25:10 -0400
X-MC-Unique: UkbilAJOMMuURQSXOQU4aQ-1
Received: by mail-wr1-f69.google.com with SMTP id p6so4737194wrm.23
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 06:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KAgktXEx3NaZtyyZCrF4aprF5W6Wd+DS4VAOjYum3+Q=;
 b=hUjR6QHzZalwz3STaUm9urln0NubaPdLwpUTrgRlHUyqhev5PBo0ZWLYlJTWwhUFEc
 Gf8YzW8IqSk6CgELKrYZi0kzuqMUPHHf5VzKl8OjCaKnxdeMSs5ARMoDWwWOgTUKYQvV
 YT4frU9sn9HVXPPt1UepqSbpSunRvBoQnZ1quUp+Ya64mRtNeyWtwonYgwFnXXZgBw3w
 ACfl6H7eUXiPnmvKKZJo2nUir5bX1YO7w4pupKs2x+tfkgBxoaoFM6R8Pbbny1YYaz55
 SQDahvq7PX1XsX9dd8jmeF40oeiCfwFQSS8/F5EdmLCytAKRCEMiPnncVRJkD5w9ZMed
 XBMA==
X-Gm-Message-State: AOAM530lOgr1YpusBEfZ5joCXdeGPManOUqSqoVdSWvlCQWQDSdcS67b
 B5ynkPD3pixxKIeQZZumx6N56C0xmljUjzq/o0FPgUL5Jm11rJgLjLw7WecFHnW78HlndvPQD4P
 xH/PnZGVpS/N0taQ=
X-Received: by 2002:adf:f50e:: with SMTP id q14mr8040734wro.56.1602249909606; 
 Fri, 09 Oct 2020 06:25:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4Cem/sv0F8sxnDTrfRPeapqzojCC+HnseN/9+G78EbnO78o8FNkZMRRhcv+iVmmNDM0WDow==
X-Received: by 2002:adf:f50e:: with SMTP id q14mr8040700wro.56.1602249909395; 
 Fri, 09 Oct 2020 06:25:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cee1:4797:6958:7698?
 ([2001:b07:6468:f312:cee1:4797:6958:7698])
 by smtp.gmail.com with ESMTPSA id u17sm12913257wri.45.2020.10.09.06.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 06:25:08 -0700 (PDT)
Subject: Re: How about using clang-format instead checkpatch for fixing style?
To: luoyonggang@gmail.com, qemu-level <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <CAE2XoE9YyZwRr5j3fCATTb32pacuGrT_yUBoUTd30k+id1D3iw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <27f82fe6-5b0f-7e35-29d9-7b00ae8f189e@redhat.com>
Date: Fri, 9 Oct 2020 15:25:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE9YyZwRr5j3fCATTb32pacuGrT_yUBoUTd30k+id1D3iw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.208, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/20 15:02, 罗勇刚(Yonggang Luo) wrote:
> We can even using clang-format to format the whole repository.

checkpatch does other checks than formatting.

Reformatting the whole repository has been mentioned many times, people
were worried of messing up the result of "git blame".  But without doing
that, it's hard to get rid of checkpatch because checkpatch only looks
at the lines that are touched by the patch.

Paolo


