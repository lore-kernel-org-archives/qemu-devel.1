Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67189C54FD0
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32142206F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 13:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZEHK3zuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32142206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQsZj-0002Wz-5L
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 09:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQsYB-0000Z0-2j
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQsYA-0002sG-FR
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:02:54 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQsYA-0002q0-1y
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 09:02:54 -0400
Received: by mail-oi1-x242.google.com with SMTP id k133so11896408oih.12
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 06:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KeatBysOs4g1w9ucJik06kMFsqtbBYNKB2LJi34r5/g=;
 b=ZEHK3zuTVFYNcFuYOAgxTYB5atjiPGX1lleSsfDtvhignUa7fXzs6WpktzR/OAVEGc
 8E1uyGgs3LDOOXc9qAnO0YfOfqcefQ0zM0EsxYkHnrO9Vimg1IYDc6wS9LWjTHf5ERWR
 nL+zBcQ57ReI1KIsOr4yD8DEpcD17YWO2UH3Zuy2GfokaHahgq5LDJ0qoaSrz408loCy
 o34nyylhNIzvvTfjUW1vstzHutbCavTyktxKpSkL1KZuaVaEUwLhEezSih6ycNwuMmie
 RP4kvXAfsYlrZ5pxQahkOhx5t+2D+DWKRNGNiEhW7iAV9LcHogVirvt6RpdWnfvwwrq3
 iJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KeatBysOs4g1w9ucJik06kMFsqtbBYNKB2LJi34r5/g=;
 b=q7NV4nmT9fVGSBZYgvymgwMHxwDJoiNDoFZfoSDYZB9N5hZuoHqe4+CBvLqKU+mmpz
 nUq+rrdLcu+DvePjAxF8r8jChfQgqWmXDv6XtoJYnKPAl6vrelJiWWCRUsQ9cHCMCNGW
 WLyCTXb9eEYOdEaCpEaIUFRCw3xK2+sRLnsejP40Jhglz1kulCdsoaCy+sLtvbJyBIau
 qa3m3sUQ7HOJU/GSeeHYI6C0MMTatTjGipy+B8ZV0PdUR2pezSjKw69sa0+tSmXFdxIi
 8cQtzNVwJdhTPhaQtzSZVv/ze0Nos83trTXJS9hF6kvhUacQfkgJQhKMQAIfgGVHrtjC
 NpeA==
X-Gm-Message-State: AGi0PuYwfObmUk3XDKShz2GLUfYz0Reg4Q5Mtbkvw6MKPiDuPaVqUpmS
 zmlCbrM7Kknu6J9RXMDe4Q/taPZdtZR/2PGOWwj/sQ==
X-Google-Smtp-Source: APiQypLEdn8xTZKTZv9gRqG5Fj19mVLGqJN/fnq7VfXeiz5gV6tiXoLVzH0IzsAvypZbVip6HiFZw00aj2c/+0a/9rE=
X-Received: by 2002:aca:c751:: with SMTP id x78mr3059673oif.163.1587474172245; 
 Tue, 21 Apr 2020 06:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200331133536.3328-1-linus.walleij@linaro.org>
 <CAFEAcA9Gep1HN+7WJHencp9g2uUBLhagxdgjHf-16AOdP5oOjg@mail.gmail.com>
 <87v9luwgc6.fsf@mid.deneb.enyo.de>
 <CAFEAcA-No3Z95+UQJZWTxDesd-z_Y5XnyHs6NMpzDo3RVOHQ4w@mail.gmail.com>
 <FA73C1DA-B07F-43D5-A9A8-FBC0BAE400CA@dilger.ca>
In-Reply-To: <FA73C1DA-B07F-43D5-A9A8-FBC0BAE400CA@dilger.ca>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Apr 2020 14:02:39 +0100
Message-ID: <CAFEAcA9kktJd8EJ1VCp4a0XikPS9mxmag2GFv0NvwobubQLABw@mail.gmail.com>
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
To: Andreas Dilger <adilger@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Theodore Ts'o <tytso@mit.edu>, Linux API <linux-api@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Florian Weimer <fw@deneb.enyo.de>,
 Andy Lutomirski <luto@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Apr 2020 at 00:51, Andreas Dilger <adilger@dilger.ca> wrote:
> Another question I had here is whether the filesystem needs to provide
> 32-bit values for other syscalls, such as stat() and statfs()?  For
> ext4, stat() is not going to return a 64-bit inode number, but other
> filesystems might (e.g. Lustre has a mode to do this).  Similarly,
> should statfs() scale up f_bsize until it can return a 32-bit f_blocks
> value?  We also had to do this ages ago for Lustre when 32-bit clients
> couldn't handle > 16TB filesystems, but that is a single disk today.
>
> Should that be added into F_SET_FILE_32BIT_FS also?

Interesting question. The directory-offset is the thing that's
got peoples' attention because it's what has actually been hit
in real-world situations, but other syscalls have the same
potential problem too. The closest I can think of to a 'general
rule' (in terms of what QEMU would like) would be "behave the
same way you would for a compat32 syscall if you had one, or
how you would behave on an actual 32-bit host".

thanks
-- PMM

