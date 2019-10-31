Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7478CA9ECB
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 13:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9236B20873
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 13:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="rdmS1Jkz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9236B20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQAQW-0005Yx-4o
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 09:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <basil@daynix.com>) id 1iQANH-0001mR-To
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 09:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <basil@daynix.com>) id 1iQANG-0007wc-TS
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 09:20:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <basil@daynix.com>) id 1iQANG-0007sK-Ex
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 09:20:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id x5so5877454wmi.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 06:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fw2AfQtEIdLw8Vi6+drRpBdfdo+O8JXqTREQNz4Whfk=;
 b=rdmS1JkzmPBq3x/Dst5ESL6pudEFstrbbHVks28nfJgkT7Hr+b+4NppdL1ZlNBzRRV
 1WRvzukn9RYqG8EGq2a8KAz6pmr/8e41Rt3xRY3eAt5opSkbRW3S68ZomxxFb74djPfp
 IfRXxb/uJp6fL1pssxK7G7FQJvbDFiQrQdW+ZhoZdWMoRzqW8ZXlu1xajGP0W0V2K17b
 BpAHL08J8BJoJg0n/48DsGxY65AbRfT3IvhcvnlMuO/Dr9fjqbcB+gmu4lmG57K3MoGW
 IB/1/OhRH9mL44qz3kZSZ771g+SRvrrUu68w2j0SKLsM8NLbg9fRyaYrc4GKX1X+qnSV
 UoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fw2AfQtEIdLw8Vi6+drRpBdfdo+O8JXqTREQNz4Whfk=;
 b=sS5xAN9FWGLeAcMzns6RX+/NwgcJWiw38+ELfTgpbTp2NVm6hgciNrvAqIuW24A4OG
 X4rdASUWqkFPf7ZB7KReydiXZnX8tBOUChgAgO4RAqhiZeCF0CR3N3oGjuW+QBCY2ewh
 WZvK9v7p4ktAC5sek4MyGq4pk4p+mQbDGYWacW2uE7PZ0jAu2hE0bDMfpRf0JBUl8W8t
 FepftNAoMVeNuwMxucrXMsD8UzsaXl2nlETZAypdxk/dyJhvYVJoCnUq266flfFjzozm
 o1jO94BE4V2jD+4Zxv1aB8OnbyFftwtktgy7Ga0ZRTsAgrJD82zhLlEnvqB7XJYnFclP
 /fvA==
X-Gm-Message-State: APjAAAXvWLlUshbjPDdWpggB8Gumje5TuGaf6SPmaYykqKssyqNag49k
 /63WKVDi/JcWRPtrrLjP/yWJtLVRz/LHj+IXIa8io8cm
X-Google-Smtp-Source: APXvYqxCS1HwTJni1BYxg3FoPWesgyKNdlIDJAPeo4QbqWfs1slwCFR+feqBe6sNruMAYppX0Z4SkB3dvIqOweNVSYQ=
X-Received: by 2002:a7b:ce0c:: with SMTP id m12mr5217152wmc.117.1572528020896; 
 Thu, 31 Oct 2019 06:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191017123438.87703-1-basil@daynix.com>
In-Reply-To: <20191017123438.87703-1-basil@daynix.com>
From: Basil Salman <basil@daynix.com>
Date: Thu, 31 Oct 2019 15:20:09 +0200
Message-ID: <CAMpN4hhUfB-nKH-TB335dr7rq1_DF9_yhXZMjz6Jq_6FaA8KDw@mail.gmail.com>
Subject: Re: [PATCH 0/1] BZ#1751431:guest-get-memory-block-info is not
 supported
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary="00000000000015dc4a059634b611"
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
Cc: Yan Vugenfirer <yan@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000015dc4a059634b611
Content-Type: text/plain; charset="UTF-8"

PING

On Thu, Oct 17, 2019 at 3:34 PM Basil Salman <basil@daynix.com> wrote:

> From: Basil Salman <bsalman@redhat.com>
>
> "guest-get-memory-block-info" is enabled according to "get-info" output,
> while the command is only supported for linux with sysfs.
>
> "guest-get-memory-block-info" command was added to blacklist.
>
> Basil Salman (1):
>   qga: Add "guest-get-memory-block-info" to blacklist
>
>  qga/commands-posix.c | 3 ++-
>  qga/commands-win32.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> --
> 2.17.2
>
>

--00000000000015dc4a059634b611
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">PING</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Oct 17, 2019 at 3:34 PM Basil Salman &lt;<a hr=
ef=3D"mailto:basil@daynix.com">basil@daynix.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">From: Basil Salman &lt;<a hr=
ef=3D"mailto:bsalman@redhat.com" target=3D"_blank">bsalman@redhat.com</a>&g=
t;<br>
<br>
&quot;guest-get-memory-block-info&quot; is enabled according to &quot;get-i=
nfo&quot; output,<br>
while the command is only supported for linux with sysfs.<br>
<br>
&quot;guest-get-memory-block-info&quot; command was added to blacklist.<br>
<br>
Basil Salman (1):<br>
=C2=A0 qga: Add &quot;guest-get-memory-block-info&quot; to blacklist<br>
<br>
=C2=A0qga/commands-posix.c | 3 ++-<br>
=C2=A0qga/commands-win32.c | 2 +-<br>
=C2=A02 files changed, 3 insertions(+), 2 deletions(-)<br>
<br>
-- <br>
2.17.2<br>
<br>
</blockquote></div>

--00000000000015dc4a059634b611--

