Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D053C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:03:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0CE222D5
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0OLNEYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0CE222D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQs3x-0001VW-Gp
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 09:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46666)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQs2a-00013S-KX
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:02:32 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f]:43953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQs2Y-0004ZW-Fa
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:02:32 -0400
Received: by mail-lf1-x12f.google.com with SMTP id j22so5071127lfe.10
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 06:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=UF88jMWPwjyQOd02gO3O9aJyH5hwZfYCB2Xni+Th3mQ=;
 b=e0OLNEYltt4CS6jtZ6zyxPqgpFwkGGLycEQcN8Pw/4vw/GhpOqa2armojjIxZd3DGP
 Aind9eeu3Sx7PJkrpFlKRMHMXcnVhSn0ALTjUmjOLLwWxTKUoZ+xN0vaXpi6mAqkKXtC
 +BT49tqCYSAXoNHmSTMsDBJnzmSV6Xo6mTCzkjjn5BVQSCiKuJoJDNSdTNIXTkPR12Ca
 mKkWNFj40XfMs30y2DUXnFWM2xlL+yrX1KqcDcJoRKh57vDcZf2vh3uAnBN9xSTjMIsL
 v13cgFEcMq3Qt4GxfWpWJ6Ik2MYLbTLK1cVs6IGEsn5Ie8aOk8O3L3Rk8d0wLBt/UVt1
 zWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=UF88jMWPwjyQOd02gO3O9aJyH5hwZfYCB2Xni+Th3mQ=;
 b=tfeV7S6UByjN+NZuGWTauaUfXN6+S3l7/+uybTTpLozpji/61fDCAlHhbcEh7rsl4F
 LRFsppg1rp9Bj8SthcrnOiS7WjT/sY72X2X+kBQEunC/tfCFPqSA/KJPj+cZU93avWVx
 7Gy2F2SkSecWBnBe4VC8DzFoMCzonV3XZMVwRSELCk1U45uoAqegngkeblM6ZQKqOvSs
 42IQMZNwBirTtzA1Qee822ZLBBAjJS26YSQs9Sfv6Fg/Nn973OxdwqmO1fozl0lU/FhZ
 7I9qHzEW+9r6D9tkOiKTsPhZJBMe2Hp+GynmgnUZdK2BVoI8pCuMFSIegd+7tYaYz7UY
 VX4Q==
X-Gm-Message-State: AOAM532qcN1tp+VNMf/z4WH4zquh9QAbgMVMFYBfxwxMmAZ/j8hEtDrz
 64FhNuCWS24wg2L8+4ZTGp2mnPfnbO5JxTHca3LUQb1IAkTpcg==
X-Google-Smtp-Source: ABdhPJzuu/0tlmznCpEGtNaIepgSO8jF6jgRT+8heRin1gph9MQmEO66JUMQDqdGSJuLCFJwGWnmlzOLVpCjGrEeouY=
X-Received: by 2002:a19:f819:: with SMTP id a25mr4034859lff.382.1602248546533; 
 Fri, 09 Oct 2020 06:02:26 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 9 Oct 2020 21:02:15 +0800
Message-ID: <CAE2XoE9YyZwRr5j3fCATTb32pacuGrT_yUBoUTd30k+id1D3iw@mail.gmail.com>
Subject: How about using clang-format instead checkpatch for fixing style?
To: qemu-level <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000754a8c05b13c8fa1"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x12f.google.com
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

--000000000000754a8c05b13c8fa1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We can even using clang-format to format the whole repository.


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000754a8c05b13c8fa1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br clear=3D"all"><div>We can even using clang-format to f=
ormat the whole repository.</div><div><br></div><div><br></div>-- <br><div =
dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature">=
=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=
=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<=
br></div></div>

--000000000000754a8c05b13c8fa1--

