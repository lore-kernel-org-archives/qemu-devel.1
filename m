Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B4BC388F7
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 16:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F50206D4
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 16:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="0u4vUDJs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F50206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYte9-0003ds-Vx
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 12:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kYtda-0003Da-PO
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 12:21:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44454)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kYtdX-0005gh-Ga
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 12:21:54 -0400
Received: by mail-wr1-x441.google.com with SMTP id b3so3810773wrx.11
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5GoIoGOs2xYhQyGggnnihJrmr4GjcOgviheszQcD+3U=;
 b=0u4vUDJsxt4QbbYXINGxv4+1U1e8xTudH3R6sQza5t87j4RUvBUjEFROKtra6Rve1Y
 MyCZps0TiRdccB4ivDIcx7gb2o8qfeS7txODW4XpFYWr/WDB4ABFa8JpY5ZmZ/WYojLy
 VLBHg2RT9aZD+KUbLYCOS215sW5eq+byFDhybkvg+APkBp4lG2Q2rSpAKkuWdgoRHzJR
 DujrsxS0VJFQ3wK5NhHswJRet4pbu5mk/+r1v5hjTgISTHROQQ968hIz5mSIRAdRzOQ6
 bBsgPvAWjNWtnpXIRwAEAgbGtH4gc88NcbQqb4b7pCkBXNeDYYCPi/sJCtiq8XN7GCqK
 jSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5GoIoGOs2xYhQyGggnnihJrmr4GjcOgviheszQcD+3U=;
 b=BZaIZf2IZfKf7U/iL0ybiZKcwYWkP1GHkhDCuxz4HkWhqCKvxv64QWZcbROMmj9VqB
 z7cx3YKnOAitGnIkyBIBmL+Otm/kSNDFLIerzZ2kDRCWu5beXZM9rn5qBvYnTPrKEiAq
 kDHR13IyEvCzjPmyhBeFk6QZkUbuKp8B05BXCvuild/kczEGc34v5j/5cm5j8r1rI2Fc
 afCn52vMKaj+dSiSxICKBm/csrwJE8W77WpkGvhcsO0GEeAFBLoGXNvQ6RKTlyndOqtx
 mLQy5gUlEPuOgydqxl0SM2urEaMrJtdH10Lt++/Sy6pqVjKLKA4+uEeEdUL7K4nrVY12
 9cxQ==
X-Gm-Message-State: AOAM533IF/fIj11wAnskTAR1ZKNIF2qQahTi5YoOHT8Z1ol6j6SVbVan
 ETQ42Px8OqWm9vQvRURFoT+1CzhDoT6uE87SfTg6dw==
X-Google-Smtp-Source: ABdhPJx/oSTxsBxw5xhcAfetlbi8QP200wulWnJE6PcUwDH9SIMpGnrIcl9S9zYLAT1K4pviowxDAZsXkAYcz+2kIpA=
X-Received: by 2002:adf:edcf:: with SMTP id v15mr9615516wro.291.1604161309432; 
 Sat, 31 Oct 2020 09:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200921093325.25617-1-ani@anisinha.ca>
 <20201015165215.GE5733@habkost.net>
In-Reply-To: <20201015165215.GE5733@habkost.net>
From: Ani Sinha <ani@anisinha.ca>
Date: Sat, 31 Oct 2020 21:51:38 +0530
Message-ID: <CAARzgwwQAaJV=Mp=nB7FmCeZqmQO+gEBrkPiCWaVSESYYwGcbg@mail.gmail.com>
Subject: Re: [PATCH v3] qom: code hardening - have bound checking while
 looping with integer value
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::441;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 15, 2020 at 10:22 PM Eduardo Habkost <ehabkost@redhat.com> wrot=
e:
>
> On Mon, Sep 21, 2020 at 03:03:25PM +0530, Ani Sinha wrote:
> > Object property insertion code iterates over an integer to get an unuse=
d
> > index that can be used as an unique name for an object property. This l=
oop
> > increments the integer value indefinitely. Although very unlikely, this=
 can
> > still cause an integer overflow.
> > In this change, we fix the above code by checking against INT16_MAX and=
 making
> > sure that the interger index does not overflow beyond that value. If no
> > available index is found, the code would cause an assertion failure. Th=
is
> > assertion failure is necessary because the callers of the function do n=
ot check
> > the return value for NULL.
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> Queued on machine-next, thanks!  My apologies for the delay.

Any idea when this will be pulled?

