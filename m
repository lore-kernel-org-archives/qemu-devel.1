Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034A0C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:58:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB77205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB77205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49072 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO2Tx-0002Gs-0N
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:58:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hO2TA-0001xj-FP
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1hO2T9-0005vx-A2
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:57:28 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1hO2T9-0005v9-5o
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:57:27 -0400
Received: by mail-ot1-f65.google.com with SMTP id l17so5889349otq.1
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 08:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=KnR6kucZkhdGzgZriGzmIkM3on0Tbt/B7yb/MYjQ9as=;
	b=mDZ4N21du9xNYTdSXb6Vbh9yz1JoP2ER9CG5NvnMb5H2GCAkOnjfSxm2Aqf6wM7s6A
	3DPHSl6973lDHwCm15wrSqIgja2aHG3tzx4eCpAhYBo7CdstXKnLiz0vPTXZtyM3exBI
	KGeIML8qnKtB6tvegLcjl5HPxWc0tsNdiTr/NIS0El/aVFBwJL2CZF25O83ZeJWOBcY8
	UiUd9+dxk/qeiSowjJRkjqXgjc0Ge+ZUc3btCaqEEcNCr/rUv8vDtwDsdT6vQUNlvACT
	T1onq18SAvKt3PH90j0Pt4eCMoxSSTw/xGX5veoT2J24/l881vTfuMXw7xOLSX4BIvVm
	1MsQ==
X-Gm-Message-State: APjAAAVP6bkkHkaGVTgq4ZfsJOdMOxZJlqRYyEe5aaTq3lk9MpMblHmb
	tWuBijIlnMOOo7APOYI3RIM0sPbvUGIcZ4iKqJOCiA==
X-Google-Smtp-Source: APXvYqxFZednQU6Ymo0fzeTVrenrIJs8YCYpwF+ajbmHcFDc0U5AdfjPNRaMAuF17F0e0BWKYzwfrbthADnCJPbGmN0=
X-Received: by 2002:a9d:e95:: with SMTP id 21mr7652832otj.145.1557244645054;
	Tue, 07 May 2019 08:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190507143727.15640-1-eblake@redhat.com>
In-Reply-To: <20190507143727.15640-1-eblake@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 May 2019 17:57:13 +0200
Message-ID: <CAMxuvax99S82UVZggPGj+R22qJp3MFZ0_YseTQ5g9=5Mz33YYQ@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.210.65
Subject: Re: [Qemu-devel] [slirp PATCH] maint: Add .gitignore
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, May 7, 2019 at 4:37 PM Eric Blake <eblake@redhat.com> wrote:
>
> Ignore build artifacts during an in-tree build.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>
> Sadly, libslirp includes no README (yet), and
> https://gitlab.freedesktop.org/slirp (mentioned in qemu commit
> 7c47bdd8) does not seem to call out any slirp-specific mailing list
> which should be cc'd for this patch.  I'd recommend that libslirp add
> some documentation (both to a README file present in a git checkout,
> and to the project web page), to make it friendlier to drive-by
> emailed patch contributions.

I started one, see:
https://gitlab.freedesktop.org/slirp/libslirp/merge_requests/7

thanks

>
>  .gitignore | 4 ++++
>  1 file changed, 4 insertions(+)
>  create mode 100644 .gitignore
>
> diff --git a/.gitignore b/.gitignore
> new file mode 100644
> index 0000000..daded16
> --- /dev/null
> +++ b/.gitignore
> @@ -0,0 +1,4 @@
> +*.a
> +*.d
> +*.o
> +/src/libslirp-version.h
> --
> 2.20.1
>

