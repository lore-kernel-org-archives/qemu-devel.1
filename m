Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D0ADC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDDF12075A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxGUCcCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDF12075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdsbA-00047p-8E
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 05:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jdsZr-0002RV-EO
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:42:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53385
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jdsZo-0007oG-2v
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590572538;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z1GK0glK7aSRIprYxKBWtbmUOZfLozuYcAEqPhIxzUw=;
 b=VxGUCcCuxB+Jhf3JOj0tH8Y1uTuTvNj+BvN3Pifvhy18sMhTgARQcr77tr592t2INWmHJg
 fbnIrhW7qnEZu2+Ti+RZQMlYS9CgWiCkIR2qSnbRNfBHxCqMKHIIzK6n++GCbWhZomYnAa
 9b5MUXGC4z/e4Cg0BLpj9a1/c+XJ8iA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-dG63g53qPHmpKM6SLuh_5w-1; Wed, 27 May 2020 05:42:12 -0400
X-MC-Unique: dG63g53qPHmpKM6SLuh_5w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56272460
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 09:42:11 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7ACD75C1B0;
 Wed, 27 May 2020 09:42:10 +0000 (UTC)
Date: Wed, 27 May 2020 10:42:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: [PATCH] crypto: Remove use of GCRYPT_VERSION macro.
Message-ID: <20200527094206.GD2665520@redhat.com>
References: <20200527093409.3588189-1-rjones@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200527093409.3588189-1-rjones@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 27, 2020 at 10:34:09AM +0100, Richard W.M. Jones wrote:
> According to the gcrypt documentation it's intended that
> gcry_check_version() is called with the minimum version of gcrypt
> needed by the program, not the version from the <gcrypt.h> header file
> that happened to be installed when qemu was compiled.  Indeed the
> gcrypt.h header says that you shouldn't use the GCRYPT_VERSION macro.

That's awesome, because the API docs illustrate gcry_check_version
with passing GCRYPT_VERSION !

> This causes the following failure:
> 
>   qemu-img: Unable to initialize gcrypt
> 
> if a slightly older version of libgcrypt is installed with a newer
> qemu, even though the slightly older version works fine.  This can
> happen with RPM packaging which uses symbol versioning to determine
> automatically which libgcrypt is required by qemu, which caused the
> following bug in RHEL 8:
> 
>   https://bugzilla.redhat.com/show_bug.cgi?id=1840485
> 
> qemu actually requires libgcrypt >= 1.5.0, so we might put the string
> "1.5.0" here.  However since 1.5.0 was released in 2011, it hardly
> seems we need to check that.  So I replaced GCRYPT_VERSION with NULL.
> Perhaps in future if we move to requiring a newer version of gcrypt we
> could put a literal string here.

I checked that v1.5.0 still accepts NULL and it does, so we're
fine. We validate the 1.5.0 version in configure, and any
runtime usage would be hanlded by ELF symbol versioning as
you say.

> 
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  crypto/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/crypto/init.c b/crypto/init.c
> index b305381ec5..ea233b9192 100644
> --- a/crypto/init.c
> +++ b/crypto/init.c
> @@ -122,7 +122,7 @@ int qcrypto_init(Error **errp)
>  #endif
>  
>  #ifdef CONFIG_GCRYPT
> -    if (!gcry_check_version(GCRYPT_VERSION)) {
> +    if (!gcry_check_version(NULL)) {
>          error_setg(errp, "Unable to initialize gcrypt");
>          return -1;
>      }

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

and queued.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


