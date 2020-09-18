Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01ACC43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD3423719
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOO4hCgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD3423719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJGDg-0002tz-F2
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthik.poduval@gmail.com>)
 id 1kJG5p-000355-DG
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:06:25 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29]:34433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <karthik.poduval@gmail.com>)
 id 1kJG5m-0007y5-Le
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 09:06:24 -0400
Received: by mail-vs1-xe29.google.com with SMTP id y190so3544226vsy.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 06:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=sVkyti8mmaTMEkSLXb0fOwKWVFb/PuOs8VhJGJfxyTU=;
 b=nOO4hCgXa/J/8r6tGoz1A94e2I4BMN4V0CEttr2fRnChcXl7yVO0Nkyw4Ml0hykVcR
 4y6hXgrAhpjVqHn4Xb96WAuIluTywOdjb/ofmLEBeGS6vPEYa0UoJo1V+Na3ZbnTNlEJ
 N7k07NTStL9PnrQUol9IxLTnR+p7dckXXc0GkCiaQKtw7IoyrWGIJzA/aWU55Wcx7HiX
 aC/MB8RZhMAWyFveE/ifSTl7cCa7VU6zfmC4PwONLuSoHcGbD0+o2C2m7j3BObwQQP9I
 Xbpvl+C4zmLe4cKqD98bySNcYFMA2oNX8MaCgq4QApvMhs3Bhi84TYICdaQA8/WXmDyW
 ntrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=sVkyti8mmaTMEkSLXb0fOwKWVFb/PuOs8VhJGJfxyTU=;
 b=nA9GDWVY11ITNJLGfWPl3YWFq666W0uoVbkRzT/wHZ/GnD7i74p3/+mQqyTZ1cpUOn
 Yfcf7jiteJxZJHdXKJUQylvrTe6Iuf8jLxeozjgEtgcZSwLO46UEDFF+OmvDPRSHWXYd
 AFQmITG0IriLIUDw4QPs7l4kDFrEgJ9iZMqVF7zbD27gAg7F+JVMHQqjcUbDrpGTnq7O
 XtKRdxTssiG/ZbtlFpocefXxhXj56rUofT1D+yajCe0GKu51aZ5nLMDoGe7xV5yhHjyX
 8HW8Mtibd3+78Zu8KVSNPYaVSnodfCllhngUhWHZALglYe+dZtC6H/UpazPJ03xE0WNN
 cYlA==
X-Gm-Message-State: AOAM533Jwkdt9+qfMr+iqVfc838+cSVxSW3edjAATVri0gnmyzIGPYkD
 mQ71R9cuyYnyQfBZ7RswxEmpch93fmNky6PQM5P7MygfOTixOQ==
X-Google-Smtp-Source: ABdhPJzCtxplU053su54LZMz4w6VdLZHQ2ooar8HoawoGVpxGmxTBYtKb2kFuX3IenRFNnX18RPGtdlxJi8mFSbTWxk=
X-Received: by 2002:a67:8a46:: with SMTP id m67mr21568513vsd.28.1600434380813; 
 Fri, 18 Sep 2020 06:06:20 -0700 (PDT)
MIME-Version: 1.0
From: karthik poduval <karthik.poduval@gmail.com>
Date: Fri, 18 Sep 2020 06:06:09 -0700
Message-ID: <CAFP0Ok82wY26BfVToT7K_0CCngr9N27UV3iaou_5QOE-Nmw1BQ@mail.gmail.com>
Subject: Heterogeneous/AMP example in mainline?
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c1381c05af962a41"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=karthik.poduval@gmail.com; helo=mail-vs1-xe29.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, HTML_OBFUSCATE_05_10=0.26, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 18 Sep 2020 09:10:55 -0400
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

--000000000000c1381c05af962a41
Content-Type: text/plain; charset="UTF-8"

Hi All,

Was sifting through the heterogeneous QEMU effort in archives here
https://lists.gnu.org/archive/html/qemu-devel/2015-10/msg06256.html

Did this effort make it to the mainline ? Are there any examples of AMP
SoC's in the mainline ?

-- 
Regards,
Karthik Poduval

--000000000000c1381c05af962a41
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,=C2=A0<div><br></div><div>Was sifting through the h=
eterogeneous QEMU effort in archives here <a href=3D"https://lists.gnu.org/=
archive/html/qemu-devel/2015-10/msg06256.html">https://lists.gnu.org/archiv=
e/html/qemu-devel/2015-10/msg06256.html</a>=C2=A0</div><div><br></div><div>=
Did this effort make it to the mainline ? Are there any examples of AMP SoC=
&#39;s in the mainline ?</div><div><br>-- <br>Regards,<br>Karthik Poduval</=
div></div>

--000000000000c1381c05af962a41--

