Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA66C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D5D214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 13:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xXAq9YIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D5D214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j03uO-00045f-Ho
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 08:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j03tU-000386-85
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:42:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j03tT-00025X-4G
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:42:04 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:33102)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j03tS-00020y-TA
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 08:42:03 -0500
Received: by mail-ot1-x32f.google.com with SMTP id b18so2191715otp.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 05:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YIJQGlggyp0BM9UFTSINm5BNdmNwNYJfwN4p7yx3r6U=;
 b=xXAq9YIrwNzF58AUKbQkP/8AbLDTa98ZjcfP2XFgYON8ThsayY4hLHENVdcUHBhUmW
 AcDws6sQ+5N7kpP/FGkxRNEH7TYpZRmQ0Vy1UL0dDA5DkRzuDHNVOIQnsihfGzJhmltD
 Dai+LBFEbkztIdQ8nwSyrC69hB6k5Gtb2TvrQnlFlkgCA4wE6FtYvbxzx+WOHv+pMn47
 WHD9WkO0tG5JvhNCA6lWba8hx23JWc+AApcjqwpxf6nv4ZrvIvu6pBoLnO0GbIPGeY1i
 SJhftK+FRIUgpDSfO18w2khY50qWXm4bgv05yk1dvO5BcatcUlJDZ5ASezT8Bv9Gt7Kl
 oXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YIJQGlggyp0BM9UFTSINm5BNdmNwNYJfwN4p7yx3r6U=;
 b=afaSCd4f+lK0k2+LH395OIhL8crqQ71/3kIN7D9PfCG3sObFXbdMiNkXXzSbvvkVne
 Y9W5d6qsffrYXjB1/s1n1jMEVWHcHUGnzv61YH9dwoo7CVxjxCDkxFMJRd/dYYImPaUx
 L9O71pwi4h/j8XsRD2AKHOa1XuWcLXvn4LuoDzuFYr1aXBbOrcsyO61JufXWyuscTsVO
 yytrMF/qAKFLQ7tinDkC4W/01zVaOf6qGmuMt80AjUT5sChhL6XjdRViapcILK5j5NG1
 eY8y5r09hkcR4DRWnIidyaiy+hCfh65bZywjSj1/IAQLH5Sr1eUQGoJ4DsrXmnmqq+nS
 akOQ==
X-Gm-Message-State: APjAAAWZ0ZYw7tbeb2+OWkOecpmZkH0tp//8e5XRiOILxyuWcdZK4B97
 gextsLCdekDuie1rZ1T+22B4gp3O5dYX8x4W3cgEnA==
X-Google-Smtp-Source: APXvYqxyL8t4YBiBfK4n6bAidFTXHTbXQBBHHxRs4evVysQVb0zkX/W9Ad7TQypG5dTtqcg3ZbV9aSGUwrl+tcnCiRE=
X-Received: by 2002:a05:6830:1184:: with SMTP id
 u4mr2609587otq.221.1581082921856; 
 Fri, 07 Feb 2020 05:42:01 -0800 (PST)
MIME-Version: 1.0
References: <158103327286.16446.1485987593254343093.stgit@gimli.home>
In-Reply-To: <158103327286.16446.1485987593254343093.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Feb 2020 13:41:50 +0000
Message-ID: <CAFEAcA_erHkiigHfgqE4acDOKc49DgsCq5p2xP9+p8NXQj-GQQ@mail.gmail.com>
Subject: Re: [PULL 0/1] VFIO update 2020-02-06
To: Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Feb 2020 at 23:57, Alex Williamson <alex.williamson@redhat.com> wrote:
>
> The following changes since commit 2021b7c9716cd579e20b4993ed75842f4e0deb34:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging (2020-02-06 12:57:54 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20200206.0
>
> for you to fetch changes up to 29d62771c81d8fd244a67c14a1d968c268d3fb19:
>
>   hw/vfio: Move the IGD quirk code to a separate file (2020-02-06 11:55:42 -0700)
>
> ----------------------------------------------------------------
> VFIO update 2020-02-06
>
>  - Split IGD to separate file and config option (Thomas Huth)
>
> ----------------------------------------------------------------
> Thomas Huth (1):
>       hw/vfio: Move the IGD quirk code to a separate file
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

