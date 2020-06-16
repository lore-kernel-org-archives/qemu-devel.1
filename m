Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24139C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA04F20882
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 16:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJnMil/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA04F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlEXM-0004TB-1y
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 12:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jlEWY-0003Fh-OF
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:33:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38743
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jlEWV-0000J3-N7
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 12:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592325198;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWWqdMF70BPtaVwqcdmn9vKnDu7si+1MiwAs/8lXuGA=;
 b=BJnMil/xXy6wFdym/kbKlCibGjfBPVUMR0mmn+/IltGs78DoTPiYSkM+zn7MXperNdYzkX
 y+Z/Rt3zFJE0A5wDR9xxDPbOT1D4x0Vlri2mKnkaWHTQI8Rb8ACeztu3SGL+yglQEMTEfq
 DHc1f6G43YLR/dCXL6BVCU9YvTsZzfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-XWzTzpaFNImIWHZcbpDcHw-1; Tue, 16 Jun 2020 12:33:04 -0400
X-MC-Unique: XWzTzpaFNImIWHZcbpDcHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDEDB10059B1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 16:33:02 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF46D79310;
 Tue, 16 Jun 2020 16:32:57 +0000 (UTC)
Date: Tue, 16 Jun 2020 17:32:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v9 4/5] crypto: Add tls-cipher-suites object
Message-ID: <20200616163254.GQ550360@redhat.com>
References: <20200615103457.25282-1-philmd@redhat.com>
 <20200615103457.25282-5-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615103457.25282-5-philmd@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 15, 2020 at 12:34:56PM +0200, Philippe Mathieu-Daudé wrote:
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
> of IANA_TLS_CIPHER objects. The firmware uses the IANA_TLS_CIPHER
> array for configuring guest-side TLS, for example in UEFI HTTPS
> Boot.
> 
> The priority at which the host-side policy is retrieved is given
> by the "priority" property of the new object type. For example,
> "priority=@SYSTEM" may be used to refer to
> "/etc/crypto-policies/back-ends/gnutls.config" (given that QEMU
> uses GNUTLS).
> 
> [Description from Daniel P. Berrangé, edited by Laszlo Ersek.]
> 
> Example of use to dump the cipher suites:
> 
>   $ qemu-system-x86_64 -S \
>     -object tls-cipher-suites,id=mysuite,priority=@SYSTEM \
>     -trace qcrypto\*
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v9: Replaced 'backends' -> 'frontends' (lersek)
> ---
>  include/crypto/tls-cipher-suites.h |  38 +++++++++
>  crypto/tls-cipher-suites.c         | 127 +++++++++++++++++++++++++++++
>  crypto/Makefile.objs               |   1 +
>  crypto/trace-events                |   5 ++
>  qemu-options.hx                    |  19 +++++
>  5 files changed, 190 insertions(+)
>  create mode 100644 include/crypto/tls-cipher-suites.h
>  create mode 100644 crypto/tls-cipher-suites.c
> 
> diff --git a/include/crypto/tls-cipher-suites.h b/include/crypto/tls-cipher-suites.h
> new file mode 100644
> index 0000000000..3848393a20
> --- /dev/null
> +++ b/include/crypto/tls-cipher-suites.h
> @@ -0,0 +1,38 @@
> +/*
> + * QEMU TLS Cipher Suites Registry (RFC8447)
> + *
> + * Copyright (c) 2019 Red Hat, Inc.
> + *
> + * Author: Philippe Mathieu-Daudé <philmd@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef QCRYPTO_TLSCIPHERSUITES_H
> +#define QCRYPTO_TLSCIPHERSUITES_H
> +
> +#include "qom/object.h"
> +#include "crypto/tlscreds.h"
> +
> +#define TYPE_QCRYPTO_TLS_CIPHER_SUITES "tls-cipher-suites"
> +#define QCRYPTO_TLS_CIPHER_SUITES(obj) \
> +    OBJECT_CHECK(QCryptoTLSCipherSuites, (obj), TYPE_QCRYPTO_TLS_CIPHER_SUITES)
> +
> +/*
> + * IANA registered TLS ciphers:
> + * https://www.iana.org/assignments/tls-parameters/tls-parameters.xhtml#tls-parameters-4
> + */
> +typedef struct {
> +    uint8_t data[2];
> +} QEMU_PACKED IANA_TLS_CIPHER;
> +
> +typedef struct QCryptoTLSCipherSuites {
> +    /* <private> */
> +    QCryptoTLSCreds parent_obj;
> +
> +    /* <public> */
> +    IANA_TLS_CIPHER *cipher_list;
> +    unsigned cipher_count;

There's no benefit to storing in a IANA_TLS_CIPHER struct
that I can see.  If you use a GByteArray for storing the
data to match my suggestion from the previous patch, then.....

> +} QCryptoTLSCipherSuites;
> +
> +#endif /* QCRYPTO_TLSCIPHERSUITES_H */
> diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
> new file mode 100644
> index 0000000000..f02a041f9a
> --- /dev/null
> +++ b/crypto/tls-cipher-suites.c
> @@ -0,0 +1,127 @@
> +/*
> + * QEMU TLS Cipher Suites
> + *
> + * Copyright (c) 2019 Red Hat, Inc.
> + *
> + * Author: Philippe Mathieu-Daudé <philmd@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qom/object_interfaces.h"
> +#include "qemu/error-report.h"
> +#include "crypto/tlscreds.h"
> +#include "crypto/tls-cipher-suites.h"
> +#include "trace.h"
> +
> +static void parse_cipher_suites(QCryptoTLSCipherSuites *s,
> +                                const char *priority_name, Error **errp)
> +{
> +    int ret;
> +    const char *err;
> +    gnutls_priority_t pcache;
> +    enum { M_ENUMERATE, M_GENERATE, M_DONE } mode;
> +
> +    assert(priority_name);
> +    trace_qcrypto_tls_cipher_suite_priority(priority_name);
> +    ret = gnutls_priority_init(&pcache, priority_name, &err);
> +    if (ret < 0) {
> +        error_setg(errp, "Syntax error using priority '%s': %s",
> +                   priority_name, gnutls_strerror(ret));
> +        return;
> +    }
> +
> +    for (mode = M_ENUMERATE; mode < M_DONE; mode++) {
> +        size_t i;

....this extra loop is not neccessary....

> +
> +        for (i = 0;; i++) {
> +            int ret;
> +            unsigned idx;
> +            const char *name;
> +            IANA_TLS_CIPHER cipher;
> +            gnutls_protocol_t protocol;
> +
> +            ret = gnutls_priority_get_cipher_suite_index(pcache, i, &idx);
> +            if (ret == GNUTLS_E_REQUESTED_DATA_NOT_AVAILABLE) {
> +                break;
> +            }
> +            if (ret == GNUTLS_E_UNKNOWN_CIPHER_SUITE) {
> +                continue;
> +            }
> +
> +            name = gnutls_cipher_suite_info(idx, (unsigned char *)&cipher,
> +                                            NULL, NULL, NULL, &protocol);
> +            if (name == NULL) {
> +                continue;
> +            }
> +
> +            if (mode == M_GENERATE) {
> +                const char *version;
> +
> +                version = gnutls_protocol_get_name(protocol);
> +                trace_qcrypto_tls_cipher_suite_info(cipher.data[0],
> +                                                    cipher.data[1],
> +                                                    version, name);
> +                s->cipher_list[s->cipher_count] = cipher;

...you can just call g_byte_array_append() here.   GByteArray will
efficiently grow as needed - it won't do  O(N) re-allocs.

> +            }
> +            s->cipher_count++;
> +        }
> +
> +        if (mode == M_ENUMERATE) {
> +            if (s->cipher_count == 0) {
> +                break;
> +            }
> +            s->cipher_list = g_new(IANA_TLS_CIPHER, s->cipher_count);
> +            s->cipher_count = 0;
> +        }
> +    }
> +    trace_qcrypto_tls_cipher_suite_count(s->cipher_count);
> +    gnutls_priority_deinit(pcache);
> +}

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


