Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5009CC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1840B208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLv7g4ng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1840B208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw2DO-000701-Do
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 06:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59297)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hw2Cl-0006Lk-Ky
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hw2Ck-000535-KJ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:33:03 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33311)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hw2Ck-00052a-E0
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:33:02 -0400
Received: by mail-ot1-x343.google.com with SMTP id q20so130616220otl.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iHVoPg+8BuMUDlRpKhiGjRvydQMjhoEPdvVwBi/uiOQ=;
 b=QLv7g4ng3lh5Qnv5En7uENfWjgwQA8fKIhZfE7YIk4MrGSJ8fbPy+0SogZ71vUvRzD
 QfUTB3Lv03aTFnQwjGISq8gw0AA1QXQ9tfl1qtPIa3G8MX5Vt/5ApEbWa+rwYBycFWdU
 Bp4fpfUiFXWfDw880ZGbWctruf0vDHu9F7NTUpNKOff+nlNtOD9cMPgZkZm9Yyt0rEAD
 rIQBQpnDyiKDc6oEYB1pn64bqfcK2t67/GS180/UNZefgt/G5hACwOjVhekv56Xmli0l
 9HKTybXNq0t1DMPx+ZjZC9fLUrjl5shlLps6NhvI1KwyXVKqyWjCRP63pKPdWkOPmkeX
 9j4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iHVoPg+8BuMUDlRpKhiGjRvydQMjhoEPdvVwBi/uiOQ=;
 b=TsUD2/uaHtWMQiMvYYAZ1OF8aUtKQPSlqMdcVUO07+oBadvvymaWLC55LRfyMoKxyJ
 GtjPYCxKXeTqZYJepB4Adc6lhCHfYeTB3v9LAYg23D9cy26sOuRCirqx9XsBEA1PeHvE
 OXdLuBIZCgROhj3BDabyy9+r4uiFsedxWtD1N6P7ChU8wt596psf7E3/qTuqHcwn9eJc
 S6l4JtuIShHOi0ZG/YWx6Q/JwC4Dkk5R600VKOkn6Vb83Oy5fNF4wkzjxelWcJ9XgFKo
 ugORalYe0lcGyMMobjhTLIfZkZU79lP2tr7T7/Uy07trdiAIqQ51TfPtQnCMVYrPhk6g
 Wp2Q==
X-Gm-Message-State: APjAAAWhls40afTpFvVeKWLaheb0d3iXz6HnhmbvyAXcvNYR22xAmzjn
 R/PDz9R4MuTUNY2JZ7WtRHaLjPGCaDpJR5cbPNrCqg==
X-Google-Smtp-Source: APXvYqwB0pVAE7PlOcKu7KFUe0zDVZNXri0BWEvY9oxZWQOyah9YI6RXaQESd7f6jfYabkMIXqJ+9LWSPe9G2bZ2Vdc=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr17853726oti.91.1565346781848; 
 Fri, 09 Aug 2019 03:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-8-damien.hedde@greensocs.com>
 <CAFEAcA-W0SaaGbUnGZ0b61ngxKY8R9xjwGXeN+=MaUi4bMDgNg@mail.gmail.com>
 <20190808154219.GK2852@work-vm>
 <CAFEAcA8L2YVMCu3Gb+eQTDfCpgVwA_WwVPrqPLV2iQ9rZ4HuTA@mail.gmail.com>
 <f400248f-7a3b-83e9-3355-77de359e3f43@greensocs.com>
In-Reply-To: <f400248f-7a3b-83e9-3355-77de359e3f43@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Aug 2019 11:32:51 +0100
Message-ID: <CAFEAcA-YjLA25wPBgWOB_c2fV2o7C8n=1-uUVe6xgiP=j5+Fgw@mail.gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v3 07/33] automatically add vmstate for
 reset support in devices
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
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 9 Aug 2019 at 11:29, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> One way to keep the feature without copy-pasting vmsd would be to add
> a new vmstate_register with an additional argument to pass the base
> class vmsd section and handle the whole thing there.

If we have a vmstate section which contains no actual data,
only subsections with 'needed' functions, is it migration
compatible with previous versions in the same way that
tacking a subsection onto an existing function is?

thanks
-- PMM

