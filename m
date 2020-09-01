Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD329C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:46:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862002083B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5mYhnfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862002083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2sG-0005b2-OM
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kD2rN-0004Qs-LG
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:45:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40324
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kD2rI-0002U1-LY
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598953543;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gpdRGh/2jOUZ/bS6vxqFBPwMsv141XnddVqAw6G4+OM=;
 b=f5mYhnfibbBsagnD1Iqqe20p7Gbdn9Oh6cbJAHg0oAMjFW4h+lCYBQYakkMhFHhlJWDRdD
 BlR0dBoXpn0RdYfFjSdQuGIBzz76jo9FWCu6C++9G3/JmYm51Z7f28ziuAQxLA/Oq1wnoc
 a5WyBzaUVfqrB7nr+qGx1awBxuo133M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-YUcImfhuPG6MMdgNtdnrGQ-1; Tue, 01 Sep 2020 05:45:41 -0400
X-MC-Unique: YUcImfhuPG6MMdgNtdnrGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F5AA18B9ED7;
 Tue,  1 Sep 2020 09:45:40 +0000 (UTC)
Received: from redhat.com (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6AA745D9CD;
 Tue,  1 Sep 2020 09:45:34 +0000 (UTC)
Date: Tue, 1 Sep 2020 10:45:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v8 1/8] Introduce yank feature
Message-ID: <20200901094531.GG345480@redhat.com>
References: <cover.1598951375.git.lukasstraub2@web.de>
 <ab5c04766f270d53e90f17f76c0af7e5b66f8623.1598951375.git.lukasstraub2@web.de>
MIME-Version: 1.0
In-Reply-To: <ab5c04766f270d53e90f17f76c0af7e5b66f8623.1598951375.git.lukasstraub2@web.de>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 01, 2020 at 11:15:07AM +0200, Lukas Straub wrote:
> The yank feature allows to recover from hanging qemu by "yanking"
> at various parts. Other qemu systems can register themselves and
> multiple yank functions. Then all yank functions for selected
> instances can be called by the 'yank' out-of-band qmp command.
> Available instances can be queried by a 'query-yank' oob command.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/qemu/yank.h |  81 +++++++++++++++++++
>  qapi/misc.json      |  62 +++++++++++++++
>  util/meson.build    |   1 +
>  util/yank.c         | 187 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 331 insertions(+)
>  create mode 100644 include/qemu/yank.h
>  create mode 100644 util/yank.c

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


