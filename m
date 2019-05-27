Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59608C04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 16:21:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C532147A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 16:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u5SsYv2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C532147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48042 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVIN9-0000d3-A6
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 12:21:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVIM9-0008Vl-LE
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVIM8-0001Jc-JH
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:20:13 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVIM8-0001IC-BU
	for qemu-devel@nongnu.org; Mon, 27 May 2019 12:20:12 -0400
Received: by mail-wr1-x441.google.com with SMTP id t4so9088155wrx.7
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 09:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=BFR9vdYCyDFPYeIl9x29b3ZwxBE8EOGas7qIp5yyizs=;
	b=u5SsYv2pmajDbY3JME1SqkZV69P02Vieo541WMQfhopjW9l4enLgoJSl+/895GhGlw
	GW1llV/Eqok0UWHUsnXJPka3MmZjVfC87C56+c2LGmTMSwlffRKTpt+VZhPNLEMXIMkm
	FbMGB8sJyaO7WmneKqCbH6hftR5hOosjN8pvaOIC1fna4U8TjLZ4wmviPSYj8OXIPCQI
	jpOauQrK/PO2NQoSgn+aGFmpUv6LAaVuv+tQ9nwf4KuXGF5A9SoU2oAgDtPj8TcY7HYq
	/DfKnYPmi+qoJiTAG9wXMvyRvPdRs57YWfjeHtT2uHi7b9sUegqVOXUVAar1HNpHlmFF
	0rBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=BFR9vdYCyDFPYeIl9x29b3ZwxBE8EOGas7qIp5yyizs=;
	b=hu+1uyQEyqc2yEJuN34UJXhx7t1+cxarD32NNbJDjVXw6fkfZkdMEY/yQeOvmSjsVn
	Tvuu3oyIjY6RIG6KONESUJFmpI3ueboG/Ic9I8vHEO7Yv94gAUl0JFSM1RM3odP/nKFi
	BxX+CqBprqEAUqxJyffH/WtAcChUYTcoAlnZbpGB6ZHKC1WI5rgg/nVcUJYa1D9stOFx
	6Nj7r94AtPPQHiBgAO5ZLh/AyPF08r0brT6EedYSLe1LO9nHACvZTIdtIY6KJaIavbCV
	g3G48o//wumYmH8RE28cQ4OXah8gudkAwFqkVCplLhTa8KCkbsxlsiYh29SpNRQ+zRGA
	70cg==
X-Gm-Message-State: APjAAAV75JdlqpeRKSkCY7Jd7vDwsx8tJDXFz1H7LWZb4FY/X3xLnRxa
	siPcYKfgTnjzYlbZJ4toJmpJSg==
X-Google-Smtp-Source: APXvYqxrX1vYOf+t7kBT6gNYtJ2v/JXko7h61P4EBJhK9GVeIJ+WLy7qyUdmfczVHsCwWvzMwWXDUQ==
X-Received: by 2002:adf:ec0f:: with SMTP id x15mr4989506wrn.165.1558974010782; 
	Mon, 27 May 2019 09:20:10 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id w2sm5104176wru.16.2019.05.27.09.20.09
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 27 May 2019 09:20:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 817871FF87;
	Mon, 27 May 2019 17:20:09 +0100 (BST)
References: <20190523102532.10486-1-alex.bennee@linaro.org>
	<20190523102532.10486-28-alex.bennee@linaro.org>
	<18f8fad1-5dac-eb5b-f531-da3b2124ec35@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Max Reitz <mreitz@redhat.com>
In-reply-to: <18f8fad1-5dac-eb5b-f531-da3b2124ec35@redhat.com>
Date: Mon, 27 May 2019 17:20:09 +0100
Message-ID: <87imtvrhs6.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v2 27/28] tests/qemu-iotests: re-format
 output to for make check-block
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	qemu-arm@nongnu.org, qemu-devel@nongnu.org,
	"open list:Block layer core" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Max Reitz <mreitz@redhat.com> writes:

> On 23.05.19 12:25, Alex Benn=C3=A9e wrote:
>> This attempts to clean-up the output to better match the output of the
>> rest of the QEMU check system when called with -makecheck. This includes:
>>
>>   - formatting as "  TEST    iotest-FMT: nnn"
>>   - only dumping config on failure (when -makecheck enabled)
>>
>> The non-make check output has been cleaned up as well:
>>
>>   - line re-displayed (\r) at the end
>>   - fancy colours for pass/fail/skip
>>   - timestamps always printed (option removed)
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20190503143904.31211-1-alex.bennee@linaro.org>
>> Tested-by: Thomas Huth <thuth@redhat.com>
>>
>> ---
>> v3
>>   - revert echo to printf
>>   - add _report_test_start
>> v4
>>   - -pretty -> -makecheck
>>   - keep all output together for makecheck
>> v5
>>   - merged in kwolf's pretty printing
>>   - timestamps always printed in non-makecheck mode
>> ---
>>  tests/qemu-iotests/check | 179 +++++++++++++++++++++++++--------------
>>  1 file changed, 116 insertions(+), 63 deletions(-)
>
> Unless I missed something, this breaks ./check:
>
> $ ./check -T -qcow2
> 000 - unknown test, ignored

Because -T has been dropped (timestamps are always shown). Of course
removing from the opts passing falls through. Should I just do:

modified   tests/qemu-iotests/check
@@ -433,6 +433,11 @@ testlist options
             cachemode=3Dtrue
             xpand=3Dfalse
             ;;
+        -T)
+            echo "-T no longer needed"
+            exit -1
+            ;;
+
         -v)
             verbose=3Dtrue


> QEMU          -- "build/x86_64-softmmu/qemu-system-x86_64" -nodefaults
> -machine accel=3Dqtest
> QEMU_IMG      -- "build/qemu-img"
> QEMU_IO       -- "build/qemu-io"  --cache writeback -f qcow2
> QEMU_NBD      -- "build/qemu-nbd"
> IMGFMT        -- qcow2 (compat=3D1.1)
> IMGPROTO      -- file
> PLATFORM      -- Linux/x86_64 dresden 5.0.14-300.fc30.x86_64
> TEST_DIR      -- build/tests/qemu-iotests/scratch
> SOCKET_SCM_HELPER -- build/tests/qemu-iotests/socket_scm_helper
>
> Passed all 0 tests
>
>
> Max


--
Alex Benn=C3=A9e

