Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBA2C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 06:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BCB3206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 06:17:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGI7p4vs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BCB3206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkiRK-0001OG-F7
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 02:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jkiQc-0000Xj-Vh
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 02:17:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54770
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1jkiQb-0001RN-5T
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 02:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592201824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5n7mSOvS9liECnzZA7za68bTFSNci/7+CoU9Kcq1aRU=;
 b=YGI7p4vsn90QceGxCpJvpbsdC1bhnZQrvNmYO/l24A5lDFXoGQvCgJwH5qQ2TBhqRGQ7AX
 nE5FDyhKJagzOZsFlr6anuOx0Rl6KmD+3Rdg4O2AaBOj9hRX4LW91uUPSbiPeEUA6u4Aqx
 h/1XLeHOZJ6+WDtJ4Q9qCT88qGc7wzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-D2M8KWmrMH2PepcxrX8OHA-1; Mon, 15 Jun 2020 02:16:52 -0400
X-MC-Unique: D2M8KWmrMH2PepcxrX8OHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2A561009600
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 06:16:51 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-132.ams2.redhat.com
 [10.36.112.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9384E60BF1;
 Mon, 15 Jun 2020 06:16:47 +0000 (UTC)
Subject: Re: [PATCH v8 5/5] crypto/tls-cipher-suites: Produce fw_cfg
 consumable blob
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200609170727.9977-1-philmd@redhat.com>
 <20200609170727.9977-6-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <157cdc98-98b5-00c1-86e5-f3f201299098@redhat.com>
Date: Mon, 15 Jun 2020 08:16:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Firefox/52.0 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200609170727.9977-6-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lersek@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:17:36
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/09/20 19:07, Philippe Mathieu-Daudé wrote:
> Since our format is consumable by the fw_cfg device,
> we can implement the FW_CFG_DATA_GENERATOR interface.
> 
> Acked-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v8: Add example in qemu-options.hx
> ---
>  crypto/tls-cipher-suites.c | 19 +++++++++++++++++++
>  qemu-options.hx            | 19 +++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/crypto/tls-cipher-suites.c b/crypto/tls-cipher-suites.c
> index f02a041f9a..d6ea0ed190 100644
> --- a/crypto/tls-cipher-suites.c
> +++ b/crypto/tls-cipher-suites.c
> @@ -14,6 +14,7 @@
>  #include "qemu/error-report.h"
>  #include "crypto/tlscreds.h"
>  #include "crypto/tls-cipher-suites.h"
> +#include "hw/nvram/fw_cfg.h"
>  #include "trace.h"
>  
>  static void parse_cipher_suites(QCryptoTLSCipherSuites *s,
> @@ -99,11 +100,28 @@ static void qcrypto_tls_cipher_suites_finalize(Object *obj)
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
>  }
>  
>  static const TypeInfo qcrypto_tls_cipher_suites_info = {
> @@ -115,6 +133,7 @@ static const TypeInfo qcrypto_tls_cipher_suites_info = {
>      .class_init = qcrypto_tls_cipher_suites_class_init,
>      .interfaces = (InterfaceInfo[]) {
>          { TYPE_USER_CREATABLE },
> +        { TYPE_FW_CFG_DATA_GENERATOR_INTERFACE },
>          { }
>      }
>  };
> diff --git a/qemu-options.hx b/qemu-options.hx
> index c74366d7cc..b12cc910e3 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4585,6 +4585,25 @@ SRST
>          string as described at
>          https://gnutls.org/manual/html_node/Priority-Strings.html.
>  
> +        An example of use of this object is to enable the UEFI HTTPS Boot.

(1) s/enable the/control/

(yes, please drop the "the")

> +        The tls-cipher-suites object exposes the ordered list of permitted
> +        TLS cipher suites from the host side to the firmware, via

(2) s/firmware/guest firmware/

> +        fw_cfg. The list is represented as an array of IANA_TLS_CIPHER
> +        objects. The firmware uses the IANA_TLS_CIPHER array for configuring
> +        guest-side TLS.
> +
> +        In the following example, the priority at which the host-side policy
> +        is retrieved is given by the ``priority`` property of the new object
> +        type. ``priority=@SYSTEM`` may be used to refer to

(3) s/ of the new object type//

Acked-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo

> +        /etc/crypto-policies/back-ends/gnutls.config (given that QEMU uses
> +        GNUTLS).
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


