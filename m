Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BF5C282E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 08:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E76FB20815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 08:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ml/BVMiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E76FB20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52450 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUocY-0000WO-6W
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 04:35:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1hUoXd-0005rM-JQ
	for qemu-devel@nongnu.org; Sun, 26 May 2019 04:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1hUoFV-0007F5-4t
	for qemu-devel@nongnu.org; Sun, 26 May 2019 04:11:22 -0400
Received: from sonic301-7.consmr.mail.ne1.yahoo.com ([66.163.184.240]:41240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lucienmp_antispam@yahoo.com>)
	id 1hUoFV-0007E0-00
	for qemu-devel@nongnu.org; Sun, 26 May 2019 04:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
	t=1558858278; bh=89bqK/nrXqlXT91TGY8K1TqCgq/4E3lxYVw48A3Ze70=;
	h=Date:From:To:Subject:References:From:Subject;
	b=Ml/BVMiMD4gxEccKB2ylFJe9i1s1pALPUTTnEwI8m/WjTBKL+7VuPm0s4pz47Mz/kIJAZjm38r1YjqMxcKc748koon0kxrFzW2sTxGVR9y3oI1GROk8Jo6yFIOPnukzLiYWf4qiU2uBCE2jBu0gtL/NVUxPDnhDauAwQex8IzJEphq+SY5t8s0LZPpJBsKdzYifOTHXUVWfShEoCvRDO96pGvXIUpU0vEUBhieAxCiz3uNNEiXzPfhAAqc+IpzHu/xob6wc1C5tgOW6ePkwuKFgN2KLHSGefY7C/nGuDtWlGGLDh/yy41ehT43ND8o4I4E67BNst8A7HbA9XL21pwQ==
X-YMail-OSG: N_6BpMEVRDvd.miR6A7lED5GPdAEx7ojsA--
Received: from sonic.gate.mail.ne1.yahoo.com by
	sonic301.consmr.mail.ne1.yahoo.com with HTTP;
	Sun, 26 May 2019 08:11:18 +0000
Date: Sun, 26 May 2019 08:09:18 +0000 (UTC)
To: qemu-devel@nongnu.org, 
	"patchew-devel@redhat.com" <patchew-devel@redhat.com>
Message-ID: <1573827788.7732060.1558858158263@mail.yahoo.com>
MIME-Version: 1.0
References: <1573827788.7732060.1558858158263.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13634 YMailNorrin Mozilla/5.0 (Windows NT 10.0; Win64;
	x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169
	Safari/537.36
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 66.163.184.240
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: [Qemu-devel] Failure to submit patches,
 two questions - what should I do?
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
From: Lucien Anti-Spam via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=20

   > On Sunday, May 26, 2019, 4:45:26 PM GMT+9, <no-reply@patchew.org> wrot=
e: > Subject;=C2=A0[Qemu-devel] [PATCH] Incorrect Stack Pointer shadow regi=
ster support on some m68k CPUs > .....> snip> .....>=C2=A0=3D=3D=3D OUTPUT =
BEGIN =3D=3D=3D
>=C2=A0ERROR: Author email address is mangled by the mailing list
>=C2=A0#2:=20
>=C2=A0Author: Lucien Murray-Pitts via Qemu-devel <qemu-devel@nongnu.org>
>=C2=A0
>=C2=A0WARNING: Block comments use a leading /* on a separate line
>=C2=A0#46: FILE: target/m68k/cpu.h:465:
>=C2=A0+/* The ColdFire core ISA is a RISC-style reduction of the 68000 ser=
ies
>=C2=A0
>=C2=A0WARNING: Block comments use * on subsequent lines
>=C2=A0#47: FILE: target/m68k/cpu.h:466:>=C2=A0
>=C2=A0+/* The ColdFire core ISA is a RISC-style reduction of the 68000 ser=
ies
> +=C2=A0 Whilst the 68000 flourished by adding extended stack/instructions=
 in>.........> snip
Q1:=C2=A0 Name mangling seems to be a bug, whats going on - how should I be=
 submiting now?=C2=A0 =C2=A0 =C2=A0 =C2=A0 ( perl script didnt catch it AND=
 there seems to already be a patch from half year or more ago ..=C2=A0https=
://patchwork.kernel.org/patch/10662525/=C2=A0)=C2=A0 whats the correct acti=
on here?
Q2:=C2=A0 I am getting a WARNING but I believe it is an exception in this c=
ase.=C2=A0 =C2=A0 =C2=A0 =C2=A0 yes I know it breaks the coding style BUT t=
his coding style was already there for these comments.=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Should I submit this patch with a move to the RIGHT coding style? or=
 will this patch be accepted as the code is older style?


 =20
