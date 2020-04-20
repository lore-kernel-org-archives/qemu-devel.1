Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1605EC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF1220857
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kyZwTKQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF1220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQbpv-0008Om-0S
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 15:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51828 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQboc-0007Gh-4V
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:10:47 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jQbob-0000eb-4K
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:10:45 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44833)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jQboa-0000aX-2X
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:10:44 -0400
Received: by mail-ot1-x342.google.com with SMTP id j4so9107687otr.11
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 12:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P8yPlcsiN05KrZRP9kREIzCaAYz3BNatIa+gv60TYdU=;
 b=kyZwTKQn93h3ojK+U8q5LYoyOvQ17xOAfaSxkyZOR1IOCu8y3Z9sedm01BuoGYCchi
 IFD/kuA+FN7AM07nt9IS0l438e5sfBnJ5l1iSh6f46OmYfinDBqT30Boh7mbLCb8X7Hp
 jf6AjPZFaZVQFRdGIb6r9c1uIbibr9qqku0GP+WwXxVjxcGv947Q64TkleoZqb4tLc0d
 2BZTIaJZCn82yJexWPlZteiQYPBjJPRpRQDEdjF4XUhDp7KmGSvY10asjOzcZuHYOrv8
 H3K+tg2CyOzZaV6t0UXHxhcKlInsokgjle/SNmhDnUpQcZmXxzIaUGj8ALnG0sLAg04K
 4Vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P8yPlcsiN05KrZRP9kREIzCaAYz3BNatIa+gv60TYdU=;
 b=Xz/YqiK/b81dN1P/xLzAxKU3oNWBYNU3QUXvM4V0wjSwk2hnv627FkrqoZrE0xOJlW
 d0lZY7BDvuIKo1GhG5D3q5Ct7+Mkk5wUKJA7YJHne+c8+FLtLl5qhpK9myHO2us/a7kP
 hn0U28F+u7Fbn+e0n+gNN9q6AsRroTLWvzcnzdYZjTfytccVd05KkxleCCblPc+h9FwA
 h2wRiH3ihtsbwfiSmAuaXfH1fxZtjOFZ6n3W00kK45Wx57ZVPPvbXvWI7P/n0LzKD3JE
 tJzp+WyCEHCFTVeKOe2LV6S4t2gM696aegvWEYwph1UwxawwVqdqYAvTGO5aMjGtmAMG
 NyeQ==
X-Gm-Message-State: AGi0PuY2xIR1asDQuQXFYFDkr1+hX7SO8RR0Fn0xaR/0GJbpY9EmGziU
 IL7hJNxsHukSFbLQVdYCJ6JojpgQ9A1Di9IwhJXFZQ==
X-Google-Smtp-Source: APiQypIyrnNSjvCb54M/GNT/zkuCEqvtyjk6Bhj20izMmdPjmn2hRjUlNCPGSOzJsle61QsWci46/YDLiREJ1AbUCDY=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr10254358otc.221.1587409841108; 
 Mon, 20 Apr 2020 12:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200420175309.75894-1-eblake@redhat.com>
In-Reply-To: <20200420175309.75894-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Apr 2020 20:10:29 +0100
Message-ID: <CAFEAcA8z_zQC5f2aD1w0ae=P-D3jHRwj_J3yijv2kwnqoYtKTA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix fcntl(F_SETFD) usage
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs1p.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Apr 2020 at 18:53, Eric Blake <eblake@redhat.com> wrote:
>
> As recently pointed out:
> https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg03133.html
> code that blindly calls fcntl(fd, F_SETFD, 1) rather than performing a
> read-modify-write when it intends to add FD_CLOEXEC is broken, in that
> it can inadvertently clear other bits.
>
> Thankfully, the culprits fixed in this series are unlikely to be
> clearing either FD_CLOFORK (if Linux ever follows Solaris' lead in
> adding that), or the new FD_32BIT_MODE being proposed (as the fds in
> question are unlikely to have that set) - but it is still better to
> write proper code than to set up a bad example prone to copy-and-paste
> propagation.  And as these usages are not new to 5.0, I don't see any
> reason against waiting until 5.1 to apply them.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

