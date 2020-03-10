Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31204C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26BC20727
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 15:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nVHkjoqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26BC20727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgYP-00016i-5C
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 11:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jBgKS-00044a-5t
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:57:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jBgKQ-0000m1-R8
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:57:56 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54158)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jBgKQ-0000kC-Lq
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:57:54 -0400
Received: by mail-wm1-x341.google.com with SMTP id 25so1760009wmk.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 07:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=oSrHBCEthDr0+360W+Bn+h+UKU5Wjj1Xj/HsJNF3QW8=;
 b=nVHkjoqQr1/vppboc/Bby8mNW/yerk/3OIRw75dFIa6Tjq/fS9xBnfsH2563V65DK9
 uD9d3B6qs0/U6vGOo4jo+Yxw2ivxf1xhVHS7xtpQjD9WY6ldoD7Qt8KvlfpeNhvLVwwz
 JLqYmR4kg2Kldy4yh9qiGr4IwjSq81SBfKEbeY7XOgvBOWRihn9be/3TkhDBV/JCId62
 M5X8BFhFS8ynHAhfqsiW1zBdYBVPxs8brWL5gL3uvyYnAIoQMS8VYtJmLeMkh70bxRZZ
 Hmb9p4yOkwfP4iQ5FF7k1SwVripaD4sSsMuU+x+tqszQbCRKKOgVqy8m6nLXDN9giz5L
 z4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=oSrHBCEthDr0+360W+Bn+h+UKU5Wjj1Xj/HsJNF3QW8=;
 b=MCOsUVs7wUzMBOs+rOs8VeQe9KHu+lyIsodZzfi2bL5ee5VJZhAX+SJemZ8TUK740p
 dcSK+QV+fGmqJoLIyBa4kVsyBXFpxK0Ca4TKNwfH4YR+8cCV15E8jZ/lNlBe0Ff5hWCM
 KZBPTJjlwdWIX9c7z59iIeoDnB00RxoqBh9BhcoG4lZXBhF34uPrlz3hAdUPsc8ABo6p
 Crq6P8Bgp8B14QChsS6ysZGlQGXmM5+PzrMqjibEmEdUz4DkELCl1f207v08vLS4s6qo
 5/tXnuFt8MAfUDOi/wYeMOSu4iduqVgNTODyglWtGGDOAX4yoe3xcdn/dH6yMa8G8eGd
 E/nw==
X-Gm-Message-State: ANhLgQ0dqpmE2xwQDK1V29eMKAFhIxQzGeooRrb1HQeQTB4AyE8YEJJB
 PST3OKhUOU35xSWK/L+q/1d3YQ==
X-Google-Smtp-Source: ADFU+vv7A34oMksafKoLUA0SEOQ6YoqQmJ9kJTaAMTchXcvf/TuCceziifx7sT5y8ha5GWpP2NPvgA==
X-Received: by 2002:a05:600c:214f:: with SMTP id
 v15mr2633381wml.110.1583852273052; 
 Tue, 10 Mar 2020 07:57:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s2sm4305192wmj.15.2020.03.10.07.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 07:57:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5ACE21FF7E;
 Tue, 10 Mar 2020 14:57:51 +0000 (GMT)
References: <20200310133020.27196-1-alex.bennee@linaro.org>
 <CAFEAcA-S1g4ojEkYdEa-ZHH+=uNUgCDWo0Z29ikbvNoX8Ro7Cw@mail.gmail.com>
User-agent: mu4e 1.3.9; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] docs/system: add a little more detail to ARM machines
In-reply-to: <CAFEAcA-S1g4ojEkYdEa-ZHH+=uNUgCDWo0Z29ikbvNoX8Ro7Cw@mail.gmail.com>
Date: Tue, 10 Mar 2020 14:57:51 +0000
Message-ID: <87y2s8gsuo.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 10 Mar 2020 at 13:30, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Taking from the wiki page mention:
>>
>>   - both 32 and 64 bit architectures
>>   - the roll of A/M profile chips
>>   - warn about kernel portability
>>   - gently suggest -M virt
>>   - add headlines for groups of boards
>>
>> This is still incomplete but hopefully is a less of a straight dive
>> into a dry list of peripherals.
>
> This is a semi-duplicate of the series I sent last night:
> https://patchew.org/QEMU/20200309215818.2021-1-peter.maydell@linaro.org/

Ahh I missed that, as your changes are more comprehensive I've reviewed
them. They render well enough:

  https://qemu-stsquad.readthedocs.io/en/docs-review/system/target-arm.html

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

