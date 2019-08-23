Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A65DC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 22:45:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B1E21019
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 22:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Qe/nssV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B1E21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1IJZ-00066J-AP
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 18:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jimw@sifive.com>) id 1i1IIR-0005S9-32
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 18:44:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jimw@sifive.com>) id 1i1IIP-0008Ui-Qm
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 18:44:38 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46175)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jimw@sifive.com>) id 1i1IIP-0008UL-Jd
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 18:44:37 -0400
Received: by mail-pl1-x642.google.com with SMTP id c2so6355970plz.13
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 15:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cducK59MBXKJ93r1KVnBEFpVm8bq0VHnRhixw0q769Y=;
 b=Qe/nssV5hSuvS3NIGru5v0fsqFWxURlLf34VzNK6NOJbuF/JObobR6peqVPq8fgfpb
 lkRaqskqMWH7G/uNlgbugQDuXusPL/BQ9Fg2N6+aUhP6RAVNRXlQRf+N28itBxCZLcQi
 V+sByVRPKxQFfMopt76I3ZH9bkqJf603BqdS67mB086gPrD/a8UUp79ibVH4rMHF+Jv6
 av2OOb5vfM49uZcrciyKeXLM/vr+V1Oh70TnUxka5NP5M7kZNCWp2Tf2VHf84iETO8H9
 fp0xi2EK9n9K5jeqb3nOqwYdi1r+JUxpM6boRrz1ErmaVl0FGQ1lr0tnW6jscIKg15L3
 ywSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cducK59MBXKJ93r1KVnBEFpVm8bq0VHnRhixw0q769Y=;
 b=mPOVxygiDDzj4zXqEDCG0O+dIMqcfipyv09lcJlIc74NcCS4XWUGkXWtZYR+Y/hHbx
 sPoLAGjkArSi0L39JwNgaaybi7kfEexZINxlP70s4+7VdqZ9Wf/UAOG7GUA21dbZI6Fk
 S2Jrf5c+wpURZ2NKOQcXexy8Kzkn3wE5O3hLIiKRcSqKcErRAUDG9xROEnvjTfprdHO4
 bz3PVDkxwe4GLfGOcVvpOLbr5maPiyFxCRfaQUzjKDDNf1JBFnB0qmJPvzGR+TFG5uij
 nOZcZB7nR8YnPPeYESSXH/48T9sw68WbCs5RcjYhl1N+oJv+cOwWLD3DLOMUoENuKuJ6
 BDkw==
X-Gm-Message-State: APjAAAWMK+au7sU880CmNlCP2KnyZfq/lB4w8lxw6qf0xDSXUzBeez1r
 kgirgmbFjNAl/HcCJ6y31EH8dQ==
X-Google-Smtp-Source: APXvYqy+6t67MWGYJz+ST908fmjspnudLBlqogElHwI11DRdhN7AABuiItUP8liOaNPvVlICvOc9sQ==
X-Received: by 2002:a17:902:a50b:: with SMTP id
 s11mr569362plq.44.1566600276169; 
 Fri, 23 Aug 2019 15:44:36 -0700 (PDT)
Received: from [10.17.0.199] ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id 65sm4746032pff.148.2019.08.23.15.44.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 15:44:35 -0700 (PDT)
To: Georg Kotheimer <georg.kotheimer@kernkonzept.com>, qemu-devel@nongnu.org
References: <20190821162831.27811-1-georg.kotheimer@kernkonzept.com>
From: Jim Wilson <jimw@sifive.com>
Message-ID: <bee5ed64-7a65-c303-9cb6-8efcf4f8daf0@sifive.com>
Date: Fri, 23 Aug 2019 15:44:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821162831.27811-1-georg.kotheimer@kernkonzept.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v3] RISC-V: Select FPU gdb xml file based
 on the supported extensions
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
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/19 9:28 AM, Georg Kotheimer wrote:
> The size of the FPU registers depends solely on the floating point
> extensions supported by the target architecture.
> However, in the previous implementation the floating point register
> size was derived from whether the target architecture is 32-bit or
> 64-bit.
> 
> To allow RVF without RVD, changes to riscv_gdb_get_fpu() and
> riscv_gdb_set_fpu() were necessary.

Reviewed-by: Jim Wilson <jimw@sifive.com>

Jim

