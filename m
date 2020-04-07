Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A7DC2BA80
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DAE420719
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 14:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WcpnJ7C2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAE420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLop9-0005uV-EJ
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 10:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLooG-0005CE-Ov
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLooE-0005mU-46
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:02:36 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLooC-0005kS-Gi
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 10:02:32 -0400
Received: by mail-wm1-x344.google.com with SMTP id z7so1871576wmk.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 07:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/PpK+224saBoM6aADddh++TY1wHXCsKuZyGh+Ladycg=;
 b=WcpnJ7C2HnxqCrbn+OL1XTVGGNIm15hXuatMiarly09vGyY4Rja0DxQXqk0drro4BS
 4VJB9C5jtylImeqaygAoeN7ZBCCpnnGYPNsDAhKmp1SjcV/kJopcwUMZ2abZf0FCLExg
 KkNK/vcZNAuBZY9KFTX3+5/AR45rOGSuWKMlf8//UwVyFMnMdCasvhx0y8Y8IhKfb6qk
 rIgxTSDbLMjApNSSOrYwp+T4/xLegmkFCKysya4tUljaPxz7yJQl8ebGLLgd1B+qrBrN
 nhgJ5r7+E7Q047njIDEA7xMW2lWLXlYbrsHtUXFym0QKjlKVE/pdape6pS1F/84f2rXT
 DvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/PpK+224saBoM6aADddh++TY1wHXCsKuZyGh+Ladycg=;
 b=Kmxf1ES/zPXxKVn86Z6gTgyR8buRiR98W9k+E5x3URWelXEaTvfnvwxfu3XXaGOc4w
 AICjLpZ+Mf+32yIpDMuVWjqLe6Zcrd3W6cUQVB/5sIZN9eUfy9XO7kfntcGdCbUOQRkr
 L0q11lLpuOLzHQaMUBq45fDZjlOzng/UJkdnTFusgbFbZKUaUI2BRuXtgstADUgc3AJF
 7EcIpceMfqJMA6oDKRdko3T/dYf1EANNxW8dh8iYBMOUCY9jFPNpMDAQJD/otwGoAaBX
 NaXqHYnh0+uaD2rJVCtRN2YKgBrGtSz8jiFWOLM/V04EQ886ZIYmm5x6X7n/Mt0V9Hme
 foFQ==
X-Gm-Message-State: AGi0PuYtnNk/jbsFi4g+wtAOpQ7RakX58jLTJSP1mAMTMt8oA6RDNOx/
 RxJbNi170ekyLI3VPthr4TY/hA==
X-Google-Smtp-Source: APiQypK8nKNtrWSOH375rY2Fizvqpb7I1ItCLx/2+7QcsGyjKTOHt2nemhw0D+DWxt5/8hj/arFETg==
X-Received: by 2002:a1c:9cc6:: with SMTP id f189mr2491085wme.75.1586268149180; 
 Tue, 07 Apr 2020 07:02:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a7sm2369800wmm.34.2020.04.07.07.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 07:02:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E98131FF7E;
 Tue,  7 Apr 2020 15:02:26 +0100 (BST)
References: <20200406214125.18538-1-f4bug@amsat.org>
 <CAFEAcA9bN_0AqR2E-cL0ymQ6LLPB3dQLE5QndTJCJRGDvnafsw@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH-for-5.0?] .github: Enable repo-lockdown bot to refuse
 GitHub pull requests
In-reply-to: <CAFEAcA9bN_0AqR2E-cL0ymQ6LLPB3dQLE5QndTJCJRGDvnafsw@mail.gmail.com>
Date: Tue, 07 Apr 2020 15:02:26 +0100
Message-ID: <87imib9yx9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Daniel_P?= =?utf-8?Q?_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 6 Apr 2020 at 22:42, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>>
>> Some GitHub users try to open pull requests against the GitHub
>> mirror. Unfortunate these get ignored until eventually someone
>> notices and closes the request.
>>
>> Enable the 'Repo Lockdown' [*] 3rd party bot which can autorespond
>> to pull requests with a friendly comment, close the request, and
>> then lock it to prevent further comments.
>>
>> [*] https://github.com/dessant/repo-lockdown
>>
>> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> Repo Lockdown is enabled on https://github.com/qemu/qemu/
>> ---
>>  .github/lockdown.yml | 35 +++++++++++++++++++++++++++++++++++
>>  MAINTAINERS          |  1 +
>>  2 files changed, 36 insertions(+)
>>  create mode 100644 .github/lockdown.yml
>>
>> diff --git a/.github/lockdown.yml b/.github/lockdown.yml
>> new file mode 100644
>> index 0000000000..94472d1256
>> --- /dev/null
>> +++ b/.github/lockdown.yml
>> @@ -0,0 +1,35 @@
>> +# Configuration for Repo Lockdown - https://github.com/dessant/repo-loc=
kdown
>> +
>> +# Close issues and pull requests
>> +close: true
>> +
>> +# Lock issues and pull requests
>> +lock: true
>> +
>> +issues:
>> +  comment: |
>> +    Thank you for your interest in the QEMU project.
>> +
>> +    This repository is a read-only mirror of the project's master
>> +    repostories hosted on https://git.qemu.org/git/qemu.git.
>> +    The project does not process issues filed on GitHub.
>> +
>> +    The project issues are tracked on Launchpad:
>> +    https://bugs.launchpad.net/qemu
>> +
>> +    QEMU welcomes bug report contributions. You can fill new ones on:
>
> "file"
>
>> +    https://bugs.launchpad.net/qemu/+filebug
>> +
>> +pulls:
>> +  comment: |
>> +    Thank you for your interest in the QEMU project.
>> +
>> +    This repository is a read-only mirror of the project's master
>> +    repostories hosted on https://git.qemu.org/git/qemu.git.
>> +    The project does not process merge requests filed on GitHub.
>> +
>> +    QEMU welcomes contributions of code (either fixing bugs or adding n=
ew
>> +    functionality). However, we get a lot of patches, and so we have so=
me
>> +    guidelines about submitting patches described in our Wiki:
>> +    https://wiki.qemu.org/Contribute/SubmitAPatch and
>> +    https://wiki.qemu.org/Contribute/FAQ
>
> Maybe include a reference to the mailing list here too?

I'll amend the patch.

>
> thnaks
> -- PMM


--=20
Alex Benn=C3=A9e

