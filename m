Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EECCC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 13:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE5620850
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 13:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="DSsNB1iV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE5620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1shC-0004w7-GF
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 09:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40755)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <3oo5iXQYKCjspXjbfadlldib.Zljnbjr-absbiklkdkr.lod@flex--sameid.bounces.google.com>)
 id 1i1sgB-0004SQ-GI
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 09:35:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <3oo5iXQYKCjspXjbfadlldib.Zljnbjr-absbiklkdkr.lod@flex--sameid.bounces.google.com>)
 id 1i1sg9-0003vF-RI
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 09:35:35 -0400
Received: from mail-qt1-x849.google.com ([2607:f8b0:4864:20::849]:49590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from
 <3oo5iXQYKCjspXjbfadlldib.Zljnbjr-absbiklkdkr.lod@flex--sameid.bounces.google.com>)
 id 1i1sg9-0003tp-Fw
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 09:35:33 -0400
Received: by mail-qt1-x849.google.com with SMTP id l17so14869360qtk.16
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 06:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:subject:from:to:cc
 :content-transfer-encoding;
 bh=nRy5VaU5yHxoTxX90BU4AtUOsfsyL9jB3YWOcBS6Wd0=;
 b=DSsNB1iVfOs/cDNw4dJT8LsW5+VWsBipz/HHVb+Gn/PTjXpsoGMIR35YoqDn+Ud1Vh
 pPiBmei594Ge4TNWHPea7LiW9WqP9vPMh4tQ8RlAQ9CB6IG2/NPB9AiI2JfF5YjmMkTl
 wrypjJ5pN7Hzz4vTBETBUDzqVHnjsqc9hBz03S+O2Wn5qzaS2Jyiq+6cxKuubtzyAsS0
 nNVgDrtWyzxhm4zyUE6jxhnzFJe/e/QHQmBbJqX7bxnUd3erQXNouL8knn5Ma3dtKLQO
 XpNcAZnXzpGmw370kqGC6p2Ut/EPBnBmPfror5nYXDJOjVxUyN/gJIhb3wFYblaSICEH
 u88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
 :from:to:cc:content-transfer-encoding;
 bh=nRy5VaU5yHxoTxX90BU4AtUOsfsyL9jB3YWOcBS6Wd0=;
 b=aT8DVYJw42AdJz2VyM9PgH4Jh7GbAlFvlimiMzYH9+Ib021ip1MaRB0R4tlD+xLfC1
 xmwKRA6+YH0sqcNUk/o1nJQpCJB3UIMkHBcZ7YDBu73k5Wr3X8IoRx2Lz9oL3PjRrQkX
 kaJWpxwdUEEf0605BJuuA7XKUQ96oymTpBseboLNU0oBiw7lFFk1/nqa8bK/UG9HwVXJ
 /28uOCmhy2Td+mKAKQZvyBJ050GxtSh8uMi84KB3I0ZSPNkEQjlAlNIKGHyxDXhWM1ko
 7aOpsWn1bI0NVkoZQlgG3PN/jghanrK1l2HR1FGR+z5ZvE70Z0LYYCvSPMGkFpVMZCDD
 nBzQ==
X-Gm-Message-State: APjAAAX7f1yypBDFf/i8228HLAg1EyTY3z15luFt9FkubLizJR8egXoT
 pMuB/nZUuQZbTXYgdjlxHMqmDRKWQnE=
X-Google-Smtp-Source: APXvYqzev35jR+tqgVQKVgpIaeKZAqLBNLzFrXlkfkJov2432qEVHlkNOZPPkVMKpyVplX8G0yTZjTbzVcQ=
X-Received: by 2002:ae9:ef06:: with SMTP id d6mr12304895qkg.157.1566740130907; 
 Sun, 25 Aug 2019 06:35:30 -0700 (PDT)
Date: Sun, 25 Aug 2019 16:35:14 +0300
In-Reply-To: <49d3db3b-5a66-c87d-8d78-157bd0201731@redhat.com>
Message-Id: <20190825133514.237228-1-sameid@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
To: Sam Eiderman <sameid@google.com>, kwolf@redhat.com, qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, seabios@seabios.org, kraxel@redhat.com, 
 kevin@koconnor.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::849
Subject: Re: [Qemu-devel] [QEMU] [PATCH v5 4/8] scsi: Propagate unrealize()
 callback to scsi-hd
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
From: Sam Eiderman via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Sam Eiderman <sameid@google.com>
Cc: liran.alon@oracle.com, karl.heubaum@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> @@ -213,11 +221,18 @@ static void scsi_qdev_realize(DeviceState *qdev, Er=
ror **errp)
>  static void scsi_qdev_unrealize(DeviceState *qdev, Error **errp)
>  {
>      SCSIDevice *dev =3D SCSI_DEVICE(qdev);
> +    Error *local_err =3D NULL;
>
>      if (dev->vmsentry) {
>          qemu_del_vm_change_state_handler(dev->vmsentry);
>      }
>
> +    scsi_device_unrealize(dev, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>      scsi_device_purge_requests(dev, SENSE_CODE(NO_SENSE));

(I see this code for the first time, but) I suppose I=E2=80=99d put the
scsi_device_unrealize() after scsi_device_purge_requests().

Max

>      blockdev_mark_auto_del(dev->conf.blk);
>  }

- shmuel.eiderman@oracle.com
+ sameid@google.com

Sure, I'll resubmit

Sam


