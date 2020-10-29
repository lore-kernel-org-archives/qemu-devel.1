Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1375C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D2C207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJ/5ZB04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D2C207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYCJa-0001Jp-RC
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 14:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kYCIR-0000Nl-MZ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:05:11 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kYCIP-0001ca-EV
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:05:11 -0400
Received: by mail-wm1-x344.google.com with SMTP id 13so706345wmf.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:references:subject:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VUolC1jlGPEjQS9XsOAVDWxe1JIU+Cdg/d4I6L9696c=;
 b=rJ/5ZB04LuyFTOn6DN94EI3DJ4a1+cWrGcZZYRkKA0tokzWmSGYdtjDCO5+OGwq7P1
 P9Nde8wH8Pn21fwpnEsCRlzg3GKd9AxZRvGXgQfwNCT4g2lxXMreKc5vcLtiKpYsuR7Q
 tNLuMCK/8Y6/pFLX5vdZIW2R5AQGjhk6mz57HVntz4n01lZ9zjTDOtlna58tTrNCV1Ph
 pAATUiHeb/gCYrwtYBmJaAMj53cuX5bH4zyN8XTS1C+k5R685VQsqROrhPd2+nPn5+GK
 dw2NjUuetRV3+tYTuz42VURfKOCwwtnynVzydWQL5Svp/KRMCWlk2n1xRVWDDoce6Ari
 o+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:references:subject:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VUolC1jlGPEjQS9XsOAVDWxe1JIU+Cdg/d4I6L9696c=;
 b=AhR1lkiTz1A4/mG8C1I6hZAdk8FBB2B1cjsLDyeiLno+Z1FlFIEAUCfVC8RETYyNnr
 YJrF3sJRyNaLXMKoMVlea955qZssoWaFMUEK/sPS2DT2BCols8ayT7PP4NDzD9RioDcT
 xBeRUTNmczaGwinxBi5kJwqJiXekhJvtnnC848007HDpzE+lGWn8pj+93CgrkIWV3yQ5
 +zYN1ONvuTRAFeFSf3sAgzX/96D8xBgfnPuN6F9tqs9/4nu5vE9XbVqgZbVZP6o/a4Sp
 bp7A1Eo0Pp04KU+f8GOi4QKDr9L2VdAFGAUw0MNpCdeTwYdi35Hhlk3ozfZAIG+PP5+5
 /HXQ==
X-Gm-Message-State: AOAM531jrkSJ5ehA/lHgx65NnvCCUVFe02ZJysC0q872uG+AhuTth71/
 UxEV8GYEZSRZTUAXdOJMsvw=
X-Google-Smtp-Source: ABdhPJxKbgvjvIlHyGgw+/1P2L8Zuqmf9pWUGpDjEs7vPhjrGKcIDRCYGda66TJCgFiC2KKWkNIloQ==
X-Received: by 2002:a1c:7707:: with SMTP id t7mr77782wmi.54.1603994705903;
 Thu, 29 Oct 2020 11:05:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.googlemail.com with ESMTPSA id t1sm5973400wrs.48.2020.10.29.11.05.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 11:05:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20201029133833.3450220-1-armbru@redhat.com>
 <20201029133833.3450220-8-armbru@redhat.com>
 <5d93ee2c-e041-6905-56cd-fc96205e37b8@redhat.com>
Subject: Re: [PATCH 07/11] sockets: Fix default of UnixSocketAddress member
 @tight
Message-ID: <67c5fe06-c846-70d8-2ffc-761c80f95ef8@redhat.com>
Date: Thu, 29 Oct 2020 19:05:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <5d93ee2c-e041-6905-56cd-fc96205e37b8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.261,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: kwolf@redhat.com, berrange@redhat.com, zxq_yx_007@163.com,
 kraxel@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/10/20 18:39, Paolo Bonzini wrote:
>> When @tight was set to false as it should be, absent @tight defaults
>> to false.  Wrong, it should default to true.  This is what breaks QMP.
> When @has_tight...

Ah, I see what you meant here.  Suggested reword:

---------
An optional bool member of a QAPI struct can be false, true, or absent.
The previous commit demonstrated that socket_listen() and
socket_connect() are broken for absent @tight, and indeed QMP chardev-
add also defaults absent member @tight to false instead of true.

In C, QAPI members are represented by two fields, has_MEMBER and MEMBER.
We have:

	    has_MEMBER    MEMBER
    false         true	   false
    true	  true	   false
    absent	 false	false/ignore

When has_MEMBER is false, MEMBER should be set to false on write, and
ignored on read.

For QMP, the QAPI visitors handle absent @tight by setting both
@has_tight and @tight to false.  unix_listen_saddr() and
unix_connect_saddr() however use @tight only, disregarding @has_tight.
This is wrong and means that absent @tight defaults to false whereas it
should default to true.

The same is true for @has_abstract, though @abstract defaults to
false and therefore has the same behavior for all of QMP, HMP and CLI.
Fix unix_listen_saddr() and unix_connect_saddr() to check
@has_abstract/@has_tight, and to default absent @tight to true.

However, this is only half of the story.  HMP chardev-add and CLI
-chardev so far correctly defaulted @tight to true, but defaults to
false again with the above fix for HMP and CLI.  In fact, the "tight"
and "abstract" options now break completely.

Digging deeper, we find that qemu_chr_parse_socket() also ignores
@has_tight, leaving it false when it sets @tight.  That is also wrong,
but the two wrongs cancelled out.  Fix qemu_chr_parse_socket() to set
@has_tight and @has_abstract; writing testcases for HMP and CLI is left
for another day.
---------

Apologies if the last sentence is incorrect. :)

Thanks,

Paolo

