Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9272C004EF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 11:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906C320651
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 11:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906C320651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlArS-0008Pe-U0
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 07:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37565)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hlAqY-0007Se-IZ
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 07:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hlAqX-0008Eu-JE
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 07:33:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hlAqX-0008EG-CW
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 07:33:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so2094421wrm.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 04:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6a4BPdwwsKj7fc9uLyBgqh43mz6aL2R1wkd+4QjrWp0=;
 b=TPJOmRzfkXSOVYpqEcbbYgMQQC6TVywJ6i/DO2fDzO/+k4nbja9rFgE9fC5SJcJKSd
 hH+6HX2qopKwZiwE3ZF7eN/cdnBRnnjfsa2rxm2Gg4kURPBvnHqj8z7uGug8OmF28SkG
 65alvALSPrh4xmAchufC5OAjv3g5Kh5H27h1pLMCJMP++GTyNngLGBphSSyxFY0gR4au
 Qn7oBiR87CUrOv9AypvDipStAbLMXMp39cmVp3YNoPk455+Ffu1jHhliDBTrf4mnXZa1
 DItk20P2T87/hi72JMh2o/g7XQTaOnv3gvSLu5j45w/XT2VqvApIGCUlU17RMmQNZebB
 6aBA==
X-Gm-Message-State: APjAAAVJQWgQdKyywErdRLquHN8dzbQqfKxp+BTI3h+/zmesN5+vKGO9
 AwV0IO7rqL5/3poIJOXTjEHkrEvbDXI=
X-Google-Smtp-Source: APXvYqwD8TVRXNVcrosMFs+8y3Fam6GH6Bexntby1RZ1iO9OJBIeN/bx6+O3d7Z5dI83Amou7h//eA==
X-Received: by 2002:adf:ea4c:: with SMTP id j12mr4304250wrn.75.1562758391885; 
 Wed, 10 Jul 2019 04:33:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d066:6881:ec69:75ab?
 ([2001:b07:6468:f312:d066:6881:ec69:75ab])
 by smtp.gmail.com with ESMTPSA id t13sm2242660wrr.0.2019.07.10.04.33.09
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 04:33:11 -0700 (PDT)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190709203806.17550-1-dmitry.fomichev@wdc.com>
 <f790cb77-fa6a-c304-bc7f-62bbede78751@redhat.com>
 <20190710110241.GB6501@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eea2bb4e-813e-456b-8aa9-514f63c5057e@redhat.com>
Date: Wed, 10 Jul 2019 13:33:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190710110241.GB6501@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 0/4] virtio: handle zoned backing devices
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
Cc: fam@euphon.net, qemu-block@nongnu.org, mst@redhat.com,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/19 13:02, Kevin Wolf wrote:
> Hm... Actually, file-posix implements .bdrv_check_perm and could just
> refuse attaching a parent there if it doesn't request a specific
> permission like BLK_PERM_SUPPORT_ZONED. That should give us the
> whitelist semantics through existing infrastructure.

I'd like Dmitry to have something more precise to base his work on.  The
permissions system is really complicated and I never really wrapped my
head around it, so I need your help.

IIUC, blkconf_apply_backend_options would grow a new argument (like
"resizable") and that argument would add BLK_PERM_SUPPORT_ZONED to the
perm that blkconf_apply_backend_options passes to blk_set_perm.  On the
other side raw_check_perm would say something like

    if (is_zoned(s) && !(perm & BLK_PERM_SUPPORT_ZONED)) {
        error_setg(....);
        return -ENOTSUP;
    }

Is this correct?

In addition, BLK_PERM_SUPPORT_ZONED would have to be a shared
permission, since it's possible to assign the same block device to
multiple scsi-block devices.  So BLK_PERM_SUPPORT_ZONED would be added
unconditionally to shared_perm.

Paolo

ps: I have always thought that shared_perm is expressed the wrong way
and should have been "denied_perm".  How hard would it be to change that
now?

