Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0820FC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70012166E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 22:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeBkrzL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70012166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54453 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRlG3-000451-0w
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 18:23:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hRlEq-0003YR-Gy
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:22:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hRlEp-0003uG-8e
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:22:04 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hRlEo-0003tP-W5
	for qemu-devel@nongnu.org; Fri, 17 May 2019 18:22:03 -0400
Received: by mail-wm1-x344.google.com with SMTP id 15so3999103wmg.5
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 15:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=V+UChBMPtsHymbUISCl3PTFaxG7COM7bk4pcxEoHlJk=;
	b=UeBkrzL27/F1hJzdMmcr6ir9PfT0Tv9SPxaj+5Zpn02cPMlLlbswuKhE99wUjHE0S3
	IyNiRofhxfLe05c39wrkHX3C6IR8bdg/We/3NM5bqyOziRKpslvR2dfNm09dUhpRADuy
	T2+dLFiXFDERemHEXxEbaYNXZUPQrJpmewF5dYUGRCT1doEGiernYFWSozJb7nz+Udt2
	LKUm1Hrgrtdrxy/0Hrdw9wLkSQ5fYNih2tyPIINhqWS8f7rPYpNevduIrl7sKLtOpJvR
	vtntEn34v193EYegf+Yj4RODhkWluGKorHH0Npdb9KHsGeDbU3SiTU82uLNyQPTkNP4w
	7rgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=V+UChBMPtsHymbUISCl3PTFaxG7COM7bk4pcxEoHlJk=;
	b=a4+2cC20qP5iDcC4lTJdGksYFhMPCpbiw0rg7hwfaluh3wbPrBCmFg8a1RFGFWyMIt
	iMwgbaMxRxXNScm7ftu5MXV/ewS5AqhxrLaHB2kCaaDKUHfaUCHFz3oH/AlljDPRfymO
	y83AMNicvHo4d6IVIvEmZjya9hAu+u8kK3Yf6wMMg7bK84e+zzWwOYzJ59yyYfYHM9/L
	iHlVuM1+GAwa9x3bWdnLh2YQ3OCqTIAH+iyRG4KYASiQ+vkqeS7ta7hmLeugV2uEqTkS
	3JDvzRTQHJXffLNAkPRKFwxzVQAblVRDJZBDSEhYGQO+owvRjFZRcIrbz3zfF48ShmQb
	Pg5w==
X-Gm-Message-State: APjAAAXzjH/XWheVdGclJeEgK1eFL1fAavNbaavR8RA4BYOI/BtVg/sC
	H9zrHNI1fjPKi+K05i1e3VOuI5cjIodfS20lMHzSI6G+
X-Google-Smtp-Source: APXvYqzNX6iNlTa0VzqvVA19ow3E79b9jd6a8F61tPithOcT7m0s64pGXkaVqYmx0BK2jumnZuNugWXvwwnnxOvt0Y0=
X-Received: by 2002:a1c:f102:: with SMTP id p2mr3540651wmh.126.1558131720669; 
	Fri, 17 May 2019 15:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190409161009.6322-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190409161009.6322-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 18 May 2019 00:21:48 +0200
Message-ID: <CAJ+F1CLEG8xgYYjuSroJ_tHOAaq+v+Ze7i_PushJ+s9yaCQdYA@mail.gmail.com>
To: QEMU <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v4 00/20] monitor: add asynchronous command
 type
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 9, 2019 at 6:12 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi,
>
> HMP and QMP commands are handled synchronously in qemu today. But
> there are benefits allowing the command handler to re-enter the main
> loop if the command cannot be handled synchronously, or if it is
> long-lasting. Some bugs such as rhbz#1230527 are difficult to solve
> without it.
>
> The common solution is to use a pair of command+event in this case.
> But this approach has a number of issues:
> - you can't "fix" an existing command: you need a new API, and ad-hoc
>   documentation for that command+signal association, and old/broken
>   command deprecation
> - since the reply event is broadcasted and 'id' is used for matching the
>   request, it may conflict with other clients request 'id' space
> - it is arguably less efficient and elegant (weird API, useless return
>   in most cases, broadcast reply, no cancelling on disconnect etc)
>
> The following series implements an async command solution instead. By
> introducing a session context and a command return handler, it can:
> - defer the return, allowing the mainloop to reenter
> - return only to the caller (instead of broadcast events for reply)
> - optionnally allow cancellation when the client is gone
> - track on-going qapi command(s) per client/session
>
> and without introduction of new QMP APIs or client visible change.
>
> Existing qemu commands can be gradually replaced by async:true
> variants when needed, while carefully reviewing the concurrency
> aspects. The async:true commands marshaller helpers are splitted in
> half, the calling and return functions. The command is called with a
> QmpReturn context, that can return immediately or later, using the
> generated return helper, which allows for a step-by-step conversion.
>
> The screendump command is converted to an async:true version to solve
> rhbz#1230527. The command shows basic cancellation (this could be
> extended if needed). It could be further improved to do asynchronous
> IO writes as well.
>
> v4:
> - rebased, mostly adapting to new OOB code
>   (there was not much feedback in v3 for the async command part,
>    but preliminary patches got merged!)
> - drop the RFC status

ping

>
> v3:
> - complete rework, dropping the asynchronous commands visibility from
>   the protocol side entirely (until there is a real need for it)
> - rebased, with a few preliminary cleanup patches
> - teach asynchronous commands to HMP
>
> v2:
> - documentation fixes and improvements
> - fix calling async commands sync without id
> - fix bad hmp monitor assert
> - add a few extra asserts
> - add async with no-id failure and screendump test
>
> Marc-Andr=C3=A9 Lureau (20):
>   qmp: constify QmpCommand and list
>   json-lexer: make it safe to call destroy multiple times
>   qmp: add QmpSession
>   QmpSession: add a return callback
>   QmpSession: add json parser and use it in qga
>   monitor: use qmp session to parse json feed
>   qga: simplify dispatch_return_cb
>   QmpSession: introduce QmpReturn
>   qmp: simplify qmp_return_error()
>   QmpSession: keep a queue of pending commands
>   QmpSession: return orderly
>   qmp: introduce asynchronous command type
>   scripts: learn 'async' qapi commands
>   qmp: add qmp_return_is_cancelled()
>   monitor: add qmp_return_get_monitor()
>   console: add graphic_hw_update_done()
>   console: make screendump asynchronous
>   monitor: start making qmp_human_monitor_command() asynchronous
>   monitor: teach HMP about asynchronous commands
>   hmp: call the asynchronous QMP screendump to fix outdated/glitches
>
>  qapi/misc.json                          |   3 +-
>  qapi/ui.json                            |   3 +-
>  scripts/qapi/commands.py                | 151 ++++++++++++++---
>  scripts/qapi/common.py                  |  15 +-
>  scripts/qapi/doc.py                     |   3 +-
>  scripts/qapi/introspect.py              |   3 +-
>  hmp.h                                   |   3 +-
>  include/monitor/monitor.h               |   3 +
>  include/qapi/qmp/dispatch.h             |  89 +++++++++-
>  include/qapi/qmp/json-parser.h          |   7 +-
>  include/ui/console.h                    |   5 +
>  hmp.c                                   |   6 +-
>  hw/display/qxl-render.c                 |   9 +-
>  hw/display/qxl.c                        |   1 +
>  monitor.c                               | 198 ++++++++++++++--------
>  qapi/qmp-dispatch.c                     | 214 +++++++++++++++++++-----
>  qapi/qmp-registry.c                     |  33 +++-
>  qga/commands.c                          |   2 +-
>  qga/main.c                              |  51 ++----
>  qobject/json-lexer.c                    |   5 +-
>  qobject/json-streamer.c                 |   3 +-
>  tests/test-qmp-cmds.c                   | 206 +++++++++++++++++++----
>  ui/console.c                            | 100 +++++++++--
>  hmp-commands.hx                         |   3 +-
>  tests/qapi-schema/qapi-schema-test.json |   5 +
>  tests/qapi-schema/qapi-schema-test.out  |   8 +
>  tests/qapi-schema/test-qapi.py          |   8 +-
>  27 files changed, 877 insertions(+), 260 deletions(-)
>
> --
> 2.21.0.196.g041f5ea1cf
>
>


--=20
Marc-Andr=C3=A9 Lureau

