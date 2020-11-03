Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B239EC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A7C4206F1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKJnz90f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7C4206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzIc-00027V-77
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:36:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1kZzI1-0001ae-DG; Tue, 03 Nov 2020 11:36:09 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37543)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1kZzHx-0007Ak-PB; Tue, 03 Nov 2020 11:36:09 -0500
Received: by mail-ot1-x343.google.com with SMTP id l36so8532717ota.4;
 Tue, 03 Nov 2020 08:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hWnbnvR07x6yzmen0OpN5x/Y7DjfEE29yJ1qSzliMo4=;
 b=HKJnz90fCQV91FdIXl2Z/TY6nKpakVDEH52r4YP6kILIY/tFfyUtPCtJBz/2kdoXtp
 O6QTZj2V7OePQGallCK+pd3uCyI93SX8QE78U+elha91sm9V71ryV3Cvy238dAWfvD6W
 5P5pAu36rfLwgQZ2A3EX67RaNROzb2kW8KhMnIQvVEnq+gozamLC8XAdg0Klg5y/aqtL
 1PLm8yoo68litekT7sXDsHp9LAlzcpD0emRWiUhaLTBqgdCXfhwhvlj54da0nVOc3r+4
 0hIKcq3Lpgaek5Suyk1jP6PA6xr+zW2ibSv+J4Ly3/fFpwVkxRfM+qwTOwtcqddx9nal
 yHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hWnbnvR07x6yzmen0OpN5x/Y7DjfEE29yJ1qSzliMo4=;
 b=F7vjQTXzAoJgJWyEtt6qtnOstfZ31NTQFUZtGfVwNwpJc4AHuvnyKt+uAPPF/Yaquu
 e3S+B5A+R/y+5k2YYrWKSpZgGp8AO5RoVm6UlW5dpIzc7+HqlUQG7A9R8YrYRUV50xp+
 9IoUxs/G2eSjeeYqvoTMxiugb62oK4JyL0r/1sg8Ncvtht6AoJuFDmSZ8iZir7tT2YpO
 B5JfAdi9qegRJu375irn23qbHhsiiUVecikE0uqA8s9F/9vByP1Fv5ny9TrDvhDW5aSX
 sJ+h9agPxMhn2jH5PG3XDFNmxws95vJ2nng00JJy09MBaT909LEPxYJeShLtvmCz+wdm
 z+Ng==
X-Gm-Message-State: AOAM531uGcW0AiVMQEsoDkTJTcK2WdTj3jDYJF/58Ubs57xuyT68V/7Q
 sqmIUzDTyWxPf2oF4Dcst+PxxwRQm+KmIl8MKFY=
X-Google-Smtp-Source: ABdhPJyG0/PR2uerkNOWV1v4H3rhDAGW+nnDGS4Kj/6fuqkC8x9RzPud9Uzh6KJs7+OHu/wJVb0haYdCqA2xcYl9WOQ=
X-Received: by 2002:a9d:6a0a:: with SMTP id g10mr16385887otn.44.1604421363829; 
 Tue, 03 Nov 2020 08:36:03 -0800 (PST)
MIME-Version: 1.0
References: <5F9AC6FF.4000301@huawei.com>
In-Reply-To: <5F9AC6FF.4000301@huawei.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Tue, 3 Nov 2020 18:35:53 +0200
Message-ID: <CAC_L=vVg=YitEAKE+wGEmphuL8Eu87mYDiYD=UNKGhqOyd8PpQ@mail.gmail.com>
Subject: Re: [PATCH] contrib/rdmacm-mux: Fix error condition in
 hash_tbl_search_fd_by_ifid()
To: AlexChen <alex.chen@huawei.com>
Content-Type: multipart/alternative; boundary="00000000000076101b05b336758d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=marcel.apfelbaum@gmail.com; helo=mail-ot1-x343.google.com
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org, mjt@tls.msk.ru,
 QEMU <qemu-devel@nongnu.org>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 zhengchuan@huawei.com, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000076101b05b336758d
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

On Thu, Oct 29, 2020 at 3:43 PM AlexChen <alex.chen@huawei.com> wrote:

> When fd is not found according to ifid, the _hash_tbl_search_fd_by_ifid()
> returns 0 and assigns the result to *fd, so We have to check that *fd is 0,
> not that fd is 0.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: AlexChen <alex.chen@huawei.com>
> ---
>  contrib/rdmacm-mux/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/rdmacm-mux/main.c b/contrib/rdmacm-mux/main.c
> index bd82abbad3..771ca01e03 100644
> --- a/contrib/rdmacm-mux/main.c
> +++ b/contrib/rdmacm-mux/main.c
> @@ -186,7 +186,7 @@ static int hash_tbl_search_fd_by_ifid(int *fd, __be64
> *gid_ifid)
>      *fd = _hash_tbl_search_fd_by_ifid(gid_ifid);
>      pthread_rwlock_unlock(&server.lock);
>
> -    if (!fd) {
> +    if (!*fd) {
>          syslog(LOG_WARNING, "Can't find matching for ifid 0x%llx\n",
> *gid_ifid);
>          return -ENOENT;
>      }
> --
> 2.19.1
>
>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks for the fix,
Marcel

--00000000000076101b05b336758d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Alex,</div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 29, 2020 at 3:43 PM A=
lexChen &lt;<a href=3D"mailto:alex.chen@huawei.com">alex.chen@huawei.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Whe=
n fd is not found according to ifid, the _hash_tbl_search_fd_by_ifid()<br>
returns 0 and assigns the result to *fd, so We have to check that *fd is 0,=
<br>
not that fd is 0.<br>
<br>
Reported-by: Euler Robot &lt;<a href=3D"mailto:euler.robot@huawei.com" targ=
et=3D"_blank">euler.robot@huawei.com</a>&gt;<br>
Signed-off-by: AlexChen &lt;<a href=3D"mailto:alex.chen@huawei.com" target=
=3D"_blank">alex.chen@huawei.com</a>&gt;<br>
---<br>
=C2=A0contrib/rdmacm-mux/main.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/contrib/rdmacm-mux/main.c b/contrib/rdmacm-mux/main.c<br>
index bd82abbad3..771ca01e03 100644<br>
--- a/contrib/rdmacm-mux/main.c<br>
+++ b/contrib/rdmacm-mux/main.c<br>
@@ -186,7 +186,7 @@ static int hash_tbl_search_fd_by_ifid(int *fd, __be64 *=
gid_ifid)<br>
=C2=A0 =C2=A0 =C2=A0*fd =3D _hash_tbl_search_fd_by_ifid(gid_ifid);<br>
=C2=A0 =C2=A0 =C2=A0pthread_rwlock_unlock(&amp;server.lock);<br>
<br>
-=C2=A0 =C2=A0 if (!fd) {<br>
+=C2=A0 =C2=A0 if (!*fd) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0syslog(LOG_WARNING, &quot;Can&#39;t find =
matching for ifid 0x%llx\n&quot;, *gid_ifid);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOENT;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.19.1<br>
<br></blockquote><div><br></div><div><div>Reviewed-by: Marcel Apfelbaum &lt=
;<a href=3D"mailto:marcel.apfelbaum@gmail.com">marcel.apfelbaum@gmail.com</=
a>&gt;</div></div><div><br></div><div>Thanks for the fix,</div><div>Marcel<=
/div><div><br></div><div>=C2=A0</div></div></div>

--00000000000076101b05b336758d--

