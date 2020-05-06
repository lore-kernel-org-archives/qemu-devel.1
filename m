Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1B0C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8947206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DR3CU60+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8947206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWFFP-0005Ry-SL
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWFEi-0004wu-MQ
 for qemu-devel@nongnu.org; Wed, 06 May 2020 04:17:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWFEh-000588-JE
 for qemu-devel@nongnu.org; Wed, 06 May 2020 04:17:00 -0400
Received: by mail-wm1-x341.google.com with SMTP id r26so1506307wmh.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 01:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=H+JIuyPT0GScT7S16v0JPwJem//OYqZ21V1wqUwNIK8=;
 b=DR3CU60+njj3IFqgXFaFMFdgLXAGRP0eQZfGKcWn5BUCuv1onAofYTSRhpxq085ShL
 ApYK2TOWufgvFkrjV+PJQr2EoAK4q4ZgM5+iynNVhbJxYKAgLqNVadqJXdCJUP3YqNeN
 QwwGTRa9j5/jhJyT5HEUR7bZyTcfhbcDlgKGEH3PBY2MltadK7jD0SLYOqzD1vKR3lci
 FuB69/tg4OU946OrvbEnOOtX3ELMgX3dwlrTNhCmiReDzBOeELNbxDzgk684z41Sdrov
 a9pykbZc5kLMcI4RJd1ZsUsJlOgOStkvsIDNGuRmzK7U2pFIXcgOyg3bQRRn06wDh45D
 GC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=H+JIuyPT0GScT7S16v0JPwJem//OYqZ21V1wqUwNIK8=;
 b=KLTtqAcBekX8GwLRJzc3F42IFAsrVgk24mlSPCh7GlOw3MTJLY5ORC4/KEojbd9f0h
 vla2zHTCWcCdn5xW3AR/Vwpe5SQz+I0YttaC+qxT1s0gRLlW5an5irtm4bcmBEe6ptB7
 ZjjXUWpZ87YhOKWGnqVxIzGcAtRVzxMuyrmiFgURS1koGy1St+x6AwHVM59UGhqjtFME
 b55durUm+24Go/Ts1w83WF8i326HiPiBMUFikw7jJTf68wlOaghHXsKvLW10Tdbv6nl4
 hg9/DtnsJE2sm33Un1/D2FyAuet8BL56O8aYVy9AF6zZdtaVfHnjNdgMDf/xPNpxIvDs
 HPBQ==
X-Gm-Message-State: AGi0PuYoTVdX3X8/nnYSK+KqKPBlqPRf+i/UHJ+hodE/UyERifwQH5iz
 UzXIQK5Ado8nSVRpUjmLLWqL3w==
X-Google-Smtp-Source: APiQypIIzhQ3DCZqFdZVSE3+EFNc6iHACEn0yj+ypg70EgT9BB3oV367EUnLG3vVj8cZfgWxUF08bQ==
X-Received: by 2002:a1c:3dd6:: with SMTP id k205mr2983586wma.138.1588753017238; 
 Wed, 06 May 2020 01:16:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h1sm1795948wme.42.2020.05.06.01.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 01:16:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E0C0D1FF7E;
 Wed,  6 May 2020 09:16:54 +0100 (BST)
References: <20200501111505.4225-1-alex.bennee@linaro.org>
 <20200501111505.4225-4-alex.bennee@linaro.org>
 <CAKBkRUzicxphjjkkxdgzB3cDSv=AszD5V4X499jT2BjiAaazGw@mail.gmail.com>
User-agent: mu4e 1.4.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Li-Wen Hsu <lwhsu@freebsd.org>
Subject: Re: [PATCH v1 3/4] .cirrus.yml: bump FreeBSD to the current stable
 release
In-reply-to: <CAKBkRUzicxphjjkkxdgzB3cDSv=AszD5V4X499jT2BjiAaazGw@mail.gmail.com>
Date: Wed, 06 May 2020 09:16:54 +0100
Message-ID: <87lfm55vgp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Ed Maste <emaste@freebsd.org>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Li-Wen Hsu <lwhsu@freebsd.org> writes:

> On Fri, May 1, 2020 at 7:15 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>
>> Hopefully this will un-stick the test which has been broken for a long
>> time.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  .cirrus.yml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/.cirrus.yml b/.cirrus.yml
>> index 90645fede6..f06f5af2b9 100644
>> --- a/.cirrus.yml
>> +++ b/.cirrus.yml
>> @@ -3,7 +3,7 @@ env:
>>
>>  freebsd_12_task:
>>    freebsd_instance:
>> -    image: freebsd-12-0-release-amd64
>> +    image_family: freebsd-12-1
>>      cpu: 8
>>      memory: 8G
>>    install_script: pkg install -y
>> --
>> 2.20.1
>>
>
> Reviewed-by: Li-Wen Hsu <lwhsu@freebsd.org>
> Tested-by: Li-Wen Hsu <lwhsu@freebsd.org>
>
> I would be nice to also add this patch:
> https://github.com/lwhsu/qemu/commit/ac699f79b4d86d8195d76c3befada65ade44=
9cc0.patch
> To prevent problems in the future.

Done. I took the liberty of apply your s-o-b tag as it wasn't on the
github commit but it came from your repo.

>
> The error was due to the pkg version got "fixed" when building image,
> and was too old when VM got provisioned, then it cannot be not
> compatible with the package repository. Ref:
> https://lists.freebsd.org/pipermail/freebsd-cloud/2020-April/000234.html
>
> Best,
> Li-Wen


--=20
Alex Benn=C3=A9e

