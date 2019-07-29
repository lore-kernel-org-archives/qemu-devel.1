Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16743C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E102D20693
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E102D20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs1Ny-0004hp-67
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 04:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51642)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hs1NY-0004Fh-B8
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hs1NW-0001ic-Rx
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:51:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38169)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hs1NW-0001hp-LE
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:51:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so60875572wrr.5
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 01:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3An3uGAr2mF6V3RndlfunQrxe21IcMOMAeh3Y6GTuFo=;
 b=BmtQgfvkO9FXf7x1Lxzym251RYCXsWVpCpClZsSmLV11I+cQGIwtcRzkTFTGC3rb1Y
 cR47bocmtfCFf8U9xs6p9U3GEgqKosPNcP1FopCFMSpQBREWktj/23eeT4qT58QXHkdV
 eeOD7gpZ1nGUVyQJfTOqu62Fx5Fg42ZqGWsMdMkEItgJN3wyYnn7dPyCoYemvqeJCEbK
 6xxlBPxglfpVyjSdWtgPVBoONoKDsheTFpZnYnTye6tTO9+JEjmXuYLuYumqdUao+kcZ
 2UrfJ2p+3ljJKzN4HVx+WqdOhvpbYCpHQQba/ov21GtTQKsC5ttLUIzHkMvRkhpNdJdz
 7uww==
X-Gm-Message-State: APjAAAUQihTEjv6Ekp/24QFCyoKrAUhokihgLpHY7fPbsETq7BXtMYvK
 AYoG9GaU/LNZqIJdkJ0FtdFA+hM53I0=
X-Google-Smtp-Source: APXvYqw4NYAC+cU7XOoCE3bGq87dsgTOGTmvbqz0sk+dhzPssnjRJ95v2TXczq3oJU4VE4kps4XuOw==
X-Received: by 2002:a5d:4a46:: with SMTP id v6mr10032602wrs.105.1564390292651; 
 Mon, 29 Jul 2019 01:51:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29d3:6123:6d5f:2c04?
 ([2001:b07:6468:f312:29d3:6123:6d5f:2c04])
 by smtp.gmail.com with ESMTPSA id e19sm83421860wra.71.2019.07.29.01.51.31
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jul 2019 01:51:31 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
 <1562775267-1222-5-git-send-email-pbonzini@redhat.com>
 <87d0ie58cj.fsf@dusky.pond.sub.org>
 <78c3bba3-3e85-682b-b4ce-fc4809add90e@redhat.com>
 <87sgqsx7zp.fsf@dusky.pond.sub.org>
 <0b209125-4277-2836-e27b-a9c13f43f294@redhat.com>
 <CAFEAcA8J5AsEC+p3vAQ0H1emN-GS3T5GSj579tS=qC76WjkTVQ@mail.gmail.com>
 <87ftmptiyq.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <41165962-2d61-697f-d17a-d5fa7516e8cc@redhat.com>
Date: Mon, 29 Jul 2019 10:51:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87ftmptiyq.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 4/8] convert libqemuutil to meson
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/07/19 09:09, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Sat, 27 Jul 2019 at 13:24, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>> On 27/07/19 09:16, Markus Armbruster wrote:
>>>> We started with a single trace-events.  That wasn't good, so we split it
>>>> up into one per directory.  That isn't good, so what about splitting it
>>>> up into one per source file?  Pass -DTRACE_HEADER='"trace-DIR-FOO.h"
>>>> instead of -DTRACE_HEADER='"trace-DIR.h"' when compiling DIR/FOO.c.
>>>
>>> For Make this would all work great, however not for Meson because it
>>> doesn't allow per-file compile flags.
>>
>> Apologies for randomly parachuting into this email thread, but if
>> Meson doesn't support per-file compile flags then what's the plan
>> for handling the cases where we currently need per-file compile flags ?
>> (This is one of the things that I thought was quite a nice move
>> forward in our make infrastructure -- we now have clean syntax
>> for saying "these files need to be built with these warnings disabled
>> or these extra include paths or whatever" and also "these files
>> imply we're going to need to link against library X".)
> 
> I vaguely remember from my review that Meson lets us express "these
> files imply we're going to need to link against library X" even more
> clearly.  I can't point you to an example, though.

Yes, you can do just

   common_ss.add(when: curl, if_true: files('curl.c'))

as a replacement for

   common-obj-$(CONFIG_CURL) += curl.c
   curl.c-cflags = $(CURL_CFLAGS)
   curl.c-libs = $(CURL_LIBS)


If conditional compilation is handled inside the file, i.e the same but
with common-obj-y, you can instead do

   common_ss.add(files('vl.c'), sdl)


In both cases, the cflags from the dependency are applied to the whole
target, rather than just to repectively curl.c and vl.c.  So you do lose
the possibility of specifying cflags only for a file.

There is no case where we're using per-.o file CFLAGS for anything other
than dependencies.  I was using per-file -f... options in the
(not-yet-applied) CET series though.  I would have to check whether
pragmas work in that case (if they do, I feel they are superior to
specifying CFLAGS in the Makefile).

>>> Meson maintainers suggest building a static library for each special set
>>> of compile flags; we could do that automatically per-directory(*) but it
>>> would be harder to scale that to per-file.
> 
> This is clearly not "minimal fuss", not even per directory, let alone
> per file.
> 
> It's pretty lame even for the large sets we have (per target,
> target-independent): I guess we'd either throw away the .a unused, or
> link with --wholearchive.

> For me, forwarding headers are just fine for a PoC, quite tolerable
> while a conversion is in progress, and perhaps even tolerable as a
> permanent work-around.  My *actual* question is how we could do per-file
> rather than per-directory trace.h with Meson.  Quoting myself:
> 
>     We have trace-events with hundreds of tracepoints for tens of source
>     files.  The generated trace.h clock in at hundreds of KiB for me.
>     Messing with tracepoints in one source file recompiles most of the
>     directory.  This is so much better than it used to be, but clearly not
>     as good as it could be.
> 
>     The worst of the lot is trace-root.h, which gets included for >1300 .o
>     in my "build everything" tree, mostly because it contains tracepoints
>     for static inline functions in widely included headers.  See also
>     "[PATCH 07/28] trace: Do not include qom/cpu.h into generated trace.h",
>     Message-Id: <20190726120542.9894-8-armbru@redhat.com>.
> 
>     We started with a single trace-events.  That wasn't good, so we split it
>     up into one per directory.  That isn't good, so what about splitting it
>     up into one per source file?
> 
> Any ideas?

Per-file (really per-device) would really be easier than per-directory,
I think, because with fine-grained trace-events there is a point in
including a specific header like

   #include "trace-mptsas.h"

or even

   #include "trace/trace-mptsas.h"

(possibly generated from trace-events-mptsas).  The only constraint
would be that the subsystem names would have to be global across all of
QEMU.  If it's per-directory as it is now, instead, you'd have something
like

   #include "trace/trace-hw_scsi.h"

which is really ugly and then forwarding headers look better.

Paolo

