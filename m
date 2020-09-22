Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA66C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 03:49:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7806F23A32
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 03:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="NGB3q1og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7806F23A32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKZIY-0000xz-Cw
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 23:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kKZHz-0000Wi-MB
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 23:48:23 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34636)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kKZHx-0007b9-HT
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 23:48:23 -0400
Received: by mail-wm1-x342.google.com with SMTP id l15so1237975wmh.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 20:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BOLhM2iI9aaRWkitloKzuyDTYFu3KZiGJYqeD/MFU7k=;
 b=NGB3q1og7k+gTXiIrNhzrsFMtyeIc+ON0cSjLoDohkjNbFBg2zj9g8oEhUvaZ1QNFt
 gqCsY343xJuj0CqjW6DmVAmRSGMApWrABOqeJCq6Lq/Yp+nYwgCKekNKi8wzFlwn92m0
 bGxSHKOSwdelg3RazJzD8flUwMQa0zjcS3vZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BOLhM2iI9aaRWkitloKzuyDTYFu3KZiGJYqeD/MFU7k=;
 b=DSZpNVj9E/i4Lts+KxbTUSWZ0d0pzcTOY01fykQMsrfD5hvknhNoOxmk5LKaNv3BPp
 GdNIjATWDeRGGoD15UCF8jcUPiYD7VZ7eNYwB9djA2I7mt7zTFqvFm6RKpRtEtuQb/gp
 nYr5TLqQY1evP2TZKBBrf7D5aO33TswZWlgrmf6xTVIkiqCORoPlJPaE0tWzz+OohfEW
 NMLhen5qmdA1p1TyRaqKSiGOVLWgVxMY/EqjyS8ww1ZR6pWLJS5kGDsbSRVEKGMWEiQr
 jFpI9aFvyhAMq3Ib3oJU/Dnn4kkAiNBwNL4q9L2ANqDRJyFzd8GFVgYX3lTbIOn9H2As
 Y+Jg==
X-Gm-Message-State: AOAM533V6c2GzIYng6RgGprKnuUdy6datZIEuC0xPBtkhTvcY0kAjGn8
 j6Fc9oS7+3AiDHrLow6paZ7VfEdG+yhQwn6Wt2w8RQ==
X-Google-Smtp-Source: ABdhPJxGCP4QTRq1uTgBIqwQgdROhZhvYQSa++Pe506DZoLcukdZkM4r38JC2EXGhKttdDpDKRUqPEreBEF3rmr2A4I=
X-Received: by 2002:a7b:cc17:: with SMTP id f23mr2114416wmh.166.1600746499484; 
 Mon, 21 Sep 2020 20:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200910104650.1182807-1-dereksu@qnap.com>
 <20200910104650.1182807-2-dereksu@qnap.com>
 <CAKEOLWXPfULXx5-vzg3w-DRS3azhkizo-Ne05FJE+t5mtPd4Mg@mail.gmail.com>
 <b92f4c7b02fd448a949fed3b304cafa8@intel.com>
In-Reply-To: <b92f4c7b02fd448a949fed3b304cafa8@intel.com>
From: Derek Su <dereksu@qnap.com>
Date: Tue, 22 Sep 2020 11:48:08 +0800
Message-ID: <CAKEOLWW+zWuA6BYMcM35pqJFdSS+jz+1OfScsksb5izemfrGig@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] COLO: only flush dirty ram pages from colo cache
To: "Zhang, Chen" <chen.zhang@intel.com>
Content-Type: multipart/alternative; boundary="0000000000007a3ed005afded67d"
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=dereksu@qnap.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: "Rao, Lei" <lei.rao@intel.com>, "quintela@redhat.com" <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "zhang.zhanghailiang@huawei.com" <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007a3ed005afded67d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Chen

Sure.

BTW, I just went through Lei's patch.
ram_bulk_stage() might need to reset to true after stopping COLO service as
my patch.
How about your opinion?

Thanks.

Best regards,
Derek


Zhang, Chen <chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=8822=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8811:41=E5=AF=AB=E9=81=93=EF=BC=
=9A

> Hi Derek and Lei,
>
>
>
> It looks same with Lei=E2=80=99 patch:
>
> [PATCH 2/3] Reduce the time of checkpoint for COLO
>
> Can you discuss to merge it into one patch?
>
>
>
> Thanks
>
> Zhang Chen
>
>
>
> *From:* Derek Su <dereksu@qnap.com>
> *Sent:* Tuesday, September 22, 2020 11:31 AM
> *To:* qemu-devel <qemu-devel@nongnu.org>
> *Cc:* zhang.zhanghailiang@huawei.com; quintela@redhat.com;
> dgilbert@redhat.com; Zhang, Chen <chen.zhang@intel.com>
> *Subject:* Re: [PATCH v1 1/1] COLO: only flush dirty ram pages from colo
> cache
>
>
>
> Hello, all
>
>
>
> Ping...
>
>
>
> Regards,
>
> Derek Su
>
>
>
> Derek Su <dereksu@qnap.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=8810=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:47=E5=AF=AB=E9=81=93=EF=BC=9A
>
> In secondary side, the colo_flush_ram_cache() calls
> migration_bitmap_find_dirty() to finding the dirty pages and
> flush them to host. But ram_state's ram_bulk_stage flag is always
> enabled in secondary side, it leads to the whole ram pages copy
> instead of only dirty pages.
>
> Here, the ram_bulk_stage in secondary side is disabled in the
> preparation of COLO incoming process to avoid the whole dirty
> ram pages flush.
>
> Signed-off-by: Derek Su <dereksu@qnap.com>
> ---
>  migration/colo.c |  6 +++++-
>  migration/ram.c  | 10 ++++++++++
>  migration/ram.h  |  3 +++
>  3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index ea7d1e9d4e..6e644db306 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -844,6 +844,8 @@ void *colo_process_incoming_thread(void *opaque)
>          return NULL;
>      }
>
> +    colo_disable_ram_bulk_stage();
> +
>      failover_init_state();
>
>      mis->to_src_file =3D qemu_file_get_return_path(mis->from_src_file);
> @@ -873,7 +875,7 @@ void *colo_process_incoming_thread(void *opaque)
>          goto out;
>      }
>  #else
> -        abort();
> +    abort();
>  #endif
>      vm_start();
>      trace_colo_vm_state_change("stop", "run");
> @@ -924,6 +926,8 @@ out:
>          qemu_fclose(fb);
>      }
>
> +    colo_enable_ram_bulk_stage();
> +
>      /* Hope this not to be too long to loop here */
>      qemu_sem_wait(&mis->colo_incoming_sem);
>      qemu_sem_destroy(&mis->colo_incoming_sem);
> diff --git a/migration/ram.c b/migration/ram.c
> index 76d4fee5d5..65e9b12058 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3357,6 +3357,16 @@ static bool postcopy_is_running(void)
>      return ps >=3D POSTCOPY_INCOMING_LISTENING && ps <
> POSTCOPY_INCOMING_END;
>  }
>
> +void colo_enable_ram_bulk_stage(void)
> +{
> +    ram_state->ram_bulk_stage =3D true;
> +}
> +
> +void colo_disable_ram_bulk_stage(void)
> +{
> +    ram_state->ram_bulk_stage =3D false;
> +}
> +
>  /*
>   * Flush content of RAM cache into SVM's memory.
>   * Only flush the pages that be dirtied by PVM or SVM or both.
> diff --git a/migration/ram.h b/migration/ram.h
> index 2eeaacfa13..c1c0ebbe0f 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -69,4 +69,7 @@ void colo_flush_ram_cache(void);
>  void colo_release_ram_cache(void);
>  void colo_incoming_start_dirty_log(void);
>
> +void colo_enable_ram_bulk_stage(void);
> +void colo_disable_ram_bulk_stage(void);
> +
>  #endif
> --
> 2.25.1
>
>

--0000000000007a3ed005afded67d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi, Chen</div><div><br></div>Sure.<div><br></div><div=
>BTW, I just went through Lei&#39;s patch.</div><div>ram_bulk_stage() might=
 need to reset to true after stopping COLO service as my patch.</div><div>H=
ow about your opinion?</div><div><br></div><div>Thanks.<br clear=3D"all"><d=
iv><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signa=
ture"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><font face=3D"Aria=
l, sans-serif" color=3D"#000000"><span style=3D"font-size:13.3333px"><br>Be=
st regards,<br></span>Derek</font></div></div></div></div></div><br></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Z=
hang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com">chen.zhang@intel.com=
</a>&gt; =E6=96=BC 2020=E5=B9=B49=E6=9C=8822=E6=97=A5 =E9=80=B1=E4=BA=8C =
=E4=B8=8A=E5=8D=8811:41=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">





<div lang=3D"EN-US">
<div class=3D"gmail-m_-7816223810535130304WordSection1">
<p class=3D"MsoNormal">Hi Derek and Lei,<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">It looks same with Lei=E2=80=99 patch:<u></u><u></u>=
</p>
<p class=3D"MsoNormal">[PATCH 2/3] Reduce the time of checkpoint for COLO<u=
></u><u></u></p>
<p class=3D"MsoNormal">Can you discuss to merge it into one patch?<u></u><u=
></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<p class=3D"MsoNormal">Thanks<u></u><u></u></p>
<p class=3D"MsoNormal">Zhang Chen<u></u><u></u></p>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div style=3D"border-top:none;border-right:none;border-bottom:none;border-l=
eft:1.5pt solid blue;padding:0in 0in 0in 4pt">
<div>
<div style=3D"border-right:none;border-bottom:none;border-left:none;border-=
top:1pt solid rgb(225,225,225);padding:3pt 0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Derek Su &lt;<a href=3D"mailto:dereksu@=
qnap.com" target=3D"_blank">dereksu@qnap.com</a>&gt; <br>
<b>Sent:</b> Tuesday, September 22, 2020 11:31 AM<br>
<b>To:</b> qemu-devel &lt;<a href=3D"mailto:qemu-devel@nongnu.org" target=
=3D"_blank">qemu-devel@nongnu.org</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:zhang.zhanghailiang@huawei.com" target=3D"_bla=
nk">zhang.zhanghailiang@huawei.com</a>; <a href=3D"mailto:quintela@redhat.c=
om" target=3D"_blank">quintela@redhat.com</a>; <a href=3D"mailto:dgilbert@r=
edhat.com" target=3D"_blank">dgilbert@redhat.com</a>; Zhang, Chen &lt;<a hr=
ef=3D"mailto:chen.zhang@intel.com" target=3D"_blank">chen.zhang@intel.com</=
a>&gt;<br>
<b>Subject:</b> Re: [PATCH v1 1/1] COLO: only flush dirty ram pages from co=
lo cache<u></u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:Arial,sans-serif;color:bl=
ack">Hello, all</span><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-family:Arial,sans-serif;color:bl=
ack">Ping...</span><u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Regards,<u></u><u></u></p>
</div>
</div>
</div>
</div>
</div>
<p class=3D"MsoNormal">Derek Su<u></u><u></u></p>
</div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<div>
<p class=3D"MsoNormal">Derek Su &lt;<a href=3D"mailto:dereksu@qnap.com" tar=
get=3D"_blank">dereksu@qnap.com</a>&gt;
<span lang=3D"ZH-CN" style=3D"font-family:DengXian">=E6=96=BC</span> 2020<s=
pan lang=3D"ZH-CN" style=3D"font-family:DengXian">=E5=B9=B4</span>9<span la=
ng=3D"ZH-CN" style=3D"font-family:DengXian">=E6=9C=88</span>10<span lang=3D=
"ZH-CN" style=3D"font-family:DengXian">=E6=97=A5</span><span lang=3D"ZH-CN"=
>
</span><span lang=3D"ZH-CN" style=3D"font-family:DengXian">=E9=80=B1=E5=9B=
=9B</span><span lang=3D"ZH-CN">
</span><span lang=3D"ZH-CN" style=3D"font-family:DengXian">=E4=B8=8B=E5=8D=
=88</span>6:47<span lang=3D"ZH-CN" style=3D"font-family:DengXian">=E5=AF=AB=
=E9=81=93=EF=BC=9A</span><u></u><u></u></p>
</div>
<blockquote style=3D"border-top:none;border-right:none;border-bottom:none;b=
order-left:1pt solid rgb(204,204,204);padding:0in 0in 0in 6pt;margin:5pt 0i=
n 5pt 4.8pt">
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt">In secondary side, the =
colo_flush_ram_cache() calls<br>
migration_bitmap_find_dirty() to finding the dirty pages and<br>
flush them to host. But ram_state&#39;s ram_bulk_stage flag is always<br>
enabled in secondary side, it leads to the whole ram pages copy<br>
instead of only dirty pages.<br>
<br>
Here, the ram_bulk_stage in secondary side is disabled in the<br>
preparation of COLO incoming process to avoid the whole dirty<br>
ram pages flush.<br>
<br>
Signed-off-by: Derek Su &lt;<a href=3D"mailto:dereksu@qnap.com" target=3D"_=
blank">dereksu@qnap.com</a>&gt;<br>
---<br>
=C2=A0migration/colo.c |=C2=A0 6 +++++-<br>
=C2=A0migration/ram.c=C2=A0 | 10 ++++++++++<br>
=C2=A0migration/ram.h=C2=A0 |=C2=A0 3 +++<br>
=C2=A03 files changed, 18 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/migration/colo.c b/migration/colo.c<br>
index ea7d1e9d4e..6e644db306 100644<br>
--- a/migration/colo.c<br>
+++ b/migration/colo.c<br>
@@ -844,6 +844,8 @@ void *colo_process_incoming_thread(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 colo_disable_ram_bulk_stage();<br>
+<br>
=C2=A0 =C2=A0 =C2=A0failover_init_state();<br>
<br>
=C2=A0 =C2=A0 =C2=A0mis-&gt;to_src_file =3D qemu_file_get_return_path(mis-&=
gt;from_src_file);<br>
@@ -873,7 +875,7 @@ void *colo_process_incoming_thread(void *opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 abort();<br>
+=C2=A0 =C2=A0 abort();<br>
=C2=A0#endif<br>
=C2=A0 =C2=A0 =C2=A0vm_start();<br>
=C2=A0 =C2=A0 =C2=A0trace_colo_vm_state_change(&quot;stop&quot;, &quot;run&=
quot;);<br>
@@ -924,6 +926,8 @@ out:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_fclose(fb);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 colo_enable_ram_bulk_stage();<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* Hope this not to be too long to loop here */<br>
=C2=A0 =C2=A0 =C2=A0qemu_sem_wait(&amp;mis-&gt;colo_incoming_sem);<br>
=C2=A0 =C2=A0 =C2=A0qemu_sem_destroy(&amp;mis-&gt;colo_incoming_sem);<br>
diff --git a/migration/ram.c b/migration/ram.c<br>
index 76d4fee5d5..65e9b12058 100644<br>
--- a/migration/ram.c<br>
+++ b/migration/ram.c<br>
@@ -3357,6 +3357,16 @@ static bool postcopy_is_running(void)<br>
=C2=A0 =C2=A0 =C2=A0return ps &gt;=3D POSTCOPY_INCOMING_LISTENING &amp;&amp=
; ps &lt; POSTCOPY_INCOMING_END;<br>
=C2=A0}<br>
<br>
+void colo_enable_ram_bulk_stage(void)<br>
+{<br>
+=C2=A0 =C2=A0 ram_state-&gt;ram_bulk_stage =3D true;<br>
+}<br>
+<br>
+void colo_disable_ram_bulk_stage(void)<br>
+{<br>
+=C2=A0 =C2=A0 ram_state-&gt;ram_bulk_stage =3D false;<br>
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 * Flush content of RAM cache into SVM&#39;s memory.<br>
=C2=A0 * Only flush the pages that be dirtied by PVM or SVM or both.<br>
diff --git a/migration/ram.h b/migration/ram.h<br>
index 2eeaacfa13..c1c0ebbe0f 100644<br>
--- a/migration/ram.h<br>
+++ b/migration/ram.h<br>
@@ -69,4 +69,7 @@ void colo_flush_ram_cache(void);<br>
=C2=A0void colo_release_ram_cache(void);<br>
=C2=A0void colo_incoming_start_dirty_log(void);<br>
<br>
+void colo_enable_ram_bulk_stage(void);<br>
+void colo_disable_ram_bulk_stage(void);<br>
+<br>
=C2=A0#endif<br>
-- <br>
2.25.1<u></u><u></u></p>
</blockquote>
</div>
</div>
</div>
</div>

</blockquote></div>

--0000000000007a3ed005afded67d--

