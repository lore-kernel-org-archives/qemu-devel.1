Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E06C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 536BA207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 13:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bS0UQEFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536BA207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlC1Y-0001G8-It
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 09:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlC0q-0000h3-DL
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:52:28 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:38934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlC0o-0002Le-K8
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 09:52:28 -0400
Received: by mail-wm1-x32a.google.com with SMTP id t194so3156712wmt.4
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 06:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=pOU2t35/hHnHT1KrAWC6toR2TSifEFkIDpmekE0qS14=;
 b=bS0UQEFkrUYn+6sQIkGp90KHSJ4x83ZGStrbjKJs57g5o01m+Jx+0uZJcSIeG0NMkO
 qwWAzU9RCS5dltGQpU0eMXQaEqsBeJpF1kW74+IpThKqErdURt7UX8bXgs1YJZtjjZ8w
 ayJKpXwNiZCpUHaIxLxDYIByDQm9Kwoe0YKbEE+sL+eAljlnAc0od9jtaWJteil4LCxd
 F3NyjhsRoOlWmSaiopdbRdbLquiSFsWAyHNLSNeGBAbjC26ImkkDdgb/5W8DrLkcF6BM
 A7BZ4XqjeGpS0ysdlzLared4nDhXsWretH+77Ht32/LN9wFxy5R3hq4myXnty4MTEQZ1
 jHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=pOU2t35/hHnHT1KrAWC6toR2TSifEFkIDpmekE0qS14=;
 b=SD0IA0JHuBYPA4NYSs3SOW0cNPM2xjutgUUAvbacX3EU7FzsLCosnCzz2FFaRcJLmX
 MVId9YVN4CM+hKOeeJLYPRwK0ViF3MP52c0Coc0rJbGdf6LsA841V8GvZPMLYoRdK1cb
 3vV+oavMFXdOs4+NIygKg8HY2wtln8NuebtC0LJA2NrCOYjXS4VrFU0k3JTPDMls1ILI
 MlYzZ9cfOkKxVWZqYrgIseDe2R4gGJp+8m9Ctdft6qA5nC5br4gR/1ZfHG3FEu7YM97L
 b2mopjuHcgbSSbZGKXzfLmbFRmWE2N8BVZQ3B7JoD8U3xzPHzz3s0oA/TnPgUp9YgAtm
 UNag==
X-Gm-Message-State: AOAM530phlSKz3YzSNzy9UQT4D1zjfnWm40dqhNQYWjCrfnSx54/I8CA
 RLHPiKaA2YThAIjm9oA3PPt+cw==
X-Google-Smtp-Source: ABdhPJy3r0oUFWEVqYmgmMcO7fmirRJ0L3a71Uiqk8xjMqRKFrDPx404UaNK82pQJVmuqwX27oH66Q==
X-Received: by 2002:a1c:2183:: with SMTP id h125mr3348571wmh.88.1592315545145; 
 Tue, 16 Jun 2020 06:52:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u3sm27762223wrw.89.2020.06.16.06.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 06:52:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E2F011FF7E;
 Tue, 16 Jun 2020 14:52:22 +0100 (BST)
References: <20200616125324.19045-1-alex.bennee@linaro.org>
 <20200616125324.19045-2-alex.bennee@linaro.org>
 <e08991ac-cb9f-9092-60d9-0f9e9522695e@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PULL 01/21] tests/docker: bump fedora to 32
In-reply-to: <e08991ac-cb9f-9092-60d9-0f9e9522695e@redhat.com>
Date: Tue, 16 Jun 2020 14:52:22 +0100
Message-ID: <874krb15k9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 6/16/20 2:53 PM, Alex Benn=C3=A9e wrote:
>> We should be keeping this up to date as Fedora goes out of support
>> quite quickly.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> FWIW this one had:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks, I've issued a v2 of the tag:

  pull-testing-and-plugin-160620-2
=20=20
>
> https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg06556.html
>
>> Message-Id: <20200612190237.30436-2-alex.bennee@linaro.org>
>>=20
>> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docke=
rfiles/fedora.docker
>> index 92b6e11c8a8..798ddd2c3e0 100644
>> --- a/tests/docker/dockerfiles/fedora.docker
>> +++ b/tests/docker/dockerfiles/fedora.docker
>> @@ -1,4 +1,4 @@
>> -FROM fedora:30
>> +FROM fedora:32
>>=20=20
>>  # Please keep this list sorted alphabetically
>>  ENV PACKAGES \
>>=20


--=20
Alex Benn=C3=A9e

