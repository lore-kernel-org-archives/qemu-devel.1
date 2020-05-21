Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5304C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:11:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D2F920721
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULnwEn8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2F920721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbj73-0008Pd-Pd
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 07:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbj6M-0007SS-Uk
 for qemu-devel@nongnu.org; Thu, 21 May 2020 07:11:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43576
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jbj6L-00037G-Ve
 for qemu-devel@nongnu.org; Thu, 21 May 2020 07:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590059460;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ci28TtFK3lFjprVMApphuuZzXBw+1EHJ4KiyZjNYQ/g=;
 b=ULnwEn8KTWrgNHR5Y5gNLxa2ToPLPuXovooLBU6U/4qMomtmhtcGG3iijPToVgYgzT67cs
 roHEGcyp2FTyAJcyIHaOT7vG+9VPlctf9zT4aB6K7lvm5/6xv3DJ/sfp0v/YJ3/79Nip3P
 r3sUFG96nyx+dFwrOY5JAEY8B3UUic0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-Dfab77aGMBeN62Us-1HKYA-1; Thu, 21 May 2020 07:10:57 -0400
X-MC-Unique: Dfab77aGMBeN62Us-1HKYA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E737A8018A7;
 Thu, 21 May 2020 11:10:56 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B887560C81;
 Thu, 21 May 2020 11:10:55 +0000 (UTC)
Date: Thu, 21 May 2020 12:10:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexey Krasikov <alex-krasikov@yandex-team.ru>
Subject: Re: [PATCH v3 2/3] crypto/linux_keyring: add 'secret_keyring' secret
 object.
Message-ID: <20200521111052.GF2211791@redhat.com>
References: <20200518202804.3761-1-alex-krasikov@yandex-team.ru>
 <20200518202804.3761-3-alex-krasikov@yandex-team.ru>
MIME-Version: 1.0
In-Reply-To: <20200518202804.3761-3-alex-krasikov@yandex-team.ru>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 06:06:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 18, 2020 at 11:28:03PM +0300, Alexey Krasikov wrote:
> Add the ability for the secret object to obtain secret data from the
> Linux in-kernel key managment and retention facility, as an extra option
> to the existing ones: reading from a file or passing directly as a
> string.
> 
> The secret is identified by the key serial number. The upper layers
> need to instantiate the key and make sure the QEMU process has access
> permissions to read it.
> 
> Signed-off-by: Alexey Krasikov <alex-krasikov@yandex-team.ru>
> ---
>  configure                       |  38 ++++++++
>  crypto/Makefile.objs            |   1 +
>  crypto/secret_keyring.c         | 148 ++++++++++++++++++++++++++++++++
>  include/crypto/secret_keyring.h |  52 +++++++++++
>  4 files changed, 239 insertions(+)
>  create mode 100644 crypto/secret_keyring.c
>  create mode 100644 include/crypto/secret_keyring.h
> 
> diff --git a/configure b/configure
> index 0d69c360c0..1bae5ec0a1 100755
> --- a/configure
> +++ b/configure

>  ##########################################
>  # End of CC checks
> @@ -6733,6 +6766,7 @@ echo "default devices   $default_devices"
>  echo "plugin support    $plugins"
>  echo "fuzzing support   $fuzzing"
>  echo "gdb               $gdb_bin"
> +echo "Linux keyring support $secret_keyring"

Remove the word "support" here and vertically align the value
with the line above, otherwise the configure output summary
looks odd.

With that fixed, 

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


