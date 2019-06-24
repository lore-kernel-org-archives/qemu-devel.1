Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADB3C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 12:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC87F212F5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 12:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="stJXWE93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC87F212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50834 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfOLN-0005md-7D
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 08:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55448)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hfOKA-0004w9-64
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hfOK9-0000w1-8m
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:43:54 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:37872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hfOK9-0000ud-2G
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 08:43:53 -0400
Received: by mail-wr1-x435.google.com with SMTP id v14so13760599wrr.4
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=bDAK4be8VdrGNnZPF3joFPMPResO1usv5rXfRIQiG+I=;
 b=stJXWE93xW7pTaWM+3DhXfMkTXJ30h8TKftIkd1Y5H8YWehjZ4QtB/jQqjTtbDUv9p
 BwZzj1/12WGbjM9ghiWlD7dMLFU/KfdurwOUX/qjmkLNFD2wTxhtD9L+27XcYLcuL+gQ
 W2anAvEZfaEmP6VAaDeo8ULzemat3U3VTSPXO8wfK35gC+Nhdg0MMIwnBTvpAgV4qSGc
 DzEvjc4vTokdl2Y3fdji8+cbQlbl5rmwHc6GfOPzuTrIpqQF/FXd+ZiJ/7W4p71FEplk
 sZT43EyA0ZFV7dCnkvWWvvthshXOs6u0L2NmVNEX6HG69kBLyxua1l8Ynqgbyghj7loX
 EsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=bDAK4be8VdrGNnZPF3joFPMPResO1usv5rXfRIQiG+I=;
 b=pFrkLrdmA1zFVDic7/Em+RgrCSvYPzhHh2sNMJaDWwwZaNeXO6NkpW45jK+gNVLUL7
 ZIgG5Lz5sLuuwtvw7u/bOkI7awYgeCGDxRlNPP6xIobcTsUJr62tW0+YMAZztAgnEh0K
 QL3wju0tYAFZZgMNnT6IITtqhhWw+Y9KggJLMhOwXCdbUN8o/BOks822oNG2OruhMGvI
 qycZb3y2vwz36FT0pakxRjgtZOGkY6sAspEIEXcWuursswsmztCzyDjRXPiqjDQEkxLi
 Jq2SmoTj6CpV72OCGgkBVQb4Wmg57XtdlyLTxQXCSJcjbMCgVe1L3Hn+VYXMvR7o3N/o
 Im7A==
X-Gm-Message-State: APjAAAVHRKhDTyZBE7Ls3cKlOgO5MYIXgZrEy8L775wAEDbwZx1I+74T
 91BKX6PjHO9xsuWRmufx9/aaO8JXIOA=
X-Google-Smtp-Source: APXvYqyI8lip6TN8OKkwdgifV471ua54sdDf4PYYo4KdQLXr/I4adYudSPwvfZeZV0L38ZSzjb+hrw==
X-Received: by 2002:adf:ec8e:: with SMTP id z14mr24700051wrn.125.1561380231697; 
 Mon, 24 Jun 2019 05:43:51 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id b203sm12884141wmd.41.2019.06.24.05.43.51
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 05:43:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D891B1FF87;
 Mon, 24 Jun 2019 13:43:50 +0100 (BST)
References: <1561116620-22245-1-git-send-email-pbonzini@redhat.com>
 <1561116620-22245-4-git-send-email-pbonzini@redhat.com>
 <87r27j1byq.fsf@zen.linaroharston> <875zovf9un.fsf@vitty.brq.redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
In-reply-to: <875zovf9un.fsf@vitty.brq.redhat.com>
Date: Mon, 24 Jun 2019 13:43:50 +0100
Message-ID: <87o92n17cp.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
Subject: Re: [Qemu-devel] [PULL 03/25] i386/kvm: convert hyperv
 enlightenments properties from bools to bits
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


Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>>
>> This looks like it's broken the build:
>>
>>   configure' '--without-default-devices' '--disable-user'
>>
>> with:
>>
>>   /home/alex/lsrc/qemu.git/target/i386/hyperv-stub.c: In function =E2=80=
=98kvm_hv_handle_exit=E2=80=99:
>>   /home/alex/lsrc/qemu.git/target/i386/hyperv-stub.c:18:19: error: =E2=
=80=98X86CPU=E2=80=99 {aka =E2=80=98struct X86CPU=E2=80=99} has no member n=
amed =E2=80=98hyperv_synic=E2=80=99; did you mean =E2=80=98hyperv_vendor_id=
=E2=80=99?
>>            if (!cpu->hyperv_synic) {
>>                      ^~~~~~~~~~~~
>>
>> Does the stub need updating for the new flag? I'm a little confused
>> about the relationship between HyperV and KVM. I thought they were
>> different hypervisors?
>
> Yes, they are. But to run Windows guests we can pretend being Hyper-V
> :-)
>
> I'll send a patch to fix the stub if nobody beats me to it. Thanks!

See:

  Subject: [PATCH] target/i386: fix feature check in hyperv-stub.c
  Date: Mon, 24 Jun 2019 13:38:35 +0100
  Message-Id: <20190624123835.28869-1-alex.bennee@linaro.org>

And let me know if it is correct. I'll include it in testing/next as
it is a build fix.

--
Alex Benn=C3=A9e

