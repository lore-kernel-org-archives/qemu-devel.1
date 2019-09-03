Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95754C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 604BE22CF7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 08:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="ve8TV1t9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604BE22CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i54Ps-0008VA-E2
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 04:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bishara@daynix.com>) id 1i54OR-0007hh-Nr
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bishara@daynix.com>) id 1i54OQ-0007hu-LC
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:42:27 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:41061)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bishara@daynix.com>) id 1i54OQ-0007hD-8K
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 04:42:26 -0400
Received: by mail-io1-xd42.google.com with SMTP id j5so34051648ioj.8
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 01:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XbkdfiK9mc4CfF+qgibQ1f0i1zBsATB537JIUIRS5Vk=;
 b=ve8TV1t9q4uXs+cAFOtg2WM5PA9ndwuKWIP8Z8ij8+8nAOsmY6SuvuArLqaFJn8WZd
 OYyQsMY7UHoml0gcJ4fOExOVDAsTFHRrd48iDC8oDiFGGiPwFnTJjyKsCgtL+tFdmPkR
 /Mwz0mCF6rLz4pIYPUHDouQW0Cr6QCpvsLWJsDHmfZfGJjkYvDTO2QGlIrE0eguc/eAo
 8+JstNaSldQOGf+x60Br6rc5v9tDvNHIxQdOWqxBp6uIE4/mTKpK42tg6DqOoykLk4oL
 b4vA2jpEvFpIhH/9EKK6UeX2eMihK7/3NmTO15CKf4IAIZ7aWP5RNcLIjt9nWn9L2NXO
 MeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XbkdfiK9mc4CfF+qgibQ1f0i1zBsATB537JIUIRS5Vk=;
 b=LaTcFhjyUnJRBmYDVg92UwkTgwK0klhcU4ZS/DzSLMwhnIFWYjrsQZjb/8/IdW6jcw
 J+DrOEW8Vq6+KyZ0hCsUvnYLWnud/y0NoY7OaecSidnHhwKoARJq+FpMO7NcVmpij+IE
 6/PabDWCe7d3oDRMi9QmWiT65mf64NFbVxTktkIgXHMq78SSM5QsYlee9gTGTD7ZrQSO
 VYGI5Jfk0sZhWzhLSTIyT5WKYm7pdSfq3kOmaEG1Lsi/8xZ+h1YYTu5+RaMGj0cFVCJb
 0kVfOKWzgp7TyZP7FNg44D5gcdrIMkAgqizmqPqDJ0+w1F9/ykwp4EpQa8+lHJACc5oN
 W6sg==
X-Gm-Message-State: APjAAAVLV3n8g1Oti0j3boencrwBnSL6EJoCRQE72TXwfD96rBVfpXqm
 W5nR1w78LdhsVx5oE7xN1cxHwcoWHEflLCkiy0N1HfjU
X-Google-Smtp-Source: APXvYqx79CYeTCuFSdhSzvdpft+JXB/6VbsvwoiQ9VGQ9qaseIfpM6G9vOdKAwDqxkWTfCQJo9NNQ6KujnKNq+fwWv8=
X-Received: by 2002:a6b:ef09:: with SMTP id k9mr8259957ioh.61.1567500145186;
 Tue, 03 Sep 2019 01:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190819131620.1302-1-bishara@daynix.com>
In-Reply-To: <20190819131620.1302-1-bishara@daynix.com>
From: Bishara AbuHattoum <bishara@daynix.com>
Date: Tue, 3 Sep 2019 11:42:14 +0300
Message-ID: <CADyT_0W8AXCaEnGBjnf04NfzJZHe+SHM2jNV9=5hCuhkvQjCkw@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 0/1] BZ#1733165: network-get-interfaces
 Chinese NIC name
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
Cc: Yan Vugenfirer <yan@daynix.com>, Basil Salman <basil@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PING

On Mon, Aug 19, 2019 at 4:22 PM Bishara AbuHattoum <bishara@daynix.com>
wrote:

> https://bugzilla.redhat.com/show_bug.cgi?id=1733165
>
> Uppon renaming a NIC to a Chinese name and invoking the network get
> interfaces command, guest-network-get-interfaces, the returned name
> field has the (\ufffd) value for each Chinese character the NIC name
> had, this value is the indication that the code page does not have the
> decoding information for the given character.
>
> The suggested fix is to use the CP_UTF8 code page for decoding the NIC's
> name instead of the CP_ACP code page.
>
> Bishara AbuHattoum (1):
>   qga-win: network-get-interfaces command name field bug fix
>
>  qga/commands-win32.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> --
> 2.17.2
>
>
>
