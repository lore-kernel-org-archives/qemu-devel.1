Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FEAC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D29D20674
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 17:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/2M/s7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D29D20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6Vu-0002Jn-MR
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 13:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msys.mizuma@gmail.com>)
 id 1jb6UB-0007sm-S8; Tue, 19 May 2020 13:57:04 -0400
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729]:34520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msys.mizuma@gmail.com>)
 id 1jb6UB-0003Xd-0i; Tue, 19 May 2020 13:57:03 -0400
Received: by mail-qk1-x729.google.com with SMTP id 190so466691qki.1;
 Tue, 19 May 2020 10:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition;
 bh=kUL4Nduzd7bupnllpb1j3UOQ+bnNnM5lDHE/TuVMEVg=;
 b=I/2M/s7ipND2YQKWJbmyaOjLGXfK9Bf8FlfWVLAdv8+1nPgkREplu7g0jRRFwL055B
 1RGOVwI8WZUX+ajJRPdZcUxuVHHsnbwg6HuDAdY/rj85FbHg/Y4XSnTbQ4uKfX4L1pep
 /2ks/x9IzSmUSj8ZBZ68CwPDO6/UfkwDX+xmbeKSRU/PN/t+swqKaGpLH+LnBu4ux+W0
 YwO1uHQUbfDUkoQaC8KQcakl/lUYxGVhtKnD3PXW1WYLNqAnHJUAfer7AAca4fIrrTr5
 yLHxWkQCTxbd50qCSsj7FsknVQwI25cgazbOEEME3lCLgH37mrlZhn0GnCAwi/v+abN+
 AEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition;
 bh=kUL4Nduzd7bupnllpb1j3UOQ+bnNnM5lDHE/TuVMEVg=;
 b=Q46i8WXg1KO6JlO5Pv8QFUJILAAZkb4MFTwLMtLIsuMLWOev4qvjcRUG4/p0egcrgn
 3HMeXNvHXvI39hZYyxB34xEseDyyVf2PMedJGz012QNPpzYCSpX3T4ofl0mupDXAP74N
 8SSJPMR+hk1teMAaOcplEMAXLjowR7uMNZ4+z1D1AOLk+KV7YQYziJ3HKgHecX+sIlec
 wih4nqbYbt+3F4zdaou44ZTZ5DZ92fniOcoYQuuA+UOYs1lzuLJghKpHr1ieJmg378Iw
 4L5Bi2IKi+w1rAn9VynyqPoI4IKhM5Mujpuv+ECgTvpYBQO2qxxyQTJDGFYA/WVA+XOM
 o5pQ==
X-Gm-Message-State: AOAM532DAmuoV4MaPqD4qOtBlfXjHY/7M+HMF/7oqBxqiJPAss/73Ru5
 IStrSHoGxy7tmtf4nidQbUmVzkE=
X-Google-Smtp-Source: ABdhPJyWJm42+2FedJ0JI3KowC3dII+/YEmESBo2WZOAhSn9z6VKHQw5o5wAmlBEws5XwJwgH6igbQ==
X-Received: by 2002:a37:db11:: with SMTP id e17mr593415qki.336.1589911021187; 
 Tue, 19 May 2020 10:57:01 -0700 (PDT)
Received: from gabell
 (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com.
 [209.6.122.159])
 by smtp.gmail.com with ESMTPSA id z19sm340548qtz.81.2020.05.19.10.57.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 19 May 2020 10:57:00 -0700 (PDT)
Date: Tue, 19 May 2020 13:56:59 -0400
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: Question: How do I discard any changes for the device which is set
 by blockdev option?
Message-ID: <20200519175659.4poxgjmp4xoufl7h@gabell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=msys.mizuma@gmail.com; helo=mail-qk1-x729.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

I would like to discard any changes while the qemu guest OS is done.
I can do that with snapshot and drive option.
However, snapshot option doesn't work for the device which set by
blockdev option like as:

$QEMU --enable-kvm \
      -m 1024 \
      -nographic \
      -serial mon:stdio \
      -blockdev driver=file,node-name=mydisk,filename=/mnt/fedora.qcow2 \
      -blockdev driver=qcow2,node-name=vda,file=mydisk \
      -device virtio-blk-pci,drive=vda,bootindex=1 \
      -snapshot

I would like to use blockdev option to set the device because
libvirt uses blockdev option for disk element.

If there's no way to do so, does that make sense to get available
snapshot option to blockdev as well? If that makes sense, I'll try to
implement that.

As for qcow2, I think we can do such things to use qemu-img snapshot
command, for example save the original image and restore the image
after the qemu guest OS is shutdowned. However, it may be complecated
for user. I would like the simple way like as snapshot/drive option...

If I'm missing something, let me know.

Thanks!
Masa

