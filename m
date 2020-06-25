Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C199FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:15:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91629206FA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 11:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWh3XpPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91629206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joPqN-0004cd-S7
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 07:14:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1joPna-00084I-Oq
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:12:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40272
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1joPnY-0004Hg-5S
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 07:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593083522;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tf2XE74HvfuaulI0Ydf2ZIVu/qXaJQLtSqnjGq/NR8Q=;
 b=iWh3XpPjwzPSwW7batyLcsJ2upoxkcVoONv6jb2CbQYtodf1ULmxtaz245Aad30jKNRkYc
 b+48cJPeR83rmXeT/BVC05JmzwKH3enLs03a2BDvEasCW08gyUuNFu5frsq1npYhEMnz5M
 jKUIfGyaStXDf/hpeYnerrrjaeFuUGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-MbKirwIEPAKsKAvngl8uWQ-1; Thu, 25 Jun 2020 07:11:59 -0400
X-MC-Unique: MbKirwIEPAKsKAvngl8uWQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1660018585A0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:11:59 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 94809101E662;
 Thu, 25 Jun 2020 11:11:57 +0000 (UTC)
Date: Thu, 25 Jun 2020 12:11:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v10 1/5] crypto: Add tls-cipher-suites object
Message-ID: <20200625111154.GI1009994@redhat.com>
References: <20200623172726.21040-1-philmd@redhat.com>
 <20200623172726.21040-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200623172726.21040-2-philmd@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 23, 2020 at 07:27:22PM +0200, Philippe Mathieu-Daudé wrote:
> On the host OS, various aspects of TLS operation are configurable.
> In particular it is possible for the sysadmin to control the TLS
> cipher/protocol algorithms that applications are permitted to use.
> 
> * Any given crypto library has a built-in default priority list
>   defined by the distro maintainer of the library package (or by
>   upstream).
> 
> * The "crypto-policies" RPM (or equivalent host OS package)
>   provides a config file such as "/etc/crypto-policies/config",
>   where the sysadmin can set a high level (library-independent)
>   policy.
> 
>   The "update-crypto-policies --set" command (or equivalent) is
>   used to translate the global policy to individual library
>   representations, producing files such as
>   "/etc/crypto-policies/back-ends/*.config". The generated files,
>   if present, are loaded by the various crypto libraries to
>   override their own built-in defaults.
> 
>   For example, the GNUTLS library may read
>   "/etc/crypto-policies/back-ends/gnutls.config".
> 
> * A management application (or the QEMU user) may overide the
>   system-wide crypto-policies config via their own config, if
>   they need to diverge from the former.
> 
> Thus the priority order is "QEMU user config" > "crypto-policies
> system config" > "library built-in config".
> 
> Introduce the "tls-cipher-suites" object for exposing the ordered
> list of permitted TLS cipher suites from the host side to the
> guest firmware, via fw_cfg. The list is represented as an array
> of bytes.
> 
> The priority at which the host-side policy is retrieved is given
> by the "priority" property of the new object type. For example,
> "priority=@SYSTEM" may be used to refer to
> "/etc/crypto-policies/back-ends/gnutls.config" (given that QEMU
> uses GNUTLS).
> 
> The firmware uses the IANA_TLS_CIPHER array for configuring
> guest-side TLS, for example in UEFI HTTPS Boot.
> 
> [Description from Daniel P. Berrangé, edited by Laszlo Ersek.]
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v10: rewrote logic (danpb)
> ---
>  include/crypto/tls-cipher-suites.h |  39 ++++++++++
>  crypto/tls-cipher-suites.c         | 115 +++++++++++++++++++++++++++++
>  crypto/Makefile.objs               |   1 +
>  crypto/trace-events                |   5 ++
>  qemu-options.hx                    |  19 +++++
>  5 files changed, 179 insertions(+)
>  create mode 100644 include/crypto/tls-cipher-suites.h
>  create mode 100644 crypto/tls-cipher-suites.c

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/include/crypto/tls-cipher-suites.h b/include/crypto/tls-cipher-suites.h
> new file mode 100644
> index 0000000000..1be7917233
> --- /dev/null
> +++ b/include/crypto/tls-cipher-suites.h
> @@ -0,0 +1,39 @@
> +/*
> + * QEMU TLS Cipher Suites Registry (RFC8447)
> + *
> + * Copyright (c) 2019 Red Hat, Inc.

nit-pick, we could make that 2019-2020, likewise other files.

No need to respin just for that though.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


