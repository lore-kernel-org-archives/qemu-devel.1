Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D57C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6F9D2173E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 14:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N2+sx9od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F9D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54985 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT5z4-0003sG-4q
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 10:43:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hT5xe-0003AY-RU
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hT5xd-0007UD-Ud
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:41:50 -0400
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:33243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hT5xd-0007Tf-Q9
	for qemu-devel@nongnu.org; Tue, 21 May 2019 10:41:49 -0400
Received: by mail-yb1-xb42.google.com with SMTP id k128so5569160ybf.0
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=zcxL9z0FP4aQiG6zq/L4cMjNf6R+is2FyEM16Q49SLA=;
	b=N2+sx9odQ9/C/cyD3q2H2TPRGzSfdanu1eYbgKVXX0jG5saInMD7SV4a3DuddXUYv9
	qRHRLkaVzp8wXjtRRawEylRVnhHGoGOqJZDj4YwwrHswvstx4nVUT6qqYwbo77GgTerT
	ImsOo/C0m01A8+Wjd5i1vMhTUaZu9QeH5AHXaMOSRthgyitj07W6Dl+F0umMhZRDbH7a
	od3OCY0ToOFZZhd0gLDL2G03c1gkrextSjPE7tLqCNrH2Sx/qofvI0mmHt8kf5f7dctj
	CMuo+rueC2ILzqF/RAusVwleItXHSlvxEC+QuMAHWFL5t8/+0T9d2XDj1+c1y3WfuCpM
	C9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=zcxL9z0FP4aQiG6zq/L4cMjNf6R+is2FyEM16Q49SLA=;
	b=c4RB5GXFQOaSCA4dx3lLFxLnTaoBLwkW3RLd8MMEKAHz66z3xdi8x4C7saDCDOuwsd
	ynNJUFEvJEXNjLqYPC74mZjE2fqL8CcBBy+NmV116THcXE4Egmgv/TsIw4QstuCshMdD
	kUCcYSrVGT7+vQbz25ZpMhjOIFrC0L85vqyB+PM4up1oTCH+Da9sfLeIS/20c8a1gAUb
	J2+RAuskR/Us0q0zeHB5dE1Gjxcz3eEmKe7/FQfvj12eZD/weVIfMqV6J5JvbwDwCo66
	6ST4+lzIT1f1uOByqR6LzeEwfZe2oL3z51VBrcLvoJM9mf9kwsmOtzzTjR2Ur/5gMQtd
	fnmw==
X-Gm-Message-State: APjAAAVA8o0fvgqtpdc10jDUVr/UVKNs3sk6VhlkbjvdocAkFWFy9pQS
	9fSSKtGtVGZLuip80fyxslmw7Unqae8=
X-Google-Smtp-Source: APXvYqxV8t+CxeJ8eyG9UB1BmiZ1uIYkUVNjv58YMrLNi11jkPD1DrIknU/FhjOXP8a7Eo7SndBQrw==
X-Received: by 2002:a25:e7c2:: with SMTP id e185mr15181288ybh.90.1558449708795;
	Tue, 21 May 2019 07:41:48 -0700 (PDT)
Received: from [10.240.180.184] ([71.46.56.58])
	by smtp.gmail.com with ESMTPSA id
	k205sm5643250ywc.69.2019.05.21.07.41.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 07:41:48 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
	qemu-devel@nongnu.org
References: <20190521095613.16584-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9059c3c9-059b-8036-2b3b-2ce5499c9527@linaro.org>
Date: Tue, 21 May 2019 10:41:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190521095613.16584-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b42
Subject: Re: [Qemu-devel] [PATCH v2] authz: optimize linking of objects for
 authorization services
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/19 5:56 AM, Daniel P. Berrangé wrote:
> The core authorization API is a dependancy of the crypto code for the
> TLS servers. The TLS server code is pulled into anything which links
> to the crypto objects, which is every QEMU tool. This in turns means
> that every tool ended up linking to the authz code, which in turn
> pulls in the PAM library dep.
> 
> This splits the authz code so that everything links to the base object
> which defines the API. Only the system emulators and qemu-nbd link to
> the object classes providing the implementations of the authz object
> API. This has the effect of removing the PAM library dep from qemu-img,
> qemu-io and other helper tools.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> In v2:
> 
>   - Now with 100% less unit test failures due to missing objs :-)
> 
>  Makefile               | 5 +++--
>  Makefile.objs          | 1 +
>  Makefile.target        | 3 ++-
>  authz/Makefile.objs    | 9 +++++----
>  tests/Makefile.include | 6 +++---
>  5 files changed, 14 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

