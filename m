Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F99C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 06:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 077A620714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 06:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="foBXMfKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077A620714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1P4a-0007jv-SR
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 01:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39787)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielcho@qnap.com>) id 1j1P3q-0007HD-FB
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 01:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielcho@qnap.com>) id 1j1P3p-0007bO-5W
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 01:30:18 -0500
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32]:41702)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielcho@qnap.com>) id 1j1P3o-0007Vh-Uw
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 01:30:17 -0500
Received: by mail-io1-xd32.google.com with SMTP id m25so10477509ioo.8
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 22:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=gfslSCwYzZVjE+dgBP+33vOGt3umviIy3E9A0Zzxq+g=;
 b=foBXMfKoTjz0Y+RHXBpK+AvEUzJD+EymmIxqWFspu39sgzhweFSCToXgj3xo35RIXk
 MXxGL/AJepSl48jDTrYLzCMBa6RsTiuQTaZ43FXD749TLo9peH+8Go74z1cGVe2RcvAL
 3Zb3uqOFwLNQe+cK0nw09ruuTWD0h7Oc1cciw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=gfslSCwYzZVjE+dgBP+33vOGt3umviIy3E9A0Zzxq+g=;
 b=EA15easaNzjlf1NXsKsbMSsV0nRk9PTymrXGRqooj/p6/TqsPVa4HOUm3ZVZKEoQRn
 /pnq3iyJsRBdXCXE7Fdgk9P1UeBjzR/1f2xB5j3AlGFB8X9xgtrPsfEnSWC9BnE20jSj
 EWW+Xd9YM4/xP3KtDs+KyaMDCqIwEObtfrAicJljXurorIam/6SlgS1Pdg1OTME/AHb/
 16sT6jwAfwsB6UVnkGT3uGLvsBoQa7sV7O/y/DWcu5OWhQSHiMzPjbIT40mrIkYiPsTJ
 Th4fph4TTOhaq3Rc/VmRiUPKUhkMzoMzgqNDqxyisYUJgkJPQHxBGDwkY6M8xBnXTfyy
 nHFA==
X-Gm-Message-State: APjAAAXJbc5xDP1Q4aIkwdGoMs+2GGeAOz0dj6AbpQv99zEtk8s0gtyc
 pf6aVOeMyX2F5jAt6N2Getzd4WUpwaolde8SwkVmrUI2gl8=
X-Google-Smtp-Source: APXvYqwXI+KUk4PbN+kwPPR70eg7Rw20EP3WwfSjTsKbgSeVWuxvarv5XVM1G+QctPz0VI13s5Gx8yd+T/fqw3SkgvA=
X-Received: by 2002:a5d:905a:: with SMTP id v26mr12825180ioq.77.1581402614921; 
 Mon, 10 Feb 2020 22:30:14 -0800 (PST)
MIME-Version: 1.0
From: Daniel Cho <danielcho@qnap.com>
Date: Tue, 11 Feb 2020 14:30:03 +0800
Message-ID: <CA+XQNE44kZjcw=0dtzaS4HwbPcRG6GpcQ3g3QfL5VS84EBWS_g@mail.gmail.com>
Subject: The issues about architecture of the COLO checkpoint
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001c3380059e46fd19"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d32
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

--0000000000001c3380059e46fd19
Content-Type: text/plain; charset="UTF-8"

Hi everyone,
     We have some issues about setting COLO feature. Hope somebody could
give us some advice.

Issue 1:
     We dynamic to set COLO feature for PVM(2 core, 16G memory),  but the
Primary VM will pause a long time(based on memory size) for waiting SVM
start. Does it have any idea to reduce the pause time?


Issue 2:
     In https://github.com/qemu/qemu/blob/master/migration/colo.c#L503,
could we move start_vm() before Line 488? Because at first checkpoint PVM
will wait for SVM's reply, it cause PVM stop for a while.

     We set the COLO feature on running VM, so we hope the running VM could
continuous service for users.
Do you have any suggestions for those issues?

Best regards,
Daniel Cho

--0000000000001c3380059e46fd19
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi everyone,=C2=A0<div><div></div><div>=C2=A0 =C2=A0 =C2=
=A0We have some issues about setting COLO feature. Hope somebody could give=
 us some advice.</div><div><br></div><div>Issue 1:</div><div>=C2=A0 =C2=A0 =
=C2=A0We dynamic to set COLO feature for PVM(2 core, 16G memory),=C2=A0 but=
 the Primary VM will pause a long time(based on memory size) for waiting=C2=
=A0SVM start. Does it have any idea to reduce the pause time?</div><div><br=
></div><div><br></div><div>Issue 2:</div><div>=C2=A0 =C2=A0 =C2=A0In=C2=A0<=
a href=3D"https://github.com/qemu/qemu/blob/master/migration/colo.c#L503" t=
arget=3D"_blank">https://github.com/qemu/qemu/blob/master/migration/colo.c#=
L503</a>, could we move start_vm() before Line 488? Because at first checkp=
oint PVM will wait for SVM&#39;s reply, it cause PVM stop for a while.=C2=
=A0</div></div><div><br></div><div><div><div>=C2=A0 =C2=A0 =C2=A0We set the=
 COLO feature on running=C2=A0VM, so we hope the running VM could continuou=
s=C2=A0service for users.=C2=A0</div></div></div><div>Do you have any sugge=
stions for those issues?=C2=A0</div><div><br></div><div>Best regards,</div>=
<div>Daniel Cho=C2=A0</div></div>

--0000000000001c3380059e46fd19--

