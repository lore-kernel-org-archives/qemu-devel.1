Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E824C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA57820656
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 10:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linux2go-dk.20150623.gappssmtp.com header.i=@linux2go-dk.20150623.gappssmtp.com header.b="qxrOhGiT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA57820656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux2go.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiyGi-0005tR-6u
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 06:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60688)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soren@linux2go.dk>) id 1jiyFs-0005Sx-Hv
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 06:46:49 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:33103)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soren@linux2go.dk>) id 1jiyFq-00066w-Cn
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 06:46:48 -0400
Received: by mail-ot1-x329.google.com with SMTP id n6so1353999otl.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 03:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux2go-dk.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=RcKQTPUXxeJDY6a8hWAG9huNEdg9pQy6utlgoB0TU/I=;
 b=qxrOhGiToa8Py+j4v4vDjnHQcfN0zi8HeMbCW7ynr5zht0lSowhips5J80m+FJw2Tr
 PyTc7pwZDkOpw3eAqLIZIrMi5lEjx2lh01nozsTp9g3ZwQJiHLTrYXam/qV4GFH5D8aY
 BfNaCXVMlz7k1qidAlBzzdjo/mW1LIW7yRrRhqnseDn4Lf9Ck+QSO6uZNS96I1vPI5Ub
 eUHMNRyxAG/nVBONLjhzBHRFyApc+nlj69Vwgtytx3lFkLi+ZVOyZEngOeydTN/FfDEN
 TNrf54tQLQ4kdqrf1EX7JQ51UD2dyhXri5xyEx06TegSreqm57p0fKDIKofGMANLpR5d
 vd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=RcKQTPUXxeJDY6a8hWAG9huNEdg9pQy6utlgoB0TU/I=;
 b=cN3RvGvU/UaYd/MpUVkZgqSkVmJ2XvjsTweJZ5umGKEIudhXjeJ/v1cdONDkZK7PeW
 6HWlGF75FOMCixD0gSlgk2nPd4/zBAVrJ6ARgYzbd5muPzwJN7D5AKoRbpIYp1CNNKBE
 Ckn9QM+VqYitW97Q7mj8zQAulWmgUklUs1p97Rpk8ZAevFAMEr7r9bkot2D90QiNmDTb
 bh/lT1VmVZH4/iGe46okOAOa3Re6uy8ESoSLx/xrwLoalUQ6LUD5lZBmVMvvgtNBK3ES
 ROkqc/4hlCynWabzckZv4of3osL6M7m1hDZhEkFIvVoxBi6mZOnGI3k9fx30G9x4FA0Z
 7blQ==
X-Gm-Message-State: AOAM530aKrYX1g0HMtoZCBkTgH9+sd1e2cbTHZEyBcDXZI2QXtTz0VKg
 4zuNSFuBTrNMFOQ0pfsJAwWKGDFcf8a98667hLraayODnXZKyg==
X-Google-Smtp-Source: ABdhPJxLzl3N/UKBGplj7c6AXnQrBQHzYr0FiaymsEny7Ez3JKE8cObDj8FoUQ4ApdW/es+1uduhorHq+0m8ty6+Kus=
X-Received: by 2002:a9d:7312:: with SMTP id e18mr2058869otk.182.1591785998831; 
 Wed, 10 Jun 2020 03:46:38 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?S=C3=B8ren_Hansen?= <soren@linux2go.dk>
Date: Wed, 10 Jun 2020 12:46:22 +0200
Message-ID: <CAPFUtkYr=rHUKdWLeyL7Ki36_yDZ0TOOVvhp36LZ7Pk+hQb7-g@mail.gmail.com>
Subject: Source for configuration for cloud-init
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000004e33c05a7b88f44"
Received-SPF: none client-ip=2607:f8b0:4864:20::329;
 envelope-from=soren@linux2go.dk; helo=mail-ot1-x329.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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

--00000000000004e33c05a7b88f44
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

All,

I'm finding myself needing to pass in some information to cloud-init in
some VM's in a non-cloud environment.

cloud-init is a (very) widely used tool for applying some initial
configuration to VM's. It originally exclusively used AWS's EC2's metadata
and userdata service, but has since been extended to use many other
configuration sources. The volume of the configuration varies a lot. For my
use, they will be several kB (passing in various certificates, etc.). For
non-cloud environments, the traditional source for user-data configuration
has been an ISO with the relevant configuration files. This feels
anachronistic to me.

I raised a feature request with cloud-init to have it support fw_cfg as a
configuration source: https://bugs.launchpad.net/cloud-init/+bug/1879294

I was told that there was already a feature request to use SMBIOS fields to
do the same: https://bugs.launchpad.net/cloud-init/+bug/1753558

Dan Berrang=C3=A9 (of libvirt fame) pointed out (in that latter bug report)=
 that
the qemu developers advised against using fw_cfg for this sort of thing. I
have no particular reason to doubt him, but I'd still like to hear from the
horse's own mouth and try to understand why.

While I can certainly find a way to serialize my config blob into a single
string with no NULLs (per SMBIOS spec) and pass it in through the SMBIOS
interface, the fw_cfg approach seems a whole lot simpler for both the user
and for cloud-init. Also, having gotten so used to cloud-init just being
there, personally it doesn't feel like much of a stretch to think of it as
a sort of firmware.

Can someone enlighten me on why using fw_cfg is the wrong way to go?

Best regards,
Soren L. Hansen

--00000000000004e33c05a7b88f44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">All,<div><br></div><div>I&#39;m finding myself needing to =
pass in some information to cloud-init in some VM&#39;s in a non-cloud envi=
ronment.</div><div><br></div><div>cloud-init is a (very) widely used tool f=
or applying some initial configuration to VM&#39;s. It originally exclusive=
ly used AWS&#39;s EC2&#39;s metadata and userdata service, but has since be=
en extended to use many other configuration sources. The volume of the conf=
iguration varies a lot. For my use, they will be several kB (passing in var=
ious certificates, etc.). For non-cloud environments, the traditional sourc=
e for user-data configuration has been an ISO with the relevant configurati=
on files. This feels anachronistic to me.</div><div><br></div><div>I raised=
 a feature request with cloud-init to have it support fw_cfg as a configura=
tion source:=C2=A0<a href=3D"https://bugs.launchpad.net/cloud-init/+bug/187=
9294">https://bugs.launchpad.net/cloud-init/+bug/1879294</a></div><div><br>=
</div><div>I was told that there was already a feature request to use SMBIO=
S fields to do the same:=C2=A0<a href=3D"https://bugs.launchpad.net/cloud-i=
nit/+bug/1753558">https://bugs.launchpad.net/cloud-init/+bug/1753558</a></d=
iv><div><br></div><div>Dan Berrang=C3=A9 (of libvirt fame) pointed out (in =
that latter bug report) that the qemu developers advised against using fw_c=
fg for this sort of thing. I have no particular reason to doubt him, but I&=
#39;d still like to hear from the horse&#39;s own mouth and try to understa=
nd why.</div><div><br></div><div>While I can certainly find a way to serial=
ize my config blob into a single string with no NULLs (per SMBIOS spec) and=
 pass it in through the SMBIOS interface, the fw_cfg approach seems a whole=
 lot simpler for both the user and for cloud-init. Also, having gotten so u=
sed to cloud-init just being there, personally it doesn&#39;t feel like muc=
h of a stretch to think of it as a sort of firmware.</div><div><br></div><d=
iv>Can someone enlighten me on why using fw_cfg is the wrong way to go?</di=
v><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_s=
ignature"><br>Best regards,<br>Soren L. Hansen<br></div></div></div>

--00000000000004e33c05a7b88f44--

