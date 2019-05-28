Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D17C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 15:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBF9B206C1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 15:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="enxNQ/E/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBF9B206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36526 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVdkX-00024R-T6
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 11:10:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVdjW-0001UY-F0
	for qemu-devel@nongnu.org; Tue, 28 May 2019 11:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVdjV-0007jj-Ce
	for qemu-devel@nongnu.org; Tue, 28 May 2019 11:09:46 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVdjV-0007hw-3s
	for qemu-devel@nongnu.org; Tue, 28 May 2019 11:09:45 -0400
Received: by mail-wr1-x444.google.com with SMTP id s17so20650861wru.3
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=BH1aUf6f8Vm/zs1e83XiWhxjvmeSFUCGkzxGvL8jRJI=;
	b=enxNQ/E/OsZ64WAYb2gbDIzzb/upvi4IYZrksNWodU/2v5TgPwZqsNf0U521rf6sFJ
	RSzFSZk9mp1ni/jWxx01qYMz2RuDlsjIeVp6vcBWp6kY3MkHqwXmQvHeMz5O+F6ra4Ed
	cPh5eSOtOs26EuQ+hS1N+NNNEYab/6wBEOs/Fc+dyAXFVyoy0ijgmnC2VgOhKVnDxgyd
	xl4LTWNsh19Bnp2/VAHjh46dxKTgzSYkeOqigqaPy9GDy+OP1OYV+lBnwcw6q8GKbpHR
	iB6h3IamjgEtZ5thV191XpP5Jw+4bBkB/aYu76jjO8PXaufFTPn6TEwGhWMzfxPclhNJ
	SSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=BH1aUf6f8Vm/zs1e83XiWhxjvmeSFUCGkzxGvL8jRJI=;
	b=kxWXBATb8u4h0/ffmwpXWPt7+FMHZbkxuCC//fA4XHrRDwmrKlN4C5n1vVqey2tK8p
	HqOHRlpsjdbRtZEcXlV3cpXrZh0l3iVProS39PpBzbhmXdCxTPk/T1ZWJoN/1KfvKnek
	+c3UOzNAb5yTO13qLW0ttQjKoA+NGArwwJunnzO48lRa3oW/l77rvOCfcGZ39+5ppHJc
	rVyGZUIxuEDMHQVyIL8bHksIHrgVgNvpD6VTgx3ccdbNeMyW0Fc9JzYtA+xO73BAJvN7
	tBMf0aMyPLTfF0FesU4V25jyLKgYcWbB8SY/GinkrXC5FO3vx3PzYGyX4MMScMTNrAlH
	Kjjg==
X-Gm-Message-State: APjAAAWl0wd+eSvDxlrJIbwKQdmdH/2dbsqmRBI+tdWpIy1g3HfLfUBE
	yJtSemA3ukOkZHQkj0ZOxnqUFQ==
X-Google-Smtp-Source: APXvYqwmNkR/DKQjn8CGsmfaltb4P1kloE/D4bvs9+j+dS/u3DR4Q3RM60atmHWzYi+jepsf8629nw==
X-Received: by 2002:adf:e850:: with SMTP id d16mr66998437wrn.269.1559056183431;
	Tue, 28 May 2019 08:09:43 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id n1sm4147386wrx.39.2019.05.28.08.09.42
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 28 May 2019 08:09:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 1276C1FF87;
	Tue, 28 May 2019 16:09:42 +0100 (BST)
References: <20190528094953.14898-1-alex.bennee@linaro.org>
	<CAFEAcA-Cbot1POVcbAzXhaLqNJpi6M_0z18=YoB7vyqY3PekUg@mail.gmail.com>
	<878suqsnb1.fsf@zen.linaroharston>
	<CAFEAcA-6Wh00+TG7r3Oeh_+Mn4Vcj0RdTjRL3sAQHtEeUm0mEw@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
In-reply-to: <CAFEAcA-6Wh00+TG7r3Oeh_+Mn4Vcj0RdTjRL3sAQHtEeUm0mEw@mail.gmail.com>
Date: Tue, 28 May 2019 16:09:42 +0100
Message-ID: <877eaasjih.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PULL 00/28] testing/next (system tests, docker,
 iotests)
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 28 May 2019 at 14:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>> Sounds like we should include the sanitizer build in our normal setup.
>> We currently only do:
>>
>>   ./configure ${CONFIG} --extra-cflags=3D"-g3 -O0 -fsanitize=3Dthread
>>   -fuse-ld=3Dgold"
>>
>> with gcc-7. What are the clang configure runes you are using?
>
> I use
> '../../configure' '--cc=3Dclang' '--cxx=3Dclang++' '--enable-gtk'
> '--extra-cflags=3D-fsanitize=3Dundefined  -fno-sanitize=3Dshift-base
> -Werror'

OK - I'll drop the final patch for now and respin and include it the next t=
esting/next

>
> (which we document at https://wiki.qemu.org/Testing#clang_UBSan)
>
> thanks
> -- PMM


--
Alex Benn=C3=A9e

