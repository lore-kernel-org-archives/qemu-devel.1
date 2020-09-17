Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C73C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D3B2072E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 07:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fwPndq6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D3B2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIoLy-0002F8-P3
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 03:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1kIoJo-00085n-SP
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:27:00 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:34598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scw@google.com>) id 1kIoJm-00026C-Lc
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:27:00 -0400
Received: by mail-ed1-x541.google.com with SMTP id k14so1461944edo.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GbM8qbPms0fd6ijq1GteDCY7MDClddMOoZTvyOWkR5E=;
 b=fwPndq6MsEj/KhApi0pqYKyKiefQSpj17SOLUGwEnZB6dqHh+r5thFUVE2Vn1JlLBW
 HmCGDarV3URjAkvZ/IRx5pzld+LOcGNHAG03eFhenwUza/K6Nab6YcDc3Vv3JrgfjuZL
 p3oaPMGK+UEYP2Ci+GAJDqMWzIW+VuujKcOC/OVOv4ScGSVRlOvSCjxWS+1iCarwYyAK
 ppy2xaAubraNW7lsaGCOR2tURZDCp77pL8v5kMIUqSxYtVj2/SAvi1elyoO0ZAtar0hs
 lIS07lHZfDqe/onsG2XoMAjiSI9hYn92dWrplTxQ0OaanFKM9F/S4+HPHYpp1bHp7Juq
 pFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GbM8qbPms0fd6ijq1GteDCY7MDClddMOoZTvyOWkR5E=;
 b=ELv5N8Jun0ExSqJnNWkY2lev5IcO9XsVnf6PKDVoEvwftN/hU90NgjAllYkq2SzCet
 REr2QAHbJihanZS0djga6iJsDKuC/WIR8BzUyaOTPn8BIQf/xEA54/G8jdqNzwg/ZJlN
 mRcojk6p8/awFD6vkKAumwPGz+2+cwupnmHh3kXbvH3KWGbReQ4lcnI4/1rD05p78l+V
 gguGb0jz5/WVLO6Bs92YiQfMjFP2uyG7z62p/mSN37kO3lp7cvLdwlOxAFC3qEgPdFaM
 bvrS0zrTjEEtn6tHl2zrdZUAGITbbRg3OU4gOx9k55ygu/KTyUfy93Ah2sjlpcIZcN1y
 6P4g==
X-Gm-Message-State: AOAM531NQbTg4grGcFmncpSxzvebJRE+hKme8QRK3nCO4j3ov0YWytog
 9DvheiPrC1Q+3Vt3W0AXkO1bpTjALI/OYsUnDRsuMrQmb+4=
X-Google-Smtp-Source: ABdhPJztH9TTr/z5v1tyj28P05vdn6kcNYa2En2oJjyxzAaUHFD09d0g2afTOxrZ7EbL3DvD1SH45155a57xHpiM0fU=
X-Received: by 2002:a50:d2d1:: with SMTP id q17mr31597131edg.167.1600327616696; 
 Thu, 17 Sep 2020 00:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597129029.git.scw@google.com>
 <7d61f792c22de8df3c6a9438eacc3906620e7c54.1597129029.git.scw@google.com>
In-Reply-To: <7d61f792c22de8df3c6a9438eacc3906620e7c54.1597129029.git.scw@google.com>
From: Shu-Chun Weng <scw@google.com>
Date: Thu, 17 Sep 2020 00:26:45 -0700
Message-ID: <CAF3nBxjs1+kyEMrSp=ag-CmEuT7T7W4cx63cqaCUyn8ruk_dug@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] linux-user: Add IPv6 options to do_print_sockopt()
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
 micalg=sha-256; boundary="00000000000023e13205af7d4fc1"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=scw@google.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--00000000000023e13205af7d4fc1
Content-Type: multipart/alternative; boundary="0000000000001e815005af7d4f40"

--0000000000001e815005af7d4f40
Content-Type: text/plain; charset="UTF-8"

Ping -- this one was broken off into its own patch from v1 due to the
amount of addition. Hence I did not add Review-by.

On Tue, Aug 11, 2020 at 12:10 AM Shu-Chun Weng <scw@google.com> wrote:

> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
> v1 -> v2:
>   New: Add all IPV6 options to do_print_sockopt(), including the newly
> supported
>   IPV6_ADDR_PREFERENCES.
>
>  linux-user/strace.c | 108 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
>
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 854b54a2ad..089fb3968e 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -6,6 +6,7 @@
>  #include <sys/select.h>
>  #include <sys/mount.h>
>  #include <arpa/inet.h>
> +#include <netinet/in.h>
>  #include <netinet/tcp.h>
>  #include <netinet/udp.h>
>  #include <linux/if_packet.h>
> @@ -2307,6 +2308,113 @@ print_optint:
>              break;
>          }
>          break;
> +    case SOL_IPV6:
> +        qemu_log("SOL_IPV6,");
> +        switch (optname) {
> +        case IPV6_MTU_DISCOVER:
> +            qemu_log("IPV6_MTU_DISCOVER,");
> +            goto print_optint;
> +        case IPV6_MTU:
> +            qemu_log("IPV6_MTU,");
> +            goto print_optint;
> +        case IPV6_V6ONLY:
> +            qemu_log("IPV6_V6ONLY,");
> +            goto print_optint;
> +        case IPV6_RECVPKTINFO:
> +            qemu_log("IPV6_RECVPKTINFO,");
> +            goto print_optint;
> +        case IPV6_UNICAST_HOPS:
> +            qemu_log("IPV6_UNICAST_HOPS,");
> +            goto print_optint;
> +        case IPV6_MULTICAST_HOPS:
> +            qemu_log("IPV6_MULTICAST_HOPS,");
> +            goto print_optint;
> +        case IPV6_MULTICAST_LOOP:
> +            qemu_log("IPV6_MULTICAST_LOOP,");
> +            goto print_optint;
> +        case IPV6_RECVERR:
> +            qemu_log("IPV6_RECVERR,");
> +            goto print_optint;
> +        case IPV6_RECVHOPLIMIT:
> +            qemu_log("IPV6_RECVHOPLIMIT,");
> +            goto print_optint;
> +        case IPV6_2292HOPLIMIT:
> +            qemu_log("IPV6_2292HOPLIMIT,");
> +            goto print_optint;
> +        case IPV6_CHECKSUM:
> +            qemu_log("IPV6_CHECKSUM,");
> +            goto print_optint;
> +        case IPV6_ADDRFORM:
> +            qemu_log("IPV6_ADDRFORM,");
> +            goto print_optint;
> +        case IPV6_2292PKTINFO:
> +            qemu_log("IPV6_2292PKTINFO,");
> +            goto print_optint;
> +        case IPV6_RECVTCLASS:
> +            qemu_log("IPV6_RECVTCLASS,");
> +            goto print_optint;
> +        case IPV6_RECVRTHDR:
> +            qemu_log("IPV6_RECVRTHDR,");
> +            goto print_optint;
> +        case IPV6_2292RTHDR:
> +            qemu_log("IPV6_2292RTHDR,");
> +            goto print_optint;
> +        case IPV6_RECVHOPOPTS:
> +            qemu_log("IPV6_RECVHOPOPTS,");
> +            goto print_optint;
> +        case IPV6_2292HOPOPTS:
> +            qemu_log("IPV6_2292HOPOPTS,");
> +            goto print_optint;
> +        case IPV6_RECVDSTOPTS:
> +            qemu_log("IPV6_RECVDSTOPTS,");
> +            goto print_optint;
> +        case IPV6_2292DSTOPTS:
> +            qemu_log("IPV6_2292DSTOPTS,");
> +            goto print_optint;
> +        case IPV6_TCLASS:
> +            qemu_log("IPV6_TCLASS,");
> +            goto print_optint;
> +        case IPV6_ADDR_PREFERENCES:
> +            qemu_log("IPV6_ADDR_PREFERENCES,");
> +            goto print_optint;
> +#ifdef IPV6_RECVPATHMTU
> +        case IPV6_RECVPATHMTU:
> +            qemu_log("IPV6_RECVPATHMTU,");
> +            goto print_optint;
> +#endif
> +#ifdef IPV6_TRANSPARENT
> +        case IPV6_TRANSPARENT:
> +            qemu_log("IPV6_TRANSPARENT,");
> +            goto print_optint;
> +#endif
> +#ifdef IPV6_FREEBIND
> +        case IPV6_FREEBIND:
> +            qemu_log("IPV6_FREEBIND,");
> +            goto print_optint;
> +#endif
> +#ifdef IPV6_RECVORIGDSTADDR
> +        case IPV6_RECVORIGDSTADDR:
> +            qemu_log("IPV6_RECVORIGDSTADDR,");
> +            goto print_optint;
> +#endif
> +        case IPV6_PKTINFO:
> +            qemu_log("IPV6_PKTINFO,");
> +            print_pointer(optval, 0);
> +            break;
> +        case IPV6_ADD_MEMBERSHIP:
> +            qemu_log("IPV6_ADD_MEMBERSHIP,");
> +            print_pointer(optval, 0);
> +            break;
> +        case IPV6_DROP_MEMBERSHIP:
> +            qemu_log("IPV6_DROP_MEMBERSHIP,");
> +            print_pointer(optval, 0);
> +            break;
> +        default:
> +            print_raw_param(TARGET_ABI_FMT_ld, optname, 0);
> +            print_pointer(optval, 0);
> +            break;
> +        }
> +        break;
>      default:
>          print_raw_param(TARGET_ABI_FMT_ld, level, 0);
>          print_raw_param(TARGET_ABI_FMT_ld, optname, 0);
> --
> 2.28.0.220.ged08abb693-goog
>
>

--0000000000001e815005af7d4f40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Ping -- this one was broken off into its own patch from v1=
 due to the amount of addition. Hence I did not add Review-by.</div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 1=
1, 2020 at 12:10 AM Shu-Chun Weng &lt;<a href=3D"mailto:scw@google.com">scw=
@google.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Signed-off-by: Shu-Chun Weng &lt;<a href=3D"mailto:scw@google.co=
m" target=3D"_blank">scw@google.com</a>&gt;<br>
---<br>
v1 -&gt; v2:<br>
=C2=A0 New: Add all IPV6 options to do_print_sockopt(), including the newly=
 supported<br>
=C2=A0 IPV6_ADDR_PREFERENCES.<br>
<br>
=C2=A0linux-user/strace.c | 108 +++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 108 insertions(+)<br>
<br>
diff --git a/linux-user/strace.c b/linux-user/strace.c<br>
index 854b54a2ad..089fb3968e 100644<br>
--- a/linux-user/strace.c<br>
+++ b/linux-user/strace.c<br>
@@ -6,6 +6,7 @@<br>
=C2=A0#include &lt;sys/select.h&gt;<br>
=C2=A0#include &lt;sys/mount.h&gt;<br>
=C2=A0#include &lt;arpa/inet.h&gt;<br>
+#include &lt;netinet/in.h&gt;<br>
=C2=A0#include &lt;netinet/tcp.h&gt;<br>
=C2=A0#include &lt;netinet/udp.h&gt;<br>
=C2=A0#include &lt;linux/if_packet.h&gt;<br>
@@ -2307,6 +2308,113 @@ print_optint:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 case SOL_IPV6:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;SOL_IPV6,&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (optname) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_MTU_DISCOVER:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_MTU_DISCOVER=
,&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_MTU:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_MTU,&quot;);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_V6ONLY:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_V6ONLY,&quot=
;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RECVPKTINFO:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_RECVPKTINFO,=
&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_UNICAST_HOPS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_UNICAST_HOPS=
,&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_MULTICAST_HOPS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_MULTICAST_HO=
PS,&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_MULTICAST_LOOP:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_MULTICAST_LO=
OP,&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RECVERR:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_RECVERR,&quo=
t;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RECVHOPLIMIT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_RECVHOPLIMIT=
,&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_2292HOPLIMIT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_2292HOPLIMIT=
,&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_CHECKSUM:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_CHECKSUM,&qu=
ot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_ADDRFORM:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_ADDRFORM,&qu=
ot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_2292PKTINFO:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_2292PKTINFO,=
&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RECVTCLASS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_RECVTCLASS,&=
quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RECVRTHDR:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_RECVRTHDR,&q=
uot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_2292RTHDR:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_2292RTHDR,&q=
uot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RECVHOPOPTS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_RECVHOPOPTS,=
&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_2292HOPOPTS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_2292HOPOPTS,=
&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RECVDSTOPTS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_RECVDSTOPTS,=
&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_2292DSTOPTS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_2292DSTOPTS,=
&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_TCLASS:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_TCLASS,&quot=
;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_ADDR_PREFERENCES:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_ADDR_PREFERE=
NCES,&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+#ifdef IPV6_RECVPATHMTU<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RECVPATHMTU:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_RECVPATHMTU,=
&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+#endif<br>
+#ifdef IPV6_TRANSPARENT<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_TRANSPARENT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_TRANSPARENT,=
&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+#endif<br>
+#ifdef IPV6_FREEBIND<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_FREEBIND:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_FREEBIND,&qu=
ot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+#endif<br>
+#ifdef IPV6_RECVORIGDSTADDR<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_RECVORIGDSTADDR:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_RECVORIGDSTA=
DDR,&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto print_optint;<br>
+#endif<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_PKTINFO:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_PKTINFO,&quo=
t;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_pointer(optval, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_ADD_MEMBERSHIP:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_ADD_MEMBERSH=
IP,&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_pointer(optval, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IPV6_DROP_MEMBERSHIP:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log(&quot;IPV6_DROP_MEMBERS=
HIP,&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_pointer(optval, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_raw_param(TARGET_ABI_FMT_l=
d, optname, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_pointer(optval, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_raw_param(TARGET_ABI_FMT_ld, level,=
 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_raw_param(TARGET_ABI_FMT_ld, optnam=
e, 0);<br>
-- <br>
2.28.0.220.ged08abb693-goog<br>
<br>
</blockquote></div>

--0000000000001e815005af7d4f40--

--00000000000023e13205af7d4fc1
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPkgYJKoZIhvcNAQcCoIIPgzCCD38CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggzsMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
--00000000000023e13205af7d4fc1--

