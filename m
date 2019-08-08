Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC692C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D6E217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVm3QevV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D6E217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvjIg-0000yg-Te
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 10:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54450)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvjIG-0000Yc-Ia
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvjIF-0004aM-HQ
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:21:28 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55561)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvjIF-0004Ya-9C
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:21:27 -0400
Received: by mail-wm1-x341.google.com with SMTP id f72so2595541wmf.5
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qqHvfP8cv/03fxWwFmpCHAYh5U8ckvWevbI7IFSRiVE=;
 b=cVm3QevVDvcbPMMryYFGm+OYTK3BLbxPDxUiLwY4KplGOzfXhfdfCHkRAuqdq5Qcid
 mpyyk4+8BPUrf1+slQxTIeFIVDQ8CRn+6mt7qNqjaCHo1rKmPmdrPTGrOImcMoDBzh5R
 36P4mhhIZTcGTxWa3QD1YvwzShuCLhFbjU5/3Psp8Guf/D9g8VfFW67tAR/m5Nni+3Nj
 NJL9IkHl7L1uUrXnq4GEMxmHqNdYxSzTbhda+/Sog9M/WVTZ+yTrhl3RSiZEhUpf47OG
 XyDALneFUTpKrAsd9VQucTY94DsjSMW+XU/ueoMaNkXk5vrj5aa976zEs8IfWG9Vm1UI
 +hPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qqHvfP8cv/03fxWwFmpCHAYh5U8ckvWevbI7IFSRiVE=;
 b=mAUkJ+g9xNgi6JINuC4M4tXIsXkSz/yV/4T+cqHb1bz/h6Xv9bM+Ul8BzIrOQd3oj0
 aKTQEOS9IcEQs0vQMQpFi1kxf5yKnSGL1VozsXU5PqWu4xNXBg52H27mZAc0Q24+wikM
 Vr5/bv2i5WlGA4JV1O/oT69SChNWnj1dp16Dm3M7fpv3I3EW1maocDeqMe7ONtSdPEl4
 1ByfK4xK1e1dp5UNJfKlx5z6D0DSrbRCj4ONVO+lw0rNUSZ1fXH2Ac/ti5M+Nv4SRnKU
 tiGioADqfPa7vX+buOTYiXtwyxoHy0FZcNUXZHqsYQeXyH7hWsjTnF0wXhJDp+BTMNBV
 yErQ==
X-Gm-Message-State: APjAAAVmXkFntEuNkFuGMNgzMGr509SSFPCQYFRwjSgQQNQft2wNDbIJ
 t4stUBA2f5O+bNO/fpbvglbz0n0GZ68=
X-Google-Smtp-Source: APXvYqw/obGU124OF556pQZXoThWIZp3lLn2DBDbpt1OcWTcpO/Gs1YeTFPz1Qiog6/68jR55JUMxg==
X-Received: by 2002:a1c:c747:: with SMTP id x68mr4763932wmf.138.1565274085315; 
 Thu, 08 Aug 2019 07:21:25 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id o6sm203916586wra.27.2019.08.08.07.21.24
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 07:21:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4482D1FF87;
 Thu,  8 Aug 2019 15:21:24 +0100 (BST)
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-27-armbru@redhat.com> <87ef1xhta7.fsf@linaro.org>
 <87h86srb2u.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Markus Armbruster <armbru@redhat.com>
In-reply-to: <87h86srb2u.fsf@dusky.pond.sub.org>
Date: Thu, 08 Aug 2019 15:21:24 +0100
Message-ID: <874l2rivq3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2 26/29] Clean up inclusion of
 sysemu/sysemu.h
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>>> In my "build everything" tree, changing sysemu/sysemu.h triggers a
>>> recompile of some 5400 out of 6600 objects (not counting tests and
>>> objects that don't depend on qemu/osdep.h).
>>>
>>> 119 of 380 #include directives are actually superfluous.  Delete them.
>>> Downgrade two more to qapi/qapi-types-run-state.h, and move one from
>>> char/serial.h to char/serial.c.
>>>
>>> This doesn't reduce actual use much, as it's still included into
>>> widely included headers.  The next commit will tackle that.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>> <snip>
>>>  hw/semihosting/config.c             | 1 +
>> <snip>
>>>  stubs/semihost.c                    | 1 +
>> <snip>
>>> diff --git a/hw/semihosting/config.c b/hw/semihosting/config.c
>>> index 2a8e7e1045..9807f10cb0 100644
>>> --- a/hw/semihosting/config.c
>>> +++ b/hw/semihosting/config.c
>>> @@ -24,6 +24,7 @@
>>>  #include "qemu/error-report.h"
>>>  #include "hw/semihosting/semihost.h"
>>>  #include "chardev/char.h"
>>> +#include "sysemu/sysemu.h"
>>>
>>>  QemuOptsList qemu_semihosting_config_opts =3D {
>>>      .name =3D "semihosting-config",
>>> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
>>> index b8332150f1..9f3cff5fb6 100644
>> <snip>
>>>
>>> diff --git a/stubs/semihost.c b/stubs/semihost.c
>>> index 4d5b3c0653..f90589259c 100644
>>> --- a/stubs/semihost.c
>>> +++ b/stubs/semihost.c
>>> @@ -12,6 +12,7 @@
>>>  #include "qemu/option.h"
>>>  #include "qemu/error-report.h"
>>>  #include "hw/semihosting/semihost.h"
>>> +#include "sysemu/sysemu.h"
>> <snip>
>>
>> These additions seem out of place. If I comment them out I can still
>> build fine
>
> sysemu/sysemu.h declares qemu_semihosting_config_opts,
> hw/semihosting/config.c and stubs/semihost.c define it.
>
> Gcc warns when you do that for functions (-Wmissing-declarations
> -Wmissing-prototypes), but not for variables.  I like to include the
> header anyway, to make sure the compiler checks the declaration is
> consistent with the definition.
>
>>            - I think the only place that needs them is vl.c so it has a
>> typedef for the semihosting configure options. Arguably the extern
>> declaration could be moved into semihostings own headers to avoid
>> polluting sysemu.h more than it needs to?
>
> I'm not sure I'm following you.
>
> What would you like me to move where?

extern QemuOptsList qemu_semihosting_config_opts;

from sysemu.h to semihosting.h - but given other options externs are
there maybe that is the best place for it.

--
Alex Benn=C3=A9e

