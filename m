Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EA6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A60207D3
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 11:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvybuFAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A60207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jduNP-0000PX-38
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 07:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jduMi-0008GG-3J
 for qemu-devel@nongnu.org; Wed, 27 May 2020 07:36:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33369
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jduMh-0006hu-2O
 for qemu-devel@nongnu.org; Wed, 27 May 2020 07:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590579414;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=APhvedGFDZ/LwTTDy5OuUup6IAa4d8ekcilBygUeLd4=;
 b=NvybuFANzbnRGo21iU2XmJE+2qTVhPEB9DoHhKxRDcHYXg7jkIFHe3KpSDI/O5KOuSRjXO
 TL2ilxhyyRNBLQmY0PWZDDVeRdCwOXQai4VnQs+mJMPkS8VNL04CgIV+/P2KIWDyczef6F
 Rwu4JHnLK91mlYPFWGDTy77fGbYBpbA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-B7C2I30NNt-QuZUKDOAYPg-1; Wed, 27 May 2020 07:36:51 -0400
X-MC-Unique: B7C2I30NNt-QuZUKDOAYPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2436E1005512
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 11:36:51 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 805067A1E1;
 Wed, 27 May 2020 11:36:46 +0000 (UTC)
Date: Wed, 27 May 2020 12:36:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 4/5] crypto: Add tls-cipher-suites object
Message-ID: <20200527113643.GL2665520@redhat.com>
References: <20200519182024.14638-1-philmd@redhat.com>
 <20200519182024.14638-5-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200519182024.14638-5-philmd@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:49:35
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 19, 2020 at 08:20:23PM +0200, Philippe Mathieu-Daudé wrote:
> Example of use to dump:
> 
>   $ qemu-system-x86_64 -S \
>     -object tls-cipher-suites,id=mysuite,priority=@SYSTEM,verbose=yes
>   Cipher suites for @SYSTEM:
>   - TLS_AES_256_GCM_SHA384                                0x13, 0x02      TLS1.3
>   - TLS_CHACHA20_POLY1305_SHA256                          0x13, 0x03      TLS1.3
>   - TLS_AES_128_GCM_SHA256                                0x13, 0x01      TLS1.3
>   - TLS_AES_128_CCM_SHA256                                0x13, 0x04      TLS1.3
>   - TLS_ECDHE_RSA_AES_256_GCM_SHA384                      0xc0, 0x30      TLS1.2
>   - TLS_ECDHE_RSA_CHACHA20_POLY1305                       0xcc, 0xa8      TLS1.2
>   - TLS_ECDHE_RSA_AES_256_CBC_SHA1                        0xc0, 0x14      TLS1.0
>   - TLS_ECDHE_RSA_AES_128_GCM_SHA256                      0xc0, 0x2f      TLS1.2
>   - TLS_ECDHE_RSA_AES_128_CBC_SHA1                        0xc0, 0x13      TLS1.0
>   - TLS_ECDHE_ECDSA_AES_256_GCM_SHA384                    0xc0, 0x2c      TLS1.2
>   - TLS_ECDHE_ECDSA_CHACHA20_POLY1305                     0xcc, 0xa9      TLS1.2
>   - TLS_ECDHE_ECDSA_AES_256_CCM                           0xc0, 0xad      TLS1.2
>   - TLS_ECDHE_ECDSA_AES_256_CBC_SHA1                      0xc0, 0x0a      TLS1.0
>   - TLS_ECDHE_ECDSA_AES_128_GCM_SHA256                    0xc0, 0x2b      TLS1.2
>   - TLS_ECDHE_ECDSA_AES_128_CCM                           0xc0, 0xac      TLS1.2
>   - TLS_ECDHE_ECDSA_AES_128_CBC_SHA1                      0xc0, 0x09      TLS1.0
>   - TLS_RSA_AES_256_GCM_SHA384                            0x00, 0x9d      TLS1.2
>   - TLS_RSA_AES_256_CCM                                   0xc0, 0x9d      TLS1.2
>   - TLS_RSA_AES_256_CBC_SHA1                              0x00, 0x35      TLS1.0
>   - TLS_RSA_AES_128_GCM_SHA256                            0x00, 0x9c      TLS1.2
>   - TLS_RSA_AES_128_CCM                                   0xc0, 0x9c      TLS1.2
>   - TLS_RSA_AES_128_CBC_SHA1                              0x00, 0x2f      TLS1.0
>   - TLS_DHE_RSA_AES_256_GCM_SHA384                        0x00, 0x9f      TLS1.2
>   - TLS_DHE_RSA_CHACHA20_POLY1305                         0xcc, 0xaa      TLS1.2
>   - TLS_DHE_RSA_AES_256_CCM                               0xc0, 0x9f      TLS1.2
>   - TLS_DHE_RSA_AES_256_CBC_SHA1                          0x00, 0x39      TLS1.0
>   - TLS_DHE_RSA_AES_128_GCM_SHA256                        0x00, 0x9e      TLS1.2
>   - TLS_DHE_RSA_AES_128_CCM                               0xc0, 0x9e      TLS1.2
>   - TLS_DHE_RSA_AES_128_CBC_SHA1                          0x00, 0x33      TLS1.0
>   total: 29 ciphers

IMHO this "verbose" option shouldn't exist. Instead we should be
using the QEMU trace infrastructure to log this information. This
will make it possible to trace the info at runtime in production
deployments too



> +static void parse_cipher_suites(QCryptoTLSCipherSuites *s,
> +                                const char *priority_name, Error **errp)
> +{
> +#ifdef CONFIG_GNUTLS

Instead of doing this......


> diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
> index c2a371b0b4..ce706d322a 100644
> --- a/crypto/Makefile.objs
> +++ b/crypto/Makefile.objs
> @@ -13,6 +13,7 @@ crypto-obj-y += cipher.o
>  crypto-obj-$(CONFIG_AF_ALG) += afalg.o
>  crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
>  crypto-obj-$(CONFIG_AF_ALG) += hash-afalg.o
> +crypto-obj-y += tls-cipher-suites.o

....Use crypto-obj-$(CONFIG_GNUTLS) += tls-cipher-suites.o

This lets the mgmt appliction introspect QEMU to discover whether the
TLS cipher suits object is present & usable.

>  crypto-obj-y += tlscreds.o
>  crypto-obj-y += tlscredsanon.o
>  crypto-obj-y += tlscredspsk.o
> -- 
> 2.21.3
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


