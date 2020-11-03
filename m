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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41703C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 19:54:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F6120E65
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 19:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUVUfKOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F6120E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2Ns-0006ka-GR
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 14:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuval.shaia.ml@gmail.com>)
 id 1ka2Js-0002xp-AB; Tue, 03 Nov 2020 14:50:16 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:41520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuval.shaia.ml@gmail.com>)
 id 1ka2Jq-0000qN-BG; Tue, 03 Nov 2020 14:50:15 -0500
Received: by mail-lf1-x144.google.com with SMTP id 126so23848958lfi.8;
 Tue, 03 Nov 2020 11:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5U1sh5MZyvuF/dyOxRnLXkyHcEX4/Vlgu2kBTFury7Q=;
 b=kUVUfKOIGTgeG35cZHyyuf2eQUgiP87AwpbS/SQBn8gtSvaWsVNSAHJpO7Y3NosMTy
 37Dfyd1UAHLpefd1W4k1BVd1qNrmPjYVr1t9S9YJ/Z0ekRMbM9kIDFr4pj8T0NjBQlXn
 82hgCoSH43YrzG4Jt88mX69lVqZfmJo5vrmF5EC/yNQOEBMMKpNQ5chuzMMu0Ezj8ug9
 /+21ItvfQe3Y3I/THhBj33CvQ9EoCup9k0aKBMSFjyUBR9YVNpaOQ9/pu6OfKKcAs3GS
 s57jMRgHGjaoZGLO3MJbWqmfQZUNCWllB8OCvKJuG0GjeJkMp9p3PLzRFKK6eE0GUDmK
 bV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5U1sh5MZyvuF/dyOxRnLXkyHcEX4/Vlgu2kBTFury7Q=;
 b=CoCwnBHQgoaOhEyh70l3kInoTdfKdYC5Bqwnlqj1d2PK9xTPUwxxbwbkfQq36GLlQw
 AZfGjsR1zKW3VIypdOo0mXFHk1mL/AGIBya6HUyCS2PvAfoJyoKsfvC0kjADtOjsLHrL
 c6kV0rGI1ebfDiNBsmJAhSHbU21Z+Nf65SMSVNAFmB0RJKQpCUnQnC/6reC1T9wMceJO
 9biSqCffLrpnIwsM6zMygj+cZiUsiaoCwvU5cKDsfmIm3uw+zLNBn5Uw3gpdmOvZceZM
 n4cY8wYja0ANWQVRqWQh4LWK0dKkVD+8yWDgObVCRcOpBy64MjLAzGxBEKPhmp1+x28/
 mcWA==
X-Gm-Message-State: AOAM533wwIErzRwUPlzU1N4bRhSTS7t7QsqIM9RTMoB/uuk9VUMFuOJV
 yJb/h4pgcCttkCp30W/1ojbpXoqKwRtlcKJQiXI=
X-Google-Smtp-Source: ABdhPJxwQhM0VwrZDzgZMrUStGdyvH+jN7lwZS+EXOpQhJJrNx++LabgnADKCtKIeqK1c7aTgJ4WaA81SvBc5k9HFYQ=
X-Received: by 2002:ac2:592c:: with SMTP id v12mr8220891lfi.492.1604433011099; 
 Tue, 03 Nov 2020 11:50:11 -0800 (PST)
MIME-Version: 1.0
References: <20201103015228.2250547-1-kuhn.chenqun@huawei.com>
 <20201103015228.2250547-3-kuhn.chenqun@huawei.com>
In-Reply-To: <20201103015228.2250547-3-kuhn.chenqun@huawei.com>
From: Yuval Shaia <yuval.shaia.ml@gmail.com>
Date: Tue, 3 Nov 2020 21:49:59 +0200
Message-ID: <CAMPkWoN1UA+jVBhhZCa3v0EiP+wBR_3gpBBwFWcFZQF0_3HgZQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] hw/rdma/rdma_backend: fix uninitialized variable
 warning in rdma_poll_cq()
To: Chen Qun <kuhn.chenqun@huawei.com>
Content-Type: multipart/alternative; boundary="000000000000b14cee05b3392b70"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=yuval.shaia.ml@gmail.com; helo=mail-lf1-x144.google.com
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
Cc: ganqixin@huawei.com, qemu-trivial@nongnu.org,
 QEMU Developers <qemu-devel@nongnu.org>, Euler Robot <euler.robot@huawei.com>,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b14cee05b3392b70
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks,

Reviewed-by:  Yuval Shaia <yuval.shaia.ml@gmail.com>

On Tue, 3 Nov 2020 at 03:53, Chen Qun <kuhn.chenqun@huawei.com> wrote:

> After the WITH_QEMU_LOCK_GUARD macro is added, the compiler cannot identi=
fy
>  that the statements in the macro must be executed. As a result, some
> variables
>  assignment statements in the macro may be considered as unexecuted by th=
e
> compiler.
>
> The compiler showed warning:
> hw/rdma/rdma_backend.c: In function =E2=80=98rdma_poll_cq=E2=80=99:
> hw/rdma/rdma_utils.h:25:5: warning: =E2=80=98ne=E2=80=99 may be used unin=
itialized in this
> function [-Wmaybe-uninitialized]
>  25 |     error_report("%s: " fmt, "rdma", ## __VA_ARGS__)
>     |     ^~~~~~~~~~~~
> hw/rdma/rdma_backend.c:93:12: note: =E2=80=98ne=E2=80=99 was declared her=
e
>  93 |     int i, ne, total_ne =3D 0;
>     |            ^~
>
> Add a default value for 'ne' to prevented the warning.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
> ---
> Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> ---
>  hw/rdma/rdma_backend.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
> index 5de010b1fa..2fe4a3501c 100644
> --- a/hw/rdma/rdma_backend.c
> +++ b/hw/rdma/rdma_backend.c
> @@ -90,7 +90,7 @@ static void clean_recv_mads(RdmaBackendDev *backend_dev=
)
>
>  static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv_cq
> *ibcq)
>  {
> -    int i, ne, total_ne =3D 0;
> +    int i, ne =3D 0, total_ne =3D 0;
>      BackendCtx *bctx;
>      struct ibv_wc wc[2];
>      RdmaProtectedGSList *cqe_ctx_list;
> --
> 2.27.0
>
>

--000000000000b14cee05b3392b70
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks,<div><br><div>Reviewed-by:=C2=A0 Yuval Shaia &lt;<a=
 href=3D"mailto:yuval.shaia.ml@gmail.com">yuval.shaia.ml@gmail.com</a>&gt;<=
br></div></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, 3 Nov 2020 at 03:53, Chen Qun &lt;<a href=3D"mailto=
:kuhn.chenqun@huawei.com">kuhn.chenqun@huawei.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">After the WITH_QEMU_LOCK_G=
UARD macro is added, the compiler cannot identify<br>
=C2=A0that the statements in the macro must be executed. As a result, some =
variables<br>
=C2=A0assignment statements in the macro may be considered as unexecuted by=
 the compiler.<br>
<br>
The compiler showed warning:<br>
hw/rdma/rdma_backend.c: In function =E2=80=98rdma_poll_cq=E2=80=99:<br>
hw/rdma/rdma_utils.h:25:5: warning: =E2=80=98ne=E2=80=99 may be used uninit=
ialized in this function [-Wmaybe-uninitialized]<br>
=C2=A025 |=C2=A0 =C2=A0 =C2=A0error_report(&quot;%s: &quot; fmt, &quot;rdma=
&quot;, ## __VA_ARGS__)<br>
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~<br>
hw/rdma/rdma_backend.c:93:12: note: =E2=80=98ne=E2=80=99 was declared here<=
br>
=C2=A093 |=C2=A0 =C2=A0 =C2=A0int i, ne, total_ne =3D 0;<br>
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~<br>
<br>
Add a default value for &#39;ne&#39; to prevented the warning.<br>
<br>
Reported-by: Euler Robot &lt;<a href=3D"mailto:euler.robot@huawei.com" targ=
et=3D"_blank">euler.robot@huawei.com</a>&gt;<br>
Signed-off-by: Chen Qun &lt;<a href=3D"mailto:kuhn.chenqun@huawei.com" targ=
et=3D"_blank">kuhn.chenqun@huawei.com</a>&gt;<br>
---<br>
Cc: Yuval Shaia &lt;<a href=3D"mailto:yuval.shaia.ml@gmail.com" target=3D"_=
blank">yuval.shaia.ml@gmail.com</a>&gt;<br>
Cc: Marcel Apfelbaum &lt;<a href=3D"mailto:marcel.apfelbaum@gmail.com" targ=
et=3D"_blank">marcel.apfelbaum@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/rdma/rdma_backend.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c<br>
index 5de010b1fa..2fe4a3501c 100644<br>
--- a/hw/rdma/rdma_backend.c<br>
+++ b/hw/rdma/rdma_backend.c<br>
@@ -90,7 +90,7 @@ static void clean_recv_mads(RdmaBackendDev *backend_dev)<=
br>
<br>
=C2=A0static int rdma_poll_cq(RdmaDeviceResources *rdma_dev_res, struct ibv=
_cq *ibcq)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 int i, ne, total_ne =3D 0;<br>
+=C2=A0 =C2=A0 int i, ne =3D 0, total_ne =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0BackendCtx *bctx;<br>
=C2=A0 =C2=A0 =C2=A0struct ibv_wc wc[2];<br>
=C2=A0 =C2=A0 =C2=A0RdmaProtectedGSList *cqe_ctx_list;<br>
-- <br>
2.27.0<br>
<br>
</blockquote></div>

--000000000000b14cee05b3392b70--

