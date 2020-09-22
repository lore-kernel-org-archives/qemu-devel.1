Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C218C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 05:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0CBE23A84
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 05:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="F4rBhX7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CBE23A84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKahs-0006un-Rj
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 01:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kKahI-0006Se-G7
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 01:18:36 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kKahG-0001LU-8K
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 01:18:36 -0400
Received: by mail-wm1-x343.google.com with SMTP id s13so1945056wmh.4
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 22:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Kw1tvxYBhKskojKIYFplLjCPX+Er5BLn4d+pxS71Em0=;
 b=F4rBhX7lKUMWnqcKB4VMePxjsdnSfQvaUaNvVo5WHhw2xyoIEGwXaB+ibi35o9SOC1
 Is7wqWsTscfRCC9Ii7MzbSJ6uiykU0qaBabR7Te3aysqMNc3Kjk//3WYsNrdSR5iVA7w
 rVDKEe4XAQVmesFmuhNTO2pPijdKfk57lmGa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Kw1tvxYBhKskojKIYFplLjCPX+Er5BLn4d+pxS71Em0=;
 b=QMxTQfFuftmnGIN2gqp64MlOPVRl7tsZTrgETPS3w9PVXqx98xHBDuC/ovQu9QxS2z
 dmy5AyhC3Y9KsqIKkpF18JiXkdIzDkuMf0h2spBNeRYZ8MOlbyLGugbsQ5KkTxPr8L8B
 gq4VNaLYHfPWImnDHQQqH8V5aA6fd59kG2wk1ogEfZRgYCSQhayfqocd9oTd5jFju5UG
 k12eA2RvGrYZL9w2PaLNzXXdEmzv33Ax13kElMDYVQ4MesIB64i93ckTZRjP9oXZ5Xie
 LPYJ4GSyFB8bMM1aZ0eqkYYgwTV7hN6KpJi+ne5z2fU8q//QNfUCj7d188XBYalgFpha
 EJ5A==
X-Gm-Message-State: AOAM531A/YWch7AvOcI63rts1RZPSeMw5lozXkfvsc1LhR5nOkig14/q
 vBE+9Yvy4BkUiELeVNZ6voTpcTwY1eZkbB2m5ic1gA==
X-Google-Smtp-Source: ABdhPJyKRTs5SBcGdr2OlUDjSLY7gwwt99EyT49A73hGdeDYpTizAvt7ovnPC1LLbre/jcMlnxITZrWJSEXAwnhLy04=
X-Received: by 2002:a1c:f208:: with SMTP id s8mr2580530wmc.85.1600751911031;
 Mon, 21 Sep 2020 22:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200910104650.1182807-1-dereksu@qnap.com>
 <20200910104650.1182807-2-dereksu@qnap.com>
 <CAKEOLWXPfULXx5-vzg3w-DRS3azhkizo-Ne05FJE+t5mtPd4Mg@mail.gmail.com>
 <b92f4c7b02fd448a949fed3b304cafa8@intel.com>
 <CAKEOLWW+zWuA6BYMcM35pqJFdSS+jz+1OfScsksb5izemfrGig@mail.gmail.com>
 <SN6PR11MB310385A0573115166280241DFD3B0@SN6PR11MB3103.namprd11.prod.outlook.com>
In-Reply-To: <SN6PR11MB310385A0573115166280241DFD3B0@SN6PR11MB3103.namprd11.prod.outlook.com>
From: Derek Su <dereksu@qnap.com>
Date: Tue, 22 Sep 2020 13:18:19 +0800
Message-ID: <CAKEOLWW+1qkNpBu27eqEvkp-OG4T_xGgpJd=L2i5YJ33WGKFOQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] COLO: only flush dirty ram pages from colo cache
To: "Rao, Lei" <lei.rao@intel.com>
Content-Type: multipart/alternative; boundary="00000000000007ebe705afe01914"
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=dereksu@qnap.com; helo=mail-wm1-x343.google.com
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "zhang.zhanghailiang@huawei.com" <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000007ebe705afe01914
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Lei

Got it. Thanks.

Regards,
Derek

Rao, Lei <lei.rao@intel.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=8822=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=881:04=E5=AF=AB=E9=81=93=EF=BC=9A

> Hi, Derek and Chen
>
> ram_bulk_stage is false by default before Hailiang's patch.
> For COLO, it does not seem to be used, so I think there is no need to
> reset it to true.
>
> Thanks,
> Lei.
>
> From: Derek Su <dereksu@qnap.com>
> Sent: Tuesday, September 22, 2020 11:48 AM
> To: Zhang, Chen <chen.zhang@intel.com>
> Cc: qemu-devel <qemu-devel@nongnu.org>; Rao, Lei <lei.rao@intel.com>;
> zhang.zhanghailiang@huawei.com; quintela@redhat.com; dgilbert@redhat.com
> Subject: Re: [PATCH v1 1/1] COLO: only flush dirty ram pages from colo
> cache
>
> Hi, Chen
>
> Sure.
>
> BTW, I just went through Lei's patch.
> ram_bulk_stage() might need to reset to true after stopping COLO service
> as my patch.
> How about your opinion?
>
> Thanks.
>
>
> Best regards,
> Derek
>
>
> Zhang, Chen <mailto:chen.zhang@intel.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=
=8822=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8811:41=E5=AF=AB=E9=81=93=
=EF=BC=9A
> Hi Derek and Lei,
>
> It looks same with Lei=E2=80=99 patch:
> [PATCH 2/3] Reduce the time of checkpoint for COLO
> Can you discuss to merge it into one patch?
>
> Thanks
> Zhang Chen
>
> From: Derek Su <mailto:dereksu@qnap.com>
> Sent: Tuesday, September 22, 2020 11:31 AM
> To: qemu-devel <mailto:qemu-devel@nongnu.org>
> Cc: mailto:zhang.zhanghailiang@huawei.com; mailto:quintela@redhat.com;
> mailto:dgilbert@redhat.com; Zhang, Chen <mailto:chen.zhang@intel.com>
> Subject: Re: [PATCH v1 1/1] COLO: only flush dirty ram pages from colo
> cache
>
> Hello, all
>
> Ping...
>
> Regards,
> Derek Su
>
> Derek Su <mailto:dereksu@qnap.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=8810=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:47=E5=AF=AB=E9=81=93=EF=BC=9A
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
> Signed-off-by: Derek Su <mailto:dereksu@qnap.com>
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

--00000000000007ebe705afe01914
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr" data-smartmail=3D"gmail_signature"><=
div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div>Hi, Lei</d=
iv><div><br></div><div>Got it. Thanks.</div><div><br></div><div>Regards,</d=
iv><div>Derek</div><div><br></div></div></div></div></div></div></div></div=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Rao, Lei =
&lt;<a href=3D"mailto:lei.rao@intel.com" target=3D"_blank">lei.rao@intel.co=
m</a>&gt; =E6=96=BC 2020=E5=B9=B49=E6=9C=8822=E6=97=A5 =E9=80=B1=E4=BA=8C =
=E4=B8=8B=E5=8D=881:04=E5=AF=AB=E9=81=93=EF=BC=9A<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Hi, Derek and Chen<br>
<br>
ram_bulk_stage is false by default before Hailiang&#39;s patch.<br>
For COLO, it does not seem to be used, so I think there is no need to reset=
 it to true.<br>
<br>
Thanks,<br>
Lei.<br>
<br>
From: Derek Su &lt;<a href=3D"mailto:dereksu@qnap.com" target=3D"_blank">de=
reksu@qnap.com</a>&gt; <br>
Sent: Tuesday, September 22, 2020 11:48 AM<br>
To: Zhang, Chen &lt;<a href=3D"mailto:chen.zhang@intel.com" target=3D"_blan=
k">chen.zhang@intel.com</a>&gt;<br>
Cc: qemu-devel &lt;<a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blan=
k">qemu-devel@nongnu.org</a>&gt;; Rao, Lei &lt;<a href=3D"mailto:lei.rao@in=
tel.com" target=3D"_blank">lei.rao@intel.com</a>&gt;; <a href=3D"mailto:zha=
ng.zhanghailiang@huawei.com" target=3D"_blank">zhang.zhanghailiang@huawei.c=
om</a>; <a href=3D"mailto:quintela@redhat.com" target=3D"_blank">quintela@r=
edhat.com</a>; <a href=3D"mailto:dgilbert@redhat.com" target=3D"_blank">dgi=
lbert@redhat.com</a><br>
Subject: Re: [PATCH v1 1/1] COLO: only flush dirty ram pages from colo cach=
e<br>
<br>
Hi, Chen<br>
<br>
Sure.<br>
<br>
BTW, I just went through Lei&#39;s patch.<br>
ram_bulk_stage() might need to reset to true after stopping COLO service as=
 my patch.<br>
How about your opinion?<br>
<br>
Thanks.<br>
<br>
<br>
Best regards,<br>
Derek<br>
<br>
<br>
Zhang, Chen &lt;mailto:<a href=3D"mailto:chen.zhang@intel.com" target=3D"_b=
lank">chen.zhang@intel.com</a>&gt; =E6=96=BC 2020=E5=B9=B49=E6=9C=8822=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8811:41=E5=AF=AB=E9=81=93=EF=BC=
=9A<br>
Hi Derek and Lei,<br>
=C2=A0<br>
It looks same with Lei=E2=80=99 patch:<br>
[PATCH 2/3] Reduce the time of checkpoint for COLO<br>
Can you discuss to merge it into one patch?<br>
=C2=A0<br>
Thanks<br>
Zhang Chen<br>
=C2=A0<br>
From: Derek Su &lt;mailto:<a href=3D"mailto:dereksu@qnap.com" target=3D"_bl=
ank">dereksu@qnap.com</a>&gt; <br>
Sent: Tuesday, September 22, 2020 11:31 AM<br>
To: qemu-devel &lt;mailto:<a href=3D"mailto:qemu-devel@nongnu.org" target=
=3D"_blank">qemu-devel@nongnu.org</a>&gt;<br>
Cc: mailto:<a href=3D"mailto:zhang.zhanghailiang@huawei.com" target=3D"_bla=
nk">zhang.zhanghailiang@huawei.com</a>; mailto:<a href=3D"mailto:quintela@r=
edhat.com" target=3D"_blank">quintela@redhat.com</a>; mailto:<a href=3D"mai=
lto:dgilbert@redhat.com" target=3D"_blank">dgilbert@redhat.com</a>; Zhang, =
Chen &lt;mailto:<a href=3D"mailto:chen.zhang@intel.com" target=3D"_blank">c=
hen.zhang@intel.com</a>&gt;<br>
Subject: Re: [PATCH v1 1/1] COLO: only flush dirty ram pages from colo cach=
e<br>
=C2=A0<br>
Hello, all<br>
=C2=A0<br>
Ping...<br>
=C2=A0<br>
Regards,<br>
Derek Su<br>
=C2=A0<br>
Derek Su &lt;mailto:<a href=3D"mailto:dereksu@qnap.com" target=3D"_blank">d=
ereksu@qnap.com</a>&gt; =E6=96=BC 2020=E5=B9=B49=E6=9C=8810=E6=97=A5 =E9=80=
=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:47=E5=AF=AB=E9=81=93=EF=BC=9A<br>
In secondary side, the colo_flush_ram_cache() calls<br>
migration_bitmap_find_dirty() to finding the dirty pages and<br>
flush them to host. But ram_state&#39;s ram_bulk_stage flag is always<br>
enabled in secondary side, it leads to the whole ram pages copy<br>
instead of only dirty pages.<br>
<br>
Here, the ram_bulk_stage in secondary side is disabled in the<br>
preparation of COLO incoming process to avoid the whole dirty<br>
ram pages flush.<br>
<br>
Signed-off-by: Derek Su &lt;mailto:<a href=3D"mailto:dereksu@qnap.com" targ=
et=3D"_blank">dereksu@qnap.com</a>&gt;<br>
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
2.25.1<br>
</blockquote></div></div>

--00000000000007ebe705afe01914--

