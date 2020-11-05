Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30162C55178
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44885206B7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8rJ0pt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44885206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kahtC-0004JX-TS
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 11:13:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kahsY-0003lZ-0j
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:12:50 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:34961)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kahsW-0007Qg-AD
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:12:49 -0500
Received: by mail-ej1-x635.google.com with SMTP id p5so3433327ejj.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 08:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=OZ7T1x5Vi8ECQiIdi/N7PEZ6qXPLW1zYuCYvGCTTu0I=;
 b=W8rJ0pt22bx8oyXGpLvxDYx4wgXhUQJoVx1aU22I/cw1mS6cucleROPss7IbVdh40i
 6mjWv8uTIoOEdQbOJ6DpX43K0UXOMq8MEKntlKW9eKv8h/vUjFfLoCx72TrULe+T25gJ
 bUgWR0r7EmvmYvJZIm4/bIwH/JzDO7sCgSbqHGtEtdjuTJGtUHlA5HbNbEmfEkgPLUdy
 5gS9WV/GEIpSLyzl9JwNJ7Z2Budhf6A1kIsa1ShQyYXEO+ZciKOZfEpaf+JIHdIk2Mfc
 8WaLVOhtmaoqoJGEs5R4ULW06WxtNb+gWI+N5eWohkJPhH76PRrfRLtPOXnpUmQsdo/5
 J4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=OZ7T1x5Vi8ECQiIdi/N7PEZ6qXPLW1zYuCYvGCTTu0I=;
 b=P2Cw61etuAWgE8e3aDkMY66DAFtPX0e4tdvTfEi5GS0InmqFEmEWZapfZ1qX5K0kYq
 K2YhmZmc50lvfQM1xQL3APJa8HncfkAvHfOFlWz8dBlf4t1VpNRPnYc6WPf0/CVSWQKO
 Td8PUVJhx/SwL54lsTHaApo6/VgfruRA1kz2S7uV4QyUcm8/vO26k+rDxGItvLMjiHvl
 PH3nt5s/Qm4oGrnENFnvfxtICY2MJszwkjl8D/v0IAjky2sF70aTXM5x4CwHsoWZwKRl
 rpG3Xa/878kyqYKuR6S+PxCRtdsTudmcL6h5V8p9rAX6T098EhKymUmtshRNrEsaOd74
 sZXQ==
X-Gm-Message-State: AOAM533SQ5Us3vnsapDd6yblsHidJh0MdcweraQzZ/FApuZsJPO6RK9k
 oGcSGfRWrzScNwJdY6Ll8bqm5YmBCM2vNVQSAnRmSNXQe+Yuqg==
X-Google-Smtp-Source: ABdhPJyynTGGUge5jjVJdvptjahD+AKhDHscoIFQkkmchgu20QVdkv7F0t3czU5PvTRKTUoFqNJ4i+wxd30OsyeTciE=
X-Received: by 2002:a17:906:bcd4:: with SMTP id
 lw20mr2935441ejb.527.1604592766316; 
 Thu, 05 Nov 2020 08:12:46 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 5 Nov 2020 20:12:34 +0400
Message-ID: <CAJ+F1CJ7KpB8C6-_+Gdh6twqjjRMweERUapw4tfjKyMqa6AM0w@mail.gmail.com>
Subject: Documents not in sphinx toctree
To: QEMU <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000d875f605b35e5d1d"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Pankaj Gupta <pagupta@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jens Freimann <jfreimann@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d875f605b35e5d1d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

By running sphinx over the docs/ directory (like readthedocs.org presumably
does), it finds a couple of rst documents that are not referenced:
- cpu-hotplug.rst
- microvm.rst
- pr-manager.rst
- virtio-net-failover.rst
- virtio-pmem.rst

Shouldn't they be?

If not (I wonder why), there should be a way to explicitly exclude those,
and avoid extra warnings.

thanks

--=20
Marc-Andr=C3=A9 Lureau

--000000000000d875f605b35e5d1d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>By running sphinx over t=
he docs/ directory (like <a href=3D"http://readthedocs.org">readthedocs.org=
</a> presumably does), it finds a couple of rst documents that are not refe=
renced:</div><div>- cpu-hotplug.rst<br>- microvm.rst<br>- pr-manager.rst<br=
>- virtio-net-failover.rst<br>- virtio-pmem.rst</div><div><br></div><div>Sh=
ouldn&#39;t they be?</div><div><br></div><div>If not (I wonder why), there =
should be a way to explicitly exclude those, and avoid extra warnings.</div=
><div><br></div><div>thanks<br></div><div><br></div><div>-- <br><div dir=3D=
"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature">Marc-And=
r=C3=A9 Lureau<br></div></div></div>

--000000000000d875f605b35e5d1d--

