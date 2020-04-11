Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C242C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 12:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B2A32084D
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 12:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yoyc6kIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2A32084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNFgx-0003YQ-Bz
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 08:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jNFft-000383-1C
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 08:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jNFfr-0005Bn-2X
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 08:55:52 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:32871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jNFfq-0005BD-PO
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 08:55:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id a25so5146403wrd.0
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 05:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=PBegOnD+xJhkFGytgoV+PJDie+drEOmi9qzS8Mvg6Cc=;
 b=yoyc6kIfYVbE2RyN0jB1byeqtf73x0A1gCPp67agwlrnhQIl++N+QGpmZR0KBAaNj1
 ysPuuHGhOlS6jH5OSMy1BuIKdq0JEghqRxP1FpUdepJ2csG1qP1dZra4WuZwt+jKOlfl
 CgUUycInsvyNTaC7FRL2pVp3lJCtbMg7XlzSeimiZT3NOO4dlJZI94/3+TTPb0rRRqNv
 WA7Xy48IloKcB0v8RRVCBEva/rlz+T6www1gMA3tquwMzDZJWTscJw5of/Y1q7EaNyz9
 yxam+uQaqLjKi9n/fIXZhC1hLiycD57VL4tKS33hyh4n8EwcuK/pjbHbJn6CvwQdJ6wI
 R3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=PBegOnD+xJhkFGytgoV+PJDie+drEOmi9qzS8Mvg6Cc=;
 b=tKcIRfQoP9jaA/fCW4fe9j1XTJTjy85ITBvfJ8poemfmItBMSI4Pm5/3NKBlEvRU3n
 SpKaOPlTKmg+2O0Dc+3XFgO6UaI6TVfZjYVSAL7PD9qgsDuPv7NAFZ/27jTgcjkK70Hm
 dauX/3dfWniVrz2rgq+Zqm3RiRXHyfQum116wMxM+FWIY3MtgQ3Yw4/NLaoOZ0FMnHFz
 YRRrOR7nj+cCbOkskI5Vo0DHP/DQeF6dksCVHtqYEE7X1DsFo2LK1ZOuyeDOseV2+VeW
 5xLtROTeAw0xxShPq6TZ+g7EMg/HOqIW9U5muI0lfFz60P1PpooUd/H30jmvR81y2jZH
 eNCQ==
X-Gm-Message-State: AGi0PubnJAOFihwZ35Jri5kgDCDuB7clTl0HnAFU4aRgMsJxewsJYaAg
 DF8CM40jGCxalxLCsbuk0d4lAA==
X-Google-Smtp-Source: APiQypLbn+U4aRqRuTNS44XQbjOnu9VO0ulySZqPAJqKZQgLb6ZWAioM7RUH183bpLF98rGTTSQbvA==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr10214091wrv.363.1586609748650; 
 Sat, 11 Apr 2020 05:55:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d7sm6888829wrr.77.2020.04.11.05.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2020 05:55:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4CB661FF7E;
 Sat, 11 Apr 2020 13:55:46 +0100 (BST)
References: <20200407155118.20139-1-alex.bennee@linaro.org>
 <20200407155118.20139-9-alex.bennee@linaro.org>
 <CAHiYmc7Eu0XsCe_bkV=tP_S3wyWy4St1RR2AphE7Obko-18mNQ@mail.gmail.com>
 <45a7fe3b-cede-c8e9-fe98-99914bef0e97@linaro.org>
 <CAFEAcA_aE5uA9eaZWU9cr8tZR3x=dmqWBx5FO8QD8K3n+Fsv5w@mail.gmail.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 08/13] softfloat: Fix BAD_SHIFT from
 normalizeFloatx80Subnormal
In-reply-to: <CAFEAcA_aE5uA9eaZWU9cr8tZR3x=dmqWBx5FO8QD8K3n+Fsv5w@mail.gmail.com>
Date: Sat, 11 Apr 2020 13:55:46 +0100
Message-ID: <87wo6m89m5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 10 Apr 2020 at 16:17, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Although why Alex didn't add his own R-b to my patch when merging it to =
his
>> branch, I don't know.
>
> I think this is one of those areas where different submaintainers
> have different work practices. Personally I distinguish "did I
> actually review this" from "did I just put this into my tree and
> rely on others doing the review" and use r-by for the former
> and not on the latter (although obviously everything I put in
> my tree I will have at least very very briefly looked over).
> But I think some submaintainers don't bother to add r-by tags
> for things they review in the process of assembling their
> tree because they see it as implicit in the process.

It was exactly this - pulling in via my tree and adding my own s-o-b
implies I'm happy enough with it. Typically for longer series that
gestate on the list the total number of r-b tags grows with each re-roll
until the series gets pulled into a maintainer branch. This PR is
atypical in that regard because it's a fairly random collection of fixes.

I think the only patches we should be wary of are those with only a
single s-o-b tag from the author. I have to admit there was one such
patch in this PR:

  Subject: [PULL 09/13] linux-user: factor out reading of /proc/self/maps
  Date: Tue,  7 Apr 2020 16:51:14 +0100
  Message-Id: <20200407155118.20139-10-alex.bennee@linaro.org>

I made an executive decision to include it as it was part of the bug fix
for patch 10 and as we approach RC releases I wanted to get it merged.
If you follow the msg-id in the patch you will see the changes in the
patch are purely in response to review comments so while missing a r-b
tag it's not like it's not been on the list and had some scrutiny.
However we should certainly aim for most patches to be fully reviewed
even if we never achieve that level of perfection.

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

