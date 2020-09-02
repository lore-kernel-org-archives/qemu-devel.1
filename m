Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB50C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 18:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 942E520758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 18:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJ5L07AK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 942E520758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDXal-0001um-Of
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 14:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDXZa-0001EP-Hc
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 14:33:30 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231]:36121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDXZY-0003dG-Rz
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 14:33:30 -0400
Received: by mail-lj1-x231.google.com with SMTP id t23so372176ljc.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=xjeAibw6M/qvscl814riOogbKHlMJMRNpPxf7RaTpmU=;
 b=WJ5L07AKvSof7IeXGohBnW9ZNsE9WM40gB3+9hENDhTpdE0Whpu+DUAWpMozdHVfns
 0i7jg0nikebgHKx+tXuBzwQKNI8UvfgB1XrQErwYfB45Z/pzA6ThwJQCBEFgxnNNEXRC
 n0+sE4LBje/KIUIuKApMi3aIqDBbDxDPEEup1gAKF3/95ALrnu719Adp5mRdO782wFh2
 us3P2/8ImAAljK8BI8uIxH04TZSz59gOSP4Kkz5OEwScznXcE24HmhCsEACEDc6A/9tr
 r8BSO4o0wYsopyfFzqE6olxnmiq/x9lzSxtaZQQoXRl5Mnd0qONEkusUIh8zr8iWklMJ
 PeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=xjeAibw6M/qvscl814riOogbKHlMJMRNpPxf7RaTpmU=;
 b=HJx4qPisCg4xsb+u4yrOTanpIZh4fJvwk03xx2PVkpMs3Fum4tkubGZDNy1a/etNcr
 hUbnG8N9fuMx2ZJGblqU5XoU4ynoXihmcu3s/9CY8ChCz0/MhzOlQPUvxIC2F+Z2fRYK
 h4aq4jDaxib3lfR6EgD8645az2n0Xl+qM0ZadobHS8m8wsF7oXvKRQGuNDe/g9HTXIgM
 QP6t0b8UDErcW5fTcYiwFtdBuy0cgJi+nv9SmFjIp3l2Wtdd1ZFqlOattAWMSiPezdCg
 zcw/Dh5hDYLyyv2LyYKiC5PKBFzC5xtnoD6pM7gjCg6m74Tu+jXxKqi+z0KCJVdyI7sl
 MMcA==
X-Gm-Message-State: AOAM530KryqPH+SDy6ifK69KgRurF++PX67/I+Yu1whP203v1deF9XiT
 FfvPUnnC96ZXHAm/dvjvEOrXl1tdGqkUkPQIKZo1sVZx5sACyQ==
X-Google-Smtp-Source: ABdhPJyNawQ6EQfdo6zQAZ1liewLw3+Bkx3Q+uRwgQ0ylJbx0MuCfmB+eydmHJYYNSH3Pk59ZqaqdO24jSXtVo/TXXc=
X-Received: by 2002:a2e:86d3:: with SMTP id n19mr4168507ljj.368.1599071605345; 
 Wed, 02 Sep 2020 11:33:25 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 02:33:13 +0800
Message-ID: <CAE2XoE8d2m7deMgEf1v37FHKqxMegQAc4BbjOwcjOd_-BQH2Zg@mail.gmail.com>
Subject: QAPI, The msys2 CI check are compiled sucess,
 but qapi tests are failing
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000001d43305ae58df9d"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x231.google.com
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

--00000000000001d43305ae58df9d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

https://cirrus-ci.com/task/5708273301061632?command=3Dmain#L6792

make: *** [Makefile.mtest:63: check-qapi-schema] Error 1
--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000001d43305ae58df9d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><a href=3D"https://cirrus-ci.com/task/5708273301061632?com=
mand=3Dmain#L6792">https://cirrus-ci.com/task/5708273301061632?command=3Dma=
in#L6792</a><br clear=3D"all"><div><br></div><div>make: *** [Makefile.mtest=
:63: check-qapi-schema] Error 1<br></div>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature" data-smartmail=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br=
>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000001d43305ae58df9d--

