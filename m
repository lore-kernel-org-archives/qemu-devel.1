Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E996CC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B63DA20873
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 13:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWqUe4CK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63DA20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoTPy-000487-0L
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 09:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43860)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hoTPo-0003g8-Oh
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hoTPm-00054i-Gs
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:59:16 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44788)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hoTPk-00052N-Oa
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 09:59:13 -0400
Received: by mail-ot1-x342.google.com with SMTP id b7so32762406otl.11
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=j9HhTrG5QPT7dZxLaelauPAelgB4nRRfcwGYk0bDb80=;
 b=lWqUe4CKqbM+E92ByDmNgtOhst4YgUuvqIN2BuDtg6r7RLTSl8s3asWYlSwpmEj09G
 qu1CDixFd9vLK1hhE8cKRjVyL8MqNFbRLpNR0Hd+9KxY4Vk904C5rDF6PqJSrgtcUkeO
 hb6XXAiXh/Eq8w2cjsZ375G/KyKgdtLK/VTotWfsB6/KilwUqqueBxXsu+dTaQvkbHeW
 SgS82+Y+d0mA678JfSB/1MdPRbQUKzZr1qRwf+C2RBiJK+VBdtwFY4Ie3Su3uBZMYBS9
 oASjj6jMUQ62BdopB6kvI7nXT64g9AhSJc47ZpFVhVC+asxn0wYZs4TnUMMNMb9ElkcR
 8rWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=j9HhTrG5QPT7dZxLaelauPAelgB4nRRfcwGYk0bDb80=;
 b=gt7e/ubHwc2D0aiA+Vw2W2wtNxYR50wuI14TKISPBT6ziMws8n0GMdEOM/RKA9MfEO
 5a16jeNXYeT8H0MR9AB9wKRKWEtjuLooa5w9Kg8NXHjPWbfNNA7cT9Tdw0Y25wuXKlb9
 1b0RLQXVkDYI4ndw4aD93hpOCS4ludxzHk+AnQ7TZhrTadfJbLfw45iz21bdygPPXnMD
 sRGIc7Sh/CLXSzZG76p62pALeEBNAgzUT1GYnZM4YYBpiGdwSKeSV8uXwkpVkVBF3oNg
 c0QxeQ9yXcnYWgGmKXpgNg8uvjXXdIkrxNCh00m5Mmv4GUG6x9H7bFX7BES6Zsb83+vv
 fdhQ==
X-Gm-Message-State: APjAAAVAO4ihUy3w3lEWqDWy4f4g3o1QlNKJxjXjcL6RixPx9kVCloVH
 kB8sSKonjkOpGgfTd/4aCSVjGx36JkRHQmI1ItS4Yw==
X-Google-Smtp-Source: APXvYqzn6yO8KHGw5f7wQDFMp//f4OQltNsYZqRxxbI0kg3iAxO1fCp0ydFrh2ItoMPkg8ntwTLs2uRkwey/fSsZOxA=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr37015651otj.97.1563544749701; 
 Fri, 19 Jul 2019 06:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190719132549.14726-1-berrange@redhat.com>
In-Reply-To: <20190719132549.14726-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jul 2019 14:58:58 +0100
Message-ID: <CAFEAcA98JkRnYc6Znxx9qwh8KVXVOkWjX1-u0d=PrrJgMSn5rA@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PULL 0/5] Misc next patches
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

On Fri, 19 Jul 2019 at 14:26, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit 0274f45bdef73283f2c213610f11d4e5dcba43=
b6:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-4.1-p=
ull-request' into staging (2019-07-19 09:44:43 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/berrange/qemu tags/misc-next-pull-request
>
> for you to fetch changes up to b7cbb8741b40b7cd4de9ad6bdb69baae4d6dadcf:
>
>   crypto: Fix LGPL information in the file headers (2019-07-19 14:21:25 +=
0100)
>
> ----------------------------------------------------------------
>
>  * Fixes crypto function signatures to be compatible with
>    both old and new versions of nettle
>  * Fixes deprecation warnings on new nettle
>  * Fixes GPL license header typos
>  * Documents security implications of monitor usage
>  * Optimize linking of capstone to avoid it in tools
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

