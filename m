Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419AAC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09DC620989
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 09:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMMcrm/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09DC620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54349 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ7dt-0001zY-Bl
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 05:53:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQ7d5-0001a5-BX
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hQ7d4-0001nF-66
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:52:19 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34190)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hQ7d4-0001n4-0H
	for qemu-devel@nongnu.org; Mon, 13 May 2019 05:52:18 -0400
Received: by mail-oi1-x241.google.com with SMTP id v10so8851746oib.1
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 02:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=PYvG6NjDQGH3CIQ0F+yQtd6Ko0eXE8yTWncx9BJJ49I=;
	b=CMMcrm/A8vdWYtGmanPD8GeVL74Mrtfem9uLPz2QNHON5ldw08ReuLpK1zD8nQsn6r
	hfClK/h1hMdbJNxCZqZizBnjnXbBy/0dQW3RyR3rFgbmwgkONGz39YVbynhbEE1TRJgF
	ziJeNdHWFhmmScC19FBIhLmUBeYkVjPhUCr/2laZ7CMcAHpIKtgO66gsvyw+gWBL+hma
	96Kj3/VBPtsmn4gCbkl/AYqU3kTNDDE5nWjclsbeC3kh3h+C/pGu1IAgW/+7+QUCq5mb
	WAKZeB2VfOUEZDxwLbWO56EfTiQn8MUxOAbFmZOMTXYK4/SBX7p9v+leayehvgXgAiMS
	sDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=PYvG6NjDQGH3CIQ0F+yQtd6Ko0eXE8yTWncx9BJJ49I=;
	b=YFhLOv2B6aMHJelL2sYjdD7jVEaNMs7LjP2OAbeqlDbj9PSFmydadIWOjlnKuchsYo
	UnM0/aQYKtKBSLeqMHVOZRQKG4WMkzsVvqo1JceAPW3awk3V3AbCiJ00pgnQ3g1Ys6RT
	YoL4d256bjUgl9rX56F1PXkDym9M470oL+fWEqbWs7qujiSk5gdlqIiV2yW9gsSo7aQ3
	qmlykFMKo0hbfr6pIKzEjDtjcxCvCNEiOlILtmmIX37TYk3hGpAYhMnFcSbE9scnkgFe
	nRgHM4fiG/H+oKHnmrXL5v3A6jEw1JGGL1f0vFmDL6K5PSylgs7IViynQUjUz0QmtpeB
	bhRA==
X-Gm-Message-State: APjAAAUOrlfqGRTFZSe50a+4TNcPnhQNJiS6rA0mdoGzo6IzUt7w4Oj0
	/jYFaZ89a//JRclli4X7pPKTDLtLSYzZYZclbXlxXg==
X-Google-Smtp-Source: APXvYqzyhkhEJnU7/HDVMAM217XpSdW0vYjlzq8vaJPV+PyQAnCmN+UZgweYJKgygbvpKJ2PQcdeIcTRO+sQ71mjyZY=
X-Received: by 2002:aca:845:: with SMTP id 66mr3172404oii.163.1557741137334;
	Mon, 13 May 2019 02:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190512083624.8916-1-drjones@redhat.com>
In-Reply-To: <20190512083624.8916-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 May 2019 10:52:06 +0100
Message-ID: <CAFEAcA8vY7WVws3rOqKxsaNTDSboecOeS4DM5rdsEZHt4Lkv-A@mail.gmail.com>
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 00/13] target/arm/kvm: enable SVE in guests
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Markus Armbruster <armbru@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	Andrea Bolognani <abologna@redhat.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	Dave P Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 12 May 2019 at 09:36, Andrew Jones <drjones@redhat.com> wrote:
>
> With the recent KVM guest SVE support pull request [1] KVM will be
> ready for guests with SVE. This series provides the QEMU bits for
> that enablement. The series starts with the bits needed for the KVM
> SVE ioctls. Then it enables the arm 'max'cpu type, which with TCG
> already supports SVE, to also support SVE when using KVM. Next
> a new QMP query is added that allows users to ask which vector
> lengths are supported by the host, allowing them to select a valid
> set of vectors for the guest. In order to select those vectors a
> new property 'sve-vls-map' is added to the 'max' cpu type, and then
> also to the 'host' cpu type. The table below shows the resulting user
> interfaces.
>
>    CPU type | accel | sve-max-vq | sve-vls-map
>    -------------------------------------------
>  1)     max | tcg   |  $MAX_VQ   |  $VLS_MAP
>  2)     max | kvm   |  $MAX_VQ   |  $VLS_MAP
>  3)    host | kvm   |  N/A       |  $VLS_MAP
>
> Where for (1) $MAX_VQ sets the maximum vq and smaller vqs are
> all supported when $VLS_MAP is zero, or when the vqs are selected
> in $VLS_MAP.
>
> (2) is the same as (1) except KVM has the final say on what
> vqs are valid.
>
> (3) doesn't accept sve-max-vq because a guest that uses this
> property without sve-vls-map cannot be safely migrated.

Is this "migrated between two hosts with the same host CPU
type but with different kernel versions which expose different
subsets of the host's permitted vector lengths" ?

thanks
-- PMM

