Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA73FC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F3B520644
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0UugzmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3B520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxXav-0002Nu-OM
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 10:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37204)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hxXa3-0001wh-92
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hxXZy-0008Nz-Ag
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:15:19 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hxXZy-0008NP-3c
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:15:14 -0400
Received: by mail-wm1-x342.google.com with SMTP id 10so1679400wmp.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 07:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=kw416TQGY0Y0XTBWnDFVgiZEwifZJU0omK8UjEPXH/M=;
 b=U0UugzmVvZyEQUDNmQQdnolJWbgzgzoQlcpm9qQiTdHLL/AQ0iqkt/JwvPBuP2Dp6r
 GYAH2uzAGzuLdEAD0AAYGG8O1vQ4W0z6ZCOEKb/o4bKYPp2/bTwQwa9A5ibdEOT9HUlG
 ds6fHcl9b+vgF798VELvGDjHMqx4FKrz23S/DhH7Z+xp8VfdpekZH7W3ojpXZiInBPok
 tlu/W7V0SRnP8zLHZWyKLci8En1oZht4Qak4XT4ZLZzWpRv5jSPgQrTPTsj/9iP1XVxu
 PXE1s7PgpzVKzWX8q+PnxGAtkEHN9CN3g5oFrpGPHC0pjNYzFUiDNpzORtWrdb/EL6YX
 +4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=kw416TQGY0Y0XTBWnDFVgiZEwifZJU0omK8UjEPXH/M=;
 b=oasAa65jHV79Nx87uWN/E14UyO135Tb8fdRAUc0srGqIevBSAyUETxIXjs76wte7/k
 wb+7HXq0MKbtEE8ZghZfxXtV43yOaSMY4kWyKnX7XFMMfkmExEi+v8PPD8r9SKpB+mIm
 PBX+Gn7aP03DUWcPPOYkpsRS2Y3+6W1A6itZTe3WYMvqMJ9tfjjfie0uXtbMRgjGDuyS
 4oB9O/fQ6XSid87wFCHOJbdUbumHi/U81LDYogMzzNDv/FonCz2Z6U8+nXA1ycn1iZcZ
 Qsld1s08f/qmir68TuXogbrwn5YF2T4r19jhk6rj6ZJR0a/RwWVoj/YXoDryLNz2Q+m7
 4HDA==
X-Gm-Message-State: APjAAAVC+1kkt53jzQRZkRoKGtnOeM5M3t7SU1I5A6sCqSh6vVKd3UHP
 EGmcZp6K3WIpemjaqh17N6d7mBHoDf0=
X-Google-Smtp-Source: APXvYqzhZhIjpYKvVLR3mlghT7wYhL18BWnNRLINbiXewy1GQrcwJQpz4CSpIRF0ENjeHeYJQ5XPIg==
X-Received: by 2002:a1c:3945:: with SMTP id g66mr3269913wma.139.1565705712193; 
 Tue, 13 Aug 2019 07:15:12 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x20sm237160515wrg.10.2019.08.13.07.15.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 13 Aug 2019 07:15:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E9ABD1FF87;
 Tue, 13 Aug 2019 15:15:10 +0100 (BST)
References: <20190813124946.25322-1-alex.bennee@linaro.org>
 <87wofh5fs7.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
In-reply-to: <87wofh5fs7.fsf@dusky.pond.sub.org>
Date: Tue, 13 Aug 2019 15:15:10 +0100
Message-ID: <87zhkdm9sh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 00/13] softfloat updates (include tweaks,
 rm LIT64)
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Hi,
>>
>> Another iteration of updates for softfloat. Instead of moving the
>> LIT64() macro from one file to another we convert the uses to the
>> stdint.h macro. I did eliminate one of the uses by converting the
>> squash_input_denormal functions to the new style code. However as you
>> can see with the follow-up patch it bloated the code a little. I'd
>> like to convert the x80 and 128bit FP functions to the new style but
>> the challenge is seeing how we can get greater re-use of the common
>> functions without bloating the generated code. However if we can do
>> that we should eliminate a class of bugs in the current code.
>>
>> There are a bunch of minor checkpatch complaints as all touched lines
>> haven't been fully converted to the proper brace style but I avoided
>> do that to make the patch more readable.
>>
>> The following patches need review:
>>    01 - fpu replace LIT64 usage with UINT64_C for special
>>    02 - fpu convert float 16 32 64 _squash_denormal to ne
>>    03 - fpu optimise float 16 32 64 _squash_denormal HACK
>>    04 - fpu use min max values from stdint.h for integral
>>    05 - fpu replace LIT64 with UINT64_C macros
>>    06 - target m68k replace LIT64 with UINT64_C macros
>>    07 - fpu remove the LIT64 macro
>
> Richard had comments on PATCH 02+03.  Should I expect v4?

There will be....

> I'm asking because my '[PATCH v4 00/29] Tame a few "touch this,
> recompile the world" headers' is ready, and I want to post the pull
> request before it goes stale.  If this series is also ready, I can do
> both together.  Else, it'll needs a rebase onto mine (one conflict,
> resolving it necessitates a commit message update).

Go ahead - I'll fixup when I rebase.

--
Alex Benn=C3=A9e

