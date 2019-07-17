Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27558C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 12:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E876C205F4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 12:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QsyAvpJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E876C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnjP7-0008SC-74
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 08:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39296)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnjOv-0007zC-Jh
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 08:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnjOu-0003EW-KU
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 08:51:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44245)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnjOs-0003A6-QL
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 08:51:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id p17so24665001wrf.11
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=FH2IKJSyWjZ147iHU4BpJSTDQwL49HJaD18tq/skVi0=;
 b=QsyAvpJ+AZWBumDkwu1X8JTX9dz5u+0bcqX+vTEtjTCS2oc41cjEyV3Y/SbWA1KTZh
 aOgpoOYokvjXksuPkNFRUGMmS8axOvkegD3SW6nwGL7vJcz0ciAknlWcoxKyQHHC5esI
 yqNAB9LcCJTwItlnD44l9B15vvQAQB1U0KteLWbrRqydinfmqp2ouiuJAWFP/GATUUEa
 PMANw3FPYYhwig00lqbL6eVKdV4iz+s7nmz3RdZ2L6sQ8o4hnP3mffXBS67KegP8tNPi
 CVSLuIdSl7Mu5fA3pBF0iXEtK4u16qrjktmpBe2dirvJSGfNtRkCIhGIo/c0pEhAksV+
 wqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=FH2IKJSyWjZ147iHU4BpJSTDQwL49HJaD18tq/skVi0=;
 b=BcZ5vnkHBz4gcqMakkIiIRsIEvnGLDpWtm7t1S9o4oAuR41euzs5u7uUy6TfHstdSh
 YcWSucgfIQ52F0xa1KOUI20kRNlc7QVc2Xp2vsU7LlxqmA7InaB6CV8sMII5iRGH0Gd/
 1LF0yCOuYt5PPyX39nlnLBLIahE6iQLvqXq0lfOrfk8ezfkkJ0MP2MvfK46oHXWYSeel
 NG5MQXicwmYiKW5XvygvPk/zPbPmmMSsMkjm37gjH7PYKvxXDOA/hNfrSCTUSe0BRRaJ
 PGV/3SnYROXU6m5ktsjfjPb5UzPtFWeXLXu3BLEYeLrRymGOzsEK6z0w3M/RwIq04iR6
 I5ig==
X-Gm-Message-State: APjAAAWK1glWE999p+qeMvYWRdSCDZetQ3NIRQD3C9dcQ09OVQoWP03e
 ZzhjmHJh+gZAuC4bicRGaaROVw==
X-Google-Smtp-Source: APXvYqxjBSkto54xq56zsSPjA4ASBsu/XnQJEOre9q3qJiYMJW4nwx/R0PBHqxXsXjFiP/NQ/7aquw==
X-Received: by 2002:a5d:4212:: with SMTP id n18mr41915053wrq.261.1563367868249; 
 Wed, 17 Jul 2019 05:51:08 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id s10sm29631546wmf.8.2019.07.17.05.51.07
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 05:51:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 39AD21FF87;
 Wed, 17 Jul 2019 13:51:07 +0100 (BST)
References: <20190717111947.30356-1-thuth@redhat.com>
User-agent: mu4e 1.3.3; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
In-reply-to: <20190717111947.30356-1-thuth@redhat.com>
Date: Wed, 17 Jul 2019 13:51:07 +0100
Message-ID: <877e8gvn7o.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Enable iotests during "make check"
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> Let's enable the block iotests during "make check" again, to avoid that
> they get broken so easily by accident (like we've seen many times in the
> past).

Queued to testing/next, thanks.
>
> v3:
>  - Added dependency for "check-block" so that the *-softmmu targets are
>    now built first
>  - Added 197 and 215 back to gitlab-ci.yml (there is no problem if they
>    do not run in parallel with the qtests)
>  - Removed 122 from the "auto" group (does not work on ZFS according to
>    Alex)
>  - Removed 181 and 201 from the "auto" group (they do not work if the
>    default machine of QEMU does not support migration)
>
> v2:
>  - Added new patch to allow tests without groups, removed the "o_direct"
>    group again.
>  - Removed some more tests from the "auto" group, like 197 and 215 which
>    were sometimes causing the CI pipelines to fail on gitlab
>  - Added a patch to remove the "duplicated" tests from the gitlab-ci.yml
>    file.
>
> Thomas Huth (4):
>   tests/qemu-iotests/check: Allow tests without groups
>   tests/qemu-iotests/group: Remove some more tests from the "auto" group
>   tests: Run the iotests during "make check" again
>   gitlab-ci: Remove qcow2 tests that are handled by "make check" already
>
>  .gitlab-ci.yml              |  13 ++--
>  tests/Makefile.include      |  10 +--
>  tests/check-block.sh        |  44 ++++++++++---
>  tests/qemu-iotests-quick.sh |   8 ---
>  tests/qemu-iotests/check    |   4 +-
>  tests/qemu-iotests/group    | 120 ++++++++++++++++++------------------
>  6 files changed, 107 insertions(+), 92 deletions(-)
>  delete mode 100755 tests/qemu-iotests-quick.sh


--
Alex Benn=C3=A9e

