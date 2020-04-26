Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA5AC55194
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 19:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8932071C
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 19:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4aFQQFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8932071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSnCJ-0003VK-36
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 15:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <padmajain967@gmail.com>) id 1jSm0X-0000vl-Un
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 14:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <padmajain967@gmail.com>) id 1jSm0X-00027Y-I9
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 14:28:01 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:34940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <padmajain967@gmail.com>)
 id 1jSm0X-0001v8-4k
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 14:28:01 -0400
Received: by mail-ot1-x330.google.com with SMTP id e26so22334025otr.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2020 11:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=3Sm+JEsJpgl1XG6pD0HAYad3hoxUAyH0k78tXN487UA=;
 b=c4aFQQFcnk+Wf0xKBYKlgW+vz5/lsDWf1H4oMl1uEDHHYQkStWFkDNlEhB7b8TsVgu
 6iLk2sDF747F8rL0pv1tCiaE7TrvqY2V2lSWxIFbkycHgGZiaN62I38WldccjlCPxc2q
 GSl3vGfMolmImvS9/eGL/FRDh2eNbzUUT0pBJXhurKxISnmnu65p396Pt+j7JH0DHN4K
 jeMy7187hwJAB8v5yB9ZVOrlFDRBQa9liLgsoKL1jDBOR9nb5QdWfGGIbtbfE6gvd+yV
 WzMbgt3inwWCAr9Yj+tjVSgZTOPRwhSY6wycUT330GibOYDOE29lBHv97Msv3lTktS4V
 WF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=3Sm+JEsJpgl1XG6pD0HAYad3hoxUAyH0k78tXN487UA=;
 b=rp/lWn/Q9rIWY9mzkj7IrxITD+ORycD98zSMVfIjvCF3weTa8r1IS3UPhMSqYb/a/T
 IUasz+Ug28zH/UPsmHtZQfc9FmWBi+o23zndlZLMRquO3QOaSO4/Gnu463fnI2Nm6l6j
 78yPakoSArQX3l8n0oV2qt9iON77sCIbIfc42jLxHRC1Z+jRqri3VTIl9PIC+bU1IEcm
 4cgSw27HS5EkHG1uiYEIpKSPVuI94q+zrsRe5opkLk9CpvMznKjtA+w1C2dh90FREDra
 GbyFEBr92/ukoFBxyvvmAVUz7ZS83Vdm1PbVHwONyKBQMf9hOAErsHVPu1DBphMvR//5
 FdXQ==
X-Gm-Message-State: AGi0PubRT6FN5rIcZLGcfAr4qac8LcaE4EVQJEbuYQ1/H0/8iKodKCKH
 b//eAnN2/MGj9GquhvPlWTfQl/5DnZa/H4U/0nFp3w==
X-Google-Smtp-Source: APiQypI4TLoYBigOE34BeQcoGL/HFI/bMc3hq3jNaSvSaRVNp2JMRreoJ+h16L+Nm1VXzglPrxInmtPi+9mmwjzjRb8=
X-Received: by 2002:aca:b6c5:: with SMTP id g188mr13012232oif.25.1587925679350; 
 Sun, 26 Apr 2020 11:27:59 -0700 (PDT)
MIME-Version: 1.0
From: padma jain <padmajain967@gmail.com>
Date: Sun, 26 Apr 2020 23:57:47 +0530
Message-ID: <CAO9fdnZ=MH5LrxWS4F7QLySKhTvqOR-X78eTWdMMXFJ-q8pOzg@mail.gmail.com>
Subject: HDMI issue with GPU passthrough
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000000c270d05a435c28b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=padmajain967@gmail.com; helo=mail-ot1-x330.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::330
X-Mailman-Approved-At: Sun, 26 Apr 2020 15:36:15 -0400
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

--0000000000000c270d05a435c28b
Content-Type: text/plain; charset="UTF-8"

Hi all,

      I am trying to make GPU and Audio PCI passthrough to VM using qemu.
display and audio is working fine except HDMI audio. HDMI audio data is
going to HDMI but not able to be heard in hdmi. Here i am passing pci-id's
of VGA and Audio to the qemu with vfio. Anything else to be done? am i
missing something?

Thanks
Padma

--0000000000000c270d05a435c28b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br><div>=C2=A0 =C2=A0 <i>=C2=A0 </i>I am tryi=
ng to make GPU and Audio PCI passthrough to VM using qemu. display and audi=
o is working fine except HDMI audio. HDMI audio data is going to HDMI but n=
ot able to be heard in hdmi. Here i am passing pci-id&#39;s of VGA and Audi=
o to the qemu with vfio. Anything else to be done? am i missing=C2=A0someth=
ing?</div><div><br></div><div>Thanks</div><div>Padma</div><div><br></div></=
div></div>

--0000000000000c270d05a435c28b--

