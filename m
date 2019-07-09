Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CB3C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 06:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CA9120861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 06:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA9120861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkjZo-0004cj-Bq
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 02:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60236)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hkjYk-00045i-0z
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 02:25:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hkjYi-0001IX-Iy
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 02:25:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hkjYi-0001Hj-CK
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 02:25:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 49A1933027C;
 Tue,  9 Jul 2019 06:24:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ECA7F5C548;
 Tue,  9 Jul 2019 06:24:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7E1A51138648; Tue,  9 Jul 2019 08:24:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Anthony PERARD <anthony.perard@citrix.com>
References: <20190704153605.4140-1-anthony.perard@citrix.com>
Date: Tue, 09 Jul 2019 08:24:52 +0200
In-Reply-To: <20190704153605.4140-1-anthony.perard@citrix.com> (Anthony
 PERARD's message of "Thu, 4 Jul 2019 16:36:05 +0100")
Message-ID: <8736jfafnv.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 09 Jul 2019 06:24:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] xen: Fix ring.h header
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
Cc: xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 qemu-devel@nongnu.org, Paul Durrant <paul.durrant@citrix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Anthony PERARD <anthony.perard@citrix.com> writes:

> The xen_[rw]?mb() macros defined in ring.h can't be used and the fact
> that there are gated behind __XEN_INTERFACE_VERSION__ means that it
> needs to be defined somewhere. QEMU doesn't implement interfaces with
> the Xen hypervisor so defining __XEN_INTERFACE_VERSION__ is pointless.
> This leads to:
>     include/hw/xen/io/ring.h:47:5: error: "__XEN_INTERFACE_VERSION__"
>         is not defined, evaluates to 0 [-Werror=undef]
>
> Cleanup ring.h. The xen_*mb() macros are already defined in xenctrl.h
> which is included in xen_common.h.
>
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>
> Notes:
>     A similar patch have been sent to the canonical version:
>     https://lists.xenproject.org/archives/html/xen-devel/2019-07/msg00370.html

That patch has an additional hunk:

  @@ -33,6 +33,13 @@
    * - standard integers types (uint8_t, uint16_t, etc)
    * They are provided by stdint.h of the standard headers.
    *
  + * Before using the different macros, you need to provide the following
  + * macros:
  + * - xen_mb()  a memory barrier
  + * - xen_rmb() a read memory barrier
  + * - xen_wmb() a write memory barrier
  + * Example of those can be found in xenctrl.h.
  + *
    * In addition, if you intend to use the FLEX macros, you also need to
    * provide the following, before invoking the FLEX macros:
    * - size_t

Suggest to include it in this patch, because (1) it's useful (I think),
and (2) it reduces differences to upstream Xen's version.

>
>  include/hw/xen/interface/io/ring.h | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/include/hw/xen/interface/io/ring.h b/include/hw/xen/interface/io/ring.h
> index 1adacf09f9..704990a2c9 100644
> --- a/include/hw/xen/interface/io/ring.h
> +++ b/include/hw/xen/interface/io/ring.h
> @@ -42,12 +42,6 @@
>   * and grant_table.h from the Xen public headers.
>   */
>  
> -#if __XEN_INTERFACE_VERSION__ < 0x00030208
> -#define xen_mb()  mb()
> -#define xen_rmb() rmb()
> -#define xen_wmb() wmb()
> -#endif
> -
>  typedef unsigned int RING_IDX;
>  
>  /* Round a 32-bit unsigned constant down to the nearest power of two. */

Regardless of my suggestion:
Reviewed-by: Markus Armbruster <armbru@redhat.com>

