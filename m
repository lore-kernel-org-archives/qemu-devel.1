Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3344C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 12:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7AE20663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 12:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hn0JKXs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7AE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEuDW-0005Ve-TW
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 08:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEuCm-0004q2-KN
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 08:23:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEuCl-0007jv-LC
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 08:23:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:23265)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEuCl-0007jf-Hc
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 08:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584620599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AHSBeAZBOsICeUJZYPgCKpbxwrGW8xtAKij48lMTN6s=;
 b=Hn0JKXs2V8MScgnBvyptxA9HZBhJY24PfOtRJ4S8Q76srUPpuhdsvaVEHX7QrQ64Rjuzo7
 FFrZ7IPkwIWQ3tR3FXsA5gUjcVkO9LjlUs6xzUgwSkQ/dQ0WR47L3/eEjAz0jyqfE7N3ej
 cxwb6oQBC6nVkCxoPbkphg02YYdURSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-e_DX7sRDNE-3qovVit7wYA-1; Thu, 19 Mar 2020 08:23:17 -0400
X-MC-Unique: e_DX7sRDNE-3qovVit7wYA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 637CADBAE;
 Thu, 19 Mar 2020 12:23:16 +0000 (UTC)
Received: from gondolin (ovpn-113-188.ams2.redhat.com [10.36.113.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7CD9810027AA;
 Thu, 19 Mar 2020 12:23:12 +0000 (UTC)
Date: Thu, 19 Mar 2020 13:23:10 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v10 13/16] s390x: protvirt: Move IO control structures
 over SIDA
Message-ID: <20200319132310.0f994bd5.cohuck@redhat.com>
In-Reply-To: <20200318143047.2335-14-frankja@linux.ibm.com>
References: <20200318143047.2335-1-frankja@linux.ibm.com>
 <20200318143047.2335-14-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 10:30:44 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> For protected guests, we need to put the IO emulation results into the
> SIDA, so SIE will write them into the guest at the next entry.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/ioinst.c | 61 +++++++++++++++++++++++++++++++------------
>  1 file changed, 45 insertions(+), 16 deletions(-)
> 

> @@ -260,6 +269,13 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
>      }
>  
>      if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
> +        /*
> +         * The Ultravisor checks schid bit 16 to be one and bits 0-12
> +         * to be 0 and injects a operand exception itself.

As a side remark, that also implies that the ultravisor doesn't support
MCSS-E, which is highly unsurprising :)

Do we want to fence off enabling MCSS-E in the sda chsc for pv guests?
Probably not really needed, as Linux does not support it anyway.

> +         *
> +         * Hence we should never end up here.
> +         */
> +        g_assert(!s390_is_pv());
>          /*
>           * As operand exceptions have a lower priority than access exceptions,
>           * we check whether the memory area is writeable (injecting the

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


