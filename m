Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E0EC10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:50:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9EB7206FA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 14:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sRRQvXDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9EB7206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCldd-0006gF-TC
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 10:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jClcS-0004h2-Sy
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jClcR-0006Gd-Ih
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:49:00 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:43298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jClcR-0006F3-CO
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 10:48:59 -0400
Received: by mail-oi1-x233.google.com with SMTP id p125so9595274oif.10
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GWljFi9fnqqkpaxlrWeRu49izTGa7gsrABdhz6/dr5U=;
 b=sRRQvXDw75DYXrF+hNPO5Fw9/FzpwIHONkfejaxqV6Dr4+Jbh1+8FZ/qqKcwADOk1m
 ZHSMdv3wceYVp7f8cXf4VeIlatnhc0S9le8R0ALaKM5bM9Kq9m6GWiLEVNHgEa+hOx+r
 /T71rG9ySKH9EjTT3LYL43kBz557gIqgI2RtVOl3qVGJsijo94nANURFbuLQLjleuEmY
 zzRvtbUNP0ezFKuBAaEnWZiUkFohyi9C0jJW+b+GpNrEqyuGOZDytao7xdpuFXljwEDl
 f5Lp+4qPL16byK4T9HdgWEZtR4E65c6Aowb2+Yib1+Qifpgi0+it4u4zwCTyc4h4I0Fw
 9H1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GWljFi9fnqqkpaxlrWeRu49izTGa7gsrABdhz6/dr5U=;
 b=e8ammH1pm5lijUc/5i8IccBD2+r7l0ijaGMVOA301/iJWvnNcIRmEmLjV0VPoP6XuL
 wOCO4nMhQKpPD6PgYaUd/sI9Nxn6Q7Zf+fh3ghVNf8SAWIBSP7uoAQ+n9iiHnLHS7OhT
 iVXFHfTnWDszHhXRkedjrGkC56pSHBq7O+jn4Jpa+kIG96yTplAjZVou4sghMaCN17kf
 wI/z5ZYENV9+uNTlkxjk9cxFwiS8aqk9I77PhdgsdunmkDTD+xl51DzNcL0ByVOPExzA
 W+81GTa0SymM+GId6pcIf86Jf7kEs8qteGFK9t4wGusGL3MspIXSbWHuBuF1CxkTWL5O
 z5BA==
X-Gm-Message-State: ANhLgQ17n07wfNYQzCPqfg52i5seWcCw4tNhYYVTUV5Y7tA1zkVR4fFl
 8XZXIDZHcBCqfQofxyoyqVujwZXyh5sJ5J4HdEw1wg==
X-Google-Smtp-Source: ADFU+vv1dgMH+s/gxj5ZH1XLQ578Bub8QrpR+v2FcZg3hvPg9FnAeueRNrxsL8fX6TcZADGEaRojjBNxb/GguswKEeQ=
X-Received: by 2002:aca:c695:: with SMTP id w143mr7381170oif.98.1584110938055; 
 Fri, 13 Mar 2020 07:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200313103039.150133-1-dgilbert@redhat.com>
In-Reply-To: <20200313103039.150133-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2020 14:48:46 +0000
Message-ID: <CAFEAcA_smwdHY6rYR=hVOJ=6Jvyi0te9HmD6io_59D8sNOK-zg@mail.gmail.com>
Subject: Re: [PULL 0/5] migration queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::233
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
Cc: Juan Quintela <quintela@redhat.com>, Keqian Zhu <zhukeqian1@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 at 10:32, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit d4f7d56759f7c75270c13d5f3f5f736a9558929c:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200312' into staging (2020-03-12 17:34:34 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20200313a
>
> for you to fetch changes up to 19dd408a479cae3027ae9ff9ef3f509ad3e681e5:
>
>   migration: recognize COLO as part of activating process (2020-03-13 09:36:30 +0000)
>
> ----------------------------------------------------------------
> Migration pull 2020-03-13
>
> zstd build fix
> A new auto-converge parameter
> Some COLO improvements


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

