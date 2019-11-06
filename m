Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2BFC5DF64
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0A0217F5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmP8uoun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0A0217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSMs6-0008N2-Bx
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 10:05:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38922)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iSMrP-0007v7-79
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iSMrN-0008LH-SO
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:04:39 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b]:39728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iSMrN-0008KX-L2
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:04:37 -0500
Received: by mail-ed1-x52b.google.com with SMTP id l25so19611334edt.6
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 07:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=sw3Rn1QToG67jTwiMuD4WHwAA7lbRqg4P4dqhJRqmvo=;
 b=QmP8uounFTplMnZxKeiUFFLpPC7cm43sZc516ywUDChWAoV8puBJiMN6dJFMNrP72x
 Ohmz1gzgJVK7vjpaDj9FhvZoXN5mdlbBxZDQDkOx+s3FIk0tp9qbcmHgUf1+tjfzztU7
 k8/ojmy153uECxNF0FtAZUQxPhNGRFyIWG7jocThHHBv/OBCUu89pgp40p8GD7ovzH24
 6BHp4QoRstbzquKoHurJ+X4nRQRU+ciSokS5ukf9eUMZAzk5mAd8IjeJeHkrDHRXjHJq
 9jq/Mkwdh4f02nd9oo6JiX0HXYXYvsmJM7m1rHhbv62nqiQJcivbRMAhTlaX9nXWlNbr
 YuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=sw3Rn1QToG67jTwiMuD4WHwAA7lbRqg4P4dqhJRqmvo=;
 b=c11vJk7LCgegQ74dgWwlyxUfeD2KvFzmdxtvmYi37fLe7jb+VMEoEFvXjg31dTk4nw
 N7CUpHKR+VBxkLCSRqqY1CX9u06dCjSB1a9Ib9Voo5Njf1puw+a87MVkc9BTn1bDtWgI
 4PyYjPgIec+C72d/L0ZNIto2d+FFdHEDZ1gHnHVi7xrGSvyBPahiQo68cP0VWXDr1Dg6
 6ST0KfPHjbbT7Rs35h/LdR+UJjCTU3vg/oCx8AhmkqbqtAIIL9IVTN1MZVi6Y0PqmT3W
 TmdMstme4IaFigKByAUHjoy4Mh/ZvcIOlWDDKnhH4h7pwyiWoOnlB35bo774GHK/aq2G
 y3XQ==
X-Gm-Message-State: APjAAAX+f6V3ee5Z0EyT5fTYNn1yN+EcF3lcjny4zkC67JWUdfs/ceJ1
 N778L1VYpGYY1eIurZoKI1wwRImOg4cjmotGgVIXWkDU
X-Google-Smtp-Source: APXvYqyf0UG/emeMIhmXqecPg8xjmMcWWf85pIhi/bP35Lwev+q8UqbGBWNSi6v/S+qolMZYFaA4H8pVggxuotsfOUY=
X-Received: by 2002:a17:907:36e:: with SMTP id
 rs14mr30501177ejb.330.1573052675736; 
 Wed, 06 Nov 2019 07:04:35 -0800 (PST)
MIME-Version: 1.0
From: Esteban Bosse <estebanbosse@gmail.com>
Date: Wed, 6 Nov 2019 16:04:24 +0100
Message-ID: <CAGbAg_CAh-U-xRh+d6wNLQVWoHXEA0xcW6021Qd4WsMJBGfgOg@mail.gmail.com>
Subject: BeagleBone support, omap1, omap2, omap3, etc.
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000f349fd0596aedd3b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::52b
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f349fd0596aedd3b
Content-Type: text/plain; charset="UTF-8"

Hello!

Some months ago I started to work trying to port the Beaglebone support
from the old qemu-linaro fork to the new QEMU mainstream.

During my work I found that the Beaglebone have an OMAP3 mpu this mpu has
very strong relation with the OMAP2 and OMAP1 in qemu, they implement a lot
of functions in common.

Then I understood that the omap1 and omap2 don't implement things like QOM
and needs a lot of work to upgrade it, at the same time they are some
boards like: omap1_sx, palm, nseries that implement this mpus.

Looking the datasheet of the omap1 I realized that it's an very old device
and some questions like "make sense work with this old device?" comes to my
mind.

When I went to the KVM Forum the last week I talked with some of you, and
you help my with different ideas and proposal to make this task, but I
can't see the right way to make this work because it is a lot of work.

My motivation is learn more about embedded devices, architecture, kernel,
etc. and of course contribute to the community.

I would love to hear your opinions about this 3 related devices with they
respected boards.

Maybe someone is interested to work with me.
I dream to make this work beautiful (like the musca board with the armsse
and armv7m modules) with a good variety of tests. And in the same time I
would like to write some documentation about the process with the final
idea to "make an easier way for new contributors".

If someone want to work with me in this task, should know that I don't have
to much experience and I'm doing this job in my free time (this means that
I work only in my free time).

I appreciate any kind of comment or advice.

Thanks for your time ;)
EstebanB

--000000000000f349fd0596aedd3b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello!<br><br>Some months ago I started to work trying to =
port the Beaglebone support from the old qemu-linaro fork to the new QEMU m=
ainstream.<br><br>During my work I found that the Beaglebone have an OMAP3 =
mpu this mpu has very strong relation with the OMAP2 and OMAP1 in qemu, the=
y implement a lot of functions in common.<br><br>Then I understood that the=
 omap1 and omap2 don&#39;t implement things like QOM and needs a lot of wor=
k to upgrade it, at the same time they are some boards like: omap1_sx, palm=
, nseries that implement this mpus.<br><br>Looking the datasheet of the oma=
p1 I realized that it&#39;s an very old device and some questions like &quo=
t;make sense work with this old device?&quot; comes to my mind.<br><br>When=
 I went to the KVM Forum the last week I talked with some of you, and you h=
elp my with different ideas and proposal to make this task, but I can&#39;t=
 see the right way to make this work because it is a lot of work.<br><br>My=
 motivation is learn more about embedded devices, architecture, kernel, etc=
. and of course contribute to the community.=C2=A0<br><br>I would love to h=
ear your opinions about this 3 related devices with they respected boards.<=
br><br>Maybe someone is interested to work with me. <br>I=C2=A0dream to mak=
e this work beautiful (like the musca board with the armsse and armv7m modu=
les) with a good variety of tests. And in the same time I would like to wri=
te some documentation about the process with the final idea to &quot;make a=
n easier way for new contributors&quot;.<br><br>If someone want to work wit=
h me in this task, should know that I don&#39;t have to much experience and=
 I&#39;m doing this job in my free time (this means that I work only in my =
free time).<br><br>I appreciate any kind of comment or advice.<div><br>Than=
ks for your time ;)<br><div>EstebanB</div></div></div>

--000000000000f349fd0596aedd3b--

