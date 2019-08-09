Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749AEC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20CB920C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 16:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FMzkM4AW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CB920C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw7LT-00064L-8S
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 12:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54090)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hw7JS-0001lL-2S
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hw7JQ-0003pO-TE
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:00:18 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54623)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hw7JQ-0003ow-Kj
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 12:00:16 -0400
Received: by mail-wm1-x343.google.com with SMTP id p74so6225349wme.4
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 09:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=gEI+pZPfBE5HyOMsVbso29spO1GnP4w+YzRcvOULs9I=;
 b=FMzkM4AW7OVzZpqom1q1VNMSrNNugztS65TzJatBpyGP4YVKjmjkqFzCjQQv9SemN3
 UasK6TGb6gHJ10oXFnxeeNrfvlIyHPQqvlMjKZKBEjVz/M4mrfSKswDAscWYg85sYe15
 AH5wCsEn2rPfKo/PevJLNZ5lxZsPaivAK5EY/7a9Sl6zZWviT/nNce+OfZigHrKkCCtd
 FZ5mSpD3APWIC7UkwGR3DDHhaObPpkiWzkNsOI66h+VVxXEw/xPP/P8EqAouOhP/rirR
 IP4nh8tlxzo/HXBv1B7TM5KW/Oce8A5NxarJ3rCQANB0RqWFA8BgdX/nbXZXyAQMV1rA
 eOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=gEI+pZPfBE5HyOMsVbso29spO1GnP4w+YzRcvOULs9I=;
 b=lldmsiINOOU5b+ZGGywtsp0bQRQNgo2HIvv2ipCI+FqwvLYLq0n1NNhPnkDP2xC0E9
 0oF28IPJRh+r0KAxRhJqx6PvnRp1Km3WwluPqDPNtLs3JLW6eh70SQAquUFuTL9oU4sI
 Bm+oVKuzp16Vz6MDH9QB3LybbzbaeJSID5WRGx6D6Y22qFTJgxnVEVgY6dgZWpyOjSma
 HMtsx7f3GYWk1SA/mEHK8Tv2d/J2S+hNcKYW6Lq0jwX1+l8cM/S9ZHlkjB9AxwE864l5
 WxobZtq2GSgrjnhOjFrXbSkxwc9WdjmDAKu0JaM2crU67xvwbd0IzVObqxYUvlNPDuMy
 GHzA==
X-Gm-Message-State: APjAAAV7Tv/u0qCP+J5+QjnmA0pqS+HYn41TFoOPs3dSiQ6ok/r8RF8e
 cs1DwZAjyF6Wahki7lxOEq6IVSFsiWY=
X-Google-Smtp-Source: APXvYqw3KgScdl/HKYNjwnIJj4juQNnmx6gdpHI75QPelHNw4dOdsISzRMNIoosY9ks2Yy9u/2GGgg==
X-Received: by 2002:a1c:c001:: with SMTP id q1mr4682346wmf.149.1565366415112; 
 Fri, 09 Aug 2019 09:00:15 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x6sm105548506wrt.63.2019.08.09.09.00.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 09 Aug 2019 09:00:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1F8A51FF87;
 Fri,  9 Aug 2019 17:00:14 +0100 (BST)
References: <20190809064645.22656-1-armbru@redhat.com>
 <20190809064645.22656-21-armbru@redhat.com>
 <c76aaebc-d4bf-cb25-fe27-7a9c9ba644c9@redhat.com>
 <87k1bmpn7y.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <87k1bmpn7y.fsf@dusky.pond.sub.org>
Date: Fri, 09 Aug 2019 17:00:14 +0100
Message-ID: <87zhkigwhd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3 20/29] Include qemu/main-loop.h less
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>
>> On 8/9/19 8:46 AM, Markus Armbruster wrote:
>>> In my "build everything" tree, changing qemu/main-loop.h triggers a
>>> recompile of some 5600 out of 6600 objects (not counting tests and
>>> objects that don't depend on qemu/osdep.h).  It includes block/aio.h,
>>> which in turn includes qemu/event_notifier.h, qemu/notify.h,
>>> qemu/processor.h, qemu/qsp.h, qemu/queue.h, qemu/thread-posix.h,
>>> qemu/thread.h, qemu/timer.h, and a few more.
>>>
>>> Include qemu/main-loop.h only where it's needed.  Touching it now
>>> recompiles only some 1700 objects.  For block/aio.h and
>>> qemu/event_notifier.h, these numbers drop from 5600 to 2800.  For the
>>> others, they shrink only slightly.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>> [...]
>>> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
>>> index 77f5df59b0..ac18a1184a 100644
>>> --- a/include/sysemu/sysemu.h
>>> +++ b/include/sysemu/sysemu.h
>>> @@ -5,7 +5,6 @@
>>>  #include "qapi/qapi-types-run-state.h"
>>>  #include "qemu/timer.h"
>>>  #include "qemu/notify.h"
>>> -#include "qemu/main-loop.h"
>>>  #include "qemu/bitmap.h"
>>>  #include "qemu/uuid.h"
>>>  #include "qom/object.h"
>>
>> netmap failing again :S
>>
>> $ make docker-image-debian-amd64 V=3D1 DEBUG=3D1
>> [...]
>>   CC      net/netmap.o
>> net/netmap.c: In function 'netmap_update_fd_handler':
>> net/netmap.c:109:5: error: implicit declaration of function
>> 'qemu_set_fd_handler' [-Werror=3Dimplicit-function-declaration]
>>      qemu_set_fd_handler(s->nmd->fd,
>>      ^~~~~~~~~~~~~~~~~~~
>> net/netmap.c:109:5: error: nested extern declaration of
>> 'qemu_set_fd_handler' [-Werror=3Dnested-externs]
>
> I managed to lose the fix somehow.
>
> I admit I ran "make docker-test-build", realized docker needs root, and
> went "sod it, cross fingers & send out the patches".

I've sent some patches to make docker-test-build more closely resemble
what shippable exercises.

As for root you can setup a docker group and do it that way (see the
docs in docs/devel/testing.rst). It's not recommended for production
machines as it makes escalation fairly trivial (the daemon itself still
runs as root). Hopefully Marc's podman support:

  Subject: [PATCH v2 0/5] tests/docker: add podman support
  Date: Tue,  9 Jul 2019 23:43:25 +0400
  Message-Id: <20190709194330.837-1-marcandre.lureau@redhat.com>

will make these requirements a little less onerous.

> My need to get out
> the changes accumulated since v2 won over the prudence to run all
> available tests first.  Not my finest hour.


--
Alex Benn=C3=A9e

