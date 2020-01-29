Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CA7C33CB7
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 14:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34EC9206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 14:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ram8Ek8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EC9206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwnyB-0000gP-Bv
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 09:05:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iwnxS-0008Sq-P8
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 09:04:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iwnxR-0004Bf-PN
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 09:04:42 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36031)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iwnxR-00049I-If
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 09:04:41 -0500
Received: by mail-wr1-x444.google.com with SMTP id z3so20349461wru.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 06:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xe1a8G6J/Tx3k1rkyKQ5Wsh4Wm+zZS5gLho6P0MA8U4=;
 b=ram8Ek8tRsWlJVU3kmU5FDtlykeaqrovvESvw0WfhswlBzRq0sHPAq8MAMRSI/l4Bj
 TprGRXciYeGqm/toBbYK+Wq1gH+QchO0RxKo4e6TBXWaIvlTeJy63ypwLlB7uHb3nEeq
 mRG85kmMQrTQbSSuG+Gcc+oFd0dBxTjzcKLhJRJGyqc5JBKnzLz6+Ode6BZBYIqZsFnd
 Fi0XDyKjBE0ehq1whMJnhxDRZLcpzIcUILmLaliddYQ++m131RMP92udf7CjNA20moB0
 DrLqPP38SMrLqUwvPt04f9rzOyBO1VQHV1kLb2tNNmaIyUrIe+NOUHEu1+gok3Vp0WGF
 4Xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xe1a8G6J/Tx3k1rkyKQ5Wsh4Wm+zZS5gLho6P0MA8U4=;
 b=ASulWBA1gtIrqG0bH/1zFPedxOZLP78DenhIxvu0k6xcC0jy1awwJau7R+NiqYtiQm
 I6YB6DaJps1PSIgraJLH99dqPPrvbA4wo06QshrWbAe/P8mUN++2PaDrTk9Abm96W9uc
 k40rIMjaj7C4OsbQB5yjsKDzC0ZySXpehKcpvwtnBK3uMpfN5qYYB+1KPMAEfuFA14Gs
 OyEnUbvNuXrWlFvx2YMupY4lFAcrk2m4zQOZhXhZwcIln+t9nNKgxAs4YpjGoJ6bwyVt
 66etU0WMqxRKTzmYq4FN2a3ZCrkLdi6Tt+bsvKZAPrkqnlZCtnqEmkDw1NAY6cMdPsBz
 x8qw==
X-Gm-Message-State: APjAAAVSZ520x3oba0TCTk+JLFJvA8IfG9RhPqkCaRyth+JdsJkv5Daq
 BFzTU6xgXDLqVe23k5gDtcz92kgFjFBn67By+R4=
X-Google-Smtp-Source: APXvYqzZU54TmKNO9Hyyv7+vD0+Zr1DEYIZuvRt9AQhZWtKGZIV+eortGOVzypl+2dOvp60Fos22cLU3E6KL/cqDZQ0=
X-Received: by 2002:a5d:438c:: with SMTP id i12mr35111338wrq.196.1580306680506; 
 Wed, 29 Jan 2020 06:04:40 -0800 (PST)
MIME-Version: 1.0
References: <20200128175342.9066-1-pbonzini@redhat.com>
 <20200128175342.9066-2-pbonzini@redhat.com>
 <81393799-e936-d5dc-1681-4317bfae510e@redhat.com>
 <CAMxuvayx55=JaVCgtZew70jeoRSzpzuLDSe2sth91yiLb_kAXA@mail.gmail.com>
 <f076136b-d118-b502-25fb-d72cbd194833@redhat.com>
In-Reply-To: <f076136b-d118-b502-25fb-d72cbd194833@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 29 Jan 2020 15:04:28 +0100
Message-ID: <CAJ+F1CLXQMTvc2VgvV6kfydrt80TqjrDsr9-4PJqq81X_Kgdug@mail.gmail.com>
Subject: Re: [PATCH 001/142] minikconf: accept alnum identifiers
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Jan 29, 2020 at 2:47 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 29/01/2020 14.41, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Wed, Jan 29, 2020 at 1:09 PM Thomas Huth <thuth@redhat.com> wrote:
> >>
> >>
> >> -EMISSINGPATCHDESCRIPTION
> >>
> >> Why is this required? Bug fix? New feature? ... please add some words =
here.
> >
> > This is required for later patch "meson: convert hw/9pfs", which adds
> > config 9PFS.
> >
> > You are right, several patches could use some comments. It's still
> > PoC. Otoh, a lot of them are quite mechanical or just what they are in
> > meson, there isn't much to say about it. We'll have to improve this
> > somehow.
>
> Sure, but with a proper patch description, this patch here could even be
> merged today already, shrinking this huge patch series by one at least...
>

Paolo has been merging many preliminary patches already. I am not sure
why that one wasn't. We have also done some preliminary work in meson
too, and continue to do.

--=20
Marc-Andr=C3=A9 Lureau

