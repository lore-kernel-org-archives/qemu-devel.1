Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C25DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:07:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E317F2087C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TK1vOTsC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E317F2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFv8X-0006js-WE
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFv7t-0005r6-Po
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:06:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46807
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFv7r-0002Q3-VI
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599638803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=onsHuhM8pHoUai14kpFYq3tGFI1Eb5eHKnOSnETWWG4=;
 b=TK1vOTsC1dSwVm7HzGmrXDw+pNWn6GOn+ozoLi1J+PrXgyYXWFrQ7byCwjV3bhUbchCLGy
 7oHxjvYCSmAiW0sw+IGzhphOfdqstiE3Xsv2s019QsKQZRJPZT5oXGQHrDAh8+kd3kwjMO
 9rBybZuwQ2+iGsqfbb7wimyQo8wPPfs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-Qafg4Jr8NM2tWAg5PKGphA-1; Wed, 09 Sep 2020 04:06:41 -0400
X-MC-Unique: Qafg4Jr8NM2tWAg5PKGphA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FF3318BE160;
 Wed,  9 Sep 2020 08:06:40 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-221.ams2.redhat.com [10.36.113.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69FDF60C15;
 Wed,  9 Sep 2020 08:06:35 +0000 (UTC)
Date: Wed, 9 Sep 2020 10:06:34 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 1/4] docs: lift block-core.json rST header into parents
Message-ID: <20200909080634.GB5219@linux.fritz.box>
References: <20200908093113.47564-1-stefanha@redhat.com>
 <20200908093113.47564-2-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200908093113.47564-2-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 02:43:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>, afrosi@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.09.2020 um 11:31 hat Stefan Hajnoczi geschrieben:
> block-core.json is included from several places. It has no way of
> knowing what header level (h1, h2, ...) is appropriate. Sphinx reports
> errors when it encounters an h2 header where it expects an h1 header.
> This issue prevents the next patch from generating documentation for
> qemu-storage-daemon QMP commands.
> 
> Move the header into parents so that the correct header level can be
> used. Note that transaction.json is not updated since it doesn't seem to
> need a header.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/interop/firmware.json | 4 ++++
>  qapi/block-core.json       | 4 ----
>  qapi/block.json            | 1 +
>  3 files changed, 5 insertions(+), 4 deletions(-)

storage-daemon/qapi/qapi-schema.json needs an update, too. With the
series as it is, the block-core.json definitions don't get any headline
at all and look as if they were part of the previous section.

Maybe a nicer solution would be to keep the second-level heading where
it is, but to just add a first-level one to the storage daemon
qapi-schema.json. It makes sense to group block-core and block-export
together even without the system emulator part, so the top-level
section wouldn't be arbitrary either, but we would add a second
subsection soon.

Kevin


