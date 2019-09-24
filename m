Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77ACBC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:56:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F26B214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZOxsSWe4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F26B214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCnAx-0001Yn-Kp
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCmVY-0008BR-Fy
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:13:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCmVX-0000Xl-1r
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:13:40 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34609)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCmVW-0000XW-Pm
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 11:13:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id y135so1836897wmc.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Le63OMzUomhO/QZ3HB9eiflAuhutGBli6rqrEAlro0g=;
 b=ZOxsSWe4bwrFkjeES0aXF0ouob99vR9+qxV8ppECDcByEgo04qcR+C/7dEtIoi35RT
 VbM8vdRItS2xPNGWmracmPhWXz7P75dQFJuQBoCxPdLLQfygebtvvBJ+qUJUp7ipeinB
 mVq1/KX6Iz12wkx/M3IrJm2jeOu6vsep71XWzRlhkoXFcs5Mz/vxJ/QiezYkKUmnjhU8
 RPDALmSlNq9cvk5W7sfQyLRlDs3E+L6HkZeiNVGSABqiVNsI8RgFyyUgRVE+gErVZ8Js
 0M3/TmN1EaSnvzEBP95dOQggHEi+lQPpcmZo3r1d+smUW5n4x/yCHI5+NO62NsGYnPFf
 UYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Le63OMzUomhO/QZ3HB9eiflAuhutGBli6rqrEAlro0g=;
 b=cvFf7z9Y+nkT+lk6MzvXVxITB3KPfEjMlP069KdS8sD7sn/I4DJvkSkGzxy8h6nikj
 YhXIIkLY9ZFDJgscx4uu/sd8ZYD6Ghwbnls5iXvFvY75jRY+whPgClu4rvK2aMDUbN/J
 nHBVWoCoT451PQl+rQlxOwSr/uZngAQ+r+P3dsRXUmhERE/AA7qPNZLObUa/WXvf4VWv
 8HRjEW99+2BSgDPEY9y/5SiBwtWZl8GtMP7tjf935Ut0E04Dfuoez9mD9E3GnB641eM8
 GeW7Os1JuMWYMEqmlfa6JwCKcxW/2iY89sju8KUXc9VzVhe+qTISwqpgIeXrYfy4fMdD
 3PFw==
X-Gm-Message-State: APjAAAWWx3pdYcTxHhep32Ap6PER9iiX8cy2ZDpHnRLSTjTmlWvEyvVg
 g4/mD7OW/JifT9KQglaEIO3lFw==
X-Google-Smtp-Source: APXvYqwo3W9dn2wToXe6Ru7++ek+Ok4WQGWEKd3a5+ycSw/+KvqJPm5Q/sCMwrLyfoxJUquMNpqiKQ==
X-Received: by 2002:a1c:600b:: with SMTP id u11mr528205wmb.147.1569338017374; 
 Tue, 24 Sep 2019 08:13:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x129sm459262wmg.8.2019.09.24.08.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 08:13:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E8A671FF87;
 Tue, 24 Sep 2019 16:13:35 +0100 (BST)
References: <20190923181140.7235-1-jsnow@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 0/6] docker: misc cleanups
In-reply-to: <20190923181140.7235-1-jsnow@redhat.com>
Date: Tue, 24 Sep 2019 16:13:35 +0100
Message-ID: <877e5xbucg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


John Snow <jsnow@redhat.com> writes:

> This should include anything I've sent so far (not including the RFC for
> more exploratory changes) that hasn't already been included in a roundup
> by Alex Benn=C3=A9e.

Queued to testing/next, thanks.
>
> Mostly, it removes unused docker files and replaces python2 with python3
> in all of the container environments.
>
> V3:
> - Reorder patches to remove everything first, THEN patch for python3
> - Split removal of debian-ports and debian-sid into two patches.
>
> V2:
> - Rolled in python2 --> python3 conversion
> - Added travis conversion to python patch
> - Remove debian8 dockerfile, which is also now unused.
>
> John Snow (6):
>   docker: remove debian8-mxe definitions
>   docker: removed unused debian8 partial image
>   docker: remove 'deprecated' image definitions
>   docker: remove unused debian-ports
>   docker: remove unused debian-sid
>   docker: move tests from python2 to python3
>
>  tests/docker/Makefile.include                 |  9 +++--
>  tests/docker/dockerfiles/centos7.docker       |  2 +-
>  tests/docker/dockerfiles/debian-ports.docker  | 36 -------------------
>  tests/docker/dockerfiles/debian-sid.docker    | 35 ------------------
>  .../dockerfiles/debian-xtensa-cross.docker    |  2 +-
>  tests/docker/dockerfiles/debian10.docker      |  2 +-
>  tests/docker/dockerfiles/debian8.docker       | 34 ------------------
>  tests/docker/dockerfiles/debian9.docker       |  2 +-
>  tests/docker/dockerfiles/travis.docker        |  2 +-
>  tests/docker/dockerfiles/ubuntu.docker        |  2 +-
>  tests/docker/dockerfiles/ubuntu1804.docker    |  2 +-
>  11 files changed, 11 insertions(+), 117 deletions(-)
>  delete mode 100644 tests/docker/dockerfiles/debian-ports.docker
>  delete mode 100644 tests/docker/dockerfiles/debian-sid.docker
>  delete mode 100644 tests/docker/dockerfiles/debian8.docker


--
Alex Benn=C3=A9e

