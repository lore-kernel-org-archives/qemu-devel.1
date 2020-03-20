Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C350C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:21:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B2AE20709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oc1tJIoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2AE20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLKr-00026m-6p
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jerry.geis@gmail.com>) id 1jFLK7-0001Hf-UQ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jerry.geis@gmail.com>) id 1jFLK7-0007bd-2B
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:20:43 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d]:36192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jerry.geis@gmail.com>)
 id 1jFLK6-0007b5-U4
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:20:43 -0400
Received: by mail-qt1-x82d.google.com with SMTP id m33so5584000qtb.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 10:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=QXrGGB8vuigt2eYXotXSBFK6hjklipVusL5A3yXQHQo=;
 b=oc1tJIoFxypTCJns0kxpl60tI/Xn5BYfNSYaZ5JYelPzRVBaBJdz8bDIQW4+kYRnCe
 c8rnTFiS7UvmUs+eGLycPlNMTpEy06EtMGFHv9ICSV7A9QciD54/zwiZslaaUl/HgWxX
 LP8pfc9qClQ8L3/Zgr3t9dCKe80+rjMZBnytYqhtNuBNIldaNwOJJli8shcMhoWZ/8ih
 MNBHOsILKG66cHSv1bYVw5sgYWp+CLMEB54cWXG+iDCH6izvJhGl4uxS76uwEciiynoQ
 sZc6JkDX6C7ZSLzzpxlolcfjnPHE5ECi7B3uEpd6w5zCU18/vuzw6PGKQVqfVPr9r1qX
 N84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=QXrGGB8vuigt2eYXotXSBFK6hjklipVusL5A3yXQHQo=;
 b=qxWEiJ2b8rEE2hiaHnAS8wkCE3wsqRDtAGKQEkXwXUH3nnmKJ9FIfBHXEx+mnT6kYs
 EfqoXr/yALPElcqdj7wnGKLwiec/R4AZ4H9CpAt8sifagy0OeDKI1DM6lOaOBAuIQ32e
 +6peJuFf03MZpwZlt5xJbFwejVp8+4FDMOzoKYInh18XDB9OUS0Yw+6Y2ChO03Bumd9o
 Tn5CsLBKDqgvSwzs07hj6xok4CrTu05tGOypmaWttxzSfQpvtG5IkFqRBJY9jPO1jact
 5PFibiliRnE0Gin00psn//m+05EZ53ign86Qn7wOcGWffOMMK1tuKhK8cj7qjFIDFECi
 Nuxg==
X-Gm-Message-State: ANhLgQ1VkTV2p26xVWOUivkcLGeTbqXyUFzuD/clpt2gp08/PoPK4O90
 APJUMpU9v8KAiaWGhZ110GRmp2z+ksgkMBBQ3/Idgg==
X-Google-Smtp-Source: ADFU+vv8d+U0O/IUvuOx/xHSUcJlZlyruUtwFu0saJH6I3BgfAK/vvkzzRSeBSvAY8GR1G4iDFcrU5WqFgDYTwClL08=
X-Received: by 2002:ac8:2bf9:: with SMTP id n54mr9356553qtn.280.1584724841512; 
 Fri, 20 Mar 2020 10:20:41 -0700 (PDT)
MIME-Version: 1.0
From: Jerry Geis <jerry.geis@gmail.com>
Date: Fri, 20 Mar 2020 13:20:31 -0400
Message-ID: <CABr8-B4RQo3OT6ogt7J=OWGhOpD6LqHt9zkp7dZTmqifiPCtyA@mail.gmail.com>
Subject: Qemu on Windows 10 - no acceleration found
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003ec37e05a14c8113"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82d
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

--0000000000003ec37e05a14c8113
Content-Type: text/plain; charset="UTF-8"

Hi All,

I have tried QEMU on Windows 10 host with and without HyperV active in the
features list.
Neither seemed to affect the "really slow" speed. Either option results in
-enable-kvm giving "no acceleration found".

How do I enable acceleration on QEMU for windows.

Jerry

--0000000000003ec37e05a14c8113
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div><br></div><div>I have tried QEMU on Windows 10=
 host with and without HyperV active in the features list.</div><div>Neithe=
r seemed to affect the &quot;really slow&quot; speed. Either option results=
 in -enable-kvm giving &quot;no acceleration=C2=A0found&quot;.</div><div><b=
r></div><div>How do I enable acceleration on QEMU for windows.</div><div><b=
r></div><div>Jerry</div></div>

--0000000000003ec37e05a14c8113--

