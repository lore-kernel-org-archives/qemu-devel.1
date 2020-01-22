Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB3CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 12:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E572465A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 12:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIGrmDAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E572465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuEje-00013p-KO
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 07:03:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iuEj1-0000fJ-1s
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 07:03:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iuEj0-0004sT-2e
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 07:03:10 -0500
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c]:33909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iuEiz-0004sG-VN
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 07:03:10 -0500
Received: by mail-qv1-xf2c.google.com with SMTP id o18so3088605qvf.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 04:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=jr3qc63rGKXAAvrmITj3Bv9IuqIleUNCXpPtlMHW23s=;
 b=mIGrmDAWRtjXq+corMPh/c5bu6nhEkQYm6gp+nr8+hiIUNxH0S3nS8dVx6M5Jr4tDi
 DlGlcMHT9qaeW4HPeXgKRSmf6QO/PkTxPVuNPToy61LS6yhVyLUuSEB/u6gWB5XsZD02
 klBxioJmKBuV5FQfiTIGwcHLU2CWAzPmndQMyeanGDPBQXuw0d0LBDrOaixeituJ4WH/
 ILXcLQmAz2p8ctUSmn3TYi3mGQvPMl5yCuTR124kK7xDN8gs9++UpyB/hao9VUq41FDz
 xH9mMbcXvHyhGjBoF7dsRJY3iMsWh/IJHXC60mJfr8HAxt82ZE8TrSK8nH3zEB0KXQ1l
 dXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=jr3qc63rGKXAAvrmITj3Bv9IuqIleUNCXpPtlMHW23s=;
 b=H2HFznWvA5IusqZ4xJb3dfxZ8UlL+shOhtUo4zw37BtxduCgGilmhksBDDhMoEpmyl
 C/ojQdKd11xifGjXIuK7w932FtGuQoMpmFsB9wLtKOMHDvTK0xeXHK6FdE1hjB4H5Rmm
 hrSVXE8LF1asShzx4ot9FlprUJUuNEAU9in4LdbQWu8E+ELg71zBpNyMN92oUnKqb2vp
 lwyVIHfcoIBhZ78hRWdIJMmmHkvX/kthIZT/Lw/FCqm1tAm4BMKPpjMcAbRchDKffkSN
 UvSQ5gR62hLi9YV6UwH22UGN3GWAxK0+Ru9zsilpgWAzE+aXPgKz4uPqzRLeuRehB4rU
 CBhA==
X-Gm-Message-State: APjAAAWH86OD7NEZGEESHA/B1Rm0i8i3w5vyCyFmAcCMD1FZikFLTYAv
 VqbBVF6hf/gqRhu8C93NGKNR1DTrHWC3sOurtfM538ygqPM=
X-Google-Smtp-Source: APXvYqzjY18uj2KXv6gnarAKTnqr5IxtjPCibr2vSVkrBXaa+kn5Hi/fercMNMZssBtg6QmcMTgC4W6nzhUk34/BQ0E=
X-Received: by 2002:a0c:ea45:: with SMTP id u5mr9647986qvp.171.1579694588808; 
 Wed, 22 Jan 2020 04:03:08 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 22 Jan 2020 12:02:57 +0000
Message-ID: <CAJSP0QX22cYJvnpb+zDDXLaYg0yY4CV3Jn5QY+ExxJyFcmQ3Gw@mail.gmail.com>
Subject: Maintainers, please add Message-Id: when merging patches
To: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f2c
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

Around 66% of qemu.git commits since v4.1.0 include a Message-Id: tag.  Hooray!

Message-Id: references the patch email that a commit was merged from.
This information is helpful to anyone wishing to refer back to email
discussions and patch series.

Please use git-am(1) -m/--message-id or set am.messageid in your git-config(1).

If you use the patches tool (https://github.com/stefanha/patches) then
Message-Id: is added automatically.

Thanks,
Stefan

