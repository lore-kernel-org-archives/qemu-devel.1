Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9A4C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A3C620674
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 10:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bdXG5J0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3C620674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPk95-0002t9-5I
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 06:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPk7h-0001ju-AB
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kPk7f-0007CZ-Ox
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 06:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601979786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1nyeoa4QTy+Z3i9A9Jn7rRfb6NxSDmG9WBVkML8Rtes=;
 b=bdXG5J0E/9OZrrXxm4qTqbHS5UOs4B1gZ9zknQB1dPxaCPece1p7LJYCJ1e7XU307HAaH+
 8h8TYlbfiuEFiMfVHuUA/vjcnVL2VnbKqFDq+kxbXOA2mFiQFAN/gqarx/dFgi6z7koNuV
 gOKjQodDgOTLOZltL54jNZtW/UOdxKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-WDX2TRjEP7C4YkJizkfvYw-1; Tue, 06 Oct 2020 06:23:05 -0400
X-MC-Unique: WDX2TRjEP7C4YkJizkfvYw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEC56804006;
 Tue,  6 Oct 2020 10:23:03 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-147.ams2.redhat.com [10.36.113.147])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92B7110013BD;
 Tue,  6 Oct 2020 10:22:58 +0000 (UTC)
Date: Tue, 6 Oct 2020 12:22:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 1/3] docs: generate qemu-storage-daemon-qmp-ref(7) man
 page
Message-ID: <20201006102255.GC4202@linux.fritz.box>
References: <20200910144400.69615-1-stefanha@redhat.com>
 <20200910144400.69615-2-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200910144400.69615-2-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Kashyap Chamarthy <kchamart@redhat.com>,
 afrosi@redhat.com, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.09.2020 um 16:43 hat Stefan Hajnoczi geschrieben:
> Although qemu-storage-daemon QMP commands are identical to QEMU QMP
> commands they are a subset. Generate a manual page of just the commands
> supported by qemu-storage-daemon so that users know exactly what is
> available in qemu-storage-daemon.
> 
> Add an h1 heading in storage-daemon/qapi/qapi-schema.json so that
> block-core.json is at the h2 heading level.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

As the series doesn't apply any more, I can't actually try it out
easily, but is the order of includes in the schema right now?

I seem to remember that in v1 we discussed that nested includes result
in an unexpected section structure in the documentation in some cases
(such as generic jobs being documented in a subsection of block
devices), and that we need to reorder includes in qapi-schema.json to
fix this because a more clever doc generator wasn't considered worth the
effort.

Kevin


