Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297C1C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:34:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC99F222F2
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 13:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mL9kNmlZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC99F222F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX3eH-00059c-RY
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 08:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iX3bm-0003MC-Fl
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iX3bk-0004Al-Lb
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:54 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:44292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iX3bk-0004A5-H9
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 08:31:52 -0500
Received: by mail-oi1-x233.google.com with SMTP id s71so18862986oih.11
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 05:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j94kPqL9zr1XVm95VWDprVduFHs3GpgzezLfnloFCAI=;
 b=mL9kNmlZrBdufOw+qSiFTkmfkqkUKmBUfj+He8oKIN5fO+8/qj4pFLD9CjzICSsVo8
 AtDfuGyHdNb2MnsIeFgrpTZsEPu7Cuyo57H8lJFasQXhHnATByEiBkXFCf+LEsqnPB8O
 A5IvOiQ8TBA8OzPpX5H5xbGUrZOr97NkXKtdrsjf7B36IarFHeXO21qQkWbT7L6h4ObL
 cEux7lbmMRbXM+DJfnSh1+kx6bUhz7feR3MnhKBQAscbiB1MJLcwm7dsxa3mKbHuzbvw
 OPTVkQANQ7Q+Pp+YAKvdxXOY75AM6g2ZzeFkCIsZVA9KLwQfkyy8rbK1XzeBiTyZS4ev
 KTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j94kPqL9zr1XVm95VWDprVduFHs3GpgzezLfnloFCAI=;
 b=sQARnol/r5lbEwMdUBtEgh7q1ZGZlq7Qkc/sGKp3ChQ1deQWLy9qlJCdOO6HiF3nLI
 sSqpW+IBwywStKRHTqtQdBGO8VgFiJQSb/fCayO7EB3eqwJSFTX6NYMbGz9AqEAAwJoq
 /7EWPy46Q5y4S08FelgGZogoqUUUPUW2hQM1kECAvoi9I5mVcMPNFFFCj2ry5JMiBAz7
 fTLB+ntswiiXh8aNFs/TJabiRSQaL86gG7bdusU9HKEGcn5oHzMBNU1vDPyvDQxFNkgi
 o/DGfLfdx/eKLBzMy4K+Yxn/w56OeySDBuN5N2CDoAAIuzoQk06FiA5INVM0gaW2Nh7z
 wXAg==
X-Gm-Message-State: APjAAAVHyChj6XlM3YkuTEFW8ci7R1x6rVliyr5SVD/UzOGHw49QRmoU
 Qs5TO3iNjdvuu2NyKVjkY2FXyTyLOQPNc3j+1ly8FA==
X-Google-Smtp-Source: APXvYqyWXZxc+CQC9UhUqt/G96XCk1QllkI+uvSAG+IxHNK/TI33rkB7yR+0Q1+j6PVrCXWWN4GX3vDdFn5eQo2+l/Y=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr4146436oij.163.1574170310742; 
 Tue, 19 Nov 2019 05:31:50 -0800 (PST)
MIME-Version: 1.0
References: <20191119090037.21686-1-armbru@redhat.com>
In-Reply-To: <20191119090037.21686-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2019 13:31:39 +0000
Message-ID: <CAFEAcA-eY+61O4W=Sn0o9CSeszBn=LU=WHNvK8h_w3xtDWzp7Q@mail.gmail.com>
Subject: Re: [PULL 0/1] Monitor patches for 2019-11-19
To: Markus Armbruster <armbru@redhat.com>
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
Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 Nov 2019 at 09:05, Markus Armbruster <armbru@redhat.com> wrote:
>
> I'd like to propose this bug fix for -rc2.  Certain usage of QMP can
> leave the monitor permanently wedged (depends on event timing).
> Libvirt does not use it this way as far as I know.  I understand it
> affects other applications.  It's not a a regression in 4.2.
>
> If it's too late for fixing it in 4.2, we'll punt to 5.0 with cc:
> qemu-stable.
>
> The following changes since commit a5c2a235103ab366ad5318636ec138e52c6dcfa4:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-11-18 17:06:17 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2019-11-19
>
> for you to fetch changes up to 2895aaa139b3f916b3650ca516b35dceb9c0d4c4:
>
>   monitor/qmp: resume monitor when clearing its queue (2019-11-19 08:21:47 +0100)
>
> ----------------------------------------------------------------
> Monitor patches for 2019-11-19
>
> ----------------------------------------------------------------
> Wolfgang Bumiller (1):
>       monitor/qmp: resume monitor when clearing its queue


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

