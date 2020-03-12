Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0A7C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B1C20663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 13:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F38wJAdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B1C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCNie-0006WV-QD
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 09:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jCNhi-0004mP-6d
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jCNhd-0003Zi-1a
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:16:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38068
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jCNhc-0003We-TD
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 09:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584019003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CF6Pu+8Rvbo00lwLLN/U2Sg3wr6R9K7gulVnFZMuX+8=;
 b=F38wJAdUXFQ0L0vlTvaKE3l8cfjcCTN4SoBXwTPbvMBQChAaPlhj9xABB8Nvp8D/UwauJg
 cfj79OKrZn810QsSEGFAFOhAwOZ2HzNoVqfMeEXy5G6lK37foj3rNwz/ux9XVUWML+xmnk
 PubZ39dUYKH3hQrsKLlEZhaJyL0IOxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-FIfQNOpXP82xIqmOqJzJyw-1; Thu, 12 Mar 2020 09:16:37 -0400
X-MC-Unique: FIfQNOpXP82xIqmOqJzJyw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32332DB60;
 Thu, 12 Mar 2020 13:16:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-34.ams2.redhat.com
 [10.36.116.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F38129CA3;
 Thu, 12 Mar 2020 13:16:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8311211386A6; Thu, 12 Mar 2020 14:16:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 31/33] docs: Stop building qemu-doc
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-32-peter.maydell@linaro.org>
 <87blp3x7rr.fsf@dusky.pond.sub.org>
 <CAFEAcA9EEuAeKm8kXtSJUtm6F3=VfyMxOkESvrZzoVt87HwKpw@mail.gmail.com>
 <87sgiertt8.fsf@dusky.pond.sub.org>
 <CAFEAcA9PrO+=pVyh1DR2Xh=apkZAXw0_aF=RxUmG=kR5VOdeDQ@mail.gmail.com>
Date: Thu, 12 Mar 2020 14:16:34 +0100
In-Reply-To: <CAFEAcA9PrO+=pVyh1DR2Xh=apkZAXw0_aF=RxUmG=kR5VOdeDQ@mail.gmail.com>
 (Peter Maydell's message of "Thu, 12 Mar 2020 10:11:34 +0000")
Message-ID: <8736adr9vx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 12 Mar 2020 at 06:06, Markus Armbruster <armbru@redhat.com> wrote=
:
>> Would it be possible to additionally render a complete manual as one
>> humongous .html?  Without an index, there's only search, and the
>> ergonomics of searching within a single page are so much better.
>
> There is a "build one big fat HTML page" Sphinx builder,
> I think. But again, I'm dubious about increasing the number
> of supported output formats -- it's all extra makefile complexity
> and more things to get right in 'make install' and so on.
>
> PS: assuming you have js enabled, each HTML manual has a js
> search engine built in, eg the 'quick search' box at the bottom
> of the LHS navigation bar on
> https://www.qemu.org/docs/master/system/index.html
>
>> I'm tempted to write a trivial QAPI doc comment backend to spit out
>> minimally processed doc comments as one plain text file just for that.
>
> What would be the difference there compared to just looking
> at the manpage? The manpages don't have the full content
> of all the HTML manuals, but the QAPI reference manpages
> will have all the QAPI content.

I forgot qemu-qmp-ref.7 exists, and missed Paolo's hint earlier in this
thread.  Thanks!


