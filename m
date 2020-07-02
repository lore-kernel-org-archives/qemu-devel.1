Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFB2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990DE20772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i816RooQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990DE20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqwwe-0007PO-TB
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 06:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jqwv9-0006UG-PW
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:58:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jqwv7-0006og-Pk
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593687501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sE2p1aR6NJWo3+BR9eUf/plv70nEiHJc3EiMkeog0t0=;
 b=i816RooQTr4ufRhumB/6jYxQQwcrqB8BTVXOF0qFGAmB7hWaOrllxk6n1Xyhz+AYAbJUoz
 TrW3MrXUOLiUJ8rtdJir3I8HCRevI0YjVkzxODYG3ZnwdDcem+TY2hf2Ud6JPLU7nnHcSk
 R6C7BNS9RmQbQTZX8wD8+lroKdqUVtE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-cFzEC1iyNlOWn5Hkyk4x1A-1; Thu, 02 Jul 2020 06:58:19 -0400
X-MC-Unique: cFzEC1iyNlOWn5Hkyk4x1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54C67EC1A0
 for <qemu-devel@nongnu.org>; Thu,  2 Jul 2020 10:58:18 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-177.ams2.redhat.com
 [10.36.113.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B6C177882;
 Thu,  2 Jul 2020 10:58:17 +0000 (UTC)
Subject: Re: [PATCH v10 5/5] crypto/tls-cipher-suites: Produce fw_cfg
 consumable blob
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200623172726.21040-1-philmd@redhat.com>
 <20200623172726.21040-6-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <de17f8c3-b505-c8e7-703e-1ab4afbdcfc3@redhat.com>
Date: Thu, 2 Jul 2020 12:58:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200623172726.21040-6-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
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
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/23/20 19:27, Philippe Mathieu-Daudé wrote:
> Since our format is consumable by the fw_cfg device,
> we can implement the FW_CFG_DATA_GENERATOR interface.
> 
> Example of use to dump the cipher suites (if tracing enabled):
> 
>   $ qemu-system-x86_64 -S \
>     -object tls-cipher-suites,id=mysuite1,priority=@SYSTEM \
>     -fw_cfg name=etc/path/to/ciphers,gen_id=mysuite1 \
>     -trace qcrypto\*
>   1590664444.197123:qcrypto_tls_cipher_suite_priority priority: @SYSTEM
>   1590664444.197219:qcrypto_tls_cipher_suite_info data=[0x13,0x02] version=TLS1.3 name=TLS_AES_256_GCM_SHA384
>   1590664444.197228:qcrypto_tls_cipher_suite_info data=[0x13,0x03] version=TLS1.3 name=TLS_CHACHA20_POLY1305_SHA256
>   1590664444.197233:qcrypto_tls_cipher_suite_info data=[0x13,0x01] version=TLS1.3 name=TLS_AES_128_GCM_SHA256
>   1590664444.197236:qcrypto_tls_cipher_suite_info data=[0x13,0x04] version=TLS1.3 name=TLS_AES_128_CCM_SHA256
>   1590664444.197240:qcrypto_tls_cipher_suite_info data=[0xc0,0x30] version=TLS1.2 name=TLS_ECDHE_RSA_AES_256_GCM_SHA384
>   1590664444.197245:qcrypto_tls_cipher_suite_info data=[0xcc,0xa8] version=TLS1.2 name=TLS_ECDHE_RSA_CHACHA20_POLY1305
>   1590664444.197250:qcrypto_tls_cipher_suite_info data=[0xc0,0x14] version=TLS1.0 name=TLS_ECDHE_RSA_AES_256_CBC_SHA1
>   1590664444.197254:qcrypto_tls_cipher_suite_info data=[0xc0,0x2f] version=TLS1.2 name=TLS_ECDHE_RSA_AES_128_GCM_SHA256
>   1590664444.197258:qcrypto_tls_cipher_suite_info data=[0xc0,0x13] version=TLS1.0 name=TLS_ECDHE_RSA_AES_128_CBC_SHA1
>   1590664444.197261:qcrypto_tls_cipher_suite_info data=[0xc0,0x2c] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_256_GCM_SHA384
>   1590664444.197266:qcrypto_tls_cipher_suite_info data=[0xcc,0xa9] version=TLS1.2 name=TLS_ECDHE_ECDSA_CHACHA20_POLY1305
>   1590664444.197270:qcrypto_tls_cipher_suite_info data=[0xc0,0xad] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_256_CCM
>   1590664444.197274:qcrypto_tls_cipher_suite_info data=[0xc0,0x0a] version=TLS1.0 name=TLS_ECDHE_ECDSA_AES_256_CBC_SHA1
>   1590664444.197278:qcrypto_tls_cipher_suite_info data=[0xc0,0x2b] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_128_GCM_SHA256
>   1590664444.197283:qcrypto_tls_cipher_suite_info data=[0xc0,0xac] version=TLS1.2 name=TLS_ECDHE_ECDSA_AES_128_CCM
>   1590664444.197287:qcrypto_tls_cipher_suite_info data=[0xc0,0x09] version=TLS1.0 name=TLS_ECDHE_ECDSA_AES_128_CBC_SHA1
>   1590664444.197291:qcrypto_tls_cipher_suite_info data=[0x00,0x9d] version=TLS1.2 name=TLS_RSA_AES_256_GCM_SHA384
>   1590664444.197296:qcrypto_tls_cipher_suite_info data=[0xc0,0x9d] version=TLS1.2 name=TLS_RSA_AES_256_CCM
>   1590664444.197300:qcrypto_tls_cipher_suite_info data=[0x00,0x35] version=TLS1.0 name=TLS_RSA_AES_256_CBC_SHA1
>   1590664444.197304:qcrypto_tls_cipher_suite_info data=[0x00,0x9c] version=TLS1.2 name=TLS_RSA_AES_128_GCM_SHA256
>   1590664444.197308:qcrypto_tls_cipher_suite_info data=[0xc0,0x9c] version=TLS1.2 name=TLS_RSA_AES_128_CCM
>   1590664444.197312:qcrypto_tls_cipher_suite_info data=[0x00,0x2f] version=TLS1.0 name=TLS_RSA_AES_128_CBC_SHA1
>   1590664444.197316:qcrypto_tls_cipher_suite_info data=[0x00,0x9f] version=TLS1.2 name=TLS_DHE_RSA_AES_256_GCM_SHA384
>   1590664444.197320:qcrypto_tls_cipher_suite_info data=[0xcc,0xaa] version=TLS1.2 name=TLS_DHE_RSA_CHACHA20_POLY1305
>   1590664444.197325:qcrypto_tls_cipher_suite_info data=[0xc0,0x9f] version=TLS1.2 name=TLS_DHE_RSA_AES_256_CCM
>   1590664444.197329:qcrypto_tls_cipher_suite_info data=[0x00,0x39] version=TLS1.0 name=TLS_DHE_RSA_AES_256_CBC_SHA1
>   1590664444.197333:qcrypto_tls_cipher_suite_info data=[0x00,0x9e] version=TLS1.2 name=TLS_DHE_RSA_AES_128_GCM_SHA256
>   1590664444.197337:qcrypto_tls_cipher_suite_info data=[0xc0,0x9e] version=TLS1.2 name=TLS_DHE_RSA_AES_128_CCM
>   1590664444.197341:qcrypto_tls_cipher_suite_info data=[0x00,0x33] version=TLS1.0 name=TLS_DHE_RSA_AES_128_CBC_SHA1
>   1590664444.197345:qcrypto_tls_cipher_suite_count count: 29
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v10: Removed Laszlo Acked-by due to logical changes
> ---
>  crypto/tls-cipher-suites.c | 11 +++++++++++
>  qemu-options.hx            | 18 ++++++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
> index 5b403f86c9..b3dba00010 100644
> --- a/crypto/tls-cipher-suites.c
> +++ b/crypto/tls-cipher-suites.c
> @@ -13,6 +13,7 @@
>  #include "qom/object_interfaces.h"
>  #include "crypto/tlscreds.h"
>  #include "crypto/tls-cipher-suites.h"
> +#include "hw/nvram/fw_cfg.h"
>  #include "trace.h"
>  
>  /*
> @@ -88,11 +89,20 @@ static void qcrypto_tls_cipher_suites_complete(UserCreatable *uc,
>      }
>  }
>  
> +static GByteArray *qcrypto_tls_cipher_suites_fw_cfg_gen_data(Object *obj,
> +                                                             Error **errp)
> +{
> +    return qcrypto_tls_cipher_suites_get_data(QCRYPTO_TLS_CIPHER_SUITES(obj),
> +                                              errp);
> +}
> +
>  static void qcrypto_tls_cipher_suites_class_init(ObjectClass *oc, void *data)
>  {
>      UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
> +    FWCfgDataGeneratorClass *fwgc = FW_CFG_DATA_GENERATOR_CLASS(oc);
>  
>      ucc->complete = qcrypto_tls_cipher_suites_complete;
> +    fwgc->get_data = qcrypto_tls_cipher_suites_fw_cfg_gen_data;
>  }
>  
>  static const TypeInfo qcrypto_tls_cipher_suites_info = {
> @@ -103,6 +113,7 @@ static const TypeInfo qcrypto_tls_cipher_suites_info = {
>      .class_init = qcrypto_tls_cipher_suites_class_init,
>      .interfaces = (InterfaceInfo[]) {
>          { TYPE_USER_CREATABLE },
> +        { TYPE_FW_CFG_DATA_GENERATOR_INTERFACE },
>          { }
>      }
>  };
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 4f519f35fd..ce54c7359c 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4585,6 +4585,24 @@ SRST
>          string as described at
>          https://gnutls.org/manual/html_node/Priority-Strings.html.
>  
> +        An example of use of this object is to control UEFI HTTPS Boot.
> +        The tls-cipher-suites object exposes the ordered list of permitted
> +        TLS cipher suites from the host side to the guest firmware, via
> +        fw_cfg. The list is represented as an array of IANA_TLS_CIPHER
> +        objects. The firmware uses the IANA_TLS_CIPHER array for configuring
> +        guest-side TLS.
> +
> +        In the following example, the priority at which the host-side policy
> +        is retrieved is given by the ``priority`` property.
> +        Given that QEMU uses GNUTLS, ``priority=@SYSTEM`` may be used to
> +        refer to /etc/crypto-policies/back-ends/gnutls.config.
> +
> +        .. parsed-literal::
> +
> +             # |qemu_system| \
> +                 -object tls-cipher-suites,id=mysuite0,priority=@SYSTEM \
> +                 -fw_cfg name=etc/edk2/https/ciphers,gen_id=mysuite0
> +
>      ``-object filter-buffer,id=id,netdev=netdevid,interval=t[,queue=all|rx|tx][,status=on|off][,position=head|tail|id=<id>][,insert=behind|before]``
>          Interval t can't be 0, this filter batches the packet delivery:
>          all packets arriving in a given interval on netdev netdevid are
> 

Acked-by: Laszlo Ersek <lersek@redhat.com>


