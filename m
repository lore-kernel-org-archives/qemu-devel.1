Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E196C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:01:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6631D20825
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPtthB4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6631D20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBe0X-0003iW-Kf
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kBdzC-00035z-Rw
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:00:06 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:35458)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kBdzB-0008GL-3J
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:00:06 -0400
Received: by mail-ed1-x541.google.com with SMTP id ba12so1094182edb.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M0rLv7ZmUUQiOebVLkF5l/R1l+rtQRtoY2nFEKjbzgQ=;
 b=LPtthB4qAxxIuZ08oThN49xR5jhV0p8aJJyiDlpaZOPxBxOKUV4VDnPv0Db/uv6iDJ
 dIEijpMqe5Ij9PXdO6XgQ5OsXwWKYyZpf5DUJIVK22U+6nrhklb2uVBmVXw+a7NrexLt
 Zlup7EEOMutOM1g79dhpZFx5gR+IcQOXM94tl8cCJcJV3Bgqn0Mbfne3NAALXn+tw/NU
 TjGK7GhihpVORQzjBygADFK6rxTqfsibnjUOUUjVHL35voE033I5V5fpRNip2kxYBrbM
 d9VX6INWoXNueIOx9vKd9BILh2kfUu3ksvswNIcJUkCD2bngMzDLDaVxQ9DOaOGgOiXm
 tBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M0rLv7ZmUUQiOebVLkF5l/R1l+rtQRtoY2nFEKjbzgQ=;
 b=ZTCKTtcJBDDFd2OzG2eKx9gntC9ZIvvWKq4b1X5GZhNuKfyIaUkmhFMSm9n/tchsok
 C/15M8+VamXrAkKqiQu/7YOFboPyJAnEw0CkWoiYNhmw9YDUPy8Dayz1tUmRMxTy7ABF
 nMqFIw5QwilRcyYsckDUqfSWWmm/7h7o9wo2CvIJ5xB52hNdMVXeUU2us9FjDme6KWfj
 AP0Hl8LYxvnUt4KE99drwNx2YVScKbfKncV2+a6ohLHZANUsSzUSeV43+8YolnNTPyl9
 JqRRKFvoZpBGLuvuwHk9cpozY6HZRKZNBmreI9/FAL9KbtPeNb0i5rKiDG/twKllQOZF
 CXzQ==
X-Gm-Message-State: AOAM530aki1DAr84kV4j+2N1KdqKkxqRN8kF5TUIcoe45o9m9c90QeAW
 3xZtbAttW4vkmocF7a0wulSnildP4WnB0H6n2+4=
X-Google-Smtp-Source: ABdhPJzGaTsmsu6YUcz+m9IwK3JhTLb3BkmcxxzN4My+3DMmfu2h1zwU+0I3W5O+iNTrdt9cGwfn+4TdcCzPCbswRyM=
X-Received: by 2002:a05:6402:1205:: with SMTP id
 c5mr1777781edw.257.1598619602861; 
 Fri, 28 Aug 2020 06:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200828110734.1638685-1-marcandre.lureau@redhat.com>
 <8b4616c8-8984-92ca-42b8-c3bb59bb5a05@redhat.com>
In-Reply-To: <8b4616c8-8984-92ca-42b8-c3bb59bb5a05@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 28 Aug 2020 16:59:51 +0400
Message-ID: <CAJ+F1C+0M4HCs0vTXbLmeUn5kjL1ZmhXPZz=8S1V-OYQct3KVA@mail.gmail.com>
Subject: Re: [PATCH 00/16] meson: convert unit tests in tests/Makefile.include
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008f44d305adefa155"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008f44d305adefa155
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Aug 28, 2020 at 4:56 PM Thomas Huth <thuth@redhat.com> wrote:

> On 28/08/2020 13.07, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Hi,
> >
> > This series convert the unit tests from tests/Makefile.include to meson=
.
>
> Just an optional idea: What about moving the unit tests to a separate
> subdirectory a la tests/unit/ , too?
>
>
Sounds like a good idea to me, but there is already quite a lot going on in
this series :) Let's add that to the todo list, shall we?

--=20
Marc-Andr=C3=A9 Lureau

--0000000000008f44d305adefa155
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 28, 2020 at 4:56 PM Tho=
mas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 28/08/2=
020 13.07, <a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank"=
>marcandre.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; Hi,<br>
&gt; <br>
&gt; This series convert the unit tests from tests/Makefile.include to meso=
n.<br>
<br>
Just an optional idea: What about moving the unit tests to a separate<br>
subdirectory a la tests/unit/ , too?<br><br></blockquote><div><br></div><di=
v>Sounds like a good idea to me, but there is already quite a lot going on =
in this series :) Let&#39;s add that to the todo list, shall we?<br></div><=
div> <br></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">Marc=
-Andr=C3=A9 Lureau<br></div></div>

--0000000000008f44d305adefa155--

