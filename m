Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801C2C33CAE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 07:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349C12053B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 07:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWq4ex13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349C12053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqtjY-0000E0-7K
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 02:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iqtiR-00089O-VR
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 02:00:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iqtiQ-00068d-PV
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 02:00:47 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iqtiQ-00067T-HO; Mon, 13 Jan 2020 02:00:46 -0500
Received: by mail-wm1-x342.google.com with SMTP id b19so8330880wmj.4;
 Sun, 12 Jan 2020 23:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6J+DdGBuWcJeBJcYnh+Ki5EMu0UqVMnEud7p4f5KBuk=;
 b=IWq4ex13s1akSf766wCKf02k8wPd7Z8q4Mhc6JIzfWUKOWVPxSxKN+kaMsBa60p8j8
 z/Zip/3HjpLmX5C7tDc2msXv97Flo78j/jyakUFjI5yytGhGfyGvNffmycb4kaUo4oLW
 iEKVhABPgU3Stt8AL+JWMJlSERyiu8May9Z3603u5JydO2XhkaNNEmySCcna+J18KOlv
 IB1iU544Mqr/2T9spjimUKqUwexrGkXASm+k08HSF2xiV9IQx7lNxRXCWUxGk6eSbPhm
 0Hn1rooWc32vFqtHu+kIQsGUZtmkLkv9DTTIuPMLjptIUFnSpUSxNABYWrKhrawQALFI
 TZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6J+DdGBuWcJeBJcYnh+Ki5EMu0UqVMnEud7p4f5KBuk=;
 b=UX9H1JhNz1a/PkWc4DASiP6XhJfJi6C8Ey6Z/vwnh8sr9ha9qksiGQM2IOPBNsvAjT
 lubOFNZAmn7X/gY6v5bMv7DAb2wjDluS8ntDrW09281Iydrd7SmbizcaRhnjBDZMM9Zb
 n9HwJdTr4leNw/gYZ1rv0YTKNPGDDNO8lOAVKLTecpgDhw+llAKylO8yNlWLRnfFGK8O
 EluyixaGUoTef+6x4lrZP/d19ffQLkDXFCCFboZAchOgOdrwMih0bJ9lOjbp5jmRyxkq
 iKLBfpo9SE3Pqi7ie+PGxGZi3psLhM3YWjL+2/RsV9bHbqXPvPDvDSNaq1graYIhKn5w
 zNyw==
X-Gm-Message-State: APjAAAWp9QqwU6LK2atH80qVMIVHQi4YuTbc0zchjkLZCxMZcEHCX4qp
 WYtXFST2kKR6tPiEWIzoBaTeK95Vmta5ihpCyrI=
X-Google-Smtp-Source: APXvYqyTcvoTQod57GH2zAUc0QvD8ns0fH8nMnYSZEdNM6MFAUzD095635ybAZrHkhqL6CrBf9hxSgNiqMVXsQY3sok=
X-Received: by 2002:a05:600c:228f:: with SMTP id
 15mr18669777wmf.56.1578898844645; 
 Sun, 12 Jan 2020 23:00:44 -0800 (PST)
MIME-Version: 1.0
References: <20200109183545.27452-1-kwolf@redhat.com>
In-Reply-To: <20200109183545.27452-1-kwolf@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 13 Jan 2020 11:00:32 +0400
Message-ID: <CAJ+F1CJ6+v7eKiOfFE1r+kVZ-pObJEjjrhPJ4XKVq=e9WG0pUA@mail.gmail.com>
Subject: Re: [PATCH 0/4] qmp: Optionally run handlers in coroutines
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: QEMU <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Thu, Jan 9, 2020 at 10:36 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
> Some QMP command handlers can block the main loop for a relatively long
> time, for example because they perform some I/O. This is quite nasty.
> Allowing such handlers to run in a coroutine where they can yield (and
> therefore release the BQL) while waiting for an event such as I/O
> completion solves the problem.
>
> This series adds the infrastructure to allow this and switches
> block_resize to run in a coroutine as a first example.
>
> This is an alternative solution to Marc-Andr=C3=A9's "monitor: add
> asynchronous command type" series.
>
> Kevin Wolf (4):
>   qapi: Add a 'coroutine' flag for commands
>   block: Mark 'block_resize' as coroutine
>   vl: Initialise main loop earlier
>   qmp: Move dispatcher to a coroutine
>
>  qapi/block-core.json                    |  3 +-
>  tests/qapi-schema/qapi-schema-test.json |  1 +
>  docs/devel/qapi-code-gen.txt            |  4 ++
>  include/qapi/qmp/dispatch.h             |  3 +
>  monitor/monitor-internal.h              |  5 +-
>  monitor/monitor.c                       | 24 ++++---
>  monitor/qmp.c                           | 83 ++++++++++++++++---------
>  qapi/qmp-dispatch.c                     | 38 ++++++++++-
>  tests/test-qmp-cmds.c                   |  4 ++
>  vl.c                                    | 10 +--
>  scripts/qapi/commands.py                | 17 +++--
>  scripts/qapi/doc.py                     |  2 +-
>  scripts/qapi/expr.py                    |  4 +-
>  scripts/qapi/introspect.py              |  2 +-
>  scripts/qapi/schema.py                  |  9 ++-
>  tests/qapi-schema/qapi-schema-test.out  |  2 +
>  tests/qapi-schema/test-qapi.py          |  7 ++-
>  17 files changed, 155 insertions(+), 63 deletions(-)

Series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



--=20
Marc-Andr=C3=A9 Lureau

