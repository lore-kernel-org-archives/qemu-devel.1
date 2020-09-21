Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D92C43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F952311D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 14:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsJsIUl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F952311D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKN0l-0003b3-F6
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 10:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kKMyu-0002S6-W8
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:39:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:51324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kKMyt-0005HY-Cv
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 10:39:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id w2so12389205wmi.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 07:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lCX8zMBWmdE62MrGvy8QVxyKgpHNgJj0gHeD/5cBQ1U=;
 b=SsJsIUl62d1SeN7dvaSNeLkeQgvKlQk7/l/p1ytU2f+p1ZGBtAOSrk9Izh0kFSKnv0
 i5vJloK4dTdAvxjf0v6ICQtn1Om2GM8T2LpxNuvOLI1nzDdtDZkR77dsDEMpXSwP+KlI
 raOVNBVK+mnSHRBe6FXl+vU8o7mqEhOJeZYckhtYhekFLDRZWjN5lWlwxtsNUhqCGEcx
 FPr42X/BL2jqSBzsftttVJ6hh72qNBP4NMD1kUYW61PtR4VsayqDFu8bWbt1cWgYu65S
 lv0OrMIvgxd7xgYYLrAXqpW8W6v0EkXoosSgJjToPemY7bddcLCp3AXh3KHKdqXPrgKG
 NsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=lCX8zMBWmdE62MrGvy8QVxyKgpHNgJj0gHeD/5cBQ1U=;
 b=LaLdtuVMNkcenW7FPedTHz0kwAVSvI0E8ehKd5CNvGTLLEn7q/xE0S/eOfMuaRwf+P
 v7Pwt/q7cKZ0pa3nqQ04eKLcyOrpLL2oQu6oZlaKcR9k/RiZN3aR9OAtDw3ofWyvkWIr
 FQ3K/LA5sFaoGQelZ4ptarRz/lxYF6eSeIxC+X/PDp4IYWmMC5ImcoYiP4QK4UrQuOnJ
 kikQjL98r6xWvME564xa+1Qi2dHy+vzYrkSAH1fKb1crE/RRz4l59yuYrjS2XVE0izJO
 Ncagkq/301Cdgn/xvC4cU5US04et9X0HjdRd+lNHTz0hGrFx3dc5I0bFmwla1tqmQywi
 lpew==
X-Gm-Message-State: AOAM5317y+2D15J/2eEB1yxXPMhnipUhafEKzeiE7qxVuRQtJU2bGA/z
 wxG3lMk3OiVqrV9G15RzTiw=
X-Google-Smtp-Source: ABdhPJzwFZleCgr8Be66nm2i8hCIqjAsmdnsBQ7+mES2CIcvaxsPGEIobJO5Azfd+slgCz4OBx24WQ==
X-Received: by 2002:a7b:c761:: with SMTP id x1mr169108wmk.91.1600699189133;
 Mon, 21 Sep 2020 07:39:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d153:8d0f:94cf:5114?
 ([2001:b07:6468:f312:d153:8d0f:94cf:5114])
 by smtp.googlemail.com with ESMTPSA id b64sm20507438wmh.13.2020.09.21.07.39.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 07:39:48 -0700 (PDT)
Subject: Re: Should we apply for GitLab's open source program?
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <878sdp4ks9.fsf@linaro.org> <20200904160836.GS721059@redhat.com>
 <20200921140305.GM1942072@redhat.com>
From: Paolo Bonzini <bonzini@gnu.org>
Autocrypt: addr=bonzini@gnu.org; prefer-encrypt=mutual; keydata=
 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
 10oh++mb6s1dGf3ADAaOTRf8
Message-ID: <106d51c9-03ca-69a0-4494-561b2305bb80@gnu.org>
Date: Mon, 21 Sep 2020 16:39:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921140305.GM1942072@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "qemu@sfconservancy.org" <qemu@sfconservancy.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/09/20 16:03, Daniel P. Berrangé wrote:
> It is still unclear how we'll cope with contributors doing
> CI in their own forks, but GitLab continue to offer positive
> feedback that they want to make projects in our situation
> succesful and thus want to find some kind of solution to the
> CI quota problem with the forking workflow.

The forking workflow is basically their value proposition, so my
impression is that they actually have three tiers:

1) small DIY projects that can live with the 400 minutes

2) growing projects that they want to keep an eye on and to enthuse with
their more proprietary offering (the open source program)

3) established projects that give them brand recognition, for which they
are okay with infinite minutes (within reasonable bounds).

Hopefully QEMU falls under the third.

Paolo

