Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7BFC3F2CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:16:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3329E208CD
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 09:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cq1Tpxin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3329E208CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9mc9-00066D-DR
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 04:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1j9mae-00059W-NR
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:14:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dmitry.fleytman@gmail.com>) id 1j9mad-0004Yo-Fh
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:14:48 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dmitry.fleytman@gmail.com>)
 id 1j9mad-0004YC-8b
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 04:14:47 -0500
Received: by mail-wm1-x342.google.com with SMTP id u9so4842602wml.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 01:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
 :references; bh=cgtmCOnM5eftUcAmprtJHi7X3jIsEiz8Ycan18zG6y8=;
 b=Cq1Tpxin0iMq2it8IdNqIRkp01hbvaL3Z8IWb1IkrRqaphfgWSx15zPW0iBC5wGKmh
 3Cs60zICuBZvAaDf1gKDq5ZK5ze4J/bFw6/Q93vPOm5jN9uVhAwxa4N2KRBnNN4RM1/W
 MrB7tPi8W3ZeSO5udjm73D9Hp+PccD/7bCLS6/Of9K7fPZ7/zG15Rkv5XJz6RGT+DJ0j
 nbqjBg78j3h5pC0y2KzK/qThndbNrUv0iCeX32bu0Sg7/D6yKfPWRXnNb0Y9Ka2B9Xcc
 XGjxoCQIdpKbJTFvQtCv2nKoHPr6D6KiHnWOskzodmC2JWMtlsq1ku4zXH/+ehbacXwe
 6oBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:message-id:mime-version:subject:date
 :in-reply-to:cc:to:references;
 bh=cgtmCOnM5eftUcAmprtJHi7X3jIsEiz8Ycan18zG6y8=;
 b=FZB4C6RC9Y1yyw1ixHl84ZfxzO490eLzyhxICQ0Vo4Q0nrvpETIUeCcUiNn87ewCIL
 avTpXDoWa0VlT+a/vyhb9R3kad66lXQXXQp+qH9/pLzXkvvRbRSyRHKTLtoC6CpBSlv/
 vZIhcL9RoSBT3xEYbhf9/URwWA5JJDaGMiimTiPf6e8re174NoGZkvqSruGqA9grAqYV
 58aIezzkRaWqno/W5YW89IbOtTNOW8e2zcCWcyqql9CzuhPi94QN0vmNISJ2myxV5P1E
 vb/WC0K9rkWfPpw+jJL2/lWYhGnTS6jqmMUqNlLYaAV3XdBsExnKWZkc8vFKcH/0q1HF
 oa6w==
X-Gm-Message-State: ANhLgQ02ziBTSPbkpqSNQQz4RZuvUJ9kHTkB50l1w/FkT0IrEyM+gKgS
 SV1dc5AmD0f9xwMcbhF6iP8=
X-Google-Smtp-Source: ADFU+vtlmJTNDbFpYQGsV9X5VCEl+2xkCwhi1GTJ+HYHQryuK2J40pb5Z4tmC3obrxghKLo96TKWIA==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr3095319wmq.88.1583399685969; 
 Thu, 05 Mar 2020 01:14:45 -0800 (PST)
Received: from [10.0.1.16] ([141.226.29.227])
 by smtp.gmail.com with ESMTPSA id f6sm8126979wmh.29.2020.03.05.01.14.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Mar 2020 01:14:45 -0800 (PST)
From: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Message-Id: <D5DA57BB-1490-4CA5-95BC-53C6E86DDF97@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_939B96E4-DC60-47CA-BD83-1711F002F37C"
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH v2] Fixed integer overflow in e1000e
Date: Thu, 5 Mar 2020 11:14:43 +0200
In-Reply-To: <20200304142058.52458-1-andrew@daynix.com>
To: andrew@daynix.com
References: <20200304142058.52458-1-andrew@daynix.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--Apple-Mail=_939B96E4-DC60-47CA-BD83-1711F002F37C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

> On 4 Mar 2020, at 16:20, andrew@daynix.com wrote:
>=20
> From: Andrew Melnychenko <andrew@daynix.com>
>=20
> Fixes: 6f3fbe4ed06
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1737400
> Fixed setting max_queue_num if there are no peers in NICConf. =
qemu_new_nic() creates NICState with 1 NetClientState(index 0) without =
peers, set max_queue_num to 0 - It prevents undefined behavior and =
possible crashes, especially during pcie hotplug.
>=20
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>

Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>

> ---
> hw/net/e1000e.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index a91dbdca3c..f2cc1552c5 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -328,7 +328,7 @@ e1000e_init_net_peer(E1000EState *s, PCIDevice =
*pci_dev, uint8_t *macaddr)
>     s->nic =3D qemu_new_nic(&net_e1000e_info, &s->conf,
>         object_get_typename(OBJECT(s)), dev->id, s);
>=20
> -    s->core.max_queue_num =3D s->conf.peers.queues - 1;
> +    s->core.max_queue_num =3D s->conf.peers.queues ? =
s->conf.peers.queues - 1 : 0;
>=20
>     trace_e1000e_mac_set_permanent(MAC_ARG(macaddr));
>     memcpy(s->core.permanent_mac, macaddr, =
sizeof(s->core.permanent_mac));
> --=20
> 2.24.1
>=20


--Apple-Mail=_939B96E4-DC60-47CA-BD83-1711F002F37C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" =
class=3D""><div><blockquote type=3D"cite" class=3D""><div class=3D"">On =
4 Mar 2020, at 16:20, <a href=3D"mailto:andrew@daynix.com" =
class=3D"">andrew@daynix.com</a> wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><div class=3D"">From: =
Andrew Melnychenko &lt;<a href=3D"mailto:andrew@daynix.com" =
class=3D"">andrew@daynix.com</a>&gt;<br class=3D""><br class=3D"">Fixes: =
6f3fbe4ed06<br class=3D"">Buglink: <a =
href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D1737400" =
class=3D"">https://bugzilla.redhat.com/show_bug.cgi?id=3D1737400</a><br =
class=3D"">Fixed setting max_queue_num if there are no peers in NICConf. =
qemu_new_nic() creates NICState with 1 NetClientState(index 0) without =
peers, set max_queue_num to 0 - It prevents undefined behavior and =
possible crashes, especially during pcie hotplug.<br class=3D""><br =
class=3D"">Signed-off-by: Andrew Melnychenko &lt;<a =
href=3D"mailto:andrew@daynix.com" class=3D"">andrew@daynix.com</a>&gt;<br =
class=3D""></div></div></blockquote><div><br class=3D""></div><div><font =
color=3D"#545454" face=3D"arial, sans-serif" size=3D"2" class=3D""><span =
style=3D"background-color: rgb(255, 255, 255);" class=3D"">Reviewed-by: =
Dmitry Fleytman&nbsp;</span></font>&lt;<a =
href=3D"mailto:dmitry.fleytman@gmail.com" =
class=3D"">dmitry.fleytman@gmail.com</a>&gt;<br class=3D""><div><br =
class=3D""></div></div><blockquote type=3D"cite" class=3D""><div =
class=3D""><div class=3D"">---<br class=3D""> hw/net/e1000e.c | 2 +-<br =
class=3D""> 1 file changed, 1 insertion(+), 1 deletion(-)<br =
class=3D""><br class=3D"">diff --git a/hw/net/e1000e.c =
b/hw/net/e1000e.c<br class=3D"">index a91dbdca3c..f2cc1552c5 100644<br =
class=3D"">--- a/hw/net/e1000e.c<br class=3D"">+++ b/hw/net/e1000e.c<br =
class=3D"">@@ -328,7 +328,7 @@ e1000e_init_net_peer(E1000EState *s, =
PCIDevice *pci_dev, uint8_t *macaddr)<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;s-&gt;nic =3D qemu_new_nic(&amp;net_e1000e_info, =
&amp;s-&gt;conf,<br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;object_get_typename(OBJECT=
(s)), dev-&gt;id, s);<br class=3D""><br class=3D"">- =
&nbsp;&nbsp;&nbsp;s-&gt;core.max_queue_num =3D s-&gt;conf.peers.queues - =
1;<br class=3D"">+ &nbsp;&nbsp;&nbsp;s-&gt;core.max_queue_num =3D =
s-&gt;conf.peers.queues ? s-&gt;conf.peers.queues - 1 : 0;<br =
class=3D""><br class=3D""> =
&nbsp;&nbsp;&nbsp;&nbsp;trace_e1000e_mac_set_permanent(MAC_ARG(macaddr));<=
br class=3D""> &nbsp;&nbsp;&nbsp;&nbsp;memcpy(s-&gt;core.permanent_mac, =
macaddr, sizeof(s-&gt;core.permanent_mac));<br class=3D"">-- <br =
class=3D"">2.24.1<br class=3D""><br =
class=3D""></div></div></blockquote></div><br class=3D""></body></html>=

--Apple-Mail=_939B96E4-DC60-47CA-BD83-1711F002F37C--

