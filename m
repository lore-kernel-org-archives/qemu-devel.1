Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781EEC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 09:49:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C3162070B
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 09:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YCQh3a9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3162070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juYc3-0000JM-CM
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 05:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juYbQ-00081y-N8
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 05:48:56 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55997)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1juYbO-0003z0-UH
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 05:48:56 -0400
Received: by mail-wm1-x341.google.com with SMTP id g75so10352430wme.5
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2020 02:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=tPmuLHuBO1y1KjHGm7EVN52urh83upAGJCKAD5bBzKM=;
 b=YCQh3a9Dyv6MzqcmHWtE6k4AUY34mehQMC/srcYllqQymUVKJdq8NmiYf9SGgBznPm
 3OR9Xc0hCj63sceTDoPCh0csNImKLRyYVJtbYqXd+58SAKocW8zdeFvH6Khb9Yfl+yo2
 Va6rTDu1fNHc5UB7u9F81GLrTp+01n8ibO9L+ZUdeMpwww8wstwDeTyyggEY/Gwl3eQ8
 CnYnHPXjd8Tkq4rlBSU0iTSPAU4InPIWXdVRuO8Atd15VxNA1syiYwYKeyM7WVT039qo
 NM+dPzGBxLUw/1hgofaIekQcHjHw5XW+71rGeTRi96N8FOqGmCWOZZ3wzFPV+LQU/IRg
 GW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=tPmuLHuBO1y1KjHGm7EVN52urh83upAGJCKAD5bBzKM=;
 b=fr/ou1SKoM87H9eZOxN0TLb09UYI5PEcU5mc51A7t8ck/+atsKkaoRZEbMBYRwXcub
 2yBD2QRu1SJ+r9pY2qhuI2mtFIUUBPVzOc00zRM7t6MzjOLBE4vKMsYPv+KONms2rgUM
 E64q6Wg7FQM80Lo5IM4nPWXKiBJyG2q/atsJPYPWvm/E4Fs6OiZEVc8wbQP+NY0bLeI4
 SqNjniEQ5eOXui61/RpOjjnjZ2+t0M307ogQafzWyJmHnqONIJcH+vZOsYDS32oiNUNb
 JshyZLC+RjoS7PQuAoEkId8THb9JvtlZi51huJ1sMIu3OyhQCrHZ2NNrQE0i5G398wQe
 o9Jg==
X-Gm-Message-State: AOAM530FuwjLrRf0BhR+B5aZwsjB7WQDf4ygYZZ/vtxpw8xua0jTF/dD
 Hx5weBBOMI1bg6QjS8vyhuojZA==
X-Google-Smtp-Source: ABdhPJxx+Z8LaZOG5YB5EG8d5LDsttyJCN/00pxduMVUPmSFSeP4A6uIdSizzUCrzH/qTitn/vhnfw==
X-Received: by 2002:a1c:44e:: with SMTP id 75mr14025335wme.139.1594547333019; 
 Sun, 12 Jul 2020 02:48:53 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t2sm17630733wma.43.2020.07.12.02.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2020 02:48:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D80871FF7E;
 Sun, 12 Jul 2020 10:48:50 +0100 (BST)
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-9-alex.bennee@linaro.org>
 <20200711215615.GE807960@sff>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Emilio G. Cota" <cota@braap.org>
Subject: Re: [PATCH  v1 08/13] plugins: expand the bb plugin to be thread
 safe and track per-cpu
In-reply-to: <20200711215615.GE807960@sff>
Date: Sun, 12 Jul 2020 10:48:50 +0100
Message-ID: <87lfjpqd19.fsf@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 f4bug@amsat.org, aaron@os.amperecomputing.com, Dave Bort <dbort@dbort.com>,
 kuhn.chenqun@huawei.com, peter.puhov@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Emilio G. Cota <cota@braap.org> writes:

> On Thu, Jul 09, 2020 at 15:13:22 +0100, Alex Benn=C3=A9e wrote:
>> While there isn't any easy way to make the inline counts thread safe
>
> Why not? At least in 64-bit hosts TCG will emit a single write to
> update the 64-bit counter.

Well the operation is an add so that is a load/add/store cycle on
non-x86. If we want to do it properly we should expose an atomic add
operation which may be helper based or maybe generate an atomic
operation if the backend can support it easily.

>
>> we can ensure the callback based ones are. While we are at it we can
>> reduce introduce a new option ("idle") to dump a report of the current
>
> s/reduce//
>
>> bb and insn count each time a vCPU enters the idle state.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Dave Bort <dbort@dbort.com>
>>=20
>> ---
>> v2
>>   - fixup for non-inline linux-user case
>>   - minor cleanup and re-factor
>> ---
>>  tests/plugin/bb.c | 96 ++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 83 insertions(+), 13 deletions(-)
>>=20
>> diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
>> index df19fd359df3..89c373e19cd8 100644
>> --- a/tests/plugin/bb.c
>> +++ b/tests/plugin/bb.c
>> @@ -16,24 +16,67 @@
>>=20=20
>>  QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
>>=20=20
>> -static uint64_t bb_count;
>> -static uint64_t insn_count;
>> +typedef struct {
>> +    GMutex lock;
>> +    int index;
>> +    uint64_t bb_count;
>> +    uint64_t insn_count;
>> +} CPUCount;
>
> Why use a mutex?
>
> Just have a per-vCPU struct that each vCPU thread updates with atomic_wri=
te.
> Then when we want to print a report we just have to collect the counts
> with atomic_read().
>
> Also, consider just adding a comment to bb.c noting that it is not thread=
-safe,
> and having a separate bb-threadsafe.c plugin for patch. The reason is tha=
t bb.c is
> very simple, which is useful to understand the interface.
>
> Thanks,
> 		E.


--=20
Alex Benn=C3=A9e

