Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8F6C43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 01:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B7C206F6
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 01:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jteH/MS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B7C206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHzvH-00016B-OS
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 21:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mohammad.elshabani@gmail.com>) id 1jHxIs-0006Th-2z
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mohammad.elshabani@gmail.com>) id 1jHxIq-0007Fh-NB
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:18:13 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:33873)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mohammad.elshabani@gmail.com>)
 id 1jHxIq-0007Dt-EC
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:18:12 -0400
Received: by mail-yb1-xb44.google.com with SMTP id l84so5445517ybb.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=3yyRLWbGknJw6Iz8pxIsVZwZ0DRsnadBYzhGoUHyE6A=;
 b=jteH/MS3cPU+X6roGQP2HAWL/njReMb/zz2luN1aTadOxS+FJHWxl6SbDz08JJWUiI
 tF6GuCojQXzwXL2Kh7HWPQ5VNl7fi4NS2VqO4xFobPmGb+bD4aB1tSm5K5ozae5ca7kK
 vtOe7pa8eoSLi7M7iYDQIT4jJv6IWzT+1ceTLvGwzl/FvAVgi8EofHxbmmq5z1NNVmU9
 Do/d9XggH8lL6YbGI3wDoJB8zMKacbk6wwAYYZn63vnkD2kLLsQdxo4dUvhLfChFhl5R
 t1fQ4jHZyxIHYLL0z0J3W6+zqhxtnvRbNRR3xuiN8EP90klI1P5i4w0OlHP5tJjxkqJ7
 wZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=3yyRLWbGknJw6Iz8pxIsVZwZ0DRsnadBYzhGoUHyE6A=;
 b=kVJwL8qA8+Mko8x6SLi1zmEdXuxr0mv1w6CLKl5bDeN6lrJ42sR1ArI39a6FDMZQzV
 4SGd0aSzBV3evCju2iH++JTEiw2Fd55Cw24lN7wG5fzZQIZ9/h2e44XyfBySMPIeDm9p
 SGyXQcGKUlEm52odOPAjjuVNE3pxnld2whaH1Rf1rtV3fAwAJCwJ2KJ+/s/0L3rlyK+f
 jpbKv/Yey526SRoXTgWwiC9yRWNej+EnrVqIUAKgzXFkdkPoCCPGe2D5L172Kf/MZH5K
 fZaRKGmjHpXiyBtrD2q8mhex/x2+f39dpSY9LCqm9z3Z3GLkX3XuBHM0nP3rwxUOoMHa
 Ig2A==
X-Gm-Message-State: ANhLgQ0o9hRVjtTzGzj9E780QcY7hWAOUmsT/glfWLxVUf4ZaDjo08fp
 YaDOuU/52gD4lvXfzxAEbw7CKdAqdEDcOG7nytsHy9f7
X-Google-Smtp-Source: ADFU+vtZU43uWXDhkvdZGGy7Mf7gjniJxJ7Zh3UDVi5zMACMzqKPtitQ/u2/dB76DwUf7z0+GrRoMK/9GRBxDnSrEMw=
X-Received: by 2002:a25:b94d:: with SMTP id s13mr1743033ybm.90.1585347490712; 
 Fri, 27 Mar 2020 15:18:10 -0700 (PDT)
MIME-Version: 1.0
From: Mohammad El-Shabani <mohammad.elshabani@gmail.com>
Date: Fri, 27 Mar 2020 15:17:59 -0700
Message-ID: <CAF_W8bf=+2fx0tsB8fYdDa-e2YjCRzMdodsKE9+hXx2qJCNQ0Q@mail.gmail.com>
Subject: PCI device perf limitation
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000000791a105a1dd7a82"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
X-Mailman-Approved-At: Fri, 27 Mar 2020 21:04:44 -0400
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

--0000000000000791a105a1dd7a82
Content-Type: text/plain; charset="UTF-8"

Hi,



I noticed a perf issue in my own pci device, and managed to reproduce it
with the pci-testdev with a small patch. Here:



   1. diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
   2. index 188de4d9cc..b2e225d25b 100644
   3. --- a/hw/misc/pci-testdev.c
   4. +++ b/hw/misc/pci-testdev.c
   5. @@ -252,7 +252,7 @@ static void pci_testdev_realize(PCIDevice *pci_dev
   , Error **errp)
   6. pci_conf[PCI_INTERRUPT_PIN] = 0; /* no interrupt pin */
   7.
   8. memory_region_init_io(&d->mmio, OBJECT(d), &pci_testdev_mmio_ops, d,
   9. - "pci-testdev-mmio", IOTEST_MEMSIZE * 2);
   10. + "pci-testdev-mmio", 256 * 1024 * 1024);
   11. memory_region_init_io(&d->portio, OBJECT(d), &pci_testdev_pio_ops, d,
   12. "pci-testdev-portio", IOTEST_IOSIZE * 2);
   13. pci_register_bar(pci_dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &d->mmio
   );



Before my patch, I could start a VM with 32 of these devices happily. I can
ssh to the VM within a minute. I also see that once the VM is up, I see
small amount of kvm activity, i.e. less than 100 kvm exits a second.



After the patch, I can start no more than 3 devices. If I do, I seems like
QEMU gets to a state of thrashing. The VM never comes up, and I see the
following:



kvm statistics - summary



 Event                                         Total %Total CurAvg/s

 kvm_fpu                                    52166411   46.8  2773738

 kvm_userspace_exit                         26083186   23.4  1386869

 kvm_vcpu_wakeup                            25415616   22.8  1386869



I tried to trace the kvm exit reason, but I get:

 qemu-system-x86 83801 [090] 10892345.982869:
kvm:kvm_userspace_exit: reason KVM_EXIT_UNKNOWN (0)



I am wondering if this is known performance limitation on io memory region?
Is there a way around it?



Thanks,

Mo

--0000000000000791a105a1dd7a82
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div><p class=3D"MsoNormal" style=3D"margin:0in 0in 0.=
0001pt;font-size:12pt;font-family:Calibri,sans-serif;color:rgb(0,0,0)"><spa=
n style=3D"font-size:11pt">Hi,</span></p><p class=3D"MsoNormal" style=3D"ma=
rgin:0in 0in 0.0001pt;font-size:12pt;font-family:Calibri,sans-serif;color:r=
gb(0,0,0)"><span style=3D"font-size:11pt">=C2=A0</span></p><p class=3D"MsoN=
ormal" style=3D"margin:0in 0in 0.0001pt;font-size:12pt;font-family:Calibri,=
sans-serif;color:rgb(0,0,0)"><span style=3D"font-size:11pt">I noticed a per=
f issue in my own pci device, and managed to reproduce it with the pci-test=
dev with a small patch. Here:</span></p><p class=3D"MsoNormal" style=3D"mar=
gin:0in 0in 0.0001pt;font-size:12pt;font-family:Calibri,sans-serif;color:rg=
b(0,0,0)"><span style=3D"font-size:11pt"><br></span></p><ol class=3D"gmail-=
linenums" style=3D"box-sizing:border-box;margin-top:0px;margin-bottom:0px;c=
olor:rgb(51,51,51);font-family:Menlo,Monaco,Consolas,&quot;Courier New&quot=
;,monospace;font-size:13px;white-space:pre-wrap"><li class=3D"gmail-L0" sty=
le=3D"box-sizing:border-box;list-style-type:none;border-left:1px solid rgb(=
204,204,204)"><span class=3D"gmail-pln" style=3D"box-sizing:border-box;colo=
r:rgb(0,0,0)">diff </span><span class=3D"gmail-pun" style=3D"box-sizing:bor=
der-box;color:rgb(102,102,0)">--</span><span class=3D"gmail-pln" style=3D"b=
ox-sizing:border-box;color:rgb(0,0,0)">git a</span><span class=3D"gmail-pun=
" style=3D"box-sizing:border-box;color:rgb(102,102,0)">/</span><span class=
=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)">hw</span><s=
pan class=3D"gmail-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)=
">/</span><span class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rg=
b(0,0,0)">misc</span><span class=3D"gmail-pun" style=3D"box-sizing:border-b=
ox;color:rgb(102,102,0)">/</span><span class=3D"gmail-pln" style=3D"box-siz=
ing:border-box;color:rgb(0,0,0)">pci</span><span class=3D"gmail-pun" style=
=3D"box-sizing:border-box;color:rgb(102,102,0)">-</span><span class=3D"gmai=
l-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)">testdev</span><span=
 class=3D"gmail-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">.=
</span><span class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0=
,0,0)">c b</span><span class=3D"gmail-pun" style=3D"box-sizing:border-box;c=
olor:rgb(102,102,0)">/</span><span class=3D"gmail-pln" style=3D"box-sizing:=
border-box;color:rgb(0,0,0)">hw</span><span class=3D"gmail-pun" style=3D"bo=
x-sizing:border-box;color:rgb(102,102,0)">/</span><span class=3D"gmail-pln"=
 style=3D"box-sizing:border-box;color:rgb(0,0,0)">misc</span><span class=3D=
"gmail-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">/</span><s=
pan class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)">pc=
i</span><span class=3D"gmail-pun" style=3D"box-sizing:border-box;color:rgb(=
102,102,0)">-</span><span class=3D"gmail-pln" style=3D"box-sizing:border-bo=
x;color:rgb(0,0,0)">testdev</span><span class=3D"gmail-pun" style=3D"box-si=
zing:border-box;color:rgb(102,102,0)">.</span><span class=3D"gmail-pln" sty=
le=3D"box-sizing:border-box;color:rgb(0,0,0)">c</span></li><li class=3D"gma=
il-L1" style=3D"box-sizing:border-box;list-style-type:none;background:rgb(2=
38,238,238);border-left:1px solid rgb(204,204,204)"><span class=3D"gmail-pl=
n" style=3D"box-sizing:border-box;color:rgb(0,0,0)">index </span><span clas=
s=3D"gmail-lit" style=3D"box-sizing:border-box;color:rgb(0,102,102)">188de4=
d9cc</span><span class=3D"gmail-pun" style=3D"box-sizing:border-box;color:r=
gb(102,102,0)">..</span><span class=3D"gmail-pln" style=3D"box-sizing:borde=
r-box;color:rgb(0,0,0)">b2e225d25b </span><span class=3D"gmail-lit" style=
=3D"box-sizing:border-box;color:rgb(0,102,102)">100644</span></li><li class=
=3D"gmail-L2" style=3D"box-sizing:border-box;list-style-type:none;border-le=
ft:1px solid rgb(204,204,204)"><span class=3D"gmail-pun" style=3D"box-sizin=
g:border-box;color:rgb(102,102,0)">---</span><span class=3D"gmail-pln" styl=
e=3D"box-sizing:border-box;color:rgb(0,0,0)"> a</span><span class=3D"gmail-=
pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">/</span><span cla=
ss=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)">hw</span>=
<span class=3D"gmail-pun" style=3D"box-sizing:border-box;color:rgb(102,102,=
0)">/</span><span class=3D"gmail-pln" style=3D"box-sizing:border-box;color:=
rgb(0,0,0)">misc</span><span class=3D"gmail-pun" style=3D"box-sizing:border=
-box;color:rgb(102,102,0)">/</span><span class=3D"gmail-pln" style=3D"box-s=
izing:border-box;color:rgb(0,0,0)">pci</span><span class=3D"gmail-pun" styl=
e=3D"box-sizing:border-box;color:rgb(102,102,0)">-</span><span class=3D"gma=
il-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)">testdev</span><spa=
n class=3D"gmail-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">=
.</span><span class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(=
0,0,0)">c</span></li><li class=3D"gmail-L3" style=3D"box-sizing:border-box;=
list-style-type:none;background:rgb(238,238,238);border-left:1px solid rgb(=
204,204,204)"><span class=3D"gmail-pun" style=3D"box-sizing:border-box;colo=
r:rgb(102,102,0)">+++</span><span class=3D"gmail-pln" style=3D"box-sizing:b=
order-box;color:rgb(0,0,0)"> b</span><span class=3D"gmail-pun" style=3D"box=
-sizing:border-box;color:rgb(102,102,0)">/</span><span class=3D"gmail-pln" =
style=3D"box-sizing:border-box;color:rgb(0,0,0)">hw</span><span class=3D"gm=
ail-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">/</span><span=
 class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)">misc<=
/span><span class=3D"gmail-pun" style=3D"box-sizing:border-box;color:rgb(10=
2,102,0)">/</span><span class=3D"gmail-pln" style=3D"box-sizing:border-box;=
color:rgb(0,0,0)">pci</span><span class=3D"gmail-pun" style=3D"box-sizing:b=
order-box;color:rgb(102,102,0)">-</span><span class=3D"gmail-pln" style=3D"=
box-sizing:border-box;color:rgb(0,0,0)">testdev</span><span class=3D"gmail-=
pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">.</span><span cla=
ss=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)">c</span><=
/li><li class=3D"gmail-L4" style=3D"box-sizing:border-box;border-left:1px s=
olid rgb(204,204,204)"><span class=3D"gmail-pun" style=3D"box-sizing:border=
-box;color:rgb(102,102,0)">@@</span><span class=3D"gmail-pln" style=3D"box-=
sizing:border-box;color:rgb(0,0,0)"> </span><span class=3D"gmail-pun" style=
=3D"box-sizing:border-box;color:rgb(102,102,0)">-</span><span class=3D"gmai=
l-lit" style=3D"box-sizing:border-box;color:rgb(0,102,102)">252</span><span=
 class=3D"gmail-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">,=
</span><span class=3D"gmail-lit" style=3D"box-sizing:border-box;color:rgb(0=
,102,102)">7</span><span class=3D"gmail-pln" style=3D"box-sizing:border-box=
;color:rgb(0,0,0)"> </span><span class=3D"gmail-pun" style=3D"box-sizing:bo=
rder-box;color:rgb(102,102,0)">+</span><span class=3D"gmail-lit" style=3D"b=
ox-sizing:border-box;color:rgb(0,102,102)">252</span><span class=3D"gmail-p=
un" style=3D"box-sizing:border-box;color:rgb(102,102,0)">,</span><span clas=
s=3D"gmail-lit" style=3D"box-sizing:border-box;color:rgb(0,102,102)">7</spa=
n><span class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)=
"> </span><span class=3D"gmail-pun" style=3D"box-sizing:border-box;color:rg=
b(102,102,0)">@@</span><span class=3D"gmail-pln" style=3D"box-sizing:border=
-box;color:rgb(0,0,0)"> </span><span class=3D"gmail-kwd" style=3D"box-sizin=
g:border-box;color:rgb(0,0,136)">static</span><span class=3D"gmail-pln" sty=
le=3D"box-sizing:border-box;color:rgb(0,0,0)"> </span><span class=3D"gmail-=
kwd" style=3D"box-sizing:border-box;color:rgb(0,0,136)">void</span><span cl=
ass=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)"> pci_tes=
tdev_realize</span><span class=3D"gmail-pun" style=3D"box-sizing:border-box=
;color:rgb(102,102,0)">(</span><span class=3D"gmail-typ" style=3D"box-sizin=
g:border-box;color:rgb(102,0,102)">PCIDevice</span><span class=3D"gmail-pln=
" style=3D"box-sizing:border-box;color:rgb(0,0,0)"> </span><span class=3D"g=
mail-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">*</span><spa=
n class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)">pci_=
dev</span><span class=3D"gmail-pun" style=3D"box-sizing:border-box;color:rg=
b(102,102,0)">,</span><span class=3D"gmail-pln" style=3D"box-sizing:border-=
box;color:rgb(0,0,0)"> </span><span class=3D"gmail-typ" style=3D"box-sizing=
:border-box;color:rgb(102,0,102)">Error</span><span class=3D"gmail-pln" sty=
le=3D"box-sizing:border-box;color:rgb(0,0,0)"> </span><span class=3D"gmail-=
pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">**</span><span cl=
ass=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)">errp</sp=
an><span class=3D"gmail-pun" style=3D"box-sizing:border-box;color:rgb(102,1=
02,0)">)</span></li><li class=3D"gmail-L5" style=3D"box-sizing:border-box;l=
ist-style-type:none;background:rgb(238,238,238);border-left:1px solid rgb(2=
04,204,204)"><span class=3D"gmail-pln" style=3D"box-sizing:border-box;color=
:rgb(0,0,0)">     pci_conf</span><span class=3D"gmail-pun" style=3D"box-siz=
ing:border-box;color:rgb(102,102,0)">[</span><span class=3D"gmail-pln" styl=
e=3D"box-sizing:border-box;color:rgb(0,0,0)">PCI_INTERRUPT_PIN</span><span =
class=3D"gmail-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">]<=
/span><span class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,=
0,0)"> </span><span class=3D"gmail-pun" style=3D"box-sizing:border-box;colo=
r:rgb(102,102,0)">=3D</span><span class=3D"gmail-pln" style=3D"box-sizing:b=
order-box;color:rgb(0,0,0)"> </span><span class=3D"gmail-lit" style=3D"box-=
sizing:border-box;color:rgb(0,102,102)">0</span><span class=3D"gmail-pun" s=
tyle=3D"box-sizing:border-box;color:rgb(102,102,0)">;</span><span class=3D"=
gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)"> </span><span c=
lass=3D"gmail-com" style=3D"box-sizing:border-box;color:rgb(136,0,0)">/* no=
 interrupt pin */</span></li><li class=3D"gmail-L6" style=3D"box-sizing:bor=
der-box;list-style-type:none;border-left:1px solid rgb(204,204,204)"><span =
class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)"> </spa=
n></li><li class=3D"gmail-L7" style=3D"box-sizing:border-box;list-style-typ=
e:none;background:rgb(238,238,238);border-left:1px solid rgb(204,204,204)">=
<span class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)">=
     memory_region_init_io</span><span class=3D"gmail-pun" style=3D"box-siz=
ing:border-box;color:rgb(102,102,0)">(&amp;</span><span class=3D"gmail-pln"=
 style=3D"box-sizing:border-box;color:rgb(0,0,0)">d</span><span class=3D"gm=
ail-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">-&gt;</span><=
span class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)">m=
mio</span><span class=3D"gmail-pun" style=3D"box-sizing:border-box;color:rg=
b(102,102,0)">,</span><span class=3D"gmail-pln" style=3D"box-sizing:border-=
box;color:rgb(0,0,0)"> OBJECT</span><span class=3D"gmail-pun" style=3D"box-=
sizing:border-box;color:rgb(102,102,0)">(</span><span class=3D"gmail-pln" s=
tyle=3D"box-sizing:border-box;color:rgb(0,0,0)">d</span><span class=3D"gmai=
l-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">),</span><span =
class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)"> </spa=
n><span class=3D"gmail-pun" style=3D"box-sizing:border-box;color:rgb(102,10=
2,0)">&amp;</span><span class=3D"gmail-pln" style=3D"box-sizing:border-box;=
color:rgb(0,0,0)">pci_testdev_mmio_ops</span><span class=3D"gmail-pun" styl=
e=3D"box-sizing:border-box;color:rgb(102,102,0)">,</span><span class=3D"gma=
il-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)"> d</span><span cla=
ss=3D"gmail-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">,</sp=
an></li><li class=3D"gmail-L8" style=3D"box-sizing:border-box;list-style-ty=
pe:none;border-left:1px solid rgb(204,204,204)"><span class=3D"gmail-pun" s=
tyle=3D"box-sizing:border-box;color:rgb(102,102,0)">-</span><span class=3D"=
gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)">               =
           </span><span class=3D"gmail-str" style=3D"box-sizing:border-box;=
color:rgb(0,136,0)">&quot;pci-testdev-mmio&quot;</span><span class=3D"gmail=
-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">,</span><span cl=
ass=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)"> IOTEST_=
MEMSIZE </span><span class=3D"gmail-pun" style=3D"box-sizing:border-box;col=
or:rgb(102,102,0)">*</span><span class=3D"gmail-pln" style=3D"box-sizing:bo=
rder-box;color:rgb(0,0,0)"> </span><span class=3D"gmail-lit" style=3D"box-s=
izing:border-box;color:rgb(0,102,102)">2</span><span class=3D"gmail-pun" st=
yle=3D"box-sizing:border-box;color:rgb(102,102,0)">);</span></li><li class=
=3D"gmail-L9" style=3D"box-sizing:border-box;background:rgb(238,238,238);bo=
rder-left:1px solid rgb(204,204,204)"><span class=3D"gmail-pun" style=3D"bo=
x-sizing:border-box;color:rgb(102,102,0)">+</span><span class=3D"gmail-pln"=
 style=3D"box-sizing:border-box;color:rgb(0,0,0)">                         =
 </span><span class=3D"gmail-str" style=3D"box-sizing:border-box;color:rgb(=
0,136,0)">&quot;pci-testdev-mmio&quot;</span><span class=3D"gmail-pun" styl=
e=3D"box-sizing:border-box;color:rgb(102,102,0)">,</span><span class=3D"gma=
il-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)"> </span><span clas=
s=3D"gmail-lit" style=3D"box-sizing:border-box;color:rgb(0,102,102)">256</s=
pan><span class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,=
0)"> </span><span class=3D"gmail-pun" style=3D"box-sizing:border-box;color:=
rgb(102,102,0)">*</span><span class=3D"gmail-pln" style=3D"box-sizing:borde=
r-box;color:rgb(0,0,0)"> </span><span class=3D"gmail-lit" style=3D"box-sizi=
ng:border-box;color:rgb(0,102,102)">1024</span><span class=3D"gmail-pln" st=
yle=3D"box-sizing:border-box;color:rgb(0,0,0)"> </span><span class=3D"gmail=
-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">*</span><span cl=
ass=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)"> </span>=
<span class=3D"gmail-lit" style=3D"box-sizing:border-box;color:rgb(0,102,10=
2)">1024</span><span class=3D"gmail-pun" style=3D"box-sizing:border-box;col=
or:rgb(102,102,0)">);</span></li><li class=3D"gmail-L0" style=3D"box-sizing=
:border-box;list-style-type:none;border-left:1px solid rgb(204,204,204)"><s=
pan class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)">  =
   memory_region_init_io</span><span class=3D"gmail-pun" style=3D"box-sizin=
g:border-box;color:rgb(102,102,0)">(&amp;</span><span class=3D"gmail-pln" s=
tyle=3D"box-sizing:border-box;color:rgb(0,0,0)">d</span><span class=3D"gmai=
l-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">-&gt;</span><sp=
an class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)">por=
tio</span><span class=3D"gmail-pun" style=3D"box-sizing:border-box;color:rg=
b(102,102,0)">,</span><span class=3D"gmail-pln" style=3D"box-sizing:border-=
box;color:rgb(0,0,0)"> OBJECT</span><span class=3D"gmail-pun" style=3D"box-=
sizing:border-box;color:rgb(102,102,0)">(</span><span class=3D"gmail-pln" s=
tyle=3D"box-sizing:border-box;color:rgb(0,0,0)">d</span><span class=3D"gmai=
l-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">),</span><span =
class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)"> </spa=
n><span class=3D"gmail-pun" style=3D"box-sizing:border-box;color:rgb(102,10=
2,0)">&amp;</span><span class=3D"gmail-pln" style=3D"box-sizing:border-box;=
color:rgb(0,0,0)">pci_testdev_pio_ops</span><span class=3D"gmail-pun" style=
=3D"box-sizing:border-box;color:rgb(102,102,0)">,</span><span class=3D"gmai=
l-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)"> d</span><span clas=
s=3D"gmail-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">,</spa=
n></li><li class=3D"gmail-L1" style=3D"box-sizing:border-box;list-style-typ=
e:none;background:rgb(238,238,238);border-left:1px solid rgb(204,204,204)">=
<span class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)">=
                           </span><span class=3D"gmail-str" style=3D"box-si=
zing:border-box;color:rgb(0,136,0)">&quot;pci-testdev-portio&quot;</span><s=
pan class=3D"gmail-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)=
">,</span><span class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rg=
b(0,0,0)"> IOTEST_IOSIZE </span><span class=3D"gmail-pun" style=3D"box-sizi=
ng:border-box;color:rgb(102,102,0)">*</span><span class=3D"gmail-pln" style=
=3D"box-sizing:border-box;color:rgb(0,0,0)"> </span><span class=3D"gmail-li=
t" style=3D"box-sizing:border-box;color:rgb(0,102,102)">2</span><span class=
=3D"gmail-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">);</spa=
n></li><li class=3D"gmail-L2" style=3D"box-sizing:border-box;list-style-typ=
e:none;border-left:1px solid rgb(204,204,204)"><span class=3D"gmail-pln" st=
yle=3D"box-sizing:border-box;color:rgb(0,0,0)">     pci_register_bar</span>=
<span class=3D"gmail-pun" style=3D"box-sizing:border-box;color:rgb(102,102,=
0)">(</span><span class=3D"gmail-pln" style=3D"box-sizing:border-box;color:=
rgb(0,0,0)">pci_dev</span><span class=3D"gmail-pun" style=3D"box-sizing:bor=
der-box;color:rgb(102,102,0)">,</span><span class=3D"gmail-pln" style=3D"bo=
x-sizing:border-box;color:rgb(0,0,0)"> </span><span class=3D"gmail-lit" sty=
le=3D"box-sizing:border-box;color:rgb(0,102,102)">0</span><span class=3D"gm=
ail-pun" style=3D"box-sizing:border-box;color:rgb(102,102,0)">,</span><span=
 class=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)"> PCI_=
BASE_ADDRESS_SPACE_MEMORY</span><span class=3D"gmail-pun" style=3D"box-sizi=
ng:border-box;color:rgb(102,102,0)">,</span><span class=3D"gmail-pln" style=
=3D"box-sizing:border-box;color:rgb(0,0,0)"> </span><span class=3D"gmail-pu=
n" style=3D"box-sizing:border-box;color:rgb(102,102,0)">&amp;</span><span c=
lass=3D"gmail-pln" style=3D"box-sizing:border-box;color:rgb(0,0,0)">d</span=
><span class=3D"gmail-pun" style=3D"box-sizing:border-box;color:rgb(102,102=
,0)">-&gt;</span><span class=3D"gmail-pln" style=3D"box-sizing:border-box;c=
olor:rgb(0,0,0)">mmio</span><span class=3D"gmail-pun" style=3D"box-sizing:b=
order-box;color:rgb(102,102,0)">);</span></li></ol><p class=3D"MsoNormal" s=
tyle=3D"margin:0in 0in 0.0001pt;font-size:12pt;font-family:Calibri,sans-ser=
if;color:rgb(0,0,0)"><span style=3D"font-size:11pt">=C2=A0</span></p><p cla=
ss=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:12pt;font-famil=
y:Calibri,sans-serif;color:rgb(0,0,0)"><span style=3D"font-size:11pt">Befor=
e my patch, I could start a VM with 32 of these devices happily. I can ssh =
to the VM within a minute. I also see that once the VM is up, I see small a=
mount of kvm activity, i.e. less than 100 kvm exits a second.</span></p><p =
class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:12pt;font-fa=
mily:Calibri,sans-serif;color:rgb(0,0,0)"><span style=3D"font-size:11pt">=
=C2=A0</span></p><p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;fo=
nt-size:12pt;font-family:Calibri,sans-serif;color:rgb(0,0,0)"><span style=
=3D"font-size:11pt">After the patch, I can start no more than 3 devices. If=
 I do, I seems like QEMU gets to a state of thrashing. The VM never comes u=
p, and I see the following:</span></p><p class=3D"MsoNormal" style=3D"margi=
n:0in 0in 0.0001pt;font-size:12pt;font-family:Calibri,sans-serif;color:rgb(=
0,0,0)"><span style=3D"font-size:11pt">=C2=A0</span></p><p class=3D"gmail-p=
1" style=3D"margin:0in 0in 0.0001pt;background-color:black;font-size:10pt;f=
ont-family:&quot;Andale Mono&quot;;color:lime"><span class=3D"gmail-s1">kvm=
 statistics - summary</span></p><p class=3D"gmail-p2" style=3D"margin:0in 0=
in 0.0001pt;background-color:black;font-size:10pt;font-family:&quot;Andale =
Mono&quot;;color:rgb(47,255,18)">=C2=A0</p><p class=3D"gmail-p3" style=3D"m=
argin:0in 0in 0.0001pt;background-color:rgb(47,255,18);font-size:10pt;font-=
family:&quot;Andale Mono&quot;;color:rgb(0,0,0)"><span class=3D"gmail-apple=
-converted-space"><span style=3D"color:rgb(47,255,18);background-color:blac=
k">=C2=A0</span></span><span class=3D"gmail-s1">Event<span class=3D"gmail-A=
pple-converted-space">=C2=A0</span></span><span class=3D"gmail-apple-conver=
ted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0<span class=3D"gmail-Apple-converted-space">=C2=A0</span></span><span cl=
ass=3D"gmail-s1">Total %Total CurAvg/s</span></p><p class=3D"gmail-p4" styl=
e=3D"margin:0in 0in 0.0001pt;background-color:black;font-size:10pt;font-fam=
ily:&quot;Andale Mono&quot;;color:rgb(47,255,18)"><span class=3D"gmail-appl=
e-converted-space">=C2=A0</span><span class=3D"gmail-s1">kvm_fpu</span><spa=
n class=3D"gmail-apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0<span class=3D"gmail-Apple-converted-space">=C2=A0</span><=
/span><span class=3D"gmail-s1">52166411<span class=3D"gmail-Apple-converted=
-space">=C2=A0</span></span><span class=3D"gmail-apple-converted-space">=C2=
=A0<span class=3D"gmail-Apple-converted-space">=C2=A0</span></span><span cl=
ass=3D"gmail-s1">46.8</span><span class=3D"gmail-apple-converted-space">=C2=
=A0<span class=3D"gmail-Apple-converted-space">=C2=A0</span></span><span cl=
ass=3D"gmail-s1">2773738</span></p><p class=3D"gmail-p4" style=3D"margin:0i=
n 0in 0.0001pt;background-color:black;font-size:10pt;font-family:&quot;Anda=
le Mono&quot;;color:rgb(47,255,18)"><span class=3D"gmail-apple-converted-sp=
ace">=C2=A0</span><span class=3D"gmail-s1">kvm_userspace_exit<span class=3D=
"gmail-Apple-converted-space">=C2=A0</span></span><span class=3D"gmail-appl=
e-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0<span class=3D"gmail-Apple-converted-space">=C2=
=A0</span></span><span class=3D"gmail-s1">26083186<span class=3D"gmail-Appl=
e-converted-space">=C2=A0</span></span><span class=3D"gmail-apple-converted=
-space">=C2=A0<span class=3D"gmail-Apple-converted-space">=C2=A0</span></sp=
an><span class=3D"gmail-s1">23.4</span><span class=3D"gmail-apple-converted=
-space">=C2=A0<span class=3D"gmail-Apple-converted-space">=C2=A0</span></sp=
an><span class=3D"gmail-s1">1386869</span></p><p class=3D"gmail-p4" style=
=3D"margin:0in 0in 0.0001pt;background-color:black;font-size:10pt;font-fami=
ly:&quot;Andale Mono&quot;;color:rgb(47,255,18)"><span class=3D"gmail-apple=
-converted-space">=C2=A0</span><span class=3D"gmail-s1">kvm_vcpu_wakeup</sp=
an><span class=3D"gmail-apple-converted-space">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<span =
class=3D"gmail-Apple-converted-space">=C2=A0</span></span><span class=3D"gm=
ail-s1">25415616<span class=3D"gmail-Apple-converted-space">=C2=A0</span></=
span><span class=3D"gmail-apple-converted-space">=C2=A0<span class=3D"gmail=
-Apple-converted-space">=C2=A0</span></span><span class=3D"gmail-s1">22.8</=
span><span class=3D"gmail-apple-converted-space">=C2=A0<span class=3D"gmail=
-Apple-converted-space">=C2=A0</span></span><span class=3D"gmail-s1">138686=
9</span></p><p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-si=
ze:12pt;font-family:Calibri,sans-serif;color:rgb(0,0,0)"><span style=3D"fon=
t-size:11pt">=C2=A0</span></p><p class=3D"MsoNormal" style=3D"margin:0in 0i=
n 0.0001pt;font-size:12pt;font-family:Calibri,sans-serif;color:rgb(0,0,0)">=
<span style=3D"font-size:11pt">I tried to trace the kvm exit reason, but I =
get:</span></p><p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font=
-size:12pt;font-family:Calibri,sans-serif;color:rgb(0,0,0);background-color=
:black"><span style=3D"font-size:10pt;font-family:&quot;Andale Mono&quot;;c=
olor:rgb(47,255,18)">=C2=A0qemu-system-x86 83801 [090] 10892345.982869:=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kvm:kvm_userspace_exit: reason KVM_E=
XIT_UNKNOWN (0)</span></p><p class=3D"MsoNormal" style=3D"margin:0in 0in 0.=
0001pt;font-size:12pt;font-family:Calibri,sans-serif;color:rgb(0,0,0)"><spa=
n style=3D"font-size:11pt">=C2=A0</span></p><p class=3D"MsoNormal" style=3D=
"margin:0in 0in 0.0001pt;font-size:12pt;font-family:Calibri,sans-serif;colo=
r:rgb(0,0,0)"><span style=3D"font-size:11pt">I am wondering if this is know=
n performance limitation on io memory region? Is there a way around it?</sp=
an></p><p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:12=
pt;font-family:Calibri,sans-serif;color:rgb(0,0,0)"><span style=3D"font-siz=
e:11pt">=C2=A0</span></p><p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0=
001pt;font-size:12pt;font-family:Calibri,sans-serif;color:rgb(0,0,0)"><span=
 style=3D"font-size:11pt">Thanks,</span></p><p class=3D"MsoNormal" style=3D=
"margin:0in 0in 0.0001pt;font-size:12pt;font-family:Calibri,sans-serif;colo=
r:rgb(0,0,0)"><span style=3D"font-size:11pt">Mo</span></p><p class=3D"MsoNo=
rmal" style=3D"margin:0in 0in 0.0001pt;font-size:12pt;font-family:Calibri,s=
ans-serif;color:rgb(0,0,0)"><span style=3D"font-size:11pt">=C2=A0</span></p=
><p class=3D"MsoNormal" style=3D"margin:0in 0in 0.0001pt;font-size:12pt;fon=
t-family:Calibri,sans-serif;color:rgb(0,0,0)"><span style=3D"font-size:11pt=
">=C2=A0</span></p></div></div>

--0000000000000791a105a1dd7a82--

