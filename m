Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F771C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:00:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE8DD20730
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IsK0hTi7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8DD20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWelN-00009E-Jp
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 06:00:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWefC-0001kP-5H
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:53:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWefA-0004U9-Ts
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:53:45 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33041)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWefA-0004Tt-O5
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 05:53:44 -0500
Received: by mail-oi1-x244.google.com with SMTP id m193so14906313oig.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 02:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LDS2clqXd1WZMxyt8Nr0cC44oIYHq9iIYN4EiU+5n5c=;
 b=IsK0hTi7GTQe26jY6Qnd47DPrPGXZ0hcaGQ9ZcJNeXY77OBXe2pMSmusTdnqsUtqtQ
 boQR1uKFRZqN+APG41zA/VU/Q8jbVXhggtRYwvwGbQGZeU/lwIeAlzrG/1QZ42gtPUA2
 zMlzr+OVfHqd1e41K52NNloZHVNBdVIUyzYrpYW3txM9HLiFp59XE/W2iGh8xcqQ3Qmb
 W3DvInG3sX8bJx0rgeVhP5rXogMnBbnAX6y+q9kAcwQOG64WFM8PuanS+OPySr2Ea1fl
 jGxMP89sK5V3nKc3gge0CB0SiA7NQ8moty8t5nYEcGVgHVZndpjZBK/A4bSAKM6UXktu
 nH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LDS2clqXd1WZMxyt8Nr0cC44oIYHq9iIYN4EiU+5n5c=;
 b=uEkfKAp8dj86jkVf2kduZd/pNni7X1OdAOvA4CpIDUlMEtdGVN9Ox/FmSjNZztSr+C
 pF6kx7iuNOzbchomMsCdKW371hCGdL3sj+fHpg9IzwOgbpLGsGYELJZhAWIZ6i7elpFu
 woFWgQGNBta+amgtOvw/xGfWnh9Gzv4fk5H0iJFLARgC+mDI2CwXZ8AScEksdwTYWcgh
 vstqY7H/+e1Q5YsjbCetgi5uGkx/LIX7e1q/2uumwVAcniXy3fWs1JhDu65z43Nt6LGr
 2GZI9um/HlRCMyN74SGLUD88BMVBUdG53EDySSUeii1NVActawH/8f33dgMNcCRs3SAw
 Lf1Q==
X-Gm-Message-State: APjAAAWHuLsqOCFcDad2qsqIWaHSEg2iG2Nhb8K1sfi065heOQ9mul/K
 lvwx9PDBae+N5xpvMrH7VFJhpikP2mFApGi9aZ0d8Q==
X-Google-Smtp-Source: APXvYqzcCF3ngXxmg9F/uAZ3b0/f2PYdVT8O/ZCusb22OplIH5jf5uoqYFalNGD2IbsGuJ7CHlp9xnwwJMjlLVXOoRg=
X-Received: by 2002:aca:4945:: with SMTP id w66mr20181631oia.98.1574074423824; 
 Mon, 18 Nov 2019 02:53:43 -0800 (PST)
MIME-Version: 1.0
References: <20191108110714.7475-1-david@redhat.com>
 <CAFEAcA-mD3-Zg2JunGpMqbcaT1qboCenhqEFytZD0FmFcL2i9Q@mail.gmail.com>
 <5dd613c0-6d9e-b943-b64d-7ba1791cbefe@redhat.com>
 <CAFEAcA-4r53vM-K24WYr1OFSOufhZ7hDHeZBhnywyaJ0gpMO1g@mail.gmail.com>
 <20191108191057.GZ3812@habkost.net>
 <CAFEAcA_No5oAFtULbAOrPDeQE18HHgc0agXbs4m2AGZ+gK_ReQ@mail.gmail.com>
 <66c64c6d-b7c0-2cb1-2b29-4fdd9b369714@redhat.com>
In-Reply-To: <66c64c6d-b7c0-2cb1-2b29-4fdd9b369714@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 10:53:32 +0000
Message-ID: <CAFEAcA-Q7H9sZjN-PcMMDHQU41yN1RdXhNY5KqMh7E6xh0yjgA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] s390x/cpumodel: Introduce "best" model variants
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Michael Mueller <mimu@linux.ibm.com>,
 Jiri Denemark <jdenemar@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 Nov 2019 at 10:47, David Hildenbrand <david@redhat.com> wrote:
> My personal opinion: "max" really means "all features". If we want an
> automatic way to specify something you requested ("give me something
> that's going to work") we either have to change the definition of the
> max model for alla rchitectures or introduce something that really
> matches the "no -cpu specified" - e.g., "best".

I don't strongly object to 'max' including deprecated features,
but I do definitely object to 'max' including by default any
experimental (x- prefix) features. Those should never be
enabled (whatever the '-cpu foo' name) unless the user has
specifically opted into them: that's the point of the x- prefix.
We need to be able to tell from the command line whether it's
got any non-standard weirdness enabled.

thanks
-- PMM

