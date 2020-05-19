Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DDFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 22:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF88A204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 22:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SumVTd/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF88A204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbB44-0008QA-1P
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 18:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jbB3S-0007vP-Tm
 for qemu-devel@nongnu.org; Tue, 19 May 2020 18:49:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23882
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jbB3R-0007a3-Mn
 for qemu-devel@nongnu.org; Tue, 19 May 2020 18:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589928584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TAaa6yk2pqo67z0u8QI/mS+RWor9IkpY46fEOJUVbxY=;
 b=SumVTd/BIBv+dvauiVXv4wE1gcm5Y0cIJKYPM/Mki73Vcr0j6ikB/qE2cM7D1amoLLz1YE
 revJhXrsdkFaVaTybV38WVOfnxF2MyVM2ES522uKOo+wHKGF52u1E4upf0hxZY9y9D0L9W
 AyBuHl0nunUYu3akh9h2zek5AJtJl5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-qda63KEmNyG8W6sD2lLy4w-1; Tue, 19 May 2020 18:49:42 -0400
X-MC-Unique: qda63KEmNyG8W6sD2lLy4w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3316F835B40
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 22:49:41 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-114-149.ams2.redhat.com
 [10.36.114.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5730D6297D;
 Tue, 19 May 2020 22:49:37 +0000 (UTC)
Subject: Re: [PATCH v6 5/5] crypto/tls-cipher-suites: Product fw_cfg
 consumable blob
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200519182024.14638-1-philmd@redhat.com>
 <20200519182024.14638-6-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <e06deffb-7bc4-c698-cb8d-073b191a5ef5@redhat.com>
Date: Wed, 20 May 2020 00:49:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200519182024.14638-6-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/19/20 20:20, Philippe Mathieu-Daudé wrote:
> Since our format is consumable by the fw_cfg device,
> we can implement the FW_CFG_DATA_GENERATOR interface.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  crypto/tls-cipher-suites.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

(1) s/product/produce/ in the subject line.

This patch looks OK to me otherwise (but I don't feel confident enough
to give an R-b):

Acked-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

> 
> diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
> index c6c51359bd..11872783eb 100644
> --- a/crypto/tls-cipher-suites.c
> +++ b/crypto/tls-cipher-suites.c
> @@ -14,6 +14,7 @@
>  #include "qemu/error-report.h"
>  #include "crypto/tlscreds.h"
>  #include "crypto/tls-cipher-suites.h"
> +#include "hw/nvram/fw_cfg.h"
>  
>  static void parse_cipher_suites(QCryptoTLSCipherSuites *s,
>                                  const char *priority_name, Error **errp)
> @@ -101,11 +102,28 @@ static void qcrypto_tls_cipher_suites_finalize(Object *obj)
>      g_free(s->cipher_list);
>  }
>  
> +static const void *qcrypto_tls_cipher_suites_get_data(Object *obj)
> +{
> +    QCryptoTLSCipherSuites *s = QCRYPTO_TLS_CIPHER_SUITES(obj);
> +
> +    return s->cipher_list;
> +}
> +
> +static size_t qcrypto_tls_cipher_suites_get_length(Object *obj)
> +{
> +    QCryptoTLSCipherSuites *s = QCRYPTO_TLS_CIPHER_SUITES(obj);
> +
> +    return s->cipher_count * sizeof(IANA_TLS_CIPHER);
> +}
> +
>  static void qcrypto_tls_cipher_suites_class_init(ObjectClass *oc, void *data)
>  {
>      UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
> +    FWCfgDataGeneratorClass *fwgc = FW_CFG_DATA_GENERATOR_CLASS(oc);
>  
>      ucc->complete = qcrypto_tls_cipher_suites_complete;
> +    fwgc->get_data = qcrypto_tls_cipher_suites_get_data;
> +    fwgc->get_length = qcrypto_tls_cipher_suites_get_length;
>  
>      object_class_property_add_bool(oc, "verbose",
>                                     qcrypto_tls_cipher_suites_get_verbose,
> @@ -121,6 +139,7 @@ static const TypeInfo qcrypto_tls_cipher_suites_info = {
>      .class_init = qcrypto_tls_cipher_suites_class_init,
>      .interfaces = (InterfaceInfo[]) {
>          { TYPE_USER_CREATABLE },
> +        { TYPE_FW_CFG_DATA_GENERATOR_INTERFACE },
>          { }
>      }
>  };
> 


