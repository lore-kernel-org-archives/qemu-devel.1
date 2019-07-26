Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCC3C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374722171F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bhme8kJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374722171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqwv0-0000vG-Dm
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 05:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34164)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqwuj-0008T5-FR
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqwuh-00014L-9R
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:53:24 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39177)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqwuh-0000dZ-1s
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:53:23 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so48726875otq.6
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 02:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8/zxFG7fs7eX2hPQEfAZCLHElnB7YA3Nq3L+pmViSn4=;
 b=Bhme8kJhr8659lKH/SpqUstNwSXQxVLuS/xVb6Ag7/URRPCkVfRc/dhfog5+rsnst7
 BVJJhLl51JORF4jGX1Gs5VTwXrPNErpzmyeNUPMbH2kOeoCHR8eBanqR8XJNTawXbgS3
 kt89Kqkcm5PdlW5IJKUIlINbe7WNJmiOQwx4y6RJESHSyLWZ35ZLgJiAUi32ahK3k9lZ
 azfSFr/mmUNuoqCUis6FEpwN9GlAWO3k3jPXYgeUhafhKzdjB+UqgBoj9swldL5AlfgX
 y+yvC2ZX07iBjD7ie2wjTd0aryN3b4xH8bFcvzvRfsjyZ1rfMKEx7ZpreXmotMtXEh5j
 swfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8/zxFG7fs7eX2hPQEfAZCLHElnB7YA3Nq3L+pmViSn4=;
 b=sw7DisyLPmPuOoYRU68uD3n5LQ13VL41uwYt7c7q3J3xac+KZR7QoF7uhVPEzmJqJp
 Snk25hmUP4aLgIF4821AEvHJjuHNbkkMTUOBUoJG+KLCLZp5+/7C55SlKt6OTwkQeUVz
 AnQZ0o7mGTjEgjO4/ETibkpwa32eNTceE6Z1nw/P5KssWo6ul7fm2Deb8N+b/FEcgkRx
 wkyfLCgqcZOrzKimOSRTLJubC8/Kquhv5EnKWCUsquab63RDfeg8HZDdvCj6bsm3vtjR
 +SQtv49FJEmgtnHOyArQf5pJDcoJaNV7TprhLjcousuitInNeR7XuMSl6n/rek7Ofbxs
 Un2w==
X-Gm-Message-State: APjAAAV7u7xIixS3jx0EgIoK/Ru0rWdSLTxjgwVHiAFJumcyoxOdKv1+
 BfznQnwDx0QU+5uSt5cW4OJp8+YpI3CkAwZVSfX5PA==
X-Google-Smtp-Source: APXvYqw+GJ+sQPoOsFOXAQAHg1JmMQFlZ+QCxvsO0z00H/gp/aAEkLXnAJlmoUlL+vWg4fjK1OG7I62eMA0pdwye+CU=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr65032383otj.97.1564134796229; 
 Fri, 26 Jul 2019 02:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190725153059.7313-1-mst@redhat.com>
In-Reply-To: <20190725153059.7313-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jul 2019 10:53:05 +0100
Message-ID: <CAFEAcA_OVGeWkz4FK51N9K=jLqXHD=fH9SJ3QQJgfmRAiN7OaQ@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 00/12] virtio, pc: fixes, cleanups
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jul 2019 at 16:31, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit bf8b024372bf8abf5a9f40bfa65eeefad23ff988:
>
>   Update version for v4.1.0-rc2 release (2019-07-23 18:28:08 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 1b47b37c33ec01ae1efc527f4c97f97f93723bc4:
>
>   virtio-balloon: free pbp more aggressively (2019-07-25 11:19:25 -0400)
>
> ----------------------------------------------------------------
> virtio, pc: fixes, cleanups
>
> A bunch of fixes all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

