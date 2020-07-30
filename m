Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E0EC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 09:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A197920809
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 09:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7eREVA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A197920809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k14l4-00015z-OK
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 05:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k14kT-0000gf-R2
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 05:21:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31937
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k14kR-0004tY-RK
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 05:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596100871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WJ5A5yvI+gGsvMCLbCD8gLtk0UxmyrRLDmS+Rt9T8Zc=;
 b=A7eREVA1DThPlejVIsyisdbUBQK54/Tcxlf0Jk7FwNSKvu1qOCNPwlvG3RlmTGQ5bJfOJV
 oBVtxsS81y40PGozF6p4D7u0HMUPVa5CQUxKr158VesJt2MZs+XihHRQUmobjc87QTeNQs
 gNIPvkSYJZNYAlaXOsj36bms/zbTtuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-UaCYHnHGN8e_Xn-cYVSA9Q-1; Thu, 30 Jul 2020 05:21:04 -0400
X-MC-Unique: UaCYHnHGN8e_Xn-cYVSA9Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CD941DE9;
 Thu, 30 Jul 2020 09:21:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4161471937;
 Thu, 30 Jul 2020 09:21:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CDB3D1132FD2; Thu, 30 Jul 2020 11:21:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH for-5.1] qapi/machine.json: Fix missing newline in doc
 comment
References: <20200729191019.19168-1-peter.maydell@linaro.org>
Date: Thu, 30 Jul 2020 11:21:01 +0200
In-Reply-To: <20200729191019.19168-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Wed, 29 Jul 2020 20:10:19 +0100")
Message-ID: <87d04d2waq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:51:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> In commit 176d2cda0dee9f4 we added the @die-id field
> to the CpuInstanceProperties struct, but in the process
> accidentally removed the newline between the doc-comment
> lines for @core-id and @thread-id.
>
> Put the newline back in; this fixes a misformatting in the
> generated HTML QMP reference manual.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Not very important but I've suggested for-5.1 as it's a safe
> docs fix. You can see the misrendered doc at
> https://www.qemu.org/docs/master/interop/qemu-qmp-ref.html#index-CpuInstanceProperties

Makes sense.

Queued, thanks!


