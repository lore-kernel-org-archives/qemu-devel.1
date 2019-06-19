Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80696C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 00:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7062080A
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 00:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KRPSBkqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7062080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34272 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdON8-0002DJ-IR
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 20:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43912)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jimw@sifive.com>) id 1hdOMJ-0001oS-J6
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:21:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jimw@sifive.com>) id 1hdOMI-0001oU-JS
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:21:51 -0400
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:45678)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jimw@sifive.com>) id 1hdOMI-0001nw-CL
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:21:50 -0400
Received: by mail-ua1-x944.google.com with SMTP id v18so7911227uad.12
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 17:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i/aRXB0UqpbB5SyeJdvXrKS2QoVbIOoKHmEwFLmZ3LE=;
 b=KRPSBkqNRxKQW554FPmWiB4edp4WvLB85SDEslS6LOYVlPLQ0qE2YX1PfLC6GhIoG7
 sX4nCE2uEXvngrngkxSszarmfyUM4oZ2oi6sNT3Bt9jRLONfgjjBixMWtNJEVLiAGtOk
 bc1nwFjeSwxDmqlj9cxtqeiKyZCvhTVSNBHYboT8OHW/oisr/2cqgbWEtk4oGbvinZnd
 2WN8nLfRANC5GRngOv9S1qVzMkBNqbVNURPm9FgGN6f87i6nqlj/KGkfBMVbzkk/+EaR
 vp7m2k5saX4Si9F0QC/MKzmxnLIKV45pCQFt0Z82xkfHjR++UfitoLR5fBaq2mROw4oh
 aXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i/aRXB0UqpbB5SyeJdvXrKS2QoVbIOoKHmEwFLmZ3LE=;
 b=pcvcakmANgVuAu2VMpTMbnje9MoeZF7FQKj2wtyuyWUIpSYWtGqAS4I2cz7CXjicbV
 3tnqXOJsAwkSShOTWk3NelTunfX/A308V9skxMxTyE70NzH2D0s/frlCBnI5mQ5gR93g
 fcLkZL29KPlp63aXXodX7XgdNp5UKpRPKRdtkKvLCrFRIQLWDLFcHYIqt6HwvPxKbadz
 zi9QWPSPl2EYs6pP5gu+TUHOQEl3HJ7LLDsDCHlut+AeQl2UwCyQjFp6A8mtYvY39ciG
 S6zVNaD99H4+yiP10h2tJAJiQc5skK/HyWOSKWQGjoCLoiGRr9IJcjFy8OQN790c/4s7
 6cIg==
X-Gm-Message-State: APjAAAU+/DVMqY3rAnY8ebjxkLshOyIWYn0Fu6WgTR10H8Q8HK2XMeGn
 MLrO9UnQVG7Ex0ihPiVGr2/j8R3Bb0Bs5e2OW/FHBHqcD6g=
X-Google-Smtp-Source: APXvYqz2gd4h5bm037/yIWxNxE1dQIA5AEXnIk4r59n7UazF6ZIXG0wWBHyV6swzEQnlxq31zQWgJ3rxmblzxvnxsbk=
X-Received: by 2002:a67:68d1:: with SMTP id
 d200mr42704862vsc.182.1560903709476; 
 Tue, 18 Jun 2019 17:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190618235313.13223-1-jimw@sifive.com>
 <156090295559.22612.10119919154946823431@ce79690b2cb9>
In-Reply-To: <156090295559.22612.10119919154946823431@ce79690b2cb9>
From: Jim Wilson <jimw@sifive.com>
Date: Tue, 18 Jun 2019 17:21:37 -0700
Message-ID: <CAFyWVab3UgZ0t-LovLeKR03DCzRUvEADTNZJy69=abOpiaOVZA@mail.gmail.com>
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::944
Subject: Re: [Qemu-devel] [PATCH] linux-user: Add strace support for statx.
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 18, 2019 at 5:09 PM <no-reply@patchew.org> wrote:
> === OUTPUT BEGIN ===
> ERROR: storage class should be at the beginning of the declaration
> #25: FILE: linux-user/strace.c:979:
> +UNUSED static struct flags statx_flags[] = {

It is complaining about UNUSED, which is a macro that expands to
attribute unused, but this is the exact same C syntax used in the rest
of the file.  I think this is a bug in the checkpatch script as this
looks like it should be allowed.  Or maybe there is an exception for
this one file?

Jim

