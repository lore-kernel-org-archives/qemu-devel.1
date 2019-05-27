Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE1DC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 18:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D119F20859
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 18:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Azk5lcfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D119F20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49567 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVKno-0001TK-1i
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 14:56:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVKn1-000170-Sz
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hVKmz-0000aV-U4
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:56:07 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hVKmy-0000Yw-0S
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:56:05 -0400
Received: by mail-oi1-x241.google.com with SMTP id z65so12492444oia.11
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 11:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=o95Pvvyn8ElGhUsAzXaeSD6n1F4JHQtTGH9f+bBSfms=;
	b=Azk5lcfs+zMsp1sx6VOvQ8StC8yzkEeLK/xoxa0pDBaGUsOy9JXEQs+ZbM5ddT+V3e
	D70qj0aDnOe3tbA2YJs8GO76hQrL3hfjWuaUB8goBewzQ0IweuoPT5e4MNmp5KEp/fhj
	uA6CDNtQ7eneKpSc4uFrdtPrZG9hWaA2UMu7USrF5orhn/tibDgWn2MR60zgKk4lhV4a
	Y5CHQLoj6yAWmHAGna8Uq60fXmlLeVaXEGyy350nghflX1w3xJytq0NjEP9XPvN+ofjr
	9Lkk1sfBrL5pkeNuqpZ2AfQ+rZFe31zxKOu12E1/SU6/EKIgq3UzvuV6duTdE9gTC/3U
	ULDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=o95Pvvyn8ElGhUsAzXaeSD6n1F4JHQtTGH9f+bBSfms=;
	b=GAh+3VGUfW8pFgEGqKCtkOQC+QyDAGatGgi4tHqA5wJ9suStP7n8g0hTUvewFjBFrR
	JjwADOUzNxvOAUw6/ozS2cZy6XWUDKHnvs07i9t811OJZt82cUnIIFGh/UnjAtKOhdEa
	8E9S0rENKQ91p8LluJCcLcpLD0DsIju92JWU9a9DEzFMTShChQqpx3WZCh/boJEH4i8Y
	W+4azIMRDy0Z/IfSo6P/6EiMj+PglNlu7hc644mXxByVfXVYkvaq58veYpRvgWu4Aca7
	Zb+plQ8pXpJxGZY8qqv0oq2r/e8tOiJXTIAk0edISR/u6zmGhwEVVIrX0FWU86qpkw/K
	4fQw==
X-Gm-Message-State: APjAAAVa5DaCKP/F1Sg3Z5lYAHLd5jawmPUW0Awbkx0OC/+U6p3YrcoE
	dgOKVOyWFWKnDF7iBZmrO2jtwLQGHymBoR9GmSCh6g==
X-Google-Smtp-Source: APXvYqx5bmTKdTQPK/6LpYKyinF4koO0XM/olh85XrgNNB082TasGUZ7oJEF5xqS9qnkhOat5DlqyezU4aTWf70/JVQ=
X-Received: by 2002:aca:b1c1:: with SMTP id a184mr273184oif.98.1558983362584; 
	Mon, 27 May 2019 11:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <51df31ee-54a1-d7be-bef4-71ae003b8811@redhat.com>
	<3fab9e76-53ad-2de7-45df-eb69c8604709@redhat.com>
	<016edc53-278e-cc58-0061-d2c5de80afd2@de.ibm.com>
	<1ddf0d83-ce0c-f1c9-065d-ff88ddb9293b@redhat.com>
	<60d1bf3d-659c-d199-6592-d3659702d754@redhat.com>
	<d38b05af-effc-97a1-0b4a-a0d44a13f769@de.ibm.com>
	<CAFEAcA9K+d+LM5SfDrX0Ljwq8zWQdmJAM4R4cdHhF+tM1F13LQ@mail.gmail.com>
	<87v9xw1gi4.fsf@dusky.pond.sub.org>
In-Reply-To: <87v9xw1gi4.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 May 2019 19:55:51 +0100
Message-ID: <CAFEAcA-eCdmqgM1vSd2Ju4j9mqnrMZ_Knr4oQEsczLM4Wq_Pdw@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] hw/s390x/ipl: Dubious use of qdev_reset_all_fn
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x <qemu-s390x@nongnu.org>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 May 2019 at 08:52, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Suggestions for how to restructure reset so this doesn't
> > happen are welcome... "reset follows the bus hierarchy"
> > works well in some places but is a bit weird in others
> > (for SoC containers and the like "follow the QOM
> > hierarchy" would make more sense, but I have no idea
> > how to usefully transition to a model where you could
> > say "for these devices, follow QOM tree for reset" or
> > what an API for that would look like).
>
> Here's a QOM composition tree for the ARM virt machine (-nodefaults
> -device e1000) as visible in qom-fuse under /machine, with irq and
> qemu:memory-region ommitted for brevity:

virt is a bit of an outlier because as a purely-virtual
machine it has no "SoC" -- it's just a bag of devices
at the machine level. It would be interesting to
also look at a machine that's emulating something
closer to real hardware (eg one of the aspeed machines,
or mps2-an521).

> Observations:
>
> * Composition tree root machine's containers are not in the qtree.
>
> * Composition tree node cortex-a15-arm-cpu is not in the qtree.  That's
>   because it's not a qdev (in QOM parlance: not a TYPE_DEVICE).

Hmm? The Arm CPUs all subclass CPUClass, which subclasses
DeviceState. The CPU is a qdev, but it is not in the qtree because
it does not have a bus it can live on.

> Now let me ramble a bit on reset.

Thanks for this -- I have put this on my list to
think through in detail next week.

-- PMM

