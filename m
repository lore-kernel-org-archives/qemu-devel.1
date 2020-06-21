Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED31EC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 13:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4E4207E8
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 13:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjKw5QWk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4E4207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmztZ-0005z3-Ve
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 09:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <windowsnotfound@gmail.com>)
 id 1jmuS9-0004vI-MX
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 03:31:45 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:43252)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <windowsnotfound@gmail.com>)
 id 1jmuS8-0002EJ-68
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 03:31:45 -0400
Received: by mail-oi1-x22e.google.com with SMTP id j189so12661799oih.10
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 00:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=IrFO8Q3/2iE2hMKbZ6XttcZcJKCrvHlfHoHnUZmVYE0=;
 b=EjKw5QWk7FDDGsqGZaiAKq9MjOY2SfO7bwMlUt6IIUNTk8zIAqFzAmlD5gTRANPrZA
 BTaxs/f3aa9w0fEGW7RHcBdthiPQrxyTdrzrZiHA/wtBiinJMGBj0UsHCRO6evG9h2xi
 IaPjWxRHCcrXlq/+qQ3xl88PKOPvIap17TdRBayXwbU0nZSAu0qnmbFskACABIh3NwIn
 b8iFUiA826B72M1RQLX3SSOLjLwfKKE1s0BktXk8k5kQuAZIBmPQRkxKlh9PQ2K+Twff
 PQbOq8PCSPpG5F5sLEMX2+Ke74BHJGEvFNmyv1lkp8oe8kQ/m0kc+Zzi64/DpP/YPPkf
 57nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=IrFO8Q3/2iE2hMKbZ6XttcZcJKCrvHlfHoHnUZmVYE0=;
 b=OZhg23MBSaED5Qde5nyN6JO1BQPbPJjreaIHoUa/Zi38hfbofeJCyJe7RdyiRLiHh4
 9JbQ01CvOLY0AvSHPuuLxAqQ8B1ONwJZcftp/l6hMxcKl03Y5fb7DcE/Tt7Y5EZaneZQ
 E4USOFEfrWXfpE8ZZ8IXcFZP7B4WEOwrLHdUcqITTbrcq/SheNM2kGtr35eD4sXTvBcH
 pGU7QHl1hgFbaEN+zubnVyegah6siZTYk/zT/w12q4uammg12bNi4vN3waJITZBP9jd8
 mnqSI/C4Pfn6Qr63iE+J4jjt+/6T+x32rx6zwQiAcU6WmxGto706AgWPO2vKckLQScGv
 wC6g==
X-Gm-Message-State: AOAM533plbPtAJr9TmAUZJja5+IbD7h5B7tnVZ1lWdYx4TatC1NJ83P5
 uwNhymR4b5Yv+dufv/USwXuG682CFat0VeliM1a3vOP8
X-Google-Smtp-Source: ABdhPJxJbiXmHMe4PR55xMWUElSdeNQ8wxOAv9f+03m94XZRlqlU7dAdX4ArG7BqtVwmH+/mbI1iMCdmQVK6JhvykV0=
X-Received: by 2002:aca:bd84:: with SMTP id n126mr8584421oif.71.1592724702285; 
 Sun, 21 Jun 2020 00:31:42 -0700 (PDT)
MIME-Version: 1.0
From: Antonio Raffaele <windowsnotfound@gmail.com>
Date: Sun, 21 Jun 2020 09:31:30 +0200
Message-ID: <CAFES52nPcmpF9dB175J4xdAqsJO+GK2614OOoKDArt+=cX2mhA@mail.gmail.com>
Subject: 
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001ad1a005a8931e67"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=windowsnotfound@gmail.com; helo=mail-oi1-x22e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 21 Jun 2020 09:19:04 -0400
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

--0000000000001ad1a005a8931e67
Content-Type: text/plain; charset="UTF-8"

Hi I'm trying to create a qemu virtual machine that runs windows 10. I
would like to try to make it almost indistinguishable from a real computer
(I know it's impossible, but at least I get close). I have already changed
any suspicious identifiers (smbios, hard disk, card network and so on,
host-passthroug cpu etc.) But now checking the various components that the
guest computer recognizes, I realized (through the hwinfo64 program) that
in the bus section, then pcibus there are devices called "Red Hat , Device
ID "and with the same devicename, as device class have:" PCI-to-PCI Bridge
". Is there a way to change the devicename of these virtual compontents
(maybe even changing the qemu source)?

--0000000000001ad1a005a8931e67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><span style=3D"color:rgb(12,13,14);font-family:&quot;helv=
etica neue&quot;,helvetica,arial,sans-serif;font-size:15px;background-color=
:rgb(255,255,255)">Hi I&#39;m trying to create a qemu virtual machine that =
runs windows 10. I would like to try to make it almost indistinguishable fr=
om a real computer (I know it&#39;s impossible, but at least I get close). =
I have already changed any suspicious identifiers (smbios, hard disk, card =
network and so on, host-passthroug cpu etc.) But now checking the various c=
omponents that the guest computer recognizes, I realized (through the hwinf=
o64 program) that in the bus section, then pcibus there are devices called =
&quot;Red Hat , Device ID &quot;and with the same devicename, as device cla=
ss have:&quot; PCI-to-PCI Bridge &quot;. Is there a way to change the devic=
ename of these virtual compontents (maybe even changing the qemu source)?</=
span></div>

--0000000000001ad1a005a8931e67--

