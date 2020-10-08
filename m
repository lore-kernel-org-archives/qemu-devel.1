Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D16C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 11:08:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32EE2184D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 11:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKiB3xay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32EE2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQTml-0007TM-NJ
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 07:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kQTlW-0006qj-B9; Thu, 08 Oct 2020 07:07:18 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:39188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kQTlT-0002Fa-RX; Thu, 08 Oct 2020 07:07:18 -0400
Received: by mail-qk1-x742.google.com with SMTP id w12so6448352qki.6;
 Thu, 08 Oct 2020 04:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=giWMNCkHRJBJZqwvaydsA69qlpNWOvy3O9S2shr1KH0=;
 b=mKiB3xayXiU3FhFsltLPXO0eEupFwtwWYeVhDVE33VLoKQKZNHC76pk39IxXLkS2MH
 8JAZb0VpeDdljmkASZS9eDFADbjpczVtPGBKFn3kqVD2wvmCRjA0DS6ko5dgQ9Ako0WZ
 NtCTikWI+RUhPCUUPfRUUhYrOc6r8f1BneRvAsz/Uc3/KJ+xfIa5o1I+iz5sy9uXALAw
 4TGyBUkaTUuBGvp5okxk7MjiIlfa2SOS/p7YGq/mORrMNstYMJBcHf4f48t2enR44Z3P
 jTWQ3pdGpyByuf53TtRvoGxF97MAzWUzCnff+Pfzac3qwml9nTD50KBY/+89ewvRWbGb
 fkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=giWMNCkHRJBJZqwvaydsA69qlpNWOvy3O9S2shr1KH0=;
 b=RI6LZcggo8WQqj8UiYHAOaT9XqZmsev5ZFnJoMgkX4DiL/BJ+Qlo9l3Rm8C4dcH+Ig
 LfJy1s0mQtGJSbnfbWDsFY+2vmY23ZDCRn8sGVyG2KtKVtDu4q1AfxEAw42YDmdEm1Jo
 bZziD3lrKFW+2VHay+u7ZTzdDNL/wsMniBFcA9sGZtYBPxqGIfdte5pu6JmtWXYBwUDi
 Axtnj8iBA/pJA/071cJUHgmtWcUmLmg9qLZ5kG4T8QLnhZhP3Ysn7le+I0LzeOjdJtIO
 xoV6Ksob/S/OMtDbUCEQAFpYE5rCKnB0favqx5JR6KoDpSvjSS7fJccX8ZfwyoqKxbU0
 7+Rg==
X-Gm-Message-State: AOAM532Zuc85YJZpzh4xLumKiRqA9poAaN1XNtqETF0H/Wb6IlCO7f16
 bhAIqekuSiWnSYYWyfE7n8hFpZDHw68=
X-Google-Smtp-Source: ABdhPJwKDI5COo9HYWpftGOR6FIXOC8ggRGavVzFF1fO59jjRjgGTkIRpC5pqM9JcXgyn0BgkjWpZQ==
X-Received: by 2002:a05:620a:1513:: with SMTP id
 i19mr7621468qkk.130.1602155234370; 
 Thu, 08 Oct 2020 04:07:14 -0700 (PDT)
Received: from ?IPv6:2804:431:c7c6:5a9b:54fc:df2a:8a5e:989b?
 ([2804:431:c7c6:5a9b:54fc:df2a:8a5e:989b])
 by smtp.gmail.com with ESMTPSA id d142sm3601218qke.125.2020.10.08.04.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 04:07:13 -0700 (PDT)
Subject: Re: [PATCH v4 0/5] pseries NUMA distance calculation
To: Greg Kurz <groug@kaod.org>
References: <20201007172849.302240-1-danielhb413@gmail.com>
 <20201008111355.2d089c84@bahia.lan>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <de77681e-1ebb-ba0d-ed7e-c35bcf86e673@gmail.com>
Date: Thu, 8 Oct 2020 08:07:11 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201008111355.2d089c84@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=danielhb413@gmail.com; helo=mail-qk1-x742.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 10/8/20 6:13 AM, Greg Kurz wrote:
> On Wed,  7 Oct 2020 14:28:44 -0300
> Daniel Henrique Barboza <danielhb413@gmail.com> wrote:
> 
>> This forth version is based on review comments and suggestion
> 
> Series for SLOF ? ;-) ;-) ;-)


hahahaha sad thing is that a typo in "fourth" is the only viable
way for me to send a Forth series. SLOF is too damn hard!




> 
>> from David in v3.
>>
>> changes from v3:
>> - patch 4:
>>      * copied the explanation in spapr_numa_define_associativity_domains()
>>        to the commit message
>>      * return numa_level directly instead of calculating a temp
>>        value in spapr_numa_get_numa_level()
>>      * we're now setting assoc_src in all n_levels above it in
>>        spapr_numa_define_associativity_domains()
>> - patch 5:
>>      * changed the documentation as suggested by David
>>
>> v3 link: https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg10443.html
>>
>> Daniel Henrique Barboza (5):
>>    spapr: add spapr_machine_using_legacy_numa() helper
>>    spapr_numa: forbid asymmetrical NUMA setups
>>    spapr_numa: change reference-points and maxdomain settings
>>    spapr_numa: consider user input when defining associativity
>>    specs/ppc-spapr-numa: update with new NUMA support
>>
>>   capstone                      |   2 +-
>>   docs/specs/ppc-spapr-numa.rst | 235 ++++++++++++++++++++++++++++++++--
>>   hw/ppc/spapr.c                |  12 ++
>>   hw/ppc/spapr_numa.c           | 185 ++++++++++++++++++++++++--
>>   include/hw/ppc/spapr.h        |   2 +
>>   5 files changed, 419 insertions(+), 17 deletions(-)
>>
> 

