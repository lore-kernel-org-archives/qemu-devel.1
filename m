Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854B0C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 12:13:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4964D21920
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 12:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZEplSfH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4964D21920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFH2F-0005gA-Ck
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 08:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40617)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <devtoe82@gmail.com>) id 1iFH1A-0005BO-Fm
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <devtoe82@gmail.com>) id 1iFH17-0008HR-Pz
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:12:35 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:35630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <devtoe82@gmail.com>) id 1iFH17-0008GS-Cn
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:12:33 -0400
Received: by mail-ot1-x32f.google.com with SMTP id z6so11326587otb.2
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 05:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=75K2boqvjiShtjVaWPC0Jb7NB2PxH93sa8fH7hOE+kw=;
 b=vZEplSfHXgwYseENL0SVUcbXd3ciXr/IzPP/7hv4ir0eo5qBu2eSyU2QzgtgFNm8t+
 ZzppK0AFS1v5+KWVHpqunCGukmxSnQxs4k/PPo4NsETxWfj0XpTV2qJyMM5r7FrXs/pT
 /JhYtAmY+SbXJcJVVX6oiWmOcSwMCbALwpqawXsAGgYWpXiwyjHO6gYMAI+d3Lmfb8iC
 K9zF5esDWehiliRwxoqlZPNao712VQfCMo9H7i+YacFYZsP3NU7npSBunhtmlPibZb30
 T75dMr2AzCQX9RcJdrpcp/VzZj2wo1YHOl9mJrxMtwB9l0ozBN0wR7x5gz3MwpeFZ2kN
 KGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=75K2boqvjiShtjVaWPC0Jb7NB2PxH93sa8fH7hOE+kw=;
 b=WRjm1izJl4WcrQfk3Iw/1QLBuFoBNAFsE+iiIi4Gh1s9qX9iO3eLMBOYsQJFc7c6kk
 2qvf9PM2NtY0IZBvTpi0Z6dGLUPDdPBWHA8F9HutoZ4r1nwydQN/kpDxytrDYr9Bivwt
 mEuhRUtQE1VxLXMf2FL/JFspugN/HURM54OsQUfE0RDXhuYYnJnwjQ3qaZCrg1NTHbxP
 DDtnZmK7fgqkmwSHjdo7A00jI3yThXvneXgiDb0M4DmBdXnqhQ5mBZtQ8mWl5bBXsH8U
 s8QaDQXy0ZG/msc96C278T9rkI1xbQNKa4hLVSit1yKncVjl1ZLGawWd4So8UYhSOO+q
 PDxg==
X-Gm-Message-State: APjAAAUm4KFElNsp+xsFvZyIKDfnGVg1gQJNty9INPTUFh9OBVVG5++A
 EtuStVKsc5iIm0JPw/RViZ25UJz4+HEve2j1bJWjliS1
X-Google-Smtp-Source: APXvYqw2LXIM9NOlkf7gKAO6aekhx3/zyyF5LVp2ymsyaMq4hkzY/fPE21IV2tadPMLKUDjvI0wvsPwdjeNFeMnZfDQ=
X-Received: by 2002:a05:6830:1e87:: with SMTP id
 n7mr17847036otr.101.1569931951419; 
 Tue, 01 Oct 2019 05:12:31 -0700 (PDT)
MIME-Version: 1.0
From: Toe Dev <devtoe82@gmail.com>
Date: Tue, 1 Oct 2019 15:12:17 +0300
Message-ID: <CAN+O=TJkZEqHs50gYZgp3n0AeV1h6Wd8UYo+kxss5LUVJqxULQ@mail.gmail.com>
Subject: header not included but used in vl.c
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
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
 does it have a reason why the file vl.c lacks reference
 #include "qemu/module.h" ?
 but still uses the defines include their(for example the enum value:
MODULE_INIT_OPTS)?
I'm using eclipse so I was notified by the IDE immediately.

Thanks for yours help :)

