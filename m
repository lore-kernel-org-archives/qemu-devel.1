Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4232EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06DF320739
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lUDZqEkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DF320739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm1VK-00029q-5Q
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 16:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jm1Ui-0001jG-TZ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:50:44 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:39235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jm1Ug-000899-Nd
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:50:44 -0400
Received: by mail-oi1-x22d.google.com with SMTP id d67so6370041oig.6
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SjuTceJmTEsgSONoBi/0cjWmkJVrr4lHVjc12FFdBiw=;
 b=lUDZqEkbpKE6IyJTsM7gPp/0DXXFLSghhGxY6sLbMDKi1Owc1AEMNebMLAzFp4JsdA
 C4kErzWzD6RmPu1yQ6aAO1gV9VPFWfQxFFlSEb+E+3ceOFl+D+NhYg5y1uDWxu/Rbndf
 W54DkeERzC3zduJUhWxmR063nvdYELIDvysx18MrfKTCnNwdGlPVUsSFzGjLgIqh/y6u
 /8OYV0IAet2xZcYKMLGY++j7RXsMek3byoIdQe4OtwgWsXRAq6za4dHhfUg3UlVxhBqC
 HZpJlTIIo5qh9q4Y1G7z+infbbUP8AeTjncswoRh8PQ2+wJTlvf1cwA6fzw5yucSUCzN
 DZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SjuTceJmTEsgSONoBi/0cjWmkJVrr4lHVjc12FFdBiw=;
 b=PfedMnYMIcFlHlrP31P4oeuLL7AwaUbd5bwJmrKZnPOEwzGnOik7/hMmFpMU1YFqZw
 PVYxP6y8v7z2eqh+VYtyMwrGY+a9VAMeCC5eu+s7U0aQfNKtkVnEIeaen4ujKwt9kxps
 sVkSP080j9M/B4j6E5xSt13uPzBJVkM3kyuhlTr0riFB+2tmMeij7N5Jyj1OGZtWTw0d
 J2lMRJE7K0JQM9FKIXdfzf6h2BUYfYQ1owNoqvgBKw4cSw7OU7P5BYA3OUEHKfldz6SV
 P3wAqDlbDCRzJLjDbTxOT2WwvUe9rcCdSsoENE1nbo72IHM+O+xzXX3mhC2LYKgLYCJe
 Ze4A==
X-Gm-Message-State: AOAM533+V7EMntlnroQ72IdAsmmdPLRBiC+eWY6EmePnOsE6pXOqe1tK
 q5UClVKIJcaKC2wVw5+G4+/P0WT0KZ98MSbPTI0CQA==
X-Google-Smtp-Source: ABdhPJzRDssWB+eBY6MEIGQzvlhcI8HENrGuhiNLd+HxSvaff388lvvhDWQ5y68AKqhkO5KM7Z8X5yKqGeYoae7339g=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr544388oia.163.1592513441319;
 Thu, 18 Jun 2020 13:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHiYmc7iD4AoV3Lj5igTQMYESNHU6_-_7cwujhsgJYv5zKraDQ@mail.gmail.com>
 <CAHiYmc4TmQ+67GNQJY3Mm0BSFuipUBFPpBLuNxBfhArCn823CQ@mail.gmail.com>
In-Reply-To: <CAHiYmc4TmQ+67GNQJY3Mm0BSFuipUBFPpBLuNxBfhArCn823CQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 21:50:30 +0100
Message-ID: <CAFEAcA_TJnzUd-++OeSda0hQdYUahcy-Ba7RH03o20aEqsGjig@mail.gmail.com>
Subject: Re: [DISCUSSION] GCOV support
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jun 2020 at 20:41, Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
> =D1=87=D0=B5=D1=82=D0=B2=D1=80=D1=82=D0=B0=D0=BA, 18. =D1=98=D1=83=D0=BD =
2020., Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>> You may recall that I signalled on couple of occasions that there are so=
me problems related to gcov builds in out-of-tree builds.
>>
>> It turned out that those problems manifest on some opder Linux distribut=
ion, and are always related to the gcovr being older than 4.1. For older gc=
ovr, the tool simply doesn't connect properly executable and its source fil=
es, and no coverage report is generated (or perhaps only some small portion=
s, but, on any case, gcov builds are virtually unusable).

Ah. Thanks for tracking this down.

>> I propose that we don't bother supporting systems with gcovr older than =
4.1. We could check version of gcovr in confugure, and refuse gcov builds i=
f that version is older than 4.1.

Seems potentially reasonable. We don't actually check for gcovr at all in
configure right now...

It looks like we only use gcovr in creating the coverage-report.html --
I guess in theory if you wanted to use gcov directly and didn't care
about the coverage report you could still do that without a new gcovr
(ie if you were just using the facilities we provided before commit
fe8bf5f62972 in 2018). But then we'd have to make the handling of the
coverage report conditional on "do we have gcovr". I don't use gcov
so I don't have any idea whether "use gcov data but don't bother with
the gcovr coverage report" is a useful thing for anybody to be doing
or if it's silly and not worth the effort to try to support.

https://repology.org/project/gcovr/versions has the distro
coverage of gcovr versions. I note that Ubuntu Bionic only
has 3.4 still. But for a developer-use-only tool we can
be a bit less strict about our supported-distros policy I think.

Side note: the coverage-report.html targets probably ought
to be only allowed if we have gcov/gcovr enabled.

thanks
-- PMM

