Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE720C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 17:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9AC2086D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 17:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9AC2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33490 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hal0G-0001r6-EK
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 13:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38946)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hakub-0006AG-Ev
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 13:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hakuY-0005Yo-J1
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 13:50:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41512)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hakuY-0005P8-Ah
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 13:50:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2712130BBE84;
 Tue, 11 Jun 2019 17:49:59 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3122A5DEF9;
 Tue, 11 Jun 2019 17:49:56 +0000 (UTC)
Date: Tue, 11 Jun 2019 18:49:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190611174954.GI2777@work-vm>
References: <20190610030852.16039-1-richardw.yang@linux.intel.com>
 <20190610030852.16039-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610030852.16039-2-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 11 Jun 2019 17:49:59 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] cutils: remove one unnecessary pointer
 operation
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> Since we will not operate on the next address pointed by out, it is not
> necessary to do addition on it.
> 
> After removing the operation, the function size reduced 16/18 bytes.

For me with a -O3 it didn't make any difference - the compiler was
already smart enough to spot it, but it is correct.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  util/cutils.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/util/cutils.c b/util/cutils.c
> index 9aacc422ca..1933a68da5 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -754,11 +754,11 @@ int uleb128_encode_small(uint8_t *out, uint32_t n)
>  {
>      g_assert(n <= 0x3fff);
>      if (n < 0x80) {
> -        *out++ = n;
> +        *out = n;
>          return 1;
>      } else {
>          *out++ = (n & 0x7f) | 0x80;
> -        *out++ = n >> 7;
> +        *out = n >> 7;
>          return 2;
>      }
>  }
> @@ -766,7 +766,7 @@ int uleb128_encode_small(uint8_t *out, uint32_t n)
>  int uleb128_decode_small(const uint8_t *in, uint32_t *n)
>  {
>      if (!(*in & 0x80)) {
> -        *n = *in++;
> +        *n = *in;
>          return 1;
>      } else {
>          *n = *in++ & 0x7f;
> @@ -774,7 +774,7 @@ int uleb128_decode_small(const uint8_t *in, uint32_t *n)
>          if (*in & 0x80) {
>              return -1;
>          }
> -        *n |= *in++ << 7;
> +        *n |= *in << 7;
>          return 2;
>      }
>  }
> -- 
> 2.19.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

