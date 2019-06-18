Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F209DC31E5E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36F12147A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qfs8WLvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36F12147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60386 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdHiX-00073o-W2
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 13:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54892)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hdH2j-0003DA-5W
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:33:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hdH2h-0005zW-SG
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:33:09 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43138)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hdH2h-0005xn-IN
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:33:07 -0400
Received: by mail-ot1-x342.google.com with SMTP id i8so15721033oth.10
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xjm4h6qQXLZeS9L+suh3uBi0+WYYNK/7IeVs0d+yW5E=;
 b=Qfs8WLvs+LJ04r2PMMRTlxtpA/MW0Y0dM/7vOt075BWX6s7Lrc0pTMfHnetqWq/Hmz
 RLyMD9nIRrIMnFClZF5BkmIcVgoyOz+N4Tr6GDefVXf3IAQwQz80o48TPwGFesP37XxF
 FxnY0VcR7kR1E/0OMUG7GQlmdgLwJtcyqK3eDZ/WTDvS8HFcHj9hPeG6lTWSebCAAGhE
 XezDBOm0oaFS31bPzJBB6xPbhPZAflpIwSXKx3BU/S3tkPbNKpAY6mVl7shy2id0fi3W
 e2O8RoztBl8rF9fZqytkraLSinuyNzkRWIuEcVuYYjoJBei0yB2mgQm4GrN1o6+QLaVX
 3OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xjm4h6qQXLZeS9L+suh3uBi0+WYYNK/7IeVs0d+yW5E=;
 b=FCRyvfSvXg5ndwRuSlLDacHN4bEy1Sa0Ad/FO2jid29KkXfuNJb07dtBY7jv7yi762
 fEPYPLeXoEfnzp5+H+9h3Ku5ZTw4iVba6VWuoIFyXy91oMUzjSpOmn1YNArdoQXKidvf
 f5fetEEOMF3qZdbuptfc1iXOtnbWQ4K8o0WY+VpPWjQ+cHWgjBAKPMS0U9BfSphBWo3X
 /yer3fkoyA1voENyxSn3arr/+Hcaq4T4b4CNdomh42J14i42LwMPtW025IccJWebalLo
 Pgo8ilkwGwuFc7YFHYjArWasm3nWerWiZQMByJSX4ZGbex5PhzvVuzkrw6/ZuX9Rk4sA
 N2Yw==
X-Gm-Message-State: APjAAAXN7C7zUugeRVSIvoyOKZH5WftvIJhndZmPMaTYUm80pjtKeJ+1
 Yrijx5HRuT5SCWnuoeBK20WxB7Hys2XmltmvMJEF7A==
X-Google-Smtp-Source: APXvYqwOEyZAkG8prqpGgNrXxYwkNCvjQQ0Pj/4vlNxlIPhdoPAF6yk93IyT3So9IRKCdRAdXSQzWLAvazH+zq3obDs=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr5755668otj.97.1560875585989; 
 Tue, 18 Jun 2019 09:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190618152318.24953-1-kwolf@redhat.com>
In-Reply-To: <20190618152318.24953-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2019 17:32:54 +0100
Message-ID: <CAFEAcA-2vpm5MfZGd_FGrWOvECMatwiOqUQyEfPb7X5SRQWDkQ@mail.gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL 00/14] Block layer patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Jun 2019 at 16:59, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit cdfaa2720f4a09e5254868bd1f6e33f3e9eae76f:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2019-06-17-v2' into staging (2019-06-18 10:47:00 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 128b05f7e00765d883164631b974a27af5b4b613:
>
>   block/null: Expose read-zeroes option in QAPI schema (2019-06-18 16:41:10 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - block: Remove bs->job
> - block: Ignore loosening perm restrictions failures
> - block/null: Expose read-zeroes option in QAPI schema
> - iotests: Hide timestamps for skipped tests
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

