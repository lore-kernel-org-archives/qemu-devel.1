Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8427FC31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 08:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4253020823
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 08:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5LhEUSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4253020823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35894 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdW72-0007iL-Ie
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 04:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46261)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mrolnik@gmail.com>) id 1hdW6X-0007Ft-PL
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:38:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1hdW6V-0003M9-Te
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:38:05 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:38668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hdW6V-0003JC-LO
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 04:38:03 -0400
Received: by mail-qt1-x843.google.com with SMTP id n11so18855404qtl.5
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2019 01:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dyto8hJqialVe8+3dHcBiO14d5kmt4Tfd9DSEWNxVfI=;
 b=M5LhEUSM/Io6xv8f7Bi30O+H+x9HL6Hx30mHCakwQa5Sjozub7oRUZsDJjTDkrKYPh
 QS3NQQI2WJrByr+WPzaJAM0jxVRgyM5KQrxnlVHkyP/oibzjewapK0KW/S6VGBwPPpb4
 ejEdJiHfonNL8C7c7w7cGx3Nr2joju+EO7N/kUi0UiuoJ72bCVHxMyCZY/2OzPJbNubH
 Wa69bXUgUYHecqSLbQcgr/ulmJTDzXhp457P1Ho4/1f7LUfzGTHk8ZA+OCezEaG7v/jY
 J4JeaDpitn6EJVpa1LRp6un2TF2EqglArcmhX1nRsoy+l3deuK7NFPKbz0ofE0QTZXlI
 W4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dyto8hJqialVe8+3dHcBiO14d5kmt4Tfd9DSEWNxVfI=;
 b=V1p9kWOpmZhi/rC/q9jTWWMVFI4LJtcvFt/ozDRnskSazWqi4BBh1WIFKO3YxxE/4W
 wlm4AvNbp7hoxfFctSJMYl3wVI/3/8emis5JVOXorQmzFK2M0ke7F18M+5MPj2yDazvM
 wXz3Hcp6CnrvzMdQPnSiRfrxaydPZZsrAoqXJZgO++zPRpz5EIDjQA/Hu1Jok/AvwDYM
 lLaYhZV91VYez+KtYYObq1epySxmKzZDg/qODWsPoKZIYXeTe/EYYIGCUOM4f4ngu8WM
 GZoDukKXIFzBBnIGOTkCx1Y9QdMvT/53X3xyw1nnf4g4GI+G7DnSI3ra3Z7+foKjq3X1
 yBPQ==
X-Gm-Message-State: APjAAAVScI9G6qqijJZKjMx07OI2NsbmFPDyDImEGLVVn/W2ZFqUVwbl
 WvBj5NIyzJJ2rwAdh//n/0HsOrtkbODE908woYszuk7EVm4=
X-Google-Smtp-Source: APXvYqzFj1DBzJRfka6ZG/w8pY/8BVzU27qNi0LBEctEvDxusQPntF1C2NbSEqUqN7wXdZsU3L9FRSj8fdOXj7WK574=
X-Received: by 2002:a0c:d610:: with SMTP id c16mr32495658qvj.22.1560933481943; 
 Wed, 19 Jun 2019 01:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190614131724.33928-1-mrolnik@gmail.com>
 <156052208061.13573.1709468080912187030@ce79690b2cb9>
In-Reply-To: <156052208061.13573.1709468080912187030@ce79690b2cb9>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Wed, 19 Jun 2019 11:37:25 +0300
Message-ID: <CAK4993hZjrL+6kQNxX=hsDXU0GB6AZ5UP1XeXmNq=dagxckdRw@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v22 0/7] QEMU AVR 8 bit cores
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

should I rebase and resend or these ones are still good?

Regards,
Michael

On Fri, Jun 14, 2019 at 5:21 PM <no-reply@patchew.org> wrote:

> Patchew URL:
> https://patchew.org/QEMU/20190614131724.33928-1-mrolnik@gmail.com/
>
>
>
> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:
>
> Subject: [Qemu-devel] [PATCH v22 0/7] QEMU AVR 8 bit cores
> Type: series
> Message-id: 20190614131724.33928-1-mrolnik@gmail.com
>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
>
> From https://github.com/patchew-project/qemu
>  * [new tag]               patchew/
> 20190614131724.33928-1-mrolnik@gmail.com -> patchew/
> 20190614131724.33928-1-mrolnik@gmail.com
> Switched to a new branch 'test'
> 9105e1c184 target/avr: Register AVR support with the rest of QEMU, the
> build system, and the MAINTAINERS file
> d41d59c5c8 target/avr: Add example board configuration
> 23be494cfe target/avr: Add limited support for USART and 16 bit timer
> peripherals
> 016f124f62 target/avr: Add instruction translation
> c32d5b797f target/avr: Add instruction decoding
> 50f51117b0 target/avr: Add instruction helpers
> cb3eb05bc2 target/avr: Add outward facing interfaces and core CPU logic
>
> === OUTPUT BEGIN ===
> 1/7 Checking commit cb3eb05bc2bb (target/avr: Add outward facing
> interfaces and core CPU logic)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #17:
> new file mode 100644
>
> total: 0 errors, 1 warnings, 1176 lines checked
>
> Patch 1/7 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 2/7 Checking commit 50f51117b021 (target/avr: Add instruction helpers)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #16:
> new file mode 100644
>
> total: 0 errors, 1 warnings, 383 lines checked
>
> Patch 2/7 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 3/7 Checking commit c32d5b797fcb (target/avr: Add instruction decoding)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #15:
> new file mode 100644
>
> total: 0 errors, 1 warnings, 175 lines checked
>
> Patch 3/7 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 4/7 Checking commit 016f124f62c8 (target/avr: Add instruction translation)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #14:
> new file mode 100644
>
> ERROR: line over 90 characters
> #56: FILE: target/avr/translate.c:38:
> + *  This is for
> https://github.com/seharris/qemu-avr-tests/tree/master/instruction-tests
> tests
>
> total: 1 errors, 1 warnings, 2886 lines checked
>
> Patch 4/7 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>
> 5/7 Checking commit 23be494cfe1b (target/avr: Add limited support for
> USART and 16 bit timer peripherals)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #37:
> new file mode 100644
>
> total: 0 errors, 1 warnings, 1127 lines checked
>
> Patch 5/7 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 6/7 Checking commit d41d59c5c884 (target/avr: Add example board
> configuration)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #26:
> new file mode 100644
>
> total: 0 errors, 1 warnings, 229 lines checked
>
> Patch 6/7 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 7/7 Checking commit 9105e1c184b3 (target/avr: Register AVR support with
> the rest of QEMU, the build system, and the MAINTAINERS file)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #66:
> new file mode 100644
>
> total: 0 errors, 1 warnings, 116 lines checked
>
> Patch 7/7 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> === OUTPUT END ===
>
> Test command exited with code: 1
>
>
> The full log is available at
>
> http://patchew.org/logs/20190614131724.33928-1-mrolnik@gmail.com/testing.checkpatch/?type=message
> .
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com



-- 
Best Regards,
Michael Rolnik
