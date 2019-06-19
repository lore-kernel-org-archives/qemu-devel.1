Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F88BC31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 17:48:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB13214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 17:48:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB13214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40834 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdehA-0004hz-Q7
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 13:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49550)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hdebg-0002QP-Kk
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 13:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hdeWn-0004VL-EW
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 13:37:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hdeWl-0004Rv-E4
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 13:37:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4CA6966995;
 Wed, 19 Jun 2019 17:37:32 +0000 (UTC)
Received: from work-vm (ovpn-117-113.ams2.redhat.com [10.36.117.113])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4207F5C205;
 Wed, 19 Jun 2019 17:37:29 +0000 (UTC)
Date: Wed, 19 Jun 2019 18:37:26 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Message-ID: <20190619173726.GG2844@work-vm>
References: <20190619162140.133674-1-liran.alon@oracle.com>
 <20190619162140.133674-8-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619162140.133674-8-liran.alon@oracle.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 19 Jun 2019 17:37:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [QEMU PATCH v4 07/10] vmstate: Add support for
 kernel integer types
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, maran.wilson@oracle.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 jmattson@google.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Liran Alon (liran.alon@oracle.com) wrote:
> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
> Reviewed-by: Maran Wilson <maran.wilson@oracle.com>
> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> ---
>  include/migration/vmstate.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 9224370ed59a..ca68584eba4d 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -797,6 +797,19 @@ extern const VMStateInfo vmstate_info_qtailq;
>  #define VMSTATE_UINT64_V(_f, _s, _v)                                  \
>      VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64, uint64_t)
>  
> +#ifdef CONFIG_LINUX
> +
> +#define VMSTATE_U8_V(_f, _s, _v)                                   \
> +    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint8, __u8)
> +#define VMSTATE_U16_V(_f, _s, _v)                                  \
> +    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint16, __u16)
> +#define VMSTATE_U32_V(_f, _s, _v)                                  \
> +    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint32, __u32)
> +#define VMSTATE_U64_V(_f, _s, _v)                                  \
> +    VMSTATE_SINGLE(_f, _s, _v, vmstate_info_uint64, __u64)
> +
> +#endif
> +

Right, and that works as well as the comment I suggested, so

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  #define VMSTATE_BOOL(_f, _s)                                          \
>      VMSTATE_BOOL_V(_f, _s, 0)
>  
> @@ -818,6 +831,19 @@ extern const VMStateInfo vmstate_info_qtailq;
>  #define VMSTATE_UINT64(_f, _s)                                        \
>      VMSTATE_UINT64_V(_f, _s, 0)
>  
> +#ifdef CONFIG_LINUX
> +
> +#define VMSTATE_U8(_f, _s)                                         \
> +    VMSTATE_U8_V(_f, _s, 0)
> +#define VMSTATE_U16(_f, _s)                                        \
> +    VMSTATE_U16_V(_f, _s, 0)
> +#define VMSTATE_U32(_f, _s)                                        \
> +    VMSTATE_U32_V(_f, _s, 0)
> +#define VMSTATE_U64(_f, _s)                                        \
> +    VMSTATE_U64_V(_f, _s, 0)
> +
> +#endif
> +
>  #define VMSTATE_UINT8_EQUAL(_f, _s, _err_hint)                        \
>      VMSTATE_SINGLE_FULL(_f, _s, 0, 0,                                 \
>                          vmstate_info_uint8_equal, uint8_t, _err_hint)
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

