Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B152ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BAAD2184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mjwcUw+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BAAD2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMrx5-00041R-Lq
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 07:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMrwO-0003a1-4O
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:03:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMrwM-00024a-NX
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:03:03 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:46966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMrwM-000240-Gy
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:03:02 -0400
Received: by mail-oi1-x231.google.com with SMTP id k25so13741325oiw.13
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 04:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zen4c2BSNeFzVj4pnB2AsVnu0zvny6Hf9YetPsnTLhA=;
 b=mjwcUw+VMqWEn2HUPSun2b46WWVOT19/fZlQQdQzqApY4EjUFeGK3EuWnXLZdAEh9U
 tdCC9MIgy4+5COHt236a2OQo3GyA/fIa+33BlfdyiUsOGdka0p3lv51OSJ6EbF719HpE
 iSaFttQF4PVsM0tGYVl8mDvrbuhWtOcZfY7UL+MS5sBvw+838/9aRyno1ws6bZuQ0GMJ
 eD5GWt/76W/e3KmbqkRtbXZv+/KB00JheaMIOyvR+miq6HkPdcK0iFmkFSc8DFmleDNC
 pdbEDNx88CyrQvCcf301mFPzCKUtfW+AP9zp6Ggvc5fux0rKsn5Em9eSrC7OY55qenCN
 WeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zen4c2BSNeFzVj4pnB2AsVnu0zvny6Hf9YetPsnTLhA=;
 b=XFMGqoWoYvC+i78q5Jn2bvGszzr159MOpT8wHXQyYJntZWSEAiSH5Pe9ihEjzrseUy
 dzIv7eyEOwR3PM1awqjUQ0mORbNVnLF8OjmdvUuwCUZ01dpm+s8UzghnqvMU9WRgtBWG
 0URGO2zhWv/H8B/eEILNm1El4tZIdhfffGJSeWRBB8WMFH1wgsbGqL4ToWnoToiapNje
 w1K5JrW+fa8pP7D4m46Xi4w3vAXeolbu83K/4/IAzKB13dbN4AtF7SH2ZrFsMWFnxOnV
 eekhNvbeZBwiq15CrPuJjlJesLPirEY0715UmmsWS8HnJbret7FKdBHLHrLXfT7HixSh
 JFXw==
X-Gm-Message-State: APjAAAXLcEEXsdmcKmZ+SwVzQqA8fpx/cvnoJDlywyycIPG//vDzxymI
 xD8w8YF1svAiku4+fHNw8r16nNGVBGQ618NhQEys8IGI2KY=
X-Google-Smtp-Source: APXvYqx6k9m7ewK3aCYOxNz/+K6AQjS2XZ70DeNG6ZZRwWQhlx7KDVqaPo/0VORYs3S3Xp9ZJyIhtrAlZDpqjBBhGb8=
X-Received: by 2002:a05:6808:9:: with SMTP id u9mr2453040oic.98.1571742181549; 
 Tue, 22 Oct 2019 04:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191022081104.11814-1-laurent@vivier.eu>
In-Reply-To: <20191022081104.11814-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Oct 2019 12:02:50 +0100
Message-ID: <CAFEAcA8kAcFT1y3Rf4GhqrBMmqut-R4c3O+z8dgeTMhcZ8wtPw@mail.gmail.com>
Subject: Re: [PULL 00/11] Linux user for 4.2 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Oct 2019 at 09:20, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit e9d42461920f6f40f4d847a5ba18e90d095ed0b9:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20191018-pull-request' into staging (2019-10-18 14:13:11 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-4.2-pull-request
>
> for you to fetch changes up to 9a68960d8e7fdda16c2ea779a70f7f894ed2ce56:
>
>   linux-user/syscall: Align target_sockaddr fields using ABI types (2019-10-21 15:37:04 +0200)
>
> ----------------------------------------------------------------
> sockaddr alignment fixes, strace update and fd-trans fix.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

