Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B336ACA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C940208E3
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 12:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHm/MI/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C940208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPQIE-0000q2-OV
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 08:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iPQGz-0008C7-DI
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iPQGx-0002iw-VS
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:06:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55910)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iPQGx-0002ie-Oo
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 08:06:51 -0400
Received: by mail-wm1-x342.google.com with SMTP id g24so2279888wmh.5
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 05:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=VPlGQ7wiTwl9CcFULnKvBeCqKRS3cLaQMb0vNthj84M=;
 b=YHm/MI/keHG8GAuuPX2u1uDlCHlaFqMltUevpi+GR6sgWfuy/nVhQfGCTgXO+UO9pI
 5k0LflwRekuiCTMmr6OaUkKYPn6tQobSXZrPw2S/LLrWb747NxiRNW1d7pi2x+hwjCb+
 beXjZ04vRHK6/tQwMm17dyYvT2V4pR5cS7LYSbJWNX0v+eGIUnB1Td8Z34HXGacM5vAX
 ZD98PgedrfRPZnOoLZFZpCsqDJUUSK/Fk5lqPbuXqlyKKDV5yyiO7uWZfufXISpA6bZ1
 wX2i23PAMuI0ROXi5Jqag2dfYQX39lVhXrUqUdlIMM6oWv3utz1Km6uwZi5leDI4N83G
 w/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=VPlGQ7wiTwl9CcFULnKvBeCqKRS3cLaQMb0vNthj84M=;
 b=Sz3a4r6hIi8VfafhWPsPiqDEPJbWbkBqevuiP9abypfoBW+neFTwZoh7PdbOhr1r18
 5As8b3THWLUq+SRN/UhSHTvp/NSonjR8Q5E2puGwDhr9QCN2Dwt2yyOzx4O2TgBkbdtR
 cl259F4S8Q2NtRy8vyCgHGGRS6kA1LE5yKfL2KHVoepN2gwd9qVnWVn4gmYZH3msWrxC
 3XlK+xoQFXdIYt6w4fvd0KMKPaETLCwSs010IqQLgza0aWC6CZ+nmB0YEic4rsMDWN2I
 AdbiNyF+wDtgtZYetKjUaJJV6jhZOvX/mJVOY2slnYtsdJs7xxr7ieHO/HbEgtFVbwCR
 PP+g==
X-Gm-Message-State: APjAAAXj/tLTc3YV/tBGNua7XiNtXMWguqsCfRjqJnSKVaMtiuJtCnWB
 AFRGxkpU4BJzc2LnTogX9lq5kg==
X-Google-Smtp-Source: APXvYqwT7NE9OgwBPMF9KFwmFMRfx9IvABV83qRa1CGHdaIZAIcIPc2f4jpb8b2nt0qbDCwip02nxA==
X-Received: by 2002:a7b:ce0c:: with SMTP id m12mr3849388wmc.38.1572350810459; 
 Tue, 29 Oct 2019 05:06:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p15sm14083969wrs.94.2019.10.29.05.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 05:06:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 883A21FF87;
 Tue, 29 Oct 2019 12:06:48 +0000 (GMT)
References: <20191018181705.17957-1-ehabkost@redhat.com>
 <20191018181705.17957-2-ehabkost@redhat.com>
 <5310d333-b264-67a4-0103-44b6b7be6ff9@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 1/3] tests/vm: netbsd autoinstall, using serial console
In-reply-to: <5310d333-b264-67a4-0103-44b6b7be6ff9@redhat.com>
Date: Tue, 29 Oct 2019 12:06:48 +0000
Message-ID: <87sgnb92nb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P=2E_Be?= =?utf-8?Q?rrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Kamil Rytarowski <n54@gmx.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 18/10/2019 20.17, Eduardo Habkost wrote:
>> From: Gerd Hoffmann <kraxel@redhat.com>
>>
>> Instead of fetching the prebuilt image from patchew download the install
>> iso and prepare the image locally.  Install to disk, using the serial
>> console.  Create qemu user, configure ssh login.  Install packages
>> needed for qemu builds.
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> Reviewed-by: Kamil Rytarowski <n54@gmx.com>
>> Tested-by: Thomas Huth <thuth@redhat.com>
>> [ehabkost: rebased to latest qemu.git master]
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>>  tests/vm/netbsd | 189 +++++++++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 179 insertions(+), 10 deletions(-)
>>
>> diff --git a/tests/vm/netbsd b/tests/vm/netbsd
>> index ee9eaeab50..49a99477f4 100755
>> --- a/tests/vm/netbsd
>> +++ b/tests/vm/netbsd
>> @@ -2,10 +2,11 @@
>>  #
>>  # NetBSD VM image
>>  #
>> -# Copyright 2017 Red Hat Inc.
>> +# Copyright 2017-2019 Red Hat Inc.
>>  #
>>  # Authors:
>>  #  Fam Zheng <famz@redhat.com>
>> +#  Gerd Hoffmann <kraxel@redhat.com>
>>  #
>>  # This code is licensed under the GPL version 2 or later.  See
>>  # the COPYING file in the top-level directory.
>> @@ -13,30 +14,198 @@
>>
>>  import os
>>  import sys
>> +import time
>>  import subprocess
>>  import basevm
>>
>>  class NetBSDVM(basevm.BaseVM):
>>      name =3D "netbsd"
>>      arch =3D "x86_64"
>> +
>> +    link =3D "https://cdn.netbsd.org/pub/NetBSD/NetBSD-8.0/images/NetBS=
D-8.0-amd64.iso"
>
> I'd like to suggest to go immediately with 8.1 instead of 8.0. I tested
> it and it worked for me out-of-the-box, without further modifications.

*Sigh* I had to drop this from my PR after it broke again. It looked
 like it was getting stuck on the installer waiting for something. I had
 it working at one point so I'm not sure why it's not working again.

The rest of the patches are merged now though.

>
>> +
>> +        if os.path.exists(img):
>> +            os.remove(img)
>
> These two lines have been removed recently with commit
> fcd2060e8efff83b7bdef04323077f87e011fdc4 ... please drop them from the
> patch.
>
>  Thanks,
>   Thomas


--
Alex Benn=C3=A9e

