Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE62C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 03:32:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3139B206FB
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 03:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="fGXd+ni2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3139B206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKZ2a-0002ZW-UB
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 23:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kKZ1U-00028x-7B
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 23:31:20 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kKZ1S-0005Sn-20
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 23:31:19 -0400
Received: by mail-wm1-x343.google.com with SMTP id x23so1804164wmi.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 20:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+LdL2E3a+rKxwsPcop7cnf7//aVUCRxOi324QqAd/eA=;
 b=fGXd+ni2lryABxsizKm76vTS9fpnqJgw+e4OfOVZP09eORZyAFMBVjB/g+SOWrr7jr
 CWt6xmipY9vvaHS0l55gg9+42ovSsdY7ETbxZpmJOhRYrUu1dKbLzx05y22umRgiVIMS
 4ePg79SgqAHQ/85SCftxR6lUPvtxQtQfJvjrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+LdL2E3a+rKxwsPcop7cnf7//aVUCRxOi324QqAd/eA=;
 b=ofwXHCuxbwiAZW7KjSoOpQGM4QjWMvZNpjf/8F5HxDvtbnZozBsBnmseoVZM4f+GC6
 33p23JKOxbyYOX+pwlA0TVV0obbOH6eWHyijJHLVxmTMib8w+tggQdZ5d7qIo1y4Yvfd
 wuvlpDRysq5xHweW0UrehiBgL/VlhbUsOyygSgEwGcY9Qv2aoogcorA9M/oUgMB46GPg
 BGxrbpiSgd9gIGVw5uBhQ5LNtyr54uNKovfkxSFv0ZEDt5uoH431p7N1xYnlOBVLdnJI
 1Uxvt7Bb2H1+KNS5EEmNnzvj8dc2B65CIjpQ9p0cajV2v658aA07ZBq0yn2Ah+FlkAa+
 1a1Q==
X-Gm-Message-State: AOAM530G/X6l89sEEld2Ve7ttHyYQjmq0PeoXGoLgMhDoaR1FqZJXn0t
 ozDixA1awcjw4Q0pjvCIkCZQtA/UU8CMpuGUPfSwngKw5etfzg==
X-Google-Smtp-Source: ABdhPJyzqvbjuhuR5ftepQP6DVdObMGdlL2pnl1/nqY4O0ug4z1vImu/ZK8+r0+McMIBt7A/vln/dm17RqNVJPs8N6A=
X-Received: by 2002:a05:600c:258:: with SMTP id
 24mr2331634wmj.66.1600745475118; 
 Mon, 21 Sep 2020 20:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200910104650.1182807-1-dereksu@qnap.com>
 <20200910104650.1182807-2-dereksu@qnap.com>
In-Reply-To: <20200910104650.1182807-2-dereksu@qnap.com>
From: Derek Su <dereksu@qnap.com>
Date: Tue, 22 Sep 2020 11:31:04 +0800
Message-ID: <CAKEOLWXPfULXx5-vzg3w-DRS3azhkizo-Ne05FJE+t5mtPd4Mg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] COLO: only flush dirty ram pages from colo cache
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000006baeaa05afde9980"
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>, zhang.zhanghailiang@huawei.com,
 dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006baeaa05afde9980
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, all

Ping...

Regards,
Derek Su

Derek Su <dereksu@qnap.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=8810=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:47=E5=AF=AB=E9=81=93=EF=BC=9A

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

--0000000000006baeaa05afde9980
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smart=
mail=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div><font color=
=3D"#000000" face=3D"Arial, sans-serif">Hello, all</font></div><div><font c=
olor=3D"#000000" face=3D"Arial, sans-serif"><br></font></div><div><font fac=
e=3D"Arial, sans-serif" color=3D"#000000">Ping...</font></div><div><br></di=
v><div>Regards,</div></div></div></div></div>Derek Su</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Derek Su &lt;<a href=
=3D"mailto:dereksu@qnap.com">dereksu@qnap.com</a>&gt; =E6=96=BC 2020=E5=B9=
=B49=E6=9C=8810=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=886:47=E5=AF=AB=
=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">In secondary side, the colo_flush_ram_cache() calls<br>
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
2.25.1<br>
<br>
</blockquote></div>

--0000000000006baeaa05afde9980--

