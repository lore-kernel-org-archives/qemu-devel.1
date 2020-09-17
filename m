Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A707C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAAFF206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yd4UFCmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAAFF206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwn3-0007rW-Qp
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIwmI-0007RW-Ir
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:28:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59977
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kIwmG-0000VK-A6
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600360135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D7tgR+PdUbf3U7DR3TSu5reizsVSsA8xTBgx364i75s=;
 b=Yd4UFCmrzLToL2vEaKyL5HVXJrUy8MPpsoCbju04a8+/mcHlitYsmTbe+9b22xPpztDZ+b
 I6h1pOeGJKeHwuw3KZbpxR+B6xiUqo082lB0UI89CDwyMdvU4RAfwXy1GcF1TMLBPkbGHq
 KX9xL4JbCev+ceMqhiH+a2Gaz/CdMKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-566m7V7JPfCk2meGMHQH0w-1; Thu, 17 Sep 2020 12:28:52 -0400
X-MC-Unique: 566m7V7JPfCk2meGMHQH0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCFA410074AF;
 Thu, 17 Sep 2020 16:28:51 +0000 (UTC)
Received: from localhost (ovpn-119-217.rdu2.redhat.com [10.10.119.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9DD199141;
 Thu, 17 Sep 2020 16:28:51 +0000 (UTC)
Date: Thu, 17 Sep 2020 12:28:51 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH] docs: simplify and clarify the platform support rules
Message-ID: <20200917162851.GP7594@habkost.net>
References: <20200917155606.1623795-1-berrange@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200917155606.1623795-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 03:47:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 04:56:06PM +0100, Daniel P. Berrangé wrote:
> The distinction between short life and long life Linux distributions
> turned out to be redundant. They can both be covered in a simple way
> by noting support will target the current release, and the previous
> release for a period of two years or until its EOL. This rule can also
> apply to the other UNIX based distros, leaving only Windows needing a
> different set of rules.
> 
> This also clarifies that Debian LTS is out of scope, because the LTS
> support is provided by a separate group from the main Debian maintainer
> team.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> This is a spin off from the Python 3.5 thread
> 
> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg06358.html
> 
>  docs/system/build-platforms.rst | 59 ++++++++++-----------------------
>  1 file changed, 18 insertions(+), 41 deletions(-)
> 
> diff --git a/docs/system/build-platforms.rst b/docs/system/build-platforms.rst
> index 9734eba2f1..03d2fd217f 100644
> --- a/docs/system/build-platforms.rst
> +++ b/docs/system/build-platforms.rst
> @@ -29,51 +29,28 @@ The Repology site https://repology.org is a useful resource to identify
[...]
> +Linux OS, macOS, FreeBSD, NetBSD, OpenBSD
> +-----------------------------------------
[...]
> +For FreeBSD, decisions will be made based on the contents of the ports tree;
> +for macOS, `HomeBrew`_ will be used, although `MacPorts`_ is expected to carry
> +similar versions.

Shouldn't we mention NetBSD and OpenBSD too?

-- 
Eduardo


