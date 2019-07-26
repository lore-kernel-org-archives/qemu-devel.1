Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98646C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:40:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0212173B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:40:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LXDRQpGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0212173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1OO-0000P9-KF
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36272)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hr1OD-0008Jt-UI
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:40:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hr1OC-0002T0-OR
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:40:09 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:36680)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hr1OC-0002RS-Fq
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:40:08 -0400
Received: by mail-ot1-x330.google.com with SMTP id r6so55563437oti.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 07:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j/nFcTwkWtLc6rBGbbdXYiER7XUV/0GRL6Bm7UQlX18=;
 b=LXDRQpGpdgMmBcVIo5fJeNkKJtyKiV4nZzVR34s+AZ/JQ2IXV5jYEbx6HqStyTz8xS
 rZFdas/i1Pi5/NGlbd+s+pFFBtaCCmusy4ClaWvmKz3r0il66PoBE5+xdJYJWdwYhxlW
 1dvpNbnkiDrFjVOqZXeNaJEsSF6KDJW6lEkqv5bjDyIPEAHLgi1fl+TyvZesKUQNahH9
 7pptrH/vUzwnTJnF20k8CT/aMrMAr2/XLCjcKPjtcU0oCo/OE5sIk6ZT90eOoT24F15F
 +bP8RlPfmx16rXzY3z+bzEsVsWJwoHXGhJyaEWFBgCObHoPdzdSYe7Lsghj0jSaq5hNd
 eBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j/nFcTwkWtLc6rBGbbdXYiER7XUV/0GRL6Bm7UQlX18=;
 b=NZCj75mxxYdrO5EMVFuxJp59HmgEdWqm84k4Zd0dBP6kEUsP2mbqPdvVwIKzJfPZQw
 WpmC9Rf49agtVxkWzihghocV3oy3MPByVv6f2hWJnRzaP04IUkJSfj1gXNbkksaNl+tP
 rp5xkcSoj6HXpzWEJjUHel30gmuYAAir6+2ile+v59TNQ4q/FeTHOi6ttMQwGNPxj9Ii
 yEz0jsg7sKsuumEvjAs84kYGH7P8dt/CEzjbmvF07IeVcJFC/0//5JVW+L/UWYXCfLfb
 dmfrr9MwxNlivoQqYHPLHbK5mY3sqYBz47gi8lZvi0apqHX0XAgddG2ucdpOjA8MwB+U
 1jig==
X-Gm-Message-State: APjAAAU0mc8E+7zenuX2Z9pdrod5MCFyykfFHDwRrPYW+iSPNcLax5vx
 FL5Y8igl1YtQP+oKm3xgzgHK1nOytK2Js3fVHeBdDg==
X-Google-Smtp-Source: APXvYqyQgmBn4omwaBbRNUdfJC1zpHasOrETwHLtUd8JOHFYe7qhyE/mcADr5MA+50FhJAvMba1aGX9zXzN2XhYkVJ4=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr11673945oti.91.1564152007613; 
 Fri, 26 Jul 2019 07:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190726112728.20889-1-cohuck@redhat.com>
In-Reply-To: <20190726112728.20889-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jul 2019 15:39:56 +0100
Message-ID: <CAFEAcA-JiZ=nd+WUCjWSgB7ZCeFNtaE18Me4KC-SSdeCPmUdyg@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
Subject: Re: [Qemu-devel] [PULL for-4.1 0/1] s390x: vfio-ccw maintainership
 update
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 at 12:27, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit bf8b024372bf8abf5a9f40bfa65eeefad23ff988:
>
>   Update version for v4.1.0-rc2 release (2019-07-23 18:28:08 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190726
>
> for you to fetch changes up to 6ef2d01abf44fa86f2de4bcde3be9391259bf718:
>
>   MAINTAINERS: vfio-ccw: Remove myself as the maintainer (2019-07-25 09:36:14 +0200)
>
> ----------------------------------------------------------------
> MAINTAINERS update for vfio-ccw
>
> ----------------------------------------------------------------
>
> Farhan Ali (1):
>   MAINTAINERS: vfio-ccw: Remove myself as the maintainer
>
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> --
> 2.20.1


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

