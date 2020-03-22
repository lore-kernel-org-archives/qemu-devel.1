Return-Path: <SRS0=K/vF=5H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86359C4332B
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 16:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE8C20724
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Mar 2020 16:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="kTdNfdhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE8C20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jG3CH-0003vV-EB
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 12:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dereksu@qnap.com>) id 1jG1uw-0000xt-NJ
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 10:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dereksu@qnap.com>) id 1jG1uv-0000CT-Bh
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 10:49:34 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:36189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dereksu@qnap.com>) id 1jG1uu-0000B8-Vx
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 10:49:33 -0400
Received: by mail-wr1-x431.google.com with SMTP id 31so7390964wrs.3
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 07:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=7Y0gFAVQDb+CW+AtEWTo4S2fF2OVzdCUPlftLvNJ+iw=;
 b=kTdNfdhTJi7+rtlEVtzDmapJAcKPnI5nyD+9U8eRedxOG8z2ABGCo22vubDhspJaFi
 sncnOzsNPX83MCfntBparP9nlY8U/8JE+MWGZCtUgwWWOzX22tbPWCs3Ht7j7NQ+F6+p
 B1Lgs5kmZV6IkwtrUrflCv1I4QxYQB7c6U3+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=7Y0gFAVQDb+CW+AtEWTo4S2fF2OVzdCUPlftLvNJ+iw=;
 b=efpBPZUSjHAu58f0+jGPqG+aKslFOnX9l603/gVeHrVOrMGPVDv1lLGPm5tn1CcNCT
 n7AkncE23XRbepCBhgUQbxxXtLxGs7m7YJ6JnuBt1pXJFXq0MkUW2l76NYs1LSKPCBON
 6dGGHGSYhWTCk+QdWPwqNyAz4NpX4KeT4M5xBih7iJ7aMGFa2hiZj6tCCboIGFsAWALI
 suQPTnsAk1AuT7WIxJHSvG6QDIkgOfWAHzeppWalaSEYocup5wx+9DnvJW9lzJ2cWoxE
 c2J5otr3NUCm+UjY2jpizTFj5MGQhkvwns4QSrMS7kOT1FPDXxlQQOFDQilif0j8/Dms
 JJHQ==
X-Gm-Message-State: ANhLgQ2w7oPP0awqETWxxMgMduIvFOKw1g+uI08ae1HRu2CN65LItGyo
 GPnFnUDdsJRUzba/qJS5fGTcLK1F1VP6sepXjxNwVQGugGjpfg==
X-Google-Smtp-Source: ADFU+vudwoRiyvwLjZcRHuiZQQiMI0cvTX7MPk+5jjRrIfUpaa/BtRFU4+umnEf46/mwVCsY7HfG2UVsIt8+YVfXrVQ=
X-Received: by 2002:adf:8b1b:: with SMTP id n27mr23650433wra.349.1584888571258; 
 Sun, 22 Mar 2020 07:49:31 -0700 (PDT)
MIME-Version: 1.0
From: Derek Su <dereksu@qnap.com>
Date: Sun, 22 Mar 2020 22:49:20 +0800
Message-ID: <CAKEOLWXi1o_jCHTvAEU69S0nMGXdUgpa_AqZhn9zzP=wb8d15w@mail.gmail.com>
Subject: [PATCH 0/1] COLO: Fix memory leak in packet_enqueue()
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004c830a05a172a0f5"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
X-Mailman-Approved-At: Sun, 22 Mar 2020 12:10:47 -0400
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
Cc: chen.zhang@intel.com, jasowang@redhat.com, lizhijian@cn.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004c830a05a172a0f5
Content-Type: text/plain; charset="UTF-8"

The patch is to fix the memory leak in packet_enqueue().
The allocated "pkt" needs to be freed if the colo compare
primary or secondary queue is too big to insert.

Reproduce steps:
(1) Setup PVM and SVM both with NIC e1000 by the steps descripted


    in the wiki qemu/COLO
(2) Run "iperf3 -s" in PVM
(3) Run "iperfs -c <PVM-IP> -t 7200"

The memory usage of qemu-system-x86_64 increases as
the PVM's QMP shows "qemu-system-x86_64: colo compare
secondary queue size too big,drop packet".


Derek Su (1):
  net/colo-compare.c: Fix memory leak in packet_enqueue()

 net/colo-compare.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

-- 
2.17.1

--0000000000004c830a05a172a0f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smart=
mail=3D"gmail_signature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"=
><div>The patch is to fix the memory leak in packet_enqueue().<br>The alloc=
ated &quot;pkt&quot; needs to be freed if the colo compare<br>primary or se=
condary queue is too big to insert.<br><br>Reproduce steps:<br>(1) Setup PV=
M and SVM both with NIC e1000 by the steps descripted =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br>=C2=
=A0 =C2=A0 in the wiki qemu/COLO<br>(2) Run &quot;iperf3 -s&quot; in PVM<br=
>(3) Run &quot;iperfs -c &lt;PVM-IP&gt; -t 7200&quot;<br><br>The memory usa=
ge of qemu-system-x86_64 increases as<br>the PVM&#39;s QMP shows &quot;qemu=
-system-x86_64: colo compare<br>secondary queue size too big,drop packet&qu=
ot;.<br><br><br>Derek Su (1):<br>=C2=A0 net/colo-compare.c: Fix memory leak=
 in packet_enqueue()<br><br>=C2=A0net/colo-compare.c | 23 +++++++++++++++--=
------<br>=C2=A01 file changed, 15 insertions(+), 8 deletions(-)<br><br>-- =
<br>2.17.1<br><br></div></div></div></div></div></div></div>

--0000000000004c830a05a172a0f5--

