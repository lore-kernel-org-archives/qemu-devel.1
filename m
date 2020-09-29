Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665AEC4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7E0220789
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVHIUYr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7E0220789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNB5k-0008A6-N2
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNB4b-0007VY-7t
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:33:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNB4Z-0005Rc-Gs
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:33:20 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601368398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uc7+JomflrGsyZ6Kurr5XwRisdLdE4FMDg7A06IjzGA=;
 b=YVHIUYr0WrtHNaZ3/UwxWRjx0GFSOH1rsUSqvzb4qNvINmKqyjBQhaoWJ1pLE/yDoO2uql
 38dQ2j17xLFqhWajxma+bnvxIAN2rdcrO/fek+VcOqNFXqSveBBpe+FUpdaV7ArB6xgiXp
 BqzKTyglb/xgeO9whDZREEU/HqIm3KU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-I2V7-qGrPYi97cF4B-AGqA-1; Tue, 29 Sep 2020 04:33:14 -0400
X-MC-Unique: I2V7-qGrPYi97cF4B-AGqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C682192C8D5;
 Tue, 29 Sep 2020 08:33:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7ACF7881E;
 Tue, 29 Sep 2020 08:33:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6D89F113864A; Tue, 29 Sep 2020 10:33:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 12/21] tests/qapi-schema: Convert doc-good.json to
 rST-style strong/emphasis
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-13-peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 10:33:05 +0200
In-Reply-To: <20200925162316.21205-13-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 25 Sep 2020 17:23:07 +0100")
Message-ID: <871ril0ypq.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> doc-good.json currently uses the old *strong* and _emphasis_ markup.
> As part of the conversion to rST this needs to switch to **strong**
> and *emphasis*, because rST uses underscores as part of its markup
> of hyperlinks and will otherwise warn about the syntax error.
>
> In commit a660eed482063b we fixed up the in-tree uses of the
> old markup:
>  1) _this_ was replaced with *this*
>  2) the only in-tree use of *this* was left alone (turning
>     a 'strong' into an 'emphasis')
> (and so currently in-tree nothing is using either new-style
> **strong** or old-style _emphasis_).
>
> Update doc-good.json in a similar way:
>  1) replace _this_ with *this*
>  2) remove the usage of old-style *this*
>
> (This slightly reduces the coverage for the old Texinfo generator,
> which is about to go away, but is fine for the new rST generator
> because that does not need to handle strong/emphasis itself because
> it is simply passing the entire text as raw rST to Sphinx.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


