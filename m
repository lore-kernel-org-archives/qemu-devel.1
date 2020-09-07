Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEF8C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:16:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B18142078E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 15:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTAoaLsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18142078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFIsH-0004qx-D5
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 11:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFIrL-0003ya-FM
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 11:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kFIrI-0005We-Ge
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 11:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599491701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hcgB4LT+FgXPReX6oL2iGs6pNSz7zaTlXgJnQrn7+t4=;
 b=TTAoaLsFSEtzI8/8cnivqS+sz8416ZYKc8E9rzZSB+MVYvpmMBLHcVdoAcR42QomQu7D9K
 RFAHgEjG2PePI0H0oi7+K/YYYZi75rQQIDa6OiFNNWztiezgSbbruB+wgoMRjb3TfIjW/g
 HXd+MD4xfsH2hin9Xr6WnL8QFm8ouLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-DpX6TPL_M2GBVkKnVSQtnQ-1; Mon, 07 Sep 2020 11:15:00 -0400
X-MC-Unique: DpX6TPL_M2GBVkKnVSQtnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05713802B60;
 Mon,  7 Sep 2020 15:14:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CAB9D27BD1;
 Mon,  7 Sep 2020 15:14:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 512811132B59; Mon,  7 Sep 2020 17:14:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/2] qapi: A section heading bug fix, and maybe an
 improvement
References: <20200320091805.5585-1-armbru@redhat.com>
 <874ko9lke7.fsf@dusky.pond.sub.org>
 <CAFEAcA9KUnyqi6RY4WF-=Ut5kcT5_Oc7VwB5H8EC6pHyTX376w@mail.gmail.com>
Date: Mon, 07 Sep 2020 17:14:57 +0200
In-Reply-To: <CAFEAcA9KUnyqi6RY4WF-=Ut5kcT5_Oc7VwB5H8EC6pHyTX376w@mail.gmail.com>
 (Peter Maydell's message of "Mon, 7 Sep 2020 15:53:58 +0100")
Message-ID: <875z8pk49a.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:52:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 7 Sep 2020 at 15:41, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Markus Armbruster <armbru@redhat.com> writes:
>>
>> > PATCH 1 fixes an old defect in the doc comment parser.  I figure it'll
>> > simplify the rST generator's job.
>> >
>> > PATCH 2 might simplify it further.  It's RFC because I'm not sure it
>> > does.  Peter, you tell me :)
>>
>> I dropped the ball on this one.  I think both patches make sense, but I
>> don't want to upset Peter's "Convert QAPI doc comments to generate rST
>> instead of texinfo" apple cart.  Peter, please tell me what you'd like
>> me to do:
>>
>> * Post a pull request, so you can base your v6 on it.
>
> Looking back at my comments on the patches I think I was happy
> with both and it probably isn't a huge rebase issue, so you
> might as well send these in a pullreq. You might consider also
> including the first 3 patches from my v5 series, which are just
> fixing markup issues in the .json that get detected by the
> rst conversion.

Good idea, will do.


