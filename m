Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3DBC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FD520838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 12:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NbHnEzFk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FD520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJFfW-0005PO-2J
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 08:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jJFeO-0004s6-PZ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jJFeN-0005e9-GR
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:05:48 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:33370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jJFeN-0005dA-Bo
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 08:05:47 -0400
Received: by mail-ot1-x329.google.com with SMTP id 22so21739393otf.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 05:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7ionw6sRKlJc47ARBqu+ga3ia7xQ/g0NaMKA/ePnw4M=;
 b=NbHnEzFkQWg2vfX7NI78gksx2UYwJFx0hGBNnF885f+SYyXRHHGuDEZBc+hQuDyEQE
 YmdJ0ifsdy8UVWd51Yk+MxHmof5uSX7dJ8FCJCOet7Ehp0FImd3ooOdLPoBc6Eke33G7
 TQzIjvSa3by2UmFuqOmFtMiHaivwk7hAAitpwkXti4UJZBDiR74uylIwX0zz3Jitm5+V
 SJgJGpDBXwBQ1m0R7iUWSHHvV/vWBczpprAtwxBB2tmZjfFNNR3xC4guCvbj9N4MvveO
 W2ngCykNNkTmK1zsQpJsg5yMgWvbw2/9Q5fBNcOjupyWWxhoOuaNJ234jqclPyIydsJQ
 oK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7ionw6sRKlJc47ARBqu+ga3ia7xQ/g0NaMKA/ePnw4M=;
 b=JIOnBSQQ6NfzMc/y1Zs3WNyDREwTsaIwhJr80FriIu8Kbj8qQj+AI34OYhSo3p+1SD
 VnQEgAC/l0gtQGUggu7IRp7nyMH4iPirVNmD8Z0nvPPxyJVF4IBXjBArFaAMCrc165jo
 cc6NnX1WW8Pr1kz1q3y9DxQictJayAMbOcuyySsR96yL2GChR9oXe1xxqAN6hHelTEbM
 dwOPfx+w8Vja8nQi/qVmvToX/GAxaB4I1oqKRR/yTD697rVQ7oWoKmqjecauF9sXt7yh
 XppDLyr6LQKqalZfSlJdAFdjb4ppjHQPINdzbUTzxbt+IFw0ScVOuLm20s23mjX4iSO3
 l7Aw==
X-Gm-Message-State: ANhLgQ0c8Qwfn6gHBWYgmC1U/l3XAA2161cmWFGk20SD3jAhlrFXlyka
 3c3D4LSiXpoqeoeCkqrcxlJR7QgMrXANpX2TsAAxrA==
X-Google-Smtp-Source: ADFU+vthDgq71s9dXVG3TuktHaKPX0Fv75Haq6b/CDyudMBrsf7OZSc+X2vb6zZ4ksLWzi3H3qhQ7DM5bmjMsn+jmdM=
X-Received: by 2002:a4a:d1a5:: with SMTP id z5mr13095478oor.63.1585656346170; 
 Tue, 31 Mar 2020 05:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <20200330134212.GO236854@redhat.com> <20200330143759.GD6139@linux.fritz.box>
 <c0a1dc94-c3f2-696e-743f-aa15ef995094@redhat.com>
 <20200331120220.GA7030@linux.fritz.box>
In-Reply-To: <20200331120220.GA7030@linux.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2020 13:05:34 +0100
Message-ID: <CAFEAcA_p1T4--Re5=-x=q=cCX-8YDAk_keS72NURe3T23j89sA@mail.gmail.com>
Subject: Re: deprecation of in-tree builds
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Mar 2020 at 13:02, Kevin Wolf <kwolf@redhat.com> wrote:
> Mainly because it allows me to start everything (most importantly: my
> editor, git and make) from the same directory.

You can use 'make -C build/whatever' to avoid having to change directory.
The odd one out here is configure, where you have to say
 (cd build/whatever && ../../configure ...)
I have occasionally wondered if we should add an equivalent to
make's -C option to configure, but AFAIX autoconf-configures don't
have it, so it would be an odd non-standardism.

thanks
-- PMM

