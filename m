Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FF2C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6EAF2071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbvZSUpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6EAF2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAYq1-0000DS-T7
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 09:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxime.guerreiro@gmail.com>)
 id 1kAYLt-0005Qo-Qn
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 08:47:01 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32]:44873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <maxime.guerreiro@gmail.com>)
 id 1kAYLs-0008Am-86
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 08:47:01 -0400
Received: by mail-io1-xd32.google.com with SMTP id v6so12274399iow.11
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=nC+DHUrQhOiAsMoOqZ/7iIpzUE7cn5EOw3lM9y7PezA=;
 b=RbvZSUpuxL5l3co3S20J0g06/5H5XZXZ1HBCwxxclTLborNk1Rkt0vHB76HoK5HGyS
 8RmjO4TEFuQNBQf2+xWq3WwwUEsjO4e8XbFPsddgyr/1oB0NWomjY6SZeqEWcLVfqH4i
 pxBIe+NnBTmH+9bJwqDXG5iQhHoMHkDgt/J0l3GtqkZY+I/DAxV4pSL6ukL7zCrcCeK7
 ISugC3BE+BT9u83gJW3720mb9FT8eVBHOfI16fikRL+T7feAcDjupYrlrOWXW4FVfuhT
 /P/Bxzj63RTLxQf7mpHmcfAxVFL3IoKTptJcfHxVMMeCfSwwiUOAfeErTTJr7cTAzLGi
 4n6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=nC+DHUrQhOiAsMoOqZ/7iIpzUE7cn5EOw3lM9y7PezA=;
 b=AKP2kcfJSnBIOBzApVXuJdI/srYf2+tnY0G96YK5noxpIU3GAQAv7Hj+FWRtTOr+LI
 gy7sKyjVz+nm90rD5lKo2i9zO+wTwqOmPQ3lg9+ltfnf60Bc+47EJvwrN0RR3ZzTzs+v
 wfduD3KK8M48/4E3FALS/CIc5Y8fx7n8c6b2ggjp+ERjafvC+5usR3Fhm9dGImzyjUs2
 IEyX3VUf0C6Woi4MypxpdGlKI7aljCwFdAyV8BKaZjpjJVmlrsh3hh0M9pXSEYi5CG28
 5YBQT9qqu0QLGidd6GGBpYIx7JOkLUHkpnZzzB0D+zBTfbXoi9vDbuKqSZPJCAD0fukY
 7W+g==
X-Gm-Message-State: AOAM5303Zmj+SU2E9l6/QO5EsYvLGZAm51isZ82IjieQt4FYI2McEyqg
 Eb42q9w8xxJOB+ldbiom9Pumq+cM+arzbIispnZhOfxEGrZix1Qu
X-Google-Smtp-Source: ABdhPJzQGDZ9nY+N0A5d/xm4NMvSSia2LYupl2JR2wjkv78E4QXmfC4LO7r169o4Riw4eve/qeOqg4wHphi9GHCLcUE=
X-Received: by 2002:a02:730b:: with SMTP id y11mr10541980jab.126.1598359618286; 
 Tue, 25 Aug 2020 05:46:58 -0700 (PDT)
MIME-Version: 1.0
From: Maxime Guerreiro <maxime.guerreiro@gmail.com>
Date: Tue, 25 Aug 2020 14:46:47 +0200
Message-ID: <CAPESWZNaFZB-4hk0GNQAbt=KKf9ZzAMON5oLw6WFBUsi_ApkkQ@mail.gmail.com>
Subject: What are the security risks of running QEMU/KVM as root?
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=maxime.guerreiro@gmail.com; helo=mail-io1-xd32.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Aug 2020 09:16:22 -0400
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

I'd be interested to learn more about the security 'vision' of qemu/kvm being
two components, one running in-kernel, one running in user land. What are the
security advantages of running guests as non-root?

In case of a qemu or KVM vulnerability, won't malicious guests gain kernel
privilege no matter what user is running qemu?

If a guest is able to execute arbitrary code as the "qemu" user, can
it escalate to
root privileges using /dev/kvm?

I've also asked this on StackExchange [1], for visibility.

Thanks,
Maxime

[1]: https://security.stackexchange.com/questions/236681/what-are-the-security-risks-of-running-qemu-kvm-as-root

