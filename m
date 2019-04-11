Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DD6C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 16:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27AF62133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 16:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LY/CQP6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AF62133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52203 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEd0C-00046b-9g
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 12:56:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEczF-0003Ku-4e
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEczE-0002qo-3L
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:55:41 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42277)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEczC-0002pd-MW
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 12:55:39 -0400
Received: by mail-oi1-x242.google.com with SMTP id w139so5497975oie.9
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 09:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=lrQUq1nSdHO+ISnMMhD3j5l2NJm6Xm75etVJJ478oJs=;
	b=LY/CQP6VhMpjOanAx1GtNfYGmCphgn3ZsXtmP/rfM8iunkLRpvF11A0nvMRqhGJQmP
	sufMdK0KiU2H/tEYkNc1EJmwRUryKtpikmrWeBWVj/LR2Kurb81IKjv1UQfO0S15qMZ3
	qzstJDVzQgkYLHOmiaAcZ+ZFtXmDJrkpLw642uqmklNOEq5kLEs0TXiZkFxlUYO5xuKq
	9RcGCD9eoAYpQMH1FUK5fmMW3QMzGRQFQ+MWVqWph39dxiqJ3JKUk64FV9SepHXU8DfB
	GC044+k/JZHTahL50P43Anjzqoks4qs0ABDZZCamYsaXrC2OFoUPhBEDOyCurTnu9w2T
	Q3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=lrQUq1nSdHO+ISnMMhD3j5l2NJm6Xm75etVJJ478oJs=;
	b=H6q+rzPnpjHeUpD93VJ2jKnf9l9vSRyD/v0BYz7+W8mq1uARx8yNBmK3Q6xZ5i2b0d
	3KLvpB69S+SaLcNzq2mUR66I6bJ0w/Elt9tu9fG4NtTdCQ0MOND3zwheyVYuWxzSQB8C
	qK8y4morNh2WwBpHJfICknn9iaf+Yh18v0TLDnAvaxKp4DcCOQcoXoDjT/HZWy0tT90U
	c4NjNVr99EloXuA3fgRKSxjupIxjYmU2zhTyzIhpuDcqOwQmuQtUNZr9jSitZ9k4Qvgo
	gkQdfBOYQsxiCdruolsVR9UEqm1ziztP5aXyd0a/SaPbkrGhCiXo+UPgelXjk1DNqcS5
	+8FA==
X-Gm-Message-State: APjAAAWhNTm7HZ2W+W+99aAgF7jVyf5ZW0SwPI5FyjK/ejDr+zpeQpu7
	7REu+rKkuutijVfyillLmvGJQz4urhhbN39Ls0eT+Q==
X-Google-Smtp-Source: APXvYqyDO0f9xLjQ8r/WaS68IUjgCmZPYiyg8/uolXlOta0pz59yhUUV40IoROenHtIArxNd/g7oJWL3EwW0MUABBQ0=
X-Received: by 2002:aca:b3c2:: with SMTP id c185mr7287933oif.98.1555001737698; 
	Thu, 11 Apr 2019 09:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190328062222.8409-1-joel@jms.id.au>
	<20190328062222.8409-2-joel@jms.id.au>
	<CAFEAcA_K1Rv1G-s=ndVYX6i_BvWME6ToShL6ZBpB4gnE3zdZdA@mail.gmail.com>
	<89438392-9a54-7f43-5dff-6ceeffaf9f3e@kaod.org>
	<8d05734c-2744-290f-0dbc-95f9c2502f21@redhat.com>
In-Reply-To: <8d05734c-2744-290f-0dbc-95f9c2502f21@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2019 17:55:26 +0100
Message-ID:
 <CAFEAcA_=uD6AQAd13deXjL83AQPsgxknjBE4jBRRJ9S4Z8nzZA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH 1/2] hw: timer: Add ASPEED RTC device
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
Cc: Andrew Jeffery <andrew@aj.id.au>, QEMU Developers <qemu-devel@nongnu.org>,
	qemu-arm <qemu-arm@nongnu.org>,
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
	Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411165526.FDeJMHM-AmS6c0_o-gOgsurZ5gIrEFmUgrG7JdkFmTc@z>

On Thu, 11 Apr 2019 at 17:37, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Peter,
>
> On 4/11/19 5:30 PM, C=C3=A9dric Le Goater wrote:
> > On 4/11/19 5:25 PM, Peter Maydell wrote:
> >> This is missing a reset function and vmstate.
>
> Is vmstate mandatory for new devices.

Yes, I think so. You can have vmstate that says
"this can't be migrated" if you absolutely must, but
it's generally easy enough to make it properly migratable.
If the device generally has no state to migrate it
should at least provide a comment saying so.
(I think we should add a way to say this in a vmstate,
so that we can then assert that every device sets its
vmsd pointer to something.)

Failing to provide a vmstate means you have a machine
which will silently break if the user tries to do
savevm/loadvm, which is not very nice.

thanks
-- PMM

