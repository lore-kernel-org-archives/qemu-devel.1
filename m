Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A52C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:59:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 900FD204EA
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 15:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ejsavaZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900FD204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrO61-0003KD-Pm
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 11:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrO58-0002Cw-Td
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:58:30 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrO57-0007OC-92
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 11:58:30 -0400
Received: by mail-ot1-x343.google.com with SMTP id h1so4824498otq.12
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 08:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ckKTxmUcETX8d+mfOYh4v+HrbMunSNWEFf2zmvYQePU=;
 b=ejsavaZ5i9ZsSh1kn/1AG/8/UyQu+vGNRjxwMixPXPzxPC5uQInbKZVYvb82wvmKGP
 /F2BVRJtzP6uWpPqmNmNJAG0vXgumY9L8zT83FiShnWv9W2QZ8lXG6evNh0Iti3c1BiP
 OMqCbAwfCnh89zPt0OKsSi5sjxQjqFPZfwnqSVPa6QP47s3HetTpqXLVNfEKrSvdkY8x
 GbubmoiCdBxBAX6aHEaPgBTiXpuXssjlyqKUja5bH3s7pF7T6oNfndgGsi7d0KoF+OKN
 Cy638T9WwaNMaYc5epqOZYxwB4g9SH0XLhVrNPTQUGo8iUHjeheFSQCeCpnZM3r/pcs9
 +/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ckKTxmUcETX8d+mfOYh4v+HrbMunSNWEFf2zmvYQePU=;
 b=BglT+rqr/tWjNRbhSizSl/SybN3xMMMPBzR10VtRqGTBxkOETpFR7L5Y22brDeNVYf
 YBC2q+G3+OPih/9T6ZS3hLeQPSZaJGqBvQYvCX7u4ktvQyQSBA+0yHQHS0EVXfQzIkd5
 psFw86Pk1dMriDHLYsxnZLr5pPMtMMgwF9B9Fb4ysPlAuugkFK3CwQrqfDCTq9YTXwLy
 trF42JT4qVHbdAD87oZZHpxZ1lZ2A0TMFyebhTENXhbL/wBt63U/E/WXcU4RRu5sV3Cw
 /xQpfW3xxcwttgIq6MU+qXIH2LrR+Utoe70tQl7KNMfxiWjH81cgG9ss+RCmFbFFosXV
 3qkw==
X-Gm-Message-State: AOAM532653dkl0tKTQMw7b9qRJsk5GC7L2EaNVnd/gV0qei+k66CPgnK
 HaCNKTNF0RPcjZ7tKLAMN864VP441+03jftbuN5Vhw==
X-Google-Smtp-Source: ABdhPJy1UE8wxzXKRcr40Q2hAjYRqpGWSZbMe7RnmI8ZKHrNTfb7pMld9scA9l9rW9LzzPcGA3SynE6Km+yPXwh1wuw=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr23769839oto.135.1593791907938; 
 Fri, 03 Jul 2020 08:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200624081349.121791-1-mreitz@redhat.com>
 <fd4e80a9-c7b1-08d0-0ae6-cf74946d6c5b@redhat.com>
 <CAFEAcA_d81NP1iu8kNSypou-rd7aVPznix6VOEoDTog=LX7aLg@mail.gmail.com>
 <7f84efb1-86e2-2417-af70-45f80b92e6fe@redhat.com>
In-Reply-To: <7f84efb1-86e2-2417-af70-45f80b92e6fe@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 16:58:15 +0100
Message-ID: <CAFEAcA8D=9786w3WnMEYRkU=1NzBOvZ6NhH=9XxXzw354mGHqA@mail.gmail.com>
Subject: Re: [PULL v2 0/2] Block patches
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jul 2020 at 12:14, Max Reitz <mreitz@redhat.com> wrote:
>
> On 03.07.20 12:47, Peter Maydell wrote:
> > On Fri, 3 Jul 2020 at 10:52, Max Reitz <mreitz@redhat.com> wrote:
> >>
> >> On 24.06.20 10:13, Max Reitz wrote:
> >>> The following changes since commit d88d5a3806d78dcfca648c62dae9d88d3e=
803bd2:
> >>>
> >>>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/renesas-hw=
-20200622' into staging (2020-06-23 13:55:52 +0100)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>   https://github.com/XanClic/qemu.git tags/pull-block-2020-06-24
> >>>
> >>> for you to fetch changes up to 24b861c0386a17ea31eb824310c21118fb7be8=
83:
> >>>
> >>>   iotests: don't test qcow2.py inside 291 (2020-06-24 10:00:04 +0200)
> >>>
> >>> ----------------------------------------------------------------
> >>> Block patches:
> >>> - Two iotest fixes
> >>>
> >>> ----------------------------------------------------------------
> >>> This is v2, where I dropped Maxim=E2=80=99s LUKS keyslot amendment se=
ries and my
> >>> iotest patches, because both caused iotest failures on some test
> >>> machines.
> >>
> >> Ping?
> >>
> >> Or should I just send another pull request that includes Maxim=E2=80=
=99s
> >> original series to supersede this one altogether?
> >
> > Sorry, your resend just fell out of my to-process queue for some
> > reason; I can put it back in the list to process.
>
> That=E2=80=99d be great, thanks!


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

