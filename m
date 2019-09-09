Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2792C433EF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 10:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B881821479
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 10:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B881821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7HJT-0001t7-Rd
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 06:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i7HGd-0007ne-19
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i7HGa-0008K3-Ol
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:51:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38644)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i7HGa-0008Hv-GI
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:51:28 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 933CF4E83E
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 10:51:26 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id v15so7223104wrg.13
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 03:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wjMYv2IyPeANagrLLEdk0F0dpH4o+VFMYivZWjd96Oc=;
 b=ob2M0N2+pSzSLKTx0Lo1k/g3c7Zm2FPJQRGrULzHGSsBDvmZ//IfU46RgcGppr9Syh
 AekcXWMIrRyth7yPGgAqADlEEDeB+tKr1kBW2gJJWAUjQiv+i3SaHlIjENXqmQva1UQb
 KLfqV/sHiV+Flrk2YS7M5KN83+btfrISMZfMwdNND+uMe/wrSt1qwRkHhFyQrrGuy9vC
 UVeLNvJbzX2SmzeEdA8y4orJT0vEiVCOxcJAjKa4pBaxKNZMz0Ra6Eb+dDqDF3dbK65J
 PAN3KJ1Iw7Dzu45dJaHc5104uYDUGO8qNTb1eR/UmuQNkebQ/AhxauEOAtCUulhjkLA7
 TrhQ==
X-Gm-Message-State: APjAAAU/P2Gv/bxq+WuhBHOoUU8z8BGtbB0ZVqEduSQESqHZOEPOi+26
 Ptqh6gTGvuZIYlk6hVBd2Yr+yDwBaHOB+G8iY+6gr+5KgibffRKShdR8LjnFgBjPDc84jnBz9tQ
 8bCFDMkiSi4CAVio=
X-Received: by 2002:adf:dd04:: with SMTP id a4mr18336038wrm.340.1568026285381; 
 Mon, 09 Sep 2019 03:51:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw9MlFIGsDytK5YQqxbESpEwAUBoV067xaSpmnkeOV5ngCGgSKEZYp8gUP+eh5iFVNKwwWdRg==
X-Received: by 2002:adf:dd04:: with SMTP id a4mr18336031wrm.340.1568026285211; 
 Mon, 09 Sep 2019 03:51:25 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id k6sm29418331wrg.0.2019.09.09.03.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2019 03:51:24 -0700 (PDT)
To: Samuel Thibault <samuel.thibault@gnu.org>,
 Chris Heinze <c.heinze@precibake.com>
References: <0115e29c-2254-09c3-13d5-6dfb5307d968@precibake.com>
 <20190907232924.a2maha6jyf7u6xbb@function>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <47bad7a1-8fae-b464-7c74-b458d02a6174@redhat.com>
Date: Mon, 9 Sep 2019 12:51:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190907232924.a2maha6jyf7u6xbb@function>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] slirp, incoming packets get truncated
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Samuel,

On 9/8/19 1:29 AM, Samuel Thibault wrote:
>
> Now, with MTU set to 9000, the packets just don't go at all. Could you
> try the attached patch? The lowest layer of slirp was indeed limited to
> 1600-byte frames for no good reason. With this and the virtio driver, I
> could exchange 9000-byte packets.
>=20
> Samuel
>=20
> diff --git a/src/slirp.c b/src/slirp.c
> index b0194cb..3fd6f68 100644
> --- a/src/slirp.c
> +++ b/src/slirp.c
> @@ -890,20 +890,22 @@ static int if_encap6(Slirp *slirp, struct mbuf
*ifm, struct ethhdr *eh,
>   */
>  int if_encap(Slirp *slirp, struct mbuf *ifm)
>  {
> -    uint8_t buf[1600];
> -    struct ethhdr *eh =3D (struct ethhdr *)buf;
> +    uint8_t *buf;
> +    struct ethhdr *eh;
>      uint8_t ethaddr[ETH_ALEN];
>      const struct ip *iph =3D (const struct ip *)ifm->m_data;
>      int ret;
>
> -    if (ifm->m_len + ETH_HLEN > sizeof(buf)) {
> -        return 1;
> -    }
> +    buf =3D g_malloc(ifm->m_len + ETH_HLEN);

Since g_malloc() aborts on failure, you want g_try_malloc() here.

> +    if (!buf)
> +        return 0;
> +    eh =3D (struct ethhdr *)buf;
>
>      switch (iph->ip_v) {
>      case IPVERSION:
>          ret =3D if_encap4(slirp, ifm, eh, ethaddr);
>          if (ret < 2) {
> +            g_free(buf);
>              return ret;
>          }
>          break;
> @@ -911,6 +913,7 @@ int if_encap(Slirp *slirp, struct mbuf *ifm)
>      case IP6VERSION:
>          ret =3D if_encap6(slirp, ifm, eh, ethaddr);
>          if (ret < 2) {
> +            g_free(buf);
>              return ret;
>          }
>          break;
> @@ -929,6 +932,7 @@ int if_encap(Slirp *slirp, struct mbuf *ifm)
>                eh->h_dest[5]);
>      memcpy(buf + sizeof(struct ethhdr), ifm->m_data, ifm->m_len);
>      slirp_send_packet_all(slirp, buf, ifm->m_len + ETH_HLEN);
> +    g_free(buf);
>      return 1;
>  }

Eventually easier to review using less exit points, i.e.:

-- >8 --
@@ -903,16 +903,10 @@ int if_encap(Slirp *slirp, struct mbuf *ifm)
     switch (iph->ip_v) {
     case IPVERSION:
         ret =3D if_encap4(slirp, ifm, eh, ethaddr);
-        if (ret < 2) {
-            return ret;
-        }
         break;

     case IP6VERSION:
         ret =3D if_encap6(slirp, ifm, eh, ethaddr);
-        if (ret < 2) {
-            return ret;
-        }
         break;

     default:
@@ -920,16 +914,21 @@ int if_encap(Slirp *slirp, struct mbuf *ifm)
         break;
     }

-    memcpy(eh->h_dest, ethaddr, ETH_ALEN);
-    DEBUG_ARG("src =3D %02x:%02x:%02x:%02x:%02x:%02x", eh->h_source[0],
-              eh->h_source[1], eh->h_source[2], eh->h_source[3],
-              eh->h_source[4], eh->h_source[5]);
-    DEBUG_ARG("dst =3D %02x:%02x:%02x:%02x:%02x:%02x", eh->h_dest[0],
-              eh->h_dest[1], eh->h_dest[2], eh->h_dest[3], eh->h_dest[4]=
,
-              eh->h_dest[5]);
-    memcpy(buf + sizeof(struct ethhdr), ifm->m_data, ifm->m_len);
-    slirp_send_packet_all(slirp, buf, ifm->m_len + ETH_HLEN);
-    return 1;
+    if (ret >=3D 2) {
+        memcpy(eh->h_dest, ethaddr, ETH_ALEN);
+        DEBUG_ARG("src =3D %02x:%02x:%02x:%02x:%02x:%02x", eh->h_source[=
0],
+                  eh->h_source[1], eh->h_source[2], eh->h_source[3],
+                  eh->h_source[4], eh->h_source[5]);
+        DEBUG_ARG("dst =3D %02x:%02x:%02x:%02x:%02x:%02x", eh->h_dest[0]=
,
+                  eh->h_dest[1], eh->h_dest[2], eh->h_dest[3],
eh->h_dest[4],
+                  eh->h_dest[5]);
+        memcpy(buf + sizeof(struct ethhdr), ifm->m_data, ifm->m_len);
+        slirp_send_packet_all(slirp, buf, ifm->m_len + ETH_HLEN);
+        ret =3D 1;
+    }
+
+    g_free(buf);
+    return ret;
 }
---

Anyhow, if you plan to properly (with your S-o-b) commit your patch to
the libslirp repository, using g_try_malloc() you can add:

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Regards,

Phil.

