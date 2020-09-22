Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D134AC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 14:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF6F2396D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 14:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WR+ofLTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF6F2396D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKjVn-0003ko-Od
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 10:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKjUk-0003H5-C3
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 10:42:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41216
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kKjUh-0000ns-Sf
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 10:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600785730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C7gPHXOam1qtJzeVJKrwnIvYbOgcIDShM/Syiys8KqY=;
 b=WR+ofLTpj5EZSeDQGxGMSciQrHvfBPTyby33HNFMfCM1uKBU9I31DSzoQztbff4pRVbva7
 pLBwa8V6pSD26huIllHADVDwiyQFGZtbg6xubJP/wxQiPn0cY5wfs3lxPGS69+7DRz0ssq
 w2qJn93LBXplr6iBc24tlU6ahij3WyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-jbTIy_yBM8yTjS1wSEENQg-1; Tue, 22 Sep 2020 10:42:07 -0400
X-MC-Unique: jbTIy_yBM8yTjS1wSEENQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EC39801F99;
 Tue, 22 Sep 2020 14:42:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DED3E60C05;
 Tue, 22 Sep 2020 14:42:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 74ACF1132E9A; Tue, 22 Sep 2020 16:42:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 10/20] docs/interop: Convert qemu-ga-ref to rST
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-11-peter.maydell@linaro.org>
 <875z8t7kd0.fsf@dusky.pond.sub.org>
 <CAFEAcA9ZPO32XC1NwH=qa4mNF8c_xZeW8Z6MTrJ0FLmB6kytXQ@mail.gmail.com>
 <87wo0mqavm.fsf@dusky.pond.sub.org>
 <CAFEAcA8uYhrpsYM5u+0MJKOK3R_NwPefC1jdJMYF3VWohe4mfA@mail.gmail.com>
 <873639q4qx.fsf@dusky.pond.sub.org>
 <CAFEAcA-8VMwkYJFUepFqodrnMu1Y-kGeEM+bxFYNGqw7ybTwSg@mail.gmail.com>
Date: Tue, 22 Sep 2020 16:42:04 +0200
In-Reply-To: <CAFEAcA-8VMwkYJFUepFqodrnMu1Y-kGeEM+bxFYNGqw7ybTwSg@mail.gmail.com>
 (Peter Maydell's message of "Tue, 22 Sep 2020 15:21:49 +0100")
Message-ID: <878sd1ooub.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:57:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 22 Sep 2020 at 15:13, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > On Tue, 22 Sep 2020 at 13:01, Markus Armbruster <armbru@redhat.com> wrote:
>> >> If you'd prefer to (re-)add it later, stick in TODO comment.
>> >
>> > Where would you want a TODO to be ?
>>
>> Before the patch, the licensing information is in
>> docs/interop/qemu-ga-ref.texi.  That file gets replaced by
>> docs/interop/qemu-ga-ref.rst, losing the licensing information.  What
>> about putting the TODO right there?
>
> I can if you insist, but what makes that .rst file any
> different from all the other .rst files we have in docs/
> which go into our various manuals and don't have explicit
> licensing comments or reader-visible text?
>
> If we want to improve how we inform readers of the docs
> license, we might:
>  * add a license note to the existing copyright footer line
>  * or to have every page to have a larger copyright/license
>    text section at the bottom
>  * or to have the interop and other manuals have a license.rst
>    like the system manual does currently,
> and none of those changes would require editing qemu-ga-ref.rst
> or qemu-qmp-ref.rst, because the overall problem being addressed
> isn't specific to those parts of the documentation, it's a
> wider one that you'd fix in a different place.

My first preference is keeping the licensing information.  How to keep
it is up to you.

If you'd prefer not to in this series, then all I ask for is a reminder
*somewhere* that we've lost licensing information, and should put it
back.  You choose where to put it and how to phrase it.  But since you
asked, I made a suggestion.  Feel free to choose anther place or
phrasing.


