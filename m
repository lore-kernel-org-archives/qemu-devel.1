Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30596C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:15:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7AE2084C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 11:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpxiIf6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7AE2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc596-0006sh-8t
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 06:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kc58C-0006Ey-NR
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:14:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1kc58B-0000eZ-5X
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 06:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604920478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UXuS91D/IYIWS13CCHkpmfwCr+FIHQYjKOw2cBiVCRw=;
 b=YpxiIf6jxyeZgZftGgHOyN1OmqW7mEATpEwdGqRUMEwsZSlg68gbNX7UwkTuCPGi/6H5OR
 A3ZySA/M/bBT1vBzyg+hrMpsXx2jDFOFJMkxPJt0A9SBrLrVhnYexqxP648C/NHUw6yiqZ
 +esy4VOi5q7K/oP+bTaufP+kyIxDefk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-3US_RHMnPKyHhqAO8vC4WA-1; Mon, 09 Nov 2020 06:14:34 -0500
X-MC-Unique: 3US_RHMnPKyHhqAO8vC4WA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D24DE5F9ED;
 Mon,  9 Nov 2020 11:14:32 +0000 (UTC)
Received: from gondolin (ovpn-113-28.ams2.redhat.com [10.36.113.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9353E1002C00;
 Mon,  9 Nov 2020 11:14:26 +0000 (UTC)
Date: Mon, 9 Nov 2020 12:14:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Daniele Buono <dbuono@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 4/9] s390x: Avoid variable size warning in ipl.h
Message-ID: <20201109121422.0a663e71.cohuck@redhat.com>
In-Reply-To: <20201105221905.1350-5-dbuono@linux.vnet.ibm.com>
References: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
 <20201105221905.1350-5-dbuono@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, "open list:S390-ccw
 boot" <qemu-s390x@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu,  5 Nov 2020 17:19:00 -0500
Daniele Buono <dbuono@linux.vnet.ibm.com> wrote:

> S390IPLState contains two IplParameterBlock, which may in turn have
> either a IPLBlockPV or a IplBlockFcp, both ending with a variable
> sized field (an array).
> 
> This causes a warning with clang 11 or greater, which checks that
> variable sized type are only allocated at the end of the struct:
> 
> In file included from ../qemu-cfi-v3/target/s390x/diag.c:21:
> ../qemu-cfi-v3/hw/s390x/ipl.h:161:23: error: field 'iplb' with variable sized type 'IplParameterBlock' (aka 'union IplParameterBlock') not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
>     IplParameterBlock iplb;
>                       ^
> ../qemu-cfi-v3/hw/s390x/ipl.h:162:23: error: field 'iplb_pv' with variable sized type 'IplParameterBlock' (aka 'union IplParameterBlock') not at the end of a struct or class is a GNU extension [-Werror,-Wgnu-variable-sized-type-not-at-end]
>     IplParameterBlock iplb_pv;
> 
> In this case, however, the warning is a false positive, because
> IPLBlockPV and IplBlockFcp are allocated in a union wrapped at 4K,
> making the union non-variable sized.
> 
> Fix the warning by turning the two variable sized arrays into arrays
> of size 0. This avoids the compiler error and should produce the
> same code.
> 
> Signed-off-by: Daniele Buono <dbuono@linux.vnet.ibm.com>
> ---
> There is the possibility of removing  IplBlockFcp from
> IplParameterBlock, since it is not actually used.
> This would also allow to entirely remove the definition of
> IplBlockFcp, but we may want to keep it for completeness.

We can easily do that in the future clean-up round, if we want that.

> 
>  hw/s390x/ipl.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 9e90169695..dfc6dfd89c 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -32,7 +32,7 @@ struct IPLBlockPV {
>      uint32_t num_comp;          /* 0x74 */
>      uint64_t pv_header_addr;    /* 0x78 */
>      uint64_t pv_header_len;     /* 0x80 */
> -    struct IPLBlockPVComp components[];
> +    struct IPLBlockPVComp components[0];
>  } QEMU_PACKED;
>  typedef struct IPLBlockPV IPLBlockPV;
>  
> @@ -63,7 +63,7 @@ struct IplBlockFcp {
>      uint64_t br_lba;
>      uint32_t scp_data_len;
>      uint8_t  reserved6[260];
> -    uint8_t  scp_data[];
> +    uint8_t  scp_data[0];
>  } QEMU_PACKED;
>  typedef struct IplBlockFcp IplBlockFcp;
>  

For now, this is a nicely small patch.

Acked-by: Cornelia Huck <cohuck@redhat.com>


