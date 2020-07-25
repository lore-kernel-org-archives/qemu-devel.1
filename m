Return-Path: <SRS0=thXK=BE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1424C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 08:14:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C6AB206C1
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2020 08:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2X3XyJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6AB206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzFKS-00075B-O0
	for qemu-devel@archiver.kernel.org; Sat, 25 Jul 2020 04:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thrivikraman.vs@gmail.com>)
 id 1jzFJr-0006eQ-Iw
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 04:14:12 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c]:39307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thrivikraman.vs@gmail.com>)
 id 1jzFJp-0002il-03
 for qemu-devel@nongnu.org; Sat, 25 Jul 2020 04:14:11 -0400
Received: by mail-lj1-x22c.google.com with SMTP id b25so12242848ljp.6
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2020 01:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=kAVAhC+L6GgAFs2XWFrmJAwMRhXrCkbzePZ6ncFZgiQ=;
 b=K2X3XyJN28qDsclO1DTFFH76jj8i/RBkc2btGgCijwNWJTgzgj3NuUFV2cb2DcWurt
 29s+RaVUwXFhusuuwOq/ilrVSO7tMJoiKpLjtnCoGwXcKZg/Wy0U3pXyTRhsqPgUItct
 xwGjgt6ES7vZWjMHKFebyu7+4wCCY2aKPNkUeix3xNyAKDZzDYe3lY3zFa1QXKAf5f+T
 JSnIoFxPADV1Sv6ZCOMMcjpGM6rjxc2oAviltap0Ct69qI/M9IV7jYUA6IwMvKXm9rLF
 r9rEaeZ6KWM0sFIyvfdjRkWR89TpvJN+1zm0JUfFUIhtZjPS2D33xWRCCrgmggY5BAbn
 snMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=kAVAhC+L6GgAFs2XWFrmJAwMRhXrCkbzePZ6ncFZgiQ=;
 b=NORzBo/EOYt/VjrO0z1lyhrISgYVmrkvKBMH/nf3M4Goom0Fa7c26bQ1w6CBcS6026
 EDx3rs9HWP0ggbIDq5UCXX6CKxi62PaVskJMrPNJE4UkzOUiWlONQyC0eF2RDrd2oeV/
 abD0iixK6Kz/tm2mNxJkiNMe9pJySkiFhd6RG+IBmV4GuGJ8HW56Naucz2Pcdxpv/ksD
 cTT762uj4X9mAjFww8ouq1Qv6d3oRS0gqUvqauoACAQynG5tdcBoDFKrv45qsd0oI+cR
 JlIbGQazQJT8kvYT3uH8fECKTaFyRRoEIoLSHaH8hB4XzdK5HLFKOqHWJObGJkZtT9/d
 qbeA==
X-Gm-Message-State: AOAM533QUCxWxZCtxG7qVUMSkXohcoCLrHe/Gn5Kx+Q6pMzBbKw7q6DX
 zS3ZkXeLBoaeOrgPF2t+Upxk7WKzlzuiebDqqQ8eDVdm
X-Google-Smtp-Source: ABdhPJwyHcXhNBG6Xce6zCKAOP1HH66owQOsqoyVs69gBJGls8ST2p91QJq2mC+E+1seqGB1VKMHIb/5w7kbtnUrKyE=
X-Received: by 2002:a2e:3618:: with SMTP id d24mr6435750lja.408.1595664846094; 
 Sat, 25 Jul 2020 01:14:06 -0700 (PDT)
MIME-Version: 1.0
From: Thrivikraman V <thrivikraman.vs@gmail.com>
Date: Sat, 25 Jul 2020 13:43:53 +0530
Message-ID: <CAOyk_3H_Rt+kb0_ScB0O_5qqsSKqFgoyOiU617_G3E1ZPRO6zw@mail.gmail.com>
Subject: Configured memory access latency and bandwidth not taking effect
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000005503bd05ab3fac40"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=thrivikraman.vs@gmail.com; helo=mail-lj1-x22c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--0000000000005503bd05ab3fac40
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I was trying to configure latencies and bandwidths between nodes in a NUMA
emulation using QEMU 5.0.0.

Host: Ubuntu 20.04 64 bit

Guest: Ubuntu 18.04 64 bit



The machine configured has 2 nodes. Each node has 2 CPUs and has been
allocated 3GB of memory. The memory access latencies and bandwidths for a
local access (i.e from initiator 0 to target 0, and from initiator 1 to
target 1) are set as 40ns and 10GB/s respectively. The memory access
latencies and bandwidths for a remote access (i.e from initiator 1 to
target 0, and from initiator 0 to target 1) are set as 80ns and 5GB/s
respectively.

The command-line launch is as follows.

sudo x86_64-softmmu/qemu-system-x86_64  \

-machine hmat=3Don \

-boot c \

-enable-kvm \

-m 6G,slots=3D2,maxmem=3D7G \

-object memory-backend-ram,size=3D3G,id=3Dm0 \

-object memory-backend-ram,size=3D3G,id=3Dm1 \

-numa node,nodeid=3D0,memdev=3Dm0 \

-numa node,nodeid=3D1,memdev=3Dm1 \

-smp 4,sockets=3D4,maxcpus=3D4  \

-numa cpu,node-id=3D0,socket-id=3D0 \

-numa cpu,node-id=3D0,socket-id=3D1 \

-numa cpu,node-id=3D1,socket-id=3D2 \

-numa cpu,node-id=3D1,socket-id=3D3 \

-numa dist,src=3D0,dst=3D1,val=3D20 \

-net nic \

-net user \

-hda testing.img \

-numa
hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Daccess-late=
ncy,latency=3D40
\

-numa
hmat-lb,initiator=3D0,target=3D0,hierarchy=3Dmemory,data-type=3Daccess-band=
width,bandwidth=3D10G
\

-numa
hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Daccess-late=
ncy,latency=3D80
\

-numa
hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Daccess-band=
width,bandwidth=3D5G
\

-numa
hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Daccess-late=
ncy,latency=3D80
\

-numa
hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Daccess-band=
width,bandwidth=3D5G
\

-numa
hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Daccess-late=
ncy,latency=3D40
\

-numa
hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dmemory,data-type=3Daccess-band=
width,bandwidth=3D10G
\

Then the latencies and bandwidths between the nodes were tested using the I=
ntel
Memory Latency Checker v3.9
<https://software.intel.com/content/www/us/en/develop/articles/intelr-memor=
y-latency-checker.html>.
But the obtained results did not match the configuration. The following are
the results obtained.

Latency_matrix with idle latencies (in ns)

Numa node

0 1

0 36.2 36.4

1 34.9 35.4

Bandwidth_matrix with memory bandwidths (in MB/s)

Numa node

0 1

0 15167.1 15308.9

1 15226.0 15234.0

A test was also conducted with the tool =E2=80=9Clat_mem_rd=E2=80=9D from l=
mbench
<http://manpages.ubuntu.com/manpages/xenial/lmbench.8.html> to measure the
memory read latencies. This also gave results that did not match the config=
.

Any information on why the config latency and bandwidth values are not
applied, would be appreciated.

--0000000000005503bd05ab3fac40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span id=3D"gmail-docs-internal-guid-b9c6455a-7fff-aa4e-a9=
b0-6db28f4bda11"><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;ma=
rgin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial;color:rgb(=
0,0,0);background-color:transparent;font-variant-numeric:normal;font-varian=
t-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">I was try=
ing to configure latencies and bandwidths between nodes in a NUMA emulation=
 using QEMU 5.0.0.</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;m=
argin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:=
Arial;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:no=
rmal;font-variant-east-asian:normal;vertical-align:baseline;white-space:pre=
-wrap">Host: Ubuntu 20.04 64 bit</span></p><p dir=3D"ltr" style=3D"line-hei=
ght:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;fo=
nt-family:Arial;color:rgb(0,0,0);background-color:transparent;font-variant-=
numeric:normal;font-variant-east-asian:normal;vertical-align:baseline;white=
-space:pre-wrap">Guest: Ubuntu 18.04 64 bit</span></p><p dir=3D"ltr" style=
=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-=
size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:transparent;f=
ont-variant-numeric:normal;font-variant-east-asian:normal;vertical-align:ba=
seline;white-space:pre-wrap">=C2=A0</span></p><p dir=3D"ltr" style=3D"line-=
height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt=
;font-family:Arial;color:rgb(0,0,0);background-color:transparent;font-varia=
nt-numeric:normal;font-variant-east-asian:normal;vertical-align:baseline;wh=
ite-space:pre-wrap">The machine configured has 2 nodes. Each node has 2 CPU=
s and has been allocated 3GB of memory. The memory access latencies and ban=
dwidths for a local access (i.e from initiator 0 to target 0, and from init=
iator 1 to target 1) are set as 40ns and 10GB/s respectively. The memory ac=
cess latencies and bandwidths for a remote access (i.e from initiator 1 to =
target 0, and from initiator 0 to target 1) are set as 80ns and 5GB/s respe=
ctively.=C2=A0</span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margi=
n-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Aria=
l;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal=
;font-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wra=
p">The command-line launch is as follows.</span></p><br><p dir=3D"ltr" styl=
e=3D"line-height:1.2;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-=
size:11pt;font-family:Consolas,sans-serif;color:rgb(0,0,0);background-color=
:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;ver=
tical-align:baseline;white-space:pre-wrap">sudo x86_64-softmmu/qemu-system-=
x86_64=C2=A0 \</span></p><p dir=3D"ltr" style=3D"line-height:1.2;margin-top=
:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Consolas,=
sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-numer=
ic:normal;font-variant-east-asian:normal;vertical-align:baseline;white-spac=
e:pre-wrap">-machine hmat=3Don \</span></p><p dir=3D"ltr" style=3D"line-hei=
ght:1.2;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;fon=
t-family:Consolas,sans-serif;color:rgb(0,0,0);background-color:transparent;=
font-variant-numeric:normal;font-variant-east-asian:normal;vertical-align:b=
aseline;white-space:pre-wrap">-boot c \</span></p><p dir=3D"ltr" style=3D"l=
ine-height:1.2;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:1=
1pt;font-family:Consolas,sans-serif;color:rgb(0,0,0);background-color:trans=
parent;font-variant-numeric:normal;font-variant-east-asian:normal;vertical-=
align:baseline;white-space:pre-wrap">-enable-kvm \</span></p><p dir=3D"ltr"=
 style=3D"line-height:1.2;margin-top:0pt;margin-bottom:0pt"><span style=3D"=
font-size:11pt;font-family:Consolas,sans-serif;color:rgb(0,0,0);background-=
color:transparent;font-variant-numeric:normal;font-variant-east-asian:norma=
l;vertical-align:baseline;white-space:pre-wrap">-m 6G,slots=3D2,maxmem=3D7G=
 \</span></p><p dir=3D"ltr" style=3D"line-height:1.2;margin-top:0pt;margin-=
bottom:0pt"><span style=3D"font-size:11pt;font-family:Consolas,sans-serif;c=
olor:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;fo=
nt-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">=
-object memory-backend-ram,size=3D3G,id=3Dm0 \</span></p><p dir=3D"ltr" sty=
le=3D"line-height:1.2;margin-top:0pt;margin-bottom:0pt"><span style=3D"font=
-size:11pt;font-family:Consolas,sans-serif;color:rgb(0,0,0);background-colo=
r:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;ve=
rtical-align:baseline;white-space:pre-wrap">-object memory-backend-ram,size=
=3D3G,id=3Dm1 \</span></p><p dir=3D"ltr" style=3D"line-height:1.2;margin-to=
p:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Consolas=
,sans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-nume=
ric:normal;font-variant-east-asian:normal;vertical-align:baseline;white-spa=
ce:pre-wrap">-numa node,nodeid=3D0,memdev=3Dm0 \</span></p><p dir=3D"ltr" s=
tyle=3D"line-height:1.2;margin-top:0pt;margin-bottom:0pt"><span style=3D"fo=
nt-size:11pt;font-family:Consolas,sans-serif;color:rgb(0,0,0);background-co=
lor:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;=
vertical-align:baseline;white-space:pre-wrap">-numa node,nodeid=3D1,memdev=
=3Dm1 \</span></p><p dir=3D"ltr" style=3D"line-height:1.2;margin-top:0pt;ma=
rgin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Consolas,sans-se=
rif;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:norm=
al;font-variant-east-asian:normal;vertical-align:baseline;white-space:pre-w=
rap">-smp 4,sockets=3D4,maxcpus=3D4=C2=A0 \</span></p><p dir=3D"ltr" style=
=3D"line-height:1.2;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-s=
ize:11pt;font-family:Consolas,sans-serif;color:rgb(0,0,0);background-color:=
transparent;font-variant-numeric:normal;font-variant-east-asian:normal;vert=
ical-align:baseline;white-space:pre-wrap">-numa cpu,node-id=3D0,socket-id=
=3D0 \</span></p><p dir=3D"ltr" style=3D"line-height:1.2;margin-top:0pt;mar=
gin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Consolas,sans-ser=
if;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:norma=
l;font-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wr=
ap">-numa cpu,node-id=3D0,socket-id=3D1 \</span></p><p dir=3D"ltr" style=3D=
"line-height:1.2;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size=
:11pt;font-family:Consolas,sans-serif;color:rgb(0,0,0);background-color:tra=
nsparent;font-variant-numeric:normal;font-variant-east-asian:normal;vertica=
l-align:baseline;white-space:pre-wrap">-numa cpu,node-id=3D1,socket-id=3D2 =
\</span></p><p dir=3D"ltr" style=3D"line-height:1.2;margin-top:0pt;margin-b=
ottom:0pt"><span style=3D"font-size:11pt;font-family:Consolas,sans-serif;co=
lor:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;fon=
t-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">-=
numa cpu,node-id=3D1,socket-id=3D3 \</span></p><p dir=3D"ltr" style=3D"line=
-height:1.2;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt=
;font-family:Consolas,sans-serif;color:rgb(0,0,0);background-color:transpar=
ent;font-variant-numeric:normal;font-variant-east-asian:normal;vertical-ali=
gn:baseline;white-space:pre-wrap">-numa dist,src=3D0,dst=3D1,val=3D20 \</sp=
an></p><p dir=3D"ltr" style=3D"line-height:1.2;margin-top:0pt;margin-bottom=
:0pt"><span style=3D"font-size:11pt;font-family:Consolas,sans-serif;color:r=
gb(0,0,0);background-color:transparent;font-variant-numeric:normal;font-var=
iant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">-net n=
ic \</span></p><p dir=3D"ltr" style=3D"line-height:1.2;margin-top:0pt;margi=
n-bottom:0pt"><span style=3D"font-size:11pt;font-family:Consolas,sans-serif=
;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;=
font-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap=
">-net user \</span></p><p dir=3D"ltr" style=3D"line-height:1.2;margin-top:=
0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Consolas,s=
ans-serif;color:rgb(0,0,0);background-color:transparent;font-variant-numeri=
c:normal;font-variant-east-asian:normal;vertical-align:baseline;white-space=
:pre-wrap">-hda testing.img \</span></p><p dir=3D"ltr" style=3D"line-height=
:1.2;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-f=
amily:Consolas,sans-serif;color:rgb(0,0,0);background-color:transparent;fon=
t-variant-numeric:normal;font-variant-east-asian:normal;vertical-align:base=
line;white-space:pre-wrap">-numa hmat-lb,initiator=3D0,target=3D0,hierarchy=
=3Dmemory,data-type=3Daccess-latency,latency=3D40 \</span></p><p dir=3D"ltr=
" style=3D"line-height:1.2;margin-top:0pt;margin-bottom:0pt"><span style=3D=
"font-size:11pt;font-family:Consolas,sans-serif;color:rgb(0,0,0);background=
-color:transparent;font-variant-numeric:normal;font-variant-east-asian:norm=
al;vertical-align:baseline;white-space:pre-wrap">-numa hmat-lb,initiator=3D=
0,target=3D0,hierarchy=3Dmemory,data-type=3Daccess-bandwidth,bandwidth=3D10=
G \</span></p><p dir=3D"ltr" style=3D"line-height:1.2;margin-top:0pt;margin=
-bottom:0pt"><span style=3D"font-size:11pt;font-family:Consolas,sans-serif;=
color:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;f=
ont-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap"=
>-numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dmemory,data-type=3Dacce=
ss-latency,latency=3D80 \</span></p><p dir=3D"ltr" style=3D"line-height:1.2=
;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-famil=
y:Consolas,sans-serif;color:rgb(0,0,0);background-color:transparent;font-va=
riant-numeric:normal;font-variant-east-asian:normal;vertical-align:baseline=
;white-space:pre-wrap">-numa hmat-lb,initiator=3D0,target=3D1,hierarchy=3Dm=
emory,data-type=3Daccess-bandwidth,bandwidth=3D5G \</span></p><p dir=3D"ltr=
" style=3D"line-height:1.2;margin-top:0pt;margin-bottom:0pt"><span style=3D=
"font-size:11pt;font-family:Consolas,sans-serif;color:rgb(0,0,0);background=
-color:transparent;font-variant-numeric:normal;font-variant-east-asian:norm=
al;vertical-align:baseline;white-space:pre-wrap">-numa hmat-lb,initiator=3D=
1,target=3D0,hierarchy=3Dmemory,data-type=3Daccess-latency,latency=3D80 \</=
span></p><p dir=3D"ltr" style=3D"line-height:1.2;margin-top:0pt;margin-bott=
om:0pt"><span style=3D"font-size:11pt;font-family:Consolas,sans-serif;color=
:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;font-v=
ariant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">-num=
a hmat-lb,initiator=3D1,target=3D0,hierarchy=3Dmemory,data-type=3Daccess-ba=
ndwidth,bandwidth=3D5G \</span></p><p dir=3D"ltr" style=3D"line-height:1.2;=
margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family=
:Consolas,sans-serif;color:rgb(0,0,0);background-color:transparent;font-var=
iant-numeric:normal;font-variant-east-asian:normal;vertical-align:baseline;=
white-space:pre-wrap">-numa hmat-lb,initiator=3D1,target=3D1,hierarchy=3Dme=
mory,data-type=3Daccess-latency,latency=3D40 \</span></p><p dir=3D"ltr" sty=
le=3D"line-height:1.2;margin-top:0pt;margin-bottom:0pt"><span style=3D"font=
-size:11pt;font-family:Consolas,sans-serif;color:rgb(0,0,0);background-colo=
r:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;ve=
rtical-align:baseline;white-space:pre-wrap">-numa hmat-lb,initiator=3D1,tar=
get=3D1,hierarchy=3Dmemory,data-type=3Daccess-bandwidth,bandwidth=3D10G \</=
span></p><br><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin=
-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,=
0);background-color:transparent;font-variant-numeric:normal;font-variant-ea=
st-asian:normal;vertical-align:baseline;white-space:pre-wrap">Then the late=
ncies and bandwidths between the nodes were tested using the </span><a href=
=3D"https://software.intel.com/content/www/us/en/develop/articles/intelr-me=
mory-latency-checker.html" style=3D"text-decoration-line:none"><span style=
=3D"font-size:11pt;font-family:Arial;background-color:transparent;font-vari=
ant-numeric:normal;font-variant-east-asian:normal;text-decoration-line:unde=
rline;vertical-align:baseline;white-space:pre-wrap">Intel Memory Latency Ch=
ecker v3.9</span></a><span style=3D"font-size:11pt;font-family:Arial;color:=
rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;font-va=
riant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">. But=
 the obtained results did not match the configuration. The following are th=
e results obtained.=C2=A0</span></p><br><p dir=3D"ltr" style=3D"line-height=
:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-=
family:Arial;color:rgb(0,0,0);background-color:transparent;font-variant-num=
eric:normal;font-variant-east-asian:normal;vertical-align:baseline;white-sp=
ace:pre-wrap">Latency_matrix with idle latencies (in ns)</span></p><p dir=
=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span =
style=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color=
:transparent;font-variant-numeric:normal;font-variant-east-asian:normal;ver=
tical-align:baseline;white-space:pre-wrap">Numa node</span></p><p dir=3D"lt=
r" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:tran=
sparent;font-variant-numeric:normal;font-variant-east-asian:normal;vertical=
-align:baseline;white-space:pre-wrap">       0      1</span></p><p dir=3D"l=
tr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:tran=
sparent;font-variant-numeric:normal;font-variant-east-asian:normal;vertical=
-align:baseline;white-space:pre-wrap">0  36.2  36.4</span></p><p dir=3D"ltr=
" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span style=
=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:tran=
sparent;font-variant-numeric:normal;font-variant-east-asian:normal;vertical=
-align:baseline;white-space:pre-wrap">1  34.9  35.4</span></p><br><p dir=3D=
"ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span sty=
le=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:tr=
ansparent;font-variant-numeric:normal;font-variant-east-asian:normal;vertic=
al-align:baseline;white-space:pre-wrap">Bandwidth_matrix with memory bandwi=
dths (in MB/s)</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-to=
p:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial;co=
lor:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;fon=
t-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">N=
uma node</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin-top:0pt;=
margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial;color:rg=
b(0,0,0);background-color:transparent;font-variant-numeric:normal;font-vari=
ant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap">       =
  0             1</span></p><p dir=3D"ltr" style=3D"line-height:1.38;margin=
-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:Arial=
;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:normal;=
font-variant-east-asian:normal;vertical-align:baseline;white-space:pre-wrap=
">0  15167.1  15308.9</span></p><p dir=3D"ltr" style=3D"line-height:1.38;ma=
rgin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-family:A=
rial;color:rgb(0,0,0);background-color:transparent;font-variant-numeric:nor=
mal;font-variant-east-asian:normal;vertical-align:baseline;white-space:pre-=
wrap">1  15226.0  15234.0</span></p><br><p dir=3D"ltr" style=3D"line-height=
:1.38;margin-top:0pt;margin-bottom:0pt"><span style=3D"font-size:11pt;font-=
family:Arial;color:rgb(0,0,0);background-color:transparent;font-variant-num=
eric:normal;font-variant-east-asian:normal;vertical-align:baseline;white-sp=
ace:pre-wrap">A test was also conducted with the tool =E2=80=9Clat_mem_rd=
=E2=80=9D from </span><a href=3D"http://manpages.ubuntu.com/manpages/xenial=
/lmbench.8.html" style=3D"text-decoration-line:none"><span style=3D"font-si=
ze:11pt;font-family:Arial;background-color:transparent;font-variant-numeric=
:normal;font-variant-east-asian:normal;text-decoration-line:underline;verti=
cal-align:baseline;white-space:pre-wrap">lmbench</span></a><span style=3D"f=
ont-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:transpare=
nt;font-variant-numeric:normal;font-variant-east-asian:normal;vertical-alig=
n:baseline;white-space:pre-wrap"> to measure the memory read latencies. Thi=
s also gave results that did not match the config.</span></p><br><p dir=3D"=
ltr" style=3D"line-height:1.38;margin-top:0pt;margin-bottom:0pt"><span styl=
e=3D"font-size:11pt;font-family:Arial;color:rgb(0,0,0);background-color:tra=
nsparent;font-variant-numeric:normal;font-variant-east-asian:normal;vertica=
l-align:baseline;white-space:pre-wrap">Any information on why the config la=
tency and bandwidth values are not applied, would be appreciated.</span></p=
></span><br class=3D"gmail-Apple-interchange-newline"></div>

--0000000000005503bd05ab3fac40--

