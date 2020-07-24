Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FA7C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EEE206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYMX2kkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EEE206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyzIW-0004yL-5B
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 11:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyzHn-0003tC-LL
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 11:06:59 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jyzHj-0002Nt-Sn
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 11:06:59 -0400
Received: by mail-wr1-x444.google.com with SMTP id f2so8610858wrp.7
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 08:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LYlLIXj4MKRiSVpNmV4f8EnfieHMZu7W7mFmpI6SfyQ=;
 b=JYMX2kkXrtOPV+nqpts/+zRPW018CqpNZJHgbRUiAz2dwN58NM39ptFFOrrTrTshJ2
 97WbXGsX2PMrggf7zaK3Bh+r2ibl/cjOwd1c2+anXiYP3r8moaR5RuD/nVxuGJrJjoRh
 ZG09gtA8/sUgyaeA0aRw24KynxFtFvGDg/ekk+Yq1zHZucvTGgtEaf9dHByQXHs10lGr
 KpSYA6ki4UgefyBhLP4kvCuR+wVyTe42ZzSiLsDqtdQxxMR9PyEgOb68a006m5Rg1w6W
 Olco5g5LPB8BqKti2CXSKc09mWJnc2dUXcjL+kt7RJFSyalPy6dxMhMVd7XbZWj9Y1be
 I4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LYlLIXj4MKRiSVpNmV4f8EnfieHMZu7W7mFmpI6SfyQ=;
 b=DW4Us73WOvx5iw87/xOOHM+gilNC0AHyZZxupgD/n/9olQnfDKNsae2BMGFva3OqUY
 R22i3N0IxvtdkkedBJydWSDV//JruUJukO2av6n9YPMlTJhHSMU7tkHE8IP9Q9ImMFSX
 87uKR0D+o+5trAEyOJ1UQSOWEusVf0+/2zK0t5Rv8082FgcG6BDnbrn5cruswJMf4kdw
 /vr9LymxUcFj9L5OFiJC0Ho+uZaEttz3GrZ3UHsi1uuFEK11QkIZz9IWJNaPzbDirpng
 Pztda909JDw8n58pAwr/3RIZ0Es45EtfphuSzZK/evIFXGLk+12hgaC0UdssdmsoyLLA
 92lg==
X-Gm-Message-State: AOAM530gkdbLMo8AHeBn5gvtv33BIxAvS+cTrzD9uLx5cSuI98aeifWJ
 HRWloqM5BM019N62S181jkM=
X-Google-Smtp-Source: ABdhPJzg/a6ZCT47rLdyF20QPBAF7x3k8oCHd86nSr6eC8bR60xsAexywBcRgQGLAZ9jZDDYAiPbjA==
X-Received: by 2002:adf:fd4e:: with SMTP id h14mr9673643wrs.251.1595603214127; 
 Fri, 24 Jul 2020 08:06:54 -0700 (PDT)
Received: from [192.168.1.33] (214.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.214])
 by smtp.gmail.com with ESMTPSA id b10sm7119445wmj.30.2020.07.24.08.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 08:06:53 -0700 (PDT)
Subject: Re: [PULL 4/4] qapi/error: Check format string argument in
 error_*prepend()
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200724134704.2248335-1-armbru@redhat.com>
 <20200724134704.2248335-5-armbru@redhat.com>
 <20200724140837.GD3146350@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5f4d5527-e151-a01c-40d8-cc20ef0b0629@amsat.org>
Date: Fri, 24 Jul 2020 17:06:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200724140837.GD3146350@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/20 4:08 PM, Daniel P. Berrangé wrote:
> On Fri, Jul 24, 2020 at 03:47:04PM +0200, Markus Armbruster wrote:
>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> error_propagate_prepend() "behaves like error_prepend()", and
>> error_prepend() uses "formatting @fmt, ... like printf()".
>> error_prepend() checks its format string argument, but
>> error_propagate_prepend() does not. Fix by addint the format
>> attribute to error_propagate_prepend() and error_vprepend().
>>
>> This would have caught the bug fixed in the previous commit.
>>
>> Missed in commit 4b5766488f "error: Fix use of error_prepend() with
>> &error_fatal, &error_abort".
> 
> FWIW, I'd suggest a followup patch that adds -Wsuggest-attribute=format
> to CFLAGS, as after a quick hack to try a build, I think all the things
> it reports are valid cases needing the format attribute.
> 
> qemu/util/error.c:62:5: warning: function ‘error_setv’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> qemu/util/error.c:133:5: warning: function ‘error_vprepend’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> qemu/util/qemu-error.c:236:5: warning: function ‘vreport’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> qemu/contrib/libvhost-user/libvhost-user.c:161:5: warning: function ‘vu_panic’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> qemu/tools/virtiofsd/fuse_log.c:20:5: warning: function ‘default_log_func’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> qemu/tools/virtiofsd/passthrough_ll.c:2752:9: warning: function ‘log_func’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> qemu/tools/virtiofsd/passthrough_ll.c:2754:9: warning: function ‘log_func’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> qemu/hw/xen/xen-bus-helper.c:124:9: warning: function ‘xs_node_vscanf’ might be a candidate for ‘gnu_scanf’ format attribute [-Wsuggest-attribute=format]
> qemu/disas.c:497:5: warning: function ‘plugin_printf’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]

I have the printf() ones ready but am waiting to be closer to 5.2.

> 
> 
> Regards,
> Daniel
> 


