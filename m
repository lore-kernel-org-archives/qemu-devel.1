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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419BEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:42:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A47E2064C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 16:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeBNeco2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A47E2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZzNw-0005Ko-LI
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 11:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1kZzN8-0004ss-5Z; Tue, 03 Nov 2020 11:41:26 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcel.apfelbaum@gmail.com>)
 id 1kZzN6-0000nL-8C; Tue, 03 Nov 2020 11:41:25 -0500
Received: by mail-ot1-x341.google.com with SMTP id 79so9083281otc.7;
 Tue, 03 Nov 2020 08:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=etzqwJCnLxbwYnPutYppI360nP/81cKAD5STmw43AkE=;
 b=FeBNeco2VnDBOnRLvuFTuOJEz6M6a+YZizfE0AyEa8R49LnBE30fQJnyh4VIkZHc6X
 lj5sOBlhzKlFURAFPpEn53PE9yMAhvlcUdoxJ6luSq2UxpihZveQE9plontHR7diZuoC
 rl70c4RXRCEkr3rJP4mq90FKN6VAnrKoclPZDjLslj5zNxSJXyNorib5r2AJpqZohwfr
 nFfVEz86UxZGupoPzBC6qLePZZqQRXaV0f/CJtffEekGxrXWivcU432oNbOMU7u2mq8W
 pp9PmLlVpdtEFFFZGXBCXIC4CuKq7hHrg0o9qic8l+P8lpoeKinkoXS23F5kx1TNrc+J
 PxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=etzqwJCnLxbwYnPutYppI360nP/81cKAD5STmw43AkE=;
 b=AY5+WVjxhNr7ceEHUFNw0++oPHaC1TkfhuV7OKePz+YZLSaVq3zDgiLX2NP/r80ss0
 ouKEh1M+GEDbe4Z3TDteaG/LeoskY+wiyUa/FBg+dmm3Th8t58QaOKtnaDGI004FP8Oo
 WhpgbOJZpxGKhQ/LhITzvknRi0Qts88l/kMDGO/WyOrm/25OwtRJ57gjRbJdlPe2aGYY
 S1EETVUssZA6IP6PU5lD6C61QSWY3fZd8J9X3jTQ53xE2TlR/UwDIs3sasDkgYbvxMrF
 SRs3BvU4lVtl2UUNT1hdfN7r/9AAGwAVG+9RivnmifThDx8hyo44TOl+N33c4mekSQVD
 Dfdw==
X-Gm-Message-State: AOAM530T+Ln/w2fEYTiViT8f0gbKqMuRWwI8b4aRkh3NKU+3/3LkJisX
 OzLe1iuQB8mTsySbMS1Dpqa+vMqQAG227pBLgfk=
X-Google-Smtp-Source: ABdhPJw6U9w0n0iViBApvdreKXLYoRy8dqoQZ9IEYRZVGn0O/7xOEeuNqMLpuw5Pbolx0X9cWRH0TX1UOW5Ow4nZeog=
X-Received: by 2002:a9d:6641:: with SMTP id q1mr11213035otm.190.1604421682703; 
 Tue, 03 Nov 2020 08:41:22 -0800 (PST)
MIME-Version: 1.0
References: <20201103015228.2250547-1-kuhn.chenqun@huawei.com>
 <20201103015228.2250547-3-kuhn.chenqun@huawei.com>
In-Reply-To: <20201103015228.2250547-3-kuhn.chenqun@huawei.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Tue, 3 Nov 2020 18:41:11 +0200
Message-ID: <CAC_L=vWANsB=2+jrE5aCw3TS2hQ-QwqX8n8ETajxfjV5DOLh1w@mail.gmail.com>
Subject: Re: [PATCH 2/6] hw/rdma/rdma_backend: fix uninitialized variable
 warning in rdma_poll_cq()
To: Chen Qun <kuhn.chenqun@huawei.com>
Content-Type: multipart/alternative; boundary="00000000000077b0a005b3368826"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=marcel.apfelbaum@gmail.com; helo=mail-ot1-x341.google.com
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
Cc: zhang.zhanghailiang@huawei.com, qemu-trivial@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 qemu devel list <qemu-devel@nongnu.org>, ganqixin@huawei.com,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000077b0a005b3368826
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chen,

On Tue, Nov 3, 2020 at 3:53 AM Chen Qun <kuhn.chenqun@huawei.com> wrote:

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
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Thanks for the fix,
Marcel

--00000000000077b0a005b3368826
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Chen,</div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Nov 3, 2020 at 3:53 AM Chen Qun &lt;<=
a href=3D"mailto:kuhn.chenqun@huawei.com">kuhn.chenqun@huawei.com</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">After the =
WITH_QEMU_LOCK_GUARD macro is added, the compiler cannot identify<br>
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
<br></blockquote><div><br></div><div><div><div>Reviewed-by: Marcel Apfelbau=
m &lt;<a href=3D"mailto:marcel.apfelbaum@gmail.com" target=3D"_blank">marce=
l.apfelbaum@gmail.com</a>&gt;</div></div><div><br></div><div>Thanks for the=
 fix,</div><div>Marcel</div></div><div>=C2=A0</div></div></div>

--00000000000077b0a005b3368826--

