Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C44C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:37:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C320620657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwxyqpKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C320620657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZaWJ-0002HG-0Z
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <johnnymarler@gmail.com>)
 id 1jZaVh-0001mc-Km
 for qemu-devel@nongnu.org; Fri, 15 May 2020 09:36:21 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:38161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <johnnymarler@gmail.com>)
 id 1jZaVg-0005LG-Nx
 for qemu-devel@nongnu.org; Fri, 15 May 2020 09:36:21 -0400
Received: by mail-lj1-x244.google.com with SMTP id e25so2277780ljg.5
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 06:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=AXu5FRrrqwUjwHItVUPJPZq5M/BxfT/VRrIVNZ3LYk8=;
 b=mwxyqpKBPDiMgmx3Bi/D1w00NOS1KuVefcQMNbRpmxdINHl3hhMOM+2TKqzjHaFk8T
 E+9z2ADdAtGMjdEqvRPSpgoJYmRuVwPc+yFSOZcu6H71XBqZin2RLu0HdIVrpkSBvZ57
 NRCzdgPHFoXXI1BxT3NprgM7zyoEyFDSLCy1P5IBGLEF5MZzyt2dJkUD8Qfc5ujr/jcP
 5gYIl1I24gZuOzsNeo3zwlo0ELFllHXRy5Vr3Ln3tGcYr+ZreEyUd4M1n5Pcbr3c81B7
 DSTrn28Wxfpc60fGeIyDapKle84qkLVau6nG8mXwuY8hMXCo4wOKxmtKL5edUfxg91at
 1bBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=AXu5FRrrqwUjwHItVUPJPZq5M/BxfT/VRrIVNZ3LYk8=;
 b=c+7H4wFLIwIVHHXs6ScYe2Py7089LPoPEKirC30XqRlfiY/9pEoYO2XPMJAe6/Jjdz
 iD8/4/thQUwdKd7eUnOh8w0ya7srFEx+jDtW2kdBls7qkFLVzMB2yzjHxSt0RgjXrAIU
 eDNhV3ZUmJ8hQJGuXVBibCW2BuqCQw/l803lHSrUVwh56jWhyF6zzDwM/IMTxKcVzhv3
 NGhUAElL9ghGJrCEaSe8xGfrBxykW2so83k5Bhc1F8Hr6nMGFAZ41oKKimIFNPveCMB7
 nEW55dKOuH/53tiTwR69ZV/hm7EoBjqlTZxcrlK9uQK3Z7AYoJK6srCSOKPjGk4doZWt
 4zCQ==
X-Gm-Message-State: AOAM531It8dnuk+/t/KkvMDu2SOfGE2QWRzVYiws2JJknX9ArpOQDZU2
 /sy6NFfEL1J0kVFA3lcqzGbOoLwbzeO8YWLYe6Z3AghHgwU=
X-Google-Smtp-Source: ABdhPJxXW9j4B8aAzzgsNWTvtdw7gb9Oq+suGZT/SaV6p7wUDNKzwapYUK1x5XHqT3yAm5yTBVWlEFzc7EVCx1ySoVQ=
X-Received: by 2002:a2e:9b0f:: with SMTP id u15mr2338416lji.272.1589549778027; 
 Fri, 15 May 2020 06:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200502161225.14346-1-johnnymarler@gmail.com>
 <CACKT+Ao+hRRuSarAcWy0PDzV8u5CF9KQq07dgVsLmQddSTfj6Q@mail.gmail.com>
In-Reply-To: <CACKT+Ao+hRRuSarAcWy0PDzV8u5CF9KQq07dgVsLmQddSTfj6Q@mail.gmail.com>
From: Jonathan Marler <johnnymarler@gmail.com>
Date: Fri, 15 May 2020 07:36:08 -0600
Message-ID: <CACKT+ApwXFEK3tu5=ZpOZrGNYLXcO6w9rv7QUEDrJKBkCQ8wGw@mail.gmail.com>
Subject: Re: [PATCH] linux-user/mmap.c: fix integer underflow in target_mremap
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000df4a7805a5afe548"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=johnnymarler@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000df4a7805a5afe548
Content-Type: text/plain; charset="UTF-8"

Been a couple weeks, checking to see if anyone has looked at this.

On Sat, May 2, 2020 at 5:43 PM Jonathan Marler <johnnymarler@gmail.com>
wrote:

> FYI, I applied this patch to the qemu build that zig uses to run
> non-native tests (
> https://github.com/ziglang/qemu-static/blob/master/patch/mremap-underflow.diff
> )
>
> After applying it, my new code that calls mremap now passes,
> whereas before the fix I was getting a segfault.
>
> On Sat, May 2, 2020 at 10:12 AM Jonathan Marler <johnnymarler@gmail.com>
> wrote:
>
>> Fixes: https://bugs.launchpad.net/bugs/1876373
>>
>> This code path in mmap occurs when a page size is decreased with mremap.
>> When a section of pages is shrunk, qemu calls mmap_reserve on the pages
>> that were released.  However, it has the diff operation reversed,
>> subtracting the larger old_size from the smaller new_size.  Instead, it
>> should be subtracting the smaller new_size from the larger old_size.  You
>> can also see in the previous line of the change that this mmap_reserve call
>> only occurs when old_size > new_size.
>>
>> Signed-off-by: Jonathan Marler <johnnymarler@gmail.com>
>> ---
>>  linux-user/mmap.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>> index e378033797..caab62909e 100644
>> --- a/linux-user/mmap.c
>> +++ b/linux-user/mmap.c
>> @@ -708,7 +708,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong
>> old_size,
>>          if (prot == 0) {
>>              host_addr = mremap(g2h(old_addr), old_size, new_size, flags);
>>              if (host_addr != MAP_FAILED && reserved_va && old_size >
>> new_size) {
>> -                mmap_reserve(old_addr + old_size, new_size - old_size);
>> +                mmap_reserve(old_addr + old_size, old_size - new_size);
>>              }
>>          } else {
>>              errno = ENOMEM;
>> --
>> 2.23.1
>>
>>

--000000000000df4a7805a5afe548
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Been a couple weeks, checking to see if anyone has looked =
at this.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Sat, May 2, 2020 at 5:43 PM Jonathan Marler &lt;<a href=3D"mailt=
o:johnnymarler@gmail.com">johnnymarler@gmail.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">FYI, I app=
lied this patch to the qemu build that zig uses=C2=A0to run non-native test=
s (

<a href=3D"https://github.com/ziglang/qemu-static/blob/master/patch/mremap-=
underflow.diff" target=3D"_blank">https://github.com/ziglang/qemu-static/bl=
ob/master/patch/mremap-underflow.diff</a>)<div><br><div>After applying it, =
my new code that calls mremap now passes, whereas=C2=A0before the fix I was=
 getting a segfault.</div></div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Sat, May 2, 2020 at 10:12 AM Jonathan Ma=
rler &lt;<a href=3D"mailto:johnnymarler@gmail.com" target=3D"_blank">johnny=
marler@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">Fixes: <a href=3D"https://bugs.launchpad.net/bugs/1876373" =
rel=3D"noreferrer" target=3D"_blank">https://bugs.launchpad.net/bugs/187637=
3</a><br>
<br>
This code path in mmap occurs when a page size is decreased with mremap.=C2=
=A0 When a section of pages is shrunk, qemu calls mmap_reserve on the pages=
 that were released.=C2=A0 However, it has the diff operation reversed, sub=
tracting the larger old_size from the smaller new_size.=C2=A0 Instead, it s=
hould be subtracting the smaller new_size from the larger old_size.=C2=A0 Y=
ou can also see in the previous line of the change that this mmap_reserve c=
all only occurs when old_size &gt; new_size.<br>
<br>
Signed-off-by: Jonathan Marler &lt;<a href=3D"mailto:johnnymarler@gmail.com=
" target=3D"_blank">johnnymarler@gmail.com</a>&gt;<br>
---<br>
=C2=A0linux-user/mmap.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/linux-user/mmap.c b/linux-user/mmap.c<br>
index e378033797..caab62909e 100644<br>
--- a/linux-user/mmap.c<br>
+++ b/linux-user/mmap.c<br>
@@ -708,7 +708,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong ol=
d_size,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (prot =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host_addr =3D mremap(g2h(ol=
d_addr), old_size, new_size, flags);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (host_addr !=3D MAP_FAIL=
ED &amp;&amp; reserved_va &amp;&amp; old_size &gt; new_size) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_reserve(old_a=
ddr + old_size, new_size - old_size);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmap_reserve(old_a=
ddr + old_size, old_size - new_size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D ENOMEM;<br>
-- <br>
2.23.1<br>
<br>
</blockquote></div>
</blockquote></div>

--000000000000df4a7805a5afe548--

