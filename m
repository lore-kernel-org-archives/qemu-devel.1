Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16241C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9F820848
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cu8LM3dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9F820848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fqQ-0001TY-2V
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2fpj-0000eJ-SD
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2fpi-0003SJ-RF
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:36:59 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:33040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2fpi-0003RG-MB
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:36:58 -0500
Received: by mail-ot1-x335.google.com with SMTP id w6so874959otk.0
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kPqfffS/TIdf0S7VKGx+PT7g2HW520ODsj6Dj2ULAyo=;
 b=Cu8LM3dr51cgMho0OziRqp5aKsMp1DOW97DSZRgTiSfxYXqB5lJz7SXubC8B+0JQj7
 mtpxzYer4liKqDX3Ji226bGqva7KedDtpVzXTkvG07zb0Vq/RX3ocZpEiWUSRZPT6Gs+
 5IREfLt7zR9VYlUUpcrPp+GgOIf3cOTFzENwoPt7UuWOQ6rZFPHVH5QPf19ukZwRVOf0
 0fnhMm/deC367EM6vg+1zhcKLpmddLfVICtEGL6Un8qA+O2W84FX0AWaBj6imbnVbVXh
 haA8WwfTMtA2D8pdSe15PXPXSqh/aynNHoh3onvHMC5dMgXwfzQ2qKyRH8jXP5oYuJ2b
 GzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kPqfffS/TIdf0S7VKGx+PT7g2HW520ODsj6Dj2ULAyo=;
 b=TJqAmgRpvTDFMrDsJ5wL4slqw54vsmNkSdZLUj77SwDV4JUQCF4m/L3jbS0A/Ic1oy
 2kLGN+CnPkORxatumpv89Vmi8GUX10m7PmGdom4VghzR7Pp3DT78cPLGitRSt1AnXG5x
 cCncrKAX4PUz5uvl6XPtNFkp4IjbXa5yF/rnNaQpTrR8NuoojIGP/8KZNkKhvwRysKnX
 5I6B2sGh1bMRsJXfRjG8sacp32V+JItVQ/AWIZT1TiDGG9rjfxa4JnBsw18O9tthESJW
 GBUybPMUVmYBP90W6lZQ52jOm0oePVg5NiatUZCxMyUzM6eNSWen1HHuHarC96Oy5sjX
 KHcQ==
X-Gm-Message-State: APjAAAUTZ9NR74AAlJ8OlHJu5smf9xYTjIddwrWzSTwNjgxxkhxqP86h
 lNV+tTVKDNTM8hqAMGy7PByadv8ThuQ1QeTaF0D0oA==
X-Google-Smtp-Source: APXvYqxuXrR2KqWJaW+r2b3jcocgOlzZmRRCp3tyQ9ZhGF+6qW+anh/HZTsa5o2FcBgSzhJTxlNZYbcSOIF5rU+1fjk=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr3422816ota.232.1581705417757; 
 Fri, 14 Feb 2020 10:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20200213132030.57757-1-quintela@redhat.com>
In-Reply-To: <20200213132030.57757-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Feb 2020 18:36:46 +0000
Message-ID: <CAFEAcA-wXHGNH_Tb-87V=WDmLRhahqPHV48ACBfLcBHsbqZTjA@mail.gmail.com>
Subject: Re: [PULL 0/6] Pull migration patches
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Feb 2020 at 13:21, Juan Quintela <quintela@redhat.com> wrote:
>
> The following changes since commit e18e5501d8ac692d32657a3e1ef545b14e72b730:
>
>   Merge remote-tracking branch 'remotes/dgilbert-gitlab/tags/pull-virtiofs-20200210' into staging (2020-02-10 18:09:14 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/juanquintela/qemu.git tags/pull-migration-pull-request
>
> for you to fetch changes up to 1a920d2b633e13df8961328b3b3e128989a34570:
>
>   git: Make submodule check only needed modules (2020-02-13 11:31:58 +0100)
>
> ----------------------------------------------------------------
> Migration pull request
>
> - don't pause when migration has been cancelled (Zhimin)
> - fix memleaks in tests (pan)(
> - optimize wait-unplug (keqian)
> - improve rdma error handling/messages (dave)
> - add some flexibility in autoconverge test (dave)
> - git-submodule: allow compiliation from same tree with different
>   number of git-submodules (juan)
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

