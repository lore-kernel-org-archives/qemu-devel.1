Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DD3C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648E021BF6
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CMTd8i48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 648E021BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvNx1-0007om-Eg
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54887)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvNuU-0004wM-VI
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:31:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvNuT-0005Db-V8
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:31:30 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36802)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvNuT-0005A6-P2
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:31:29 -0400
Received: by mail-ot1-x343.google.com with SMTP id r6so105898843oti.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n5CUP9iKngGTYQ6rCMj6xqqpG2afIWfSpULWf3AWlxM=;
 b=CMTd8i48PMxrLsjFr+fSpbmiVt37WYHsZccBV6owzAQntGFrj8EmkF6ecR0ADumr78
 aMt3GIj0WmwLtGilhfXia0GCKJo9mf8+liBY7xhXbq0C2KOJOWGlfNNIZ34IzgvFB3cr
 PKRebkbjuqanID3NgmtSc/DIWZhcK1XCt7tmYuFcpaaeZCk61Zrn583KvxUaZeXf26cc
 D3h/HdFKLujss/EQRA0Jdxp5UtxWmIoJSeKt9+fBi6T9uH9Xqd5HEd5rlLAkmydkj3/l
 eCtYwCAQbSECn9FqmdOi1iXADXCCPZiRmIz3ujjBZr1bKxC/Q13l79fpGnoXlTtq6jQ4
 gFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n5CUP9iKngGTYQ6rCMj6xqqpG2afIWfSpULWf3AWlxM=;
 b=N/KtMle8IgO+N0ohxIumhEKMM85blJ3u8hCLfUE4CZrxEiPLJzsKE+VGL2Jzvdwdtw
 /0OdovVmMCc08Qe1F5cHiIqpmbwgGVnyJGjBLlSfq1O093FetEehAiYQU2jYfuuAjwqM
 xyLfAUj9jNCLHT95s12PvDH1AO8CbvCNkNmR2C6s5hLfEd3quEJcYkBA5LSMX9vIiTLB
 O4E6WxbIBaPoNY4OkWx3zjbyMfzffd/oGdLpiezIxx9jbreSwiOXR5A6R8l8sks5nINU
 HjB3EGz6cy38s+P9jrwlGbkjQvH7WLBqBfuy35gBnIgy5+sr4oi31Ze5URKHaVfECp8u
 +jLA==
X-Gm-Message-State: APjAAAXA8at01AIwN0HIamkmmYUQZ1gFxv9orrP85w/nZPB26f9JZP/b
 NWCy5CDfG/v88zscDxa55TRql0hkXifehkr1XuG2yw==
X-Google-Smtp-Source: APXvYqwpXUh1Imr2TKG+g8UtHZKse+TN+HwU44hNPE4X27dk/x1ASoggrb9jf/ShxqCIlt28rGsrUaVqrh5eGBdT58k=
X-Received: by 2002:a5e:9319:: with SMTP id k25mr10482751iom.137.1565191882962; 
 Wed, 07 Aug 2019 08:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-13-damien.hedde@greensocs.com>
In-Reply-To: <20190729145654.14644-13-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 16:31:12 +0100
Message-ID: <CAFEAcA95fPLh=KgYFgtCxrXR5Vm89-=2fPq-psYYiiJ84j4qvQ@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3 12/33] hw/pci/: remove
 qdev/qbus_reset_all call
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jul 2019 at 15:59, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> Replace deprecated qdev/bus_reset_all by device/bus_reset_warm.
>
> This does not impact the behavior.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>

I'll come back to patches 12-28 later. They're all ok
in principle, we just need to check that in each individual
case:
 * we've made the right choice of cold vs warm reset
 * we're ok to switch to 'reset including children' from
   the legacy 'reset not including children' semantics

thanks
-- PMM

