Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C98C3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 07:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E531B206E0
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 07:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+g6K5Dc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E531B206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1QYY-0001Fz-5c
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 03:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36525)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i1QVi-0000NW-9d
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 03:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i1QVh-0007mN-3a
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 03:30:53 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i1QVg-0007ji-Rm
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 03:30:53 -0400
Received: by mail-wr1-x444.google.com with SMTP id b16so10525210wrq.9
 for <qemu-devel@nongnu.org>; Sat, 24 Aug 2019 00:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Q7dE7xRWtNonIg7MYGdizMevWkr3L0SG5YEIrbJTAy0=;
 b=h+g6K5DcdRlYKfmxnQCmjESeeiMRJ3Y+LG4TFVgYCRJPyFBM/h5lW9iRQ4MJqfp0x9
 Hj55wCmOovdJV3MmcEgfyNIMjg3+6jxBxCYM3vyrZjneFfvhgMUkLhe/trQjNES8Xa8q
 4CZcD4ntkl2ic2Jift1RgGMcoQmfv0BbEEkbSImAyGFfbPmeI2v4ZiEH/S1sf6zwhxTP
 zbQA2ibWt8mSVaofWlDpDljWpMO5v6v5wNzQMEuj6DFkIa6/iY7Zh/QqmBvfbd+OZ7fq
 5gJ32b39IVnzCCDhgDtlhodQ6/QM524Y6Gr+fytrGOjUONlIprhlrn1TTXwgK2+tarM3
 t39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Q7dE7xRWtNonIg7MYGdizMevWkr3L0SG5YEIrbJTAy0=;
 b=uavKyx16NNx5Tph3c6Cm3ltwZ3KRkrM5eXaJSOZWQRJDF6IoLx10HB3LX2yAOI+coW
 oODYmqQxibrAw9uY/6iUOs8aRqKS/ocIXqE3Mej+tVAYGQBRX3nx87Vc/aVJB6Gw1/7W
 8XhLt51kK6vQX77eDhbHSMa48edmNCmnwVOCKyT/0eyXNFSCp7HsOzikbyZ+Y1o7ItC8
 esreD8mmu7gCD/uOLdsf+ZEBVp/o8zXhA24oJTJwJtWBqUaPrnI5OH37VTfyfWgx3OQz
 IwDyhzWqvaTRSS0gXu/I/ePDGXCRhyUkOIzR+j2kM7PMyNi2SDJnbeFa31JaYoDWWTyA
 tzwQ==
X-Gm-Message-State: APjAAAWov1OZ383csxPujzIYWFjijf7Wq5xZocCY830ieIbNW2EiaZhI
 guKWJXT707LnEnF/XJrZU4+vSQ==
X-Google-Smtp-Source: APXvYqyy+PyOpBNQD+RuJzprbao603f/OoeLpaV4QmD4xAW+NZtuI0J76jnabUn8moUUIoiEgfC58g==
X-Received: by 2002:adf:f646:: with SMTP id x6mr10151004wrp.18.1566631851256; 
 Sat, 24 Aug 2019 00:30:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b15sm4399956wrt.77.2019.08.24.00.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Aug 2019 00:30:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CAEA01FF87;
 Sat, 24 Aug 2019 08:30:49 +0100 (BST)
References: <20190822230916.576-1-philmd@redhat.com>
 <874l2876kx.fsf@dusky.pond.sub.org>
 <CAL1e-=hvVp4i=s_Wr0iKy5UO7kH6xw3QR0Ms4_v_tobJSM2wRA@mail.gmail.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
In-reply-to: <CAL1e-=hvVp4i=s_Wr0iKy5UO7kH6xw3QR0Ms4_v_tobJSM2wRA@mail.gmail.com>
Date: Sat, 24 Aug 2019 08:30:49 +0100
Message-ID: <87a7bz2f6e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 0/3] mailmap: Clean up
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
Cc: qemu-trivial@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <aleksandar.m.mail@gmail.com> writes:

> 23.08.2019. 08.13, "Markus Armbruster" <armbru@redhat.com> =D1=98=D0=B5 =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>
>> > Trivial cleanup of .mailmap to have a nice 'git shortlog' output.
>> >
>> > Philippe Mathieu-Daud=C3=A9 (3):
>> >   mailmap: Reorder by sections
>> >   mailmap: Update philmd email address
>> >   mailmap: Add many entries to improve 'git shortlog' statistics
>> >
>> >  .mailmap | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++----
>> >  1 file changed, 115 insertions(+), 8 deletions(-)
>>
>> Series
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>
>> However, it increases the difference to contrib/gitdm/aliases.
>
> Alex' initial gitdm effort, as I understood it, was not meant to cover all
> history from 2007 or so, but just to give reasonable statistics for 2018
> (amd future years).
>
> In that light, .mailmap and gitdm aliases do not need to be equivalent.
>
> But perhaps Alex would now want gitdm to be used for all QEMU history? Is
> this desirable?

It would be of interest historically but not something I'd want to spend
a lot of time adding code churn for.

>
> Aleksandar
>
>> I'm just
>> as guilty; my recent "[PATCH 2/2] contrib/gitdm: Add armbru@pond.sub.org
>> to group-map-redhat" updates only that. and not .mailmap.
>>
>> Perhaps we want to keep the two in sync manually.  We should then add
>> suitable comments to each file.
>>
>> Could we instead teach gitdm to use .mailmap, and ditch
>> contrib/gitdm/aliases?
>>
>> aliases' format is documented in gitdm's README.  Each line maps a
>> non-canonical e-mail address to a canonical one.
>>
>> .mailmap's format is documented in git-shortlog(1).  It can do a bit
>> more.  Even the common part differs: it has two addresses in different
>> order *boggle*.
>>


--
Alex Benn=C3=A9e

