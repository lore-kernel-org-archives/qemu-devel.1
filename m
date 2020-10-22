Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D68C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB2A22267
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 16:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjJfJLbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB2A22267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVdmR-0003IK-BJ
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 12:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVdl0-00022a-6b
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:48:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58248)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kVdkx-0007p5-Bu
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 12:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603385281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7T5EoyhPcci5i+NMsBL+0fub7KS0/sNX+xuifPFubLU=;
 b=RjJfJLbVP8RFzQ/Bc8FdjSqh0xSRGwyY7lIGruSR+qfxEuk62ZU7qGmj+hENw/WhQXTkKQ
 874F+btPRWLHa4wBajK1cNlMmK0azgeEyBzxTqQupfi7gNmXb2bW4xhEuEakPAUI80l3AX
 yiyxyyLnZhMYdPWeY99fvgzL8KGV/x0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-Jqxjx-HsPXyx7dNmtP9HcA-1; Thu, 22 Oct 2020 12:47:58 -0400
X-MC-Unique: Jqxjx-HsPXyx7dNmtP9HcA-1
Received: by mail-wm1-f71.google.com with SMTP id r19so791253wmh.9
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 09:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=7T5EoyhPcci5i+NMsBL+0fub7KS0/sNX+xuifPFubLU=;
 b=SDCrc0EUJrlXYt34/GqQcWR6R7G6sneCQoZoHmEP8KHglpmT7cPIGIT3oDnPEoAA7n
 Msv4lvqLI8MYCRI0kKKtdDB/5wyb3ol7ZedvLzlKd4HoQOWis1grXJWR0cF1r+9hf4M0
 1cXfElpQ6DhVovHk/5JHotzmvtvnAITyF/ntV/RTDL88thJsBc+PGa305SfsUPWHle/y
 lUEc1DBVQ3b0hem3WEXC5KrgQPTu1Hb+9tKrGbSSxud8yaj8Z684bwu4mp+TXxnKONK3
 rnNQPIcyrSKgixiUKujA06kpSE8rGmM1oA+HHozpZI/SUvvgKPCAGgmkxNRJZ2adruom
 SRrg==
X-Gm-Message-State: AOAM530pwckca0YQselVtG8VUFpleFowcTNjzqGzN52MeuH57cViVFsI
 KagQBko1fvBGrCJUHsqbhkWH6ra0+Nsp1OnX1Fpe3SgMFkAD1QzaOULGUG0QqwGFWIZPNJZh36O
 p4HqK63KQ/M4Lmj8=
X-Received: by 2002:a1c:40d5:: with SMTP id n204mr3320555wma.148.1603385277330; 
 Thu, 22 Oct 2020 09:47:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz92fGpHDOO1CYjdPz8Q+1hd5fW9VuLmoc6bkJNsi1hcR+yuHG7EpZxLSZDMBncN70ejyJDYw==
X-Received: by 2002:a1c:40d5:: with SMTP id n204mr3320541wma.148.1603385277149; 
 Thu, 22 Oct 2020 09:47:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id s11sm4582020wrm.56.2020.10.22.09.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2020 09:47:56 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC] Using gitlab for upstream qemu repo?
Message-ID: <672b8aa0-2128-23e1-b778-01a4d96b209d@redhat.com>
Date: Thu, 22 Oct 2020 18:47:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:09:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all,

now that Gitlab is the primary CI infrastructure for QEMU, and that all
QEMU git repositories (including mirrors) are available on Gitlab, I
would like to propose that committers use Gitlab when merging commits to
QEMU repositories.

There are four reasons for this:

- this would be a step towards ensuring that all commits go through the
CI process, and it would also provide a way to run the deployment of the
web site via .gitlab-ci.yml.

- right now Gitlab pulls from upstream repos and qemu.org pulls from
gitlab, but this is not true for the qemu, qemu-web and openbios
repositories where Gitlab pulls from qemu.org and qemu.org is the main
repository.  With this switch, all the main repositories would be on
Gitlab and then mirrored to both qemu.org and GitHub.  Having a
homogeneous configuration makes it easier to document what's going on.

- it would limit the number of people with access to qemu.org, since
committers would no longer need an account on the machine.

- by treating gitlab as authoritative, we could include it in the
.gitmodules file and remove load on the qemu.org server

Nothing would change for developers, who would still have access to all
three sets of repositories (git.qemu.org, gitlab.com and github.com).
Committers however would need to have an account on the
https://gitlab.com/qemu-project organization with access to the
repositories they care about.  They would also lose write access to
/srv/git on qemu.org.

Of course this is just starting a discussion, so I'm not even proposing
a date for the switch.

Paolo


