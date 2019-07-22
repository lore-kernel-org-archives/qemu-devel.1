Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D2CC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF9D1214C6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 10:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="feWJ4X+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9D1214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpVqB-0006qg-UF
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 06:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38384)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpVq0-0006P7-HS
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:46:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpVpz-0002Ri-FB
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:46:36 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45299)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpVpz-0002IE-0D
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 06:46:35 -0400
Received: by mail-ot1-x341.google.com with SMTP id x21so1254383otq.12
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 03:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=C3GylwjMPbXXWaeokZi0EpklTiwTE2W7CbkOBYS3kmE=;
 b=feWJ4X+FC8LrLElVHadAI8SxGkZzAbApGvX6TV3pWdAld5r1j4vmMJbWfKLm9gFffk
 jk8JvL/xRYQ50mWGDqe1JGJcEsJEPclou+1sGgRvbaAbRWpXUJMS3GJE1Iya7IMo7VMk
 LWu0936LJ/2uzzj2n1vLbbIAASlRuXJEr/cd7z3cXjAsdiD9sklpyTskea17DoGFwPq8
 SziFNCzHP7GSsVtHFPN8ubyKO1m/uK3LkKIYnhwdrOzPvaDmLYHTEPUQkakkIyIIPrGG
 gulzBm8JDY1r5klj31G3y3NJctwytSP2cGHpSZFXC+IsjjjYYG/zmDiCzoFgErFsTyaQ
 1iDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=C3GylwjMPbXXWaeokZi0EpklTiwTE2W7CbkOBYS3kmE=;
 b=SfE5Vq068JfXzeHfBxs8ndTDQKc63IpKaqTOCu/DddlMhgKT3uJAp+V6SgFi+QH5NP
 WCXK33PhyqMXjrkWamH8rvKwCrlVd/IKYpAoWmglYKuXZEefzK3zfmhCJXjpIa9/H4Al
 togU2MCjGU6eTbgIdvNKBjltFFG88nF+2PjQaN+pQdm0llK2z3J5cMP6Cg1GLWRhfuCS
 9quTDWrdjA2uZn0v/mzBZbYGRcVnH6Go4dX3Ki6wDTlCyPnBM8S894Ie2ZYg+43f1+Mm
 GfgX9AjQodA5M/6k8WhQWy4HU3eEy4B2vDx1prLzJdDWSVhINTbZVpK4F/euuNXbfrhG
 XbCA==
X-Gm-Message-State: APjAAAWMBud+J0WnRrRl87XpxI3eIGcj580fKSFi/IJR+f8ejJl9vgAu
 w0u+Sxa4lkP9FLhzXQwzG8KrDAzbM/3IPV4fD7dpyvGnZTc=
X-Google-Smtp-Source: APXvYqzEb5OHciIWqzUpbXiT2C4o7tJ1HyB+uFY8voo7FugGkWgzksVMQcSZVDkRRpr/gv2miSSxwGt4y3cbSJ2Y7F4=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr44160126otr.232.1563792393047; 
 Mon, 22 Jul 2019 03:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190718131659.20783-1-peter.maydell@linaro.org>
In-Reply-To: <20190718131659.20783-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2019 11:46:22 +0100
Message-ID: <CAFEAcA83kpX0h_+17jKQ791jvz6+v0QrQuVoE_XZMnajWHcuyQ@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH for-4.1] configure: Clarify URL to source
 downloads
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
Cc: Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jul 2019 at 14:17, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> If configure detects that it's being run on a source tree which
> is missing git modules, it prints an error messages suggesting
> that the user downloads a correct source archive from the project
> website. However https://www.qemu.org/download/ is a link to a
> page with multiple tabs, with the default being the one telling
> users how to get binaries from their distro. Clarify the URL
> we print to include the #source anchor, so that the browser will
> go directly to the source-tarball instructions.
>
> Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Suggested-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'll put this in master via my target-arm.next tree, since
I'm doing a pullreq anyway today.

thanks
-- PMM

