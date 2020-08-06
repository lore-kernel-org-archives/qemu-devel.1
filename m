Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F40C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ACCE23131
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 15:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgHtameZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ACCE23131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3hTt-0001OQ-G0
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 11:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3hTH-0000q4-Qh
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:06:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40488
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3hTG-0006ka-6h
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 11:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596726377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=anoUfy73Hfyz/OO3srGrIv6f9LC+dugpjVd4YhN7TeQ=;
 b=QgHtameZs/5sj1XPN7oNa0vADK17LrBRCzF3TX8+Qxm+bmTlKcVlbA5ashFPsoX1ig2uCs
 aMzMTR8ivZZfPy6/NZHzI171NZ/EAGuCXXemU4k8kFEICGCcHrZzxN/eHNHkirtPdaytd1
 H2pABIyvTfFn/zlkDa4vh/jXAgZH4Lw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-EyPOECMzO3S2_lKrL9-C6w-1; Thu, 06 Aug 2020 11:06:13 -0400
X-MC-Unique: EyPOECMzO3S2_lKrL9-C6w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5A9E800469;
 Thu,  6 Aug 2020 15:06:11 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AEE41A7D8;
 Thu,  6 Aug 2020 15:06:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2CABA1132801; Thu,  6 Aug 2020 17:06:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v4 05/18] scripts/qapi: Move doc-comment whitespace
 stripping to doc.py
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-6-peter.maydell@linaro.org>
Date: Thu, 06 Aug 2020 17:06:07 +0200
In-Reply-To: <20200309154405.13548-6-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 9 Mar 2020 15:43:52 +0000")
Message-ID: <87v9hv4xwg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:24:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> As we accumulate lines from doc comments when parsing the JSON, the
> QAPIDoc class generally strips leading and trailing whitespace using
> line.strip() when it calls _append_freeform().  This is fine for
> texinfo,

Texinfo

>          but for rST leading whitespace is significant.  We'd like to
> move to having the text in doc comments be rST format rather than a
> custom syntax, so move the removal of leading whitespace from the
> QAPIDoc class to the texinfo-specific processing code in
> texi_format() in qapi/doc.py.
>
> (Trailing whitespace will always be stripped by the rstrip() in
> Section::append regardless.)

We strip to keep the Texinfo source tidier.  Stripping less as we move
towards its replacement is fine.

> In a followup commit we will make the whitespace in the lines of doc
> comment sections more consistently follow the input source.
>
> There is no change to the generated .texi files before and after this
> commit.
>
> Because the qapi-schema test checks the exact values of the
> documentation comments against a reference, we need to update that
> reference to match the new whitespace.  In the first four places this
> is now correctly checking that we did put in the amount of whitespace
> to pass a rST-formatted list to the backend; in the last two places
> the extra whitespace is 'wrong' and will go away again in the
> following commit.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

The thorough explanation in the commit message made review easier.
Thanks!

Reviewed-by: Markus Armbruster <armbru@redhat.com>


