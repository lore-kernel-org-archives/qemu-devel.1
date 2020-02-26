Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D017BC4BA0A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BCA821D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgbUuQkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BCA821D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rFq-00084M-S8
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1j6rFH-0007X7-7a
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1j6rFG-0004Ea-1J
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:36:39 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:36166)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>)
 id 1j6rFD-00047Y-Gw; Wed, 26 Feb 2020 02:36:35 -0500
Received: by mail-ot1-x329.google.com with SMTP id j20so2095549otq.3;
 Tue, 25 Feb 2020 23:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=e4h1QzzxTrFpAbBAQmInM/nVY0lJzyrmy+1s53NHOH8=;
 b=BgbUuQkBAL0MFj37y9vGY134U9wdscnjNc9s2LvwmsWiBXmqL7w7ssxsgPWeWetUtO
 D76Xee8H2CGibKiSsURnWn9jO5MAO9CBkKaOpuYI5N9BLbczxwopQQEawEn8tUcVY1PQ
 CJsEE+vTA8GjaP/r89JTsFHmSNhfFUrxzsawEfDOzXzpVvqwGd+ggfyQSS7BHUikf+G0
 5BNXq6YLvZiXOm/ZuaFlMD5LDQTNzU7zYkC1fytgaly1s3yco6GAZoz0CbJlNx5kpH6S
 b3eV8fNb53uml0T0Kejqr0CpShXR8ZlmIGqSysmdG91/2mSPQp85qp4VWSTYMCcg6p8l
 o0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=e4h1QzzxTrFpAbBAQmInM/nVY0lJzyrmy+1s53NHOH8=;
 b=NwFxbgI/Mszj4SzxmH3ig+Cj32IjDSUmNBgJuHWZmua1b42r5YjTi2LuOFAU7Qi2OZ
 oTBEk9l3Owm9+1HIiuT4DdEXNQ054X19d5XQl+84TdLIGrF4c/bt2YfxqGEmLEBYXc57
 OEhDJlYk1zqdtDYu2HlrHzp4cVRiPKMAkCMkQnoqWTuhHzjCOoja8lFH0JsbDO+SCsaw
 BL4REPVKOEY2xxRmP7J1VvzCWr7JEZQ7fBs4ngAc21TM91tBmLZLrWo8KuoImOv1m67g
 mZWYYZz+Hv/AFiVjUr+griTgGvBMVS+Y9t2Avszr7kBN/d176jNArW1meGdgkjMlGoW+
 6mig==
X-Gm-Message-State: APjAAAU+ABgN2h5SOQPGQ5gDpQQGOOo3VPWFWVHdh9+riyN1SvbBKDK8
 pQjT48FL3lyLO8VTHT5Pa8t/xeWQbJCCn6Ql43AoVqN3
X-Google-Smtp-Source: APXvYqwoXtItYm6wP0EMn73RbTsW2CD7sfnSiMZu19T0eOs1jymCahOTInarc9mjXL4F4mclztB48q7wqPNT9RU0aD4=
X-Received: by 2002:a05:6830:1e76:: with SMTP id
 m22mr2008329otr.295.1582702594181; 
 Tue, 25 Feb 2020 23:36:34 -0800 (PST)
MIME-Version: 1.0
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Wed, 26 Feb 2020 08:36:23 +0100
Message-ID: <CABLmASF7CoOufGDz-1d-Py3t1PN3CrWdN64XAzgAx4=rbSxGEA@mail.gmail.com>
Subject: Issue with vl.c: move -m parsing after memory backends has been
 processed. Commit a1b18df9a4848fc8a906e40c275063bfe9ca2047
To: qemu-ppc <qemu-ppc@nongnu.org>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Content-Type: multipart/alternative; boundary="000000000000e9545a059f75a9cb"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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

--000000000000e9545a059f75a9cb
Content-Type: text/plain; charset="UTF-8"

Hi all,

Commit a1b18df9a4848fc8a906e40c275063bfe9ca2047 on the ppc-for-50 branch
makes qemu-system-ppc running Mac OS 9 extremely slow. I bisected to the
result below.

Command line used:
./qemu-system-ppc -L pc-bios -M mac99,via=pmu -m 512 -boot c \
-hda 9.2.img \
-serial stdio -sdl

Best,
Howard

a1b18df9a4848fc8a906e40c275063bfe9ca2047 is the first bad commit
commit a1b18df9a4848fc8a906e40c275063bfe9ca2047
Author: Igor Mammedov <imammedo@redhat.com>
Date:   Wed Feb 19 11:08:40 2020 -0500

    vl.c: move -m parsing after memory backends has been processed

    It will be possible for main RAM to come from memory-backend
    and we should check that size specified in -m matches the size
    of the backend and [MachineState::]ram_size also matches
    backend's size.

    However -m parsing (set_memory_options()) happens before backends
    are intialized (object_create_delayed()) which complicates it.
    Consolidate set_memory_options() and assigning parsed results to
    current_machine after backends are initialized, so it would be
    possible access the initialized backend instance to compare
    sizes.

    This patch only consolidates scattered places touching ram_size
    within vl.c. And follow up patch will integrate backend handling
    to set_memory_options().

    Signed-off-by: Igor Mammedov <imammedo@redhat.com>
    Message-Id: <20200219160953.13771-7-imammedo@redhat.com>

 vl.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

--000000000000e9545a059f75a9cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi all,<br></div><div><br></div><div>Commit a1b18df9a=
4848fc8a906e40c275063bfe9ca2047 on the ppc-for-50 branch makes qemu-system-=
ppc running Mac OS 9 extremely slow. I bisected to the result below.</div><=
div><br></div><div>Command line used:</div><div>./qemu-system-ppc -L pc-bio=
s -M mac99,via=3Dpmu -m 512 -boot c \<br>-hda 9.2.img \<br>-serial stdio -s=
dl</div><div><br></div><div>Best,</div><div>Howard<br></div><div><br></div>=
<div>a1b18df9a4848fc8a906e40c275063bfe9ca2047 is the first bad commit<br>co=
mmit a1b18df9a4848fc8a906e40c275063bfe9ca2047<br>Author: Igor Mammedov &lt;=
<a href=3D"mailto:imammedo@redhat.com">imammedo@redhat.com</a>&gt;<br>Date:=
 =C2=A0 Wed Feb 19 11:08:40 2020 -0500<br><br>=C2=A0 =C2=A0 vl.c: move -m p=
arsing after memory backends has been processed<br>=C2=A0 =C2=A0 <br>=C2=A0=
 =C2=A0 It will be possible for main RAM to come from memory-backend<br>=C2=
=A0 =C2=A0 and we should check that size specified in -m matches the size<b=
r>=C2=A0 =C2=A0 of the backend and [MachineState::]ram_size also matches<br=
>=C2=A0 =C2=A0 backend&#39;s size.<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 Howev=
er -m parsing (set_memory_options()) happens before backends<br>=C2=A0 =C2=
=A0 are intialized (object_create_delayed()) which complicates it.<br>=C2=
=A0 =C2=A0 Consolidate set_memory_options() and assigning parsed results to=
<br>=C2=A0 =C2=A0 current_machine after backends are initialized, so it wou=
ld be<br>=C2=A0 =C2=A0 possible access the initialized backend instance to =
compare<br>=C2=A0 =C2=A0 sizes.<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 This pat=
ch only consolidates scattered places touching ram_size<br>=C2=A0 =C2=A0 wi=
thin vl.c. And follow up patch will integrate backend handling<br>=C2=A0 =
=C2=A0 to set_memory_options().<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 Signed-o=
ff-by: Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com">imammedo@re=
dhat.com</a>&gt;<br>=C2=A0 =C2=A0 Message-Id: &lt;<a href=3D"mailto:2020021=
9160953.13771-7-imammedo@redhat.com">20200219160953.13771-7-imammedo@redhat=
.com</a>&gt;<br><br>=C2=A0vl.c | 27 ++++++++++++++-------------<br>=C2=A01 =
file changed, 14 insertions(+), 13 deletions(-)<br></div></div>

--000000000000e9545a059f75a9cb--

