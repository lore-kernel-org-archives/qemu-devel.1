Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19282CA9EB0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 10:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D526320842
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 10:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIe0J6zq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D526320842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRD7d-0008PC-Vr
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 05:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <estebanbosse@gmail.com>) id 1iRD6p-0007dF-LD
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 05:27:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <estebanbosse@gmail.com>) id 1iRD6o-0006Nn-Q5
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 05:27:47 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b]:41065)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <estebanbosse@gmail.com>)
 id 1iRD6o-0006Kx-Jd
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 05:27:46 -0500
Received: by mail-ed1-x52b.google.com with SMTP id a21so10913305edj.8
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2019 02:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=Zh7Jr7iS6TXg7qH64JOj8orqDwqvF38/6wav8iRmihY=;
 b=iIe0J6zq0QqoLNW9okLSmH/CBKLbRJpc/+XOYrjqGQK/dhw1xD6CntXTwRFWQKNsA8
 FS9GCy1TE3M1oSqCsEofS7fqjMSZqQBKNioBuQXZwML7GjUqWiaBt5RFyHfXj3qtKtsR
 oBOjb3HWI1UuEggXw5iOMLifD17rVYVdTDXEN1qlauoGgalzWT+HrNX58vm8RxCJ3Fzs
 pa+C/l+F/UwMyIwXn148NfbcxDtsffuJ19XkMMWb3Vz67vjvTFSFYHfBQ+Hc8o4ogfiU
 AyEULTbZH23RLoby5oZXL80kRovrih6hal7K3c4DLzkQ9cqHh7CKdq/a0JDmFcStwxhT
 svpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Zh7Jr7iS6TXg7qH64JOj8orqDwqvF38/6wav8iRmihY=;
 b=NAoH3b5rywIrf7gnMBYw8effL3nClG3WF6qB41ecEU4csm8SrmStBGKQLUgJ6ZXFC9
 0B+0v0YkWjwWu87qpzodEf+uPA8bDQfccSskJ/W2aFeSknvN+B0T2n1fcP+ESFl1aFUO
 nmYxTu16/AJlsNDyzZJZXVGhpMrHqR6Vhpo4gGVDV84TAeStPWEO9k9SvOSdA/j7lWfE
 TJCXxM5QWhxfrUp4+AMhfsST3/EKczXb/qcnq509OZ6JcGjM+xT5+xdLkpG8uFu8W4Jz
 5SOnS92wr2dXm1O+4Yow47q5ba7rJIHO/rxUduJcZ9d+afWd3jEWNZda92+NZDewBq0b
 7jmQ==
X-Gm-Message-State: APjAAAVn6k+C55wS40YXZIw9kzf0dtuvNop9/9ek/1Pmfqp92EDJPKAL
 VdHP/CkKH2m3Z77FUYvmUpzglHOJOZC1LJbDWCgLs6Hx1eo=
X-Google-Smtp-Source: APXvYqxW5g9nkrDi9DUsa6ECYueqc1j1SuzYJNoyYxC8MBjqYG31agjfozj4H3uGI0xGJiPF8LpmikrEQFvP72T2Od8=
X-Received: by 2002:a17:907:36e:: with SMTP id
 rs14mr13881535ejb.330.1572776864709; 
 Sun, 03 Nov 2019 02:27:44 -0800 (PST)
MIME-Version: 1.0
From: Esteban Bosse <estebanbosse@gmail.com>
Date: Sun, 3 Nov 2019 11:27:33 +0100
Message-ID: <CAGbAg_D_FL-7GVppw_nYDV3i2Bu7Z1hm6eW74tvhvxEKXh0KcA@mail.gmail.com>
Subject: Wiki account
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000005501f905966ea6a6"
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005501f905966ea6a6
Content-Type: text/plain; charset="UTF-8"

Hello,
I would like to have an wiki account.

Preferred user: estebanb

Thank you,
Esteban Bosse

--0000000000005501f905966ea6a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello,<div dir=3D"auto">I would like to have an wiki acco=
unt.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Preferred user: est=
ebanb</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thank you,</div><d=
iv dir=3D"auto">Esteban Bosse=C2=A0</div></div>

--0000000000005501f905966ea6a6--

