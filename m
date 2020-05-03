Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CE6C47247
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 11:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C8E205ED
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 11:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaVhKsL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C8E205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVCun-0006B2-IU
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 07:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rmsh.b4@gmail.com>)
 id 1jVCt6-0004l1-Pj; Sun, 03 May 2020 07:34:24 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c]:37341)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rmsh.b4@gmail.com>)
 id 1jVCt6-0000Vs-2s; Sun, 03 May 2020 07:34:24 -0400
Received: by mail-ed1-x52c.google.com with SMTP id w2so11070300edx.4;
 Sun, 03 May 2020 04:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=vW+X5vUrHySxGrsGP5E9IZMuidaZFMeOw3ZMwScisJE=;
 b=qaVhKsL8CxHJM4XfrTQS9XSajhwOI60lfj9PMHyLrHoD/JaSms8Nic2c1kkY4EUEc6
 b4TA204yvmyy/VIOt7AI2g3LsixhktG4Qy//xKm9sZtATK73dAcqR8xyCrmp2pS7O6tN
 loCLBRNSSqi6tEUopDV/XpVhJcRxSTEl8W5OS4LAR+jUda+u6dBIN1etDPwGUCYdiaI+
 iFzYoTvbbX/Y0+ShQdogynAKd8texUtUfwrcA+k4EtwPF+m8aglJfm9DRpa1zfjJ6OUW
 uYm+glTci9y3MNs2WWc16MVBM2wBZC8gcyglIbzqMLKsiBU1SvanEgsWRst8EBnQGkwy
 OpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=vW+X5vUrHySxGrsGP5E9IZMuidaZFMeOw3ZMwScisJE=;
 b=dtNSHb9m2ZZhb41H7p1s8IXzCcwIVwoHRSR34OtqEyr612PuKkGIU0Xh6Yo290szCF
 OUPl2pt8kVqTbmR3eUQtraM9t9E7WJYtpXaaRWEp2pe9v4DDlM21WfHYSgolLuBPW8G8
 tWl+Qb8MXUHYYMPIUlOQiQ4QYdIonbt9NrkzEKEEK7svtwqM0JMc/n9jF8Ra7QNi0b70
 pkGgvUFyTnmqd3eoduRKHUfhaBZmE2azZXnFjtWTpD7duM9A6//MkDfOOBKdoLocKM+s
 wikcBHt3IUuMfClAiJk7piivCLaAQ2GEmcwu2zL3A6x740N7TkomBra2dutFXPpAaEPn
 Yohw==
X-Gm-Message-State: AGi0PuY/eu2LDSC9LmRQm7ENpng49ZERTOWwQIoQ+cdhTxrJLGdsvg9A
 QCWqv3wUj0DR7GbfnkO1AT7kwXB4VnBFCmhfLXAsfdyN
X-Google-Smtp-Source: APiQypK/NZgAcJtaN9DosANCCOa4r1qFmLHIjkef8tdJje4k/hJGKg86gkIGPqDAtkAN5aUi2oYUEk7Y9vBbl4P5HGg=
X-Received: by 2002:a50:de02:: with SMTP id z2mr10046497edk.292.1588505661468; 
 Sun, 03 May 2020 04:34:21 -0700 (PDT)
MIME-Version: 1.0
From: Ramesh B <rmsh.b4@gmail.com>
Date: Sun, 3 May 2020 17:04:10 +0530
Message-ID: <CAJvkk904hhJ0q54KAkYE-azEmg5gkt_-HVSyLnACKsV9=TmzQg@mail.gmail.com>
Subject: [Query] VM CPU scheduling
To: qemu-discuss@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000acf46105a4bccb7b"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=rmsh.b4@gmail.com; helo=mail-ed1-x52c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000acf46105a4bccb7b
Content-Type: text/plain; charset="UTF-8"

Hi All,

I started recently using QEMU for OS virtualization.
Want to know/understand about scheduling.

Environment:
Host OS: Ubuntu 18.4 + KVM enable
QEMU: 4.2
Workstation/Desktop: x86_64

Would like to understand,

1. How CPU scheduling works.
2. Tools/commands to monitor.
3. Tuning parameter/API

Could you please suggest good reference or books or pointers.

Thanks,
Babu

--000000000000acf46105a4bccb7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div><br></div><div>I started recently using QEMU f=
or OS virtualization.</div><div>Want to know/understand=C2=A0about scheduli=
ng.</div><div><br></div><div>Environment:</div><div>Host OS: Ubuntu 18.4=C2=
=A0+ KVM enable</div><div>QEMU: 4.2</div><div>Workstation/Desktop: x86_64</=
div><div><br></div><div>Would like to understand,=C2=A0</div><div><br></div=
><div>1. How CPU scheduling works.</div><div>2. Tools/commands to monitor.<=
/div><div>3. Tuning parameter/API</div><div><br></div><div>Could you please=
 suggest good reference or books or pointers.</div><div><br></div><div>Than=
ks,<br></div><div>Babu=C2=A0</div></div>

--000000000000acf46105a4bccb7b--

