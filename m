Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CBDC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 20:33:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E94E2208E4
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 20:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uMpkwdDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94E2208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWnD5-00066q-6t
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 16:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWnCI-0005Iy-Fe
 for qemu-devel@nongnu.org; Thu, 07 May 2020 16:32:46 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWnCH-0007l6-8q
 for qemu-devel@nongnu.org; Thu, 07 May 2020 16:32:45 -0400
Received: by mail-wr1-x441.google.com with SMTP id g13so7983763wrb.8
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 13:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+yJF/CZ1fUdX/0Oia0BgC7RlCNx505JWZhgHtx5BDuM=;
 b=uMpkwdDyc/OWCbhPW00Z5wvMxa9mS+S8A+jMnN4hcTJxf6a7SqiVJ5A9Q9yZUjfif0
 0GvQTEkCGE/Us7jhTyJTWRG1nITC2eORe2hdr/LNjH+zGI1nIenW9WG/aDHBT8LfCJJp
 M3VejjGExqkYtY1ot0/NCp8lxj7h0KkY+U9uqrmTh0m9326veoLXkcc1s1r1jQ+wCnJe
 UPB+4Y+Qk/4vNFYFaUJxO35lezfYJvRAKX4DPP0GuraQGdOHrjV+A+Hj3RjxlsUvxkNw
 7oC6oedgdIhiXa/SGwFR/Gm0N68MhufBA6+55QxNyxDg9UDN8iMUMjxGMfR3MU9uGb4x
 EdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+yJF/CZ1fUdX/0Oia0BgC7RlCNx505JWZhgHtx5BDuM=;
 b=L14k8Qd1+h7kffxWYwqg9049mveezRzmnQ2PDVIKxzwDFHvgrLK3KBx2kJGhVCfME6
 iMuo/UoZk0gPZNSY9aROxu8gSD6QM7hTe8gCKuvC2KJyLO86t61gWD/OLPuCX9vlGE+O
 v9WEszMLwju0nUypPsVZuZxLA7mVId1urF7kUrADXgcUQ+nGVOU8pEZfRxYNq4S8Dsp8
 sdFsrQo2gOlF1YrgROVUOJqjk0rbeclZze+I2WsTeD3Dynj6m7wCzZk0nCoTzV+KvUch
 ovmLK5t1u9waxS22d9ZQ0vH8j8QADYx3C9SUkz/ELMG3MQCRe11Jmn+zvqihOrfkFWPX
 0f9w==
X-Gm-Message-State: AGi0PuZvvda9XihNCSfJDTMO8vi2AI1KmifrSzG/z0GwcgyqOSx3Ibgj
 amMGdqgBuYf7tp01WlxFfO35Kg==
X-Google-Smtp-Source: APiQypKPVrUgvejCzbXovhFrYFXdSeYeWpbNNwl7DDXCfIqvihgB9HltRXCvVmrVJFdGDava8OfM/Q==
X-Received: by 2002:a5d:46cf:: with SMTP id g15mr14032465wrs.276.1588883563501; 
 Thu, 07 May 2020 13:32:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h10sm9473806wrv.29.2020.05.07.13.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 13:32:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7EA9B1FF7E;
 Thu,  7 May 2020 21:32:41 +0100 (BST)
References: <20200507162235.1790-1-philmd@redhat.com>
 <874ksr615d.fsf@linaro.org>
 <CAFEAcA800Lhgqa6gOWmA5M2D3+Xj0hYcJw9Tkget4yvW5fFs+A@mail.gmail.com>
User-agent: mu4e 1.4.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] tests/acceptance/boot_linux: Skip slow Aarch64 'virt'
 machine TCG test
In-reply-to: <CAFEAcA800Lhgqa6gOWmA5M2D3+Xj0hYcJw9Tkget4yvW5fFs+A@mail.gmail.com>
Date: Thu, 07 May 2020 21:32:41 +0100
Message-ID: <871rnv5vva.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 7 May 2020 at 19:38, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>>
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>
>> > The BootLinuxAarch64.test_virt_tcg is reported to take >7min to run.
>> > Add a possibility to users to skip this particular test, by setting
>> > the AVOCADO_SKIP_SLOW_TESTS environment variable:
>> >
>> >   $ AVOCADO_SKIP_SLOW_TESTS=3Dplease make check-acceptance
>> >   ...
>> >     (05/88) tests/acceptance/boot_linux.py:BootLinuxAarch64.test_virt_=
tcg: SKIP: Test takes >7min
>> >   ...
>>
>> 7m =3D 420s - I'm seeing:
>>
>>   hyperfine "./tests/venv/bin/avocado run ./tests/acceptance/boot_linux.=
py:BootLinuxAarch64.test_virt_tcg"
>>   Benchmark #1: ./tests/venv/bin/avocado run ./tests/acceptance/boot_lin=
ux.py:BootLinuxAarch64.test_virt_tcg
>>     Time (mean =C2=B1 =CF=83):     162.179 s =C2=B1  3.138 s    [User: 2=
04.726 s, System: 9.663 s]
>>     Range (min =E2=80=A6 max):   158.651 s =E2=80=A6 170.036 s    10 runs
>>
>> Is this on very slow hardware?
>
> Intel(R) Xeon(R) W-2145 CPU @ 3.70GHz 16-core
> clang sanitizer build, which probably slows it down a bit.
>
> But even 200 seconds is an order of magnitude slower than any
> of the other tests that check-acceptance runs. I think we
> should be aiming for tests here to be ~30 seconds at most,
> or the whole thing will take forever by the time we have
> decent coverage of most machines.

I think we could say the same for a whole bunch of the tests that are
based on full distro downloads. What is this one running under the hood
anyway?


>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

