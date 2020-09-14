Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83EBC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:44:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36243205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 14:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYBds0oF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36243205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHpi7-0007VP-4y
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 10:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHpN2-0006ZW-Iw
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:22:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59067
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kHpN0-0001Mu-LS
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600093333;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=2ie34C1Nrify66QddFHK2c4Ik5ZXbZ8QQTzGd6yTYY8=;
 b=cYBds0oFHKOZ770iFzSR2CGZMioIKlXJwUKSB+1vwDZw/TkBiOAxZc7fJ5j8yblW7eDSmn
 Hl1QsSvO02zRWbfVopZ/HxiwFkOf42eFLLPsj/Lw+qyKrTaV7XIfbgps9U5D2YNjS7volM
 eOFrhGt7h3KCigTDDQLoYrNuAtrzEtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173--OttyGeEOLOoNANoaNftQg-1; Mon, 14 Sep 2020 10:21:56 -0400
X-MC-Unique: -OttyGeEOLOoNANoaNftQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D70C318B9F01;
 Mon, 14 Sep 2020 14:21:55 +0000 (UTC)
Received: from redhat.com (ovpn-114-99.ams2.redhat.com [10.36.114.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F0C17A414;
 Mon, 14 Sep 2020 14:21:48 +0000 (UTC)
Date: Mon, 14 Sep 2020 15:21:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] docs/system: clarify deprecation scheduled
Message-ID: <20200914142146.GN1252186@redhat.com>
References: <20200811104736.17140-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200811104736.17140-1-stefanha@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 00:11:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: libvir-list@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 11, 2020 at 11:47:36AM +0100, Stefan Hajnoczi wrote:
> The sentence explaining the deprecation schedule is ambiguous. Make it
> clear that a feature deprecated in the Nth release is guaranteed to
> remain available in the N+1th release. Removal can occur in the N+2nd
> release or later.
> 
> As an example of this in action, see commit
> 25956af3fe5dd0385ad8017bc768a6afe41e2a74 ("block: Finish deprecation of
> 'qemu-img convert -n -o'"). The feature was deprecated in QEMU 4.2.0. It
> was present in the 5.0.0 release and removed in the 5.1.0 release.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/system/deprecated.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 851dbdeb8a..fecfb2f1c1 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -4,9 +4,9 @@ Deprecated features
>  In general features are intended to be supported indefinitely once
>  introduced into QEMU. In the event that a feature needs to be removed,
>  it will be listed in this section. The feature will remain functional
> -for 2 releases prior to actual removal. Deprecated features may also
> -generate warnings on the console when QEMU starts up, or if activated
> -via a monitor command, however, this is not a mandatory requirement.
> +for 1 more release after deprecation. Deprecated features may also generate
> +warnings on the console when QEMU starts up, or if activated via a monitor
> +command, however, this is not a mandatory requirement.

So we're changing

  The feature will remain functional for 2 releases prior to actual removal.

to

  The feature will remain functional for 1 more release after deprecation.

How about

  The feature will remain functional for the release in which it was
  deprecated and one further release. After these two releases, the
  feature is liable to be removed.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


