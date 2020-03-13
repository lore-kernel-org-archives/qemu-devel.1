Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5311C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 806DD206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 13:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJaOwiMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806DD206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCknp-0002YW-Km
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 09:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCknD-0001xw-3f
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCknB-00041X-UI
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:56:02 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCknB-0003z3-OU
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 09:56:01 -0400
Received: by mail-ot1-x342.google.com with SMTP id t28so7519733ott.5
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 06:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xTTntM3fNzs+2JnmLYStgo0n7jeZrWIApCXxBedI9+s=;
 b=BJaOwiMbslq/TGTXu3fxk4/im6bdtWPViRYSaluR2yM2Xhn05OwWoRcnOiFNUd0Dd+
 252b1VlXeXr9Lb3ap+U/hS3oeW9dKZ9zjrGDEMb7t1NwUq1QWqiWOS1XLh3x2U8s5Qv6
 Do0hpEJ8lTc2Eb4ZD0BQgY6fOvgvGxYjKg4z5UI/bzHqTe3XHNCsMw1pBt1IPSlqA3bH
 ZkJM+LDicTaswh44gtIsBj4eOwiH5WuBQTxDvtXgHXigsfEwhJNNsMs5aK71ltFiiveF
 0g94pobMt4Kg+75dNFqU5aaekXghg7bGmo1AmhOforE02ehtcTP4cVoeEUpPJZJgvqlg
 8zNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xTTntM3fNzs+2JnmLYStgo0n7jeZrWIApCXxBedI9+s=;
 b=VYFib3dLgOSLO8PpashdPnnhqGgtUfW79uEKXEAzYx2vIJwySqG+kvhkAmm4UP08Az
 +Yqxl/yZ71nD/oeiGQnY3B4gZdf/JudSNapgR/4ldo/+3d5VfIQCaXph6aaCr8eiZY8o
 q07mBEh6/PoD9FW/rhuXznpVkn0Rzosw5RFnlLPN19R5aUfNsScqxyhXLq6PgeeCavX3
 CTtwOFRiw5uji7M+yI/9bbUW2gMNbj2rELt6QfZ9Uc9GtndCniMFun54PZWc4VD97c6O
 nhdIkGdD9ShYw6xaoxJFgkNCJdbT2jsUQAIJKWtPTQd5DZivIAzGH9duZxa8/l1zIBxS
 Xn2A==
X-Gm-Message-State: ANhLgQ0VNiy3liOiiPOk/ttwN/A4LOfIl5oXmnvcqzMVRSh3AvPMMGb8
 V/05UfHVO3Mx9NKd1kH2ylOPu+f6ZsX81qKrXYGXGA==
X-Google-Smtp-Source: ADFU+vtvQCA+46ZDZQ9+w/1MizPsie47jSpACW0dzq3klLYSIuXZFe73dI/krltGKTmqhJs0In/i1lzhVxqF9GDmtYg=
X-Received: by 2002:a9d:6c05:: with SMTP id f5mr11204304otq.232.1584107760699; 
 Fri, 13 Mar 2020 06:56:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200312193616.438922-1-crosa@redhat.com>
 <CAFEAcA_PiX7LffcT9+1Bdn764fsqsSzUZib-yp=Og0Vpa3oOrw@mail.gmail.com>
 <20200312221619.GA483011@dhcp-17-173.bos.redhat.com>
In-Reply-To: <20200312221619.GA483011@dhcp-17-173.bos.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2020 13:55:49 +0000
Message-ID: <CAFEAcA_aocOSyy+6vG5T6PJm9HgFC2sKa+BKGp-AcKosiiT8iA@mail.gmail.com>
Subject: Re: [PATCH 0/5] QEMU Gating CI
To: Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Wainer Moschetta <wmoschet@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Mar 2020 at 22:16, Cleber Rosa <crosa@redhat.com> wrote:
>
> On Thu, Mar 12, 2020 at 10:00:42PM +0000, Peter Maydell wrote:
> > OK, so my question here is:
> >  * what are the instructions that I have to follow to be
> > able to say "ok, here's my branch, run it through these tests,
> > please" ?
>
> The quick answer is:
>
>  $ git push git@gitlab.com:qemu-project/qemu.git my-branch:staging
>
> The longer explanation is that these jobs are limited to a "staging"
> branch, so all you'd have to do is to push something to a branch
> called "staging".  If that branch happens to be from the
> "gitlab.com/qemu-project/qemu" repo, than the runners setup there
> would be used.  The documentation an ansible playbooks are supposed
> to help with this setup.

Great, thanks. Could I do that for testing purposes with a
staging branch that includes these patches, or would we have
to wait for them to be in master before it works?

-- PMM

