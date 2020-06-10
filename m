Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7D5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53F820734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hHiiapAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53F820734
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jitIz-0002l0-3e
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42126)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sameid@google.com>) id 1jitIM-0002GB-NX
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:29:02 -0400
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730]:33200)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sameid@google.com>) id 1jitIL-0002ep-Ad
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:29:02 -0400
Received: by mail-qk1-x730.google.com with SMTP id g28so986087qkl.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 22:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=uuA/mABJ5qT0JGnq3eWqSjvpXwgBw/oa9cO68/YlNz8=;
 b=hHiiapAWqttZbHcz+Li1BX0f9TmJhvRVXDKS9v7dmdsJEbe2qwfoLHnESIwGHT6k89
 N9HcKxru38qhhrsF3PQ12GyLCUKAXCCQt3zSk76HGlu+ad6GvqHC9zMFigjKVOpiEmM1
 WLYxhWaJnpqAfCXScwcpkoGvGwSQWgWi/JSQJ2z9YoUQHU34mEihJOWNGwnRG164qn7B
 /Meuy/ODKZEYS4pa9FwWGNXAQ+dzIcVQsrSsYO/qlJoG6BLQquMRbf16WPrWm06FQqJb
 O9/AVt7dqvwsRat1nPHj3LiE4z1WqBsyQOEQ4RxWEgooaKGyfxk9IH7jyIMqRT894UVa
 phwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=uuA/mABJ5qT0JGnq3eWqSjvpXwgBw/oa9cO68/YlNz8=;
 b=F5QZh/36d84myK7TzR5CwZNTc81wqibEJa84T7svRc3X+kN0t9zjFTrvaMG+nbLrGV
 Y+Xi9/Lzg0KFnKXBlzl2ekZASJ304s2THFohbeWz7aVbz70zgbJ5ZgF+kuh1HWHU46G+
 xeUOHRMMujfre6RNpZuy6ftBu30ngUdhHnbi8dHRyC1IontMVBR27gkEi3V0RW5SgX97
 gHoxbexh72Uf/808EO3QStG3LD4ueQpKa1deMAj0QWujP7X1VuKAdYXAvY+TX2l2Jhrv
 99Hm6qP4gBenwUMUYXAmTPDEYJBYYPMjrK12KHN2EVvOSlRYWiYhxNI185PjcQCXFUuK
 eORA==
X-Gm-Message-State: AOAM533GUhlfD2mf51Am3kggeeDjlTcwrDb28VPz5ngNJIlBPRp8g5iS
 25PZutwltxdgoHHQE5XRx+DL9E7v38Zn9yX+Ez6sPQ==
X-Google-Smtp-Source: ABdhPJwPbcczs+oWCOBaTE0ypR73OkpR5Lzh4YoOe3nVFQY+R01u7LiZCMYnpo/WXolW/skzybdPDUEqtyqYD5EGjps=
X-Received: by 2002:a05:620a:15e8:: with SMTP id
 p8mr1442037qkm.333.1591766934465; 
 Tue, 09 Jun 2020 22:28:54 -0700 (PDT)
MIME-Version: 1.0
From: Sam Eiderman <sameid@google.com>
Date: Wed, 10 Jun 2020 08:28:29 +0300
Message-ID: <CAFr6bU=LjeW5_eGtwL38cher2TM52skohuANNXN9EpO+mA-z8Q@mail.gmail.com>
Subject: Clarification regarding new qemu-img convert --target-is-zero flag
To: qemu-block@nongnu.org, qemu-devel@nongnu.org, david.edmondson@oracle.com
Cc: vsementsov@virtuozzo.com, eblake@redhat.com, Max Reitz <mreitz@redhat.com>,
 Tony Zhang <tzz@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=sameid@google.com; helo=mail-qk1-x730.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -185
X-Spam_score: -18.6
X-Spam_bar: ------------------
X-Spam_report: (-18.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
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

Hi,

168468fe19c8 ("qemu-img: Add --target-is-zero to convert") has added a
nice functionality for cloud scenarios:

* Create a virtual disk
* Convert a sparse image (qcow2, vmdk) to the virtual disk using
--target-is-zero
* Use the virtual disk

This saves many unnecessary writes - a qcow2 with 1MB of allocated
data but with 100GB virtual size will be converted efficiently.

However, does this pose a problem if the virtual disk is not zero initialized?

Theoretically - if all unallocated blocks contain garbage - this
shouldn't matter, however what about allocated blocks of zero? Will
convert skip copying allocated zero blocks in the source image to the
target since it assumes that the target is zeroed out first thing?

Sam

