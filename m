Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43786C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:16:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084392078E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRqyAmBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084392078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDb30-0004Zh-7s
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDb2P-00044s-8N
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:15:29 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c]:42524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDb2M-0005C8-IN
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:15:28 -0400
Received: by mail-lj1-x22c.google.com with SMTP id k25so1020898ljg.9
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 15:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=kVwStpnP5FYLM1jiLrM+U+mjnvGZazLS/dNeQgW8cg4=;
 b=BRqyAmBi0Crh5XtE5mFbR6zRtOwy+1LupuJHOF3QXyN8FqgDUxr/7HbP0Blu2fV9CB
 l2ZJcu29rX0abAkDZcf00LZrZ/7r5Oygw0umTHs0CuDvUUlmLLQVMOGzt1JnezVBkssl
 MwZHKZIqYvkB1zN6+zniltlqRge9jAe0XVHo7f+tiIyMTxrxrVikNuXxTZoEDZBIlvMR
 Y2tpe88RrN7TQF2bVPqISEsndj0kX0H63AwJgsaM93d8S8WvYHr0JQ2OBYmtj7ccAjCH
 IiEdHTdKg0XIGJlI/aBaJWAWuFKu2Xh5wYeEpLK03PWZ/e2tifV8n30v4wFFM+OJqRoU
 iuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=kVwStpnP5FYLM1jiLrM+U+mjnvGZazLS/dNeQgW8cg4=;
 b=HMPllboQEj+I56bkDNFOPe6yvlqMCYVHjZ405AER47vs+FnY0zNbJmfhYLunV08kzs
 Vtmgr7ecnW20fU44GwdEVhhDfX/sB5NlCfp7UVLgfD4mcP+dUlnLJoxB5EwZczQjRgJA
 6PwpNKRaF8WUAJ7PiiYyQA/waHLFxa7XQT090+CmY9Bnlu4xiktgb2LHsF08kxpYr2ke
 D/HbT8oRy0kAFMztqyLMVUAYI4bATnIUz0n1bsp88LncCxGonx3sJ8TOkio86M6SaI+e
 AbS/BmaGl3UokEf9FghuI6KnlXNEo2/wYyNmXGVqmISPiL4GeuWTxHr5QJcCCBWWF0rC
 Izaw==
X-Gm-Message-State: AOAM531Fd6ORAIEUec441McuELEcsv0x+9E03lfwOKszRu+dwqsnK4pd
 mPmk8hI2+0xhezmam1WwsXsCq/f9lqt5GWj/h9xDg3BYWfRexsk2
X-Google-Smtp-Source: ABdhPJxZeoFiSyQdqxLJhE5zwjcHNTaMfjPNMyu3Yhy/FG5BTljkxCr46SG8oCqb/KzhWGwUHm9RNIUjqf5XH7Wn8xY=
X-Received: by 2002:a05:651c:1119:: with SMTP id
 d25mr16442ljo.300.1599084923892; 
 Wed, 02 Sep 2020 15:15:23 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 06:15:11 +0800
Message-ID: <CAE2XoE-Rwe8-k8p5zC6YzxFX-=bj+JY+RCJN4A1ZQudSZ8DQKQ@mail.gmail.com>
Subject: Thouhgs about cross-platform signals and process
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000dab7e205ae5bf830"
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22c.google.com
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000dab7e205ae5bf830
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Seems signal handling are common and process fork are common in qemu,
I suggest wrapping those in utils library for easily and consistence access
across
different platforms(Win32/POSIX)


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000dab7e205ae5bf830
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Seems signal handling are common and process fork are=
 common in qemu,<br></div><div>I suggest wrapping those in utils library fo=
r easily and consistence access across</div><div>different platforms(Win32/=
POSIX)</div><div><br></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"=
gmail_signature" data-smartmail=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =
=C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A=
<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000dab7e205ae5bf830--

