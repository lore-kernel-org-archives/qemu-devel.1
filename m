Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734A6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A232253D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btl2dM4I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A232253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iui7k-00087L-TX
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:26:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iugYT-0000Wh-H0
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:46:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iugYR-0001OB-I6
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:46:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53806
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iugYQ-0001Lh-5Z
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 12:46:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579801564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UqWcpkAG6te6ZTvC2GtC5y6/78hHzB3HNAboiyHr1mk=;
 b=btl2dM4IShfJRowXDRfO5PGQxYQbzzYLh3NiMhkw+essdPv0UeOC2N7RDGk5ABYdap0ils
 U/JLpJk0JzfEmMZY11nhJTSoteDk62oEcxOL8Cq5dG+agVongVq0WF3SwtAWiFoLv1Ot/d
 WqoFeDBuBT0pDspfkHOtv7RybTFHyIE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-VKrPNoDkNa6ETS99cjkW6A-1; Thu, 23 Jan 2020 12:42:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 081D11800D48;
 Thu, 23 Jan 2020 17:42:24 +0000 (UTC)
Received: from gondolin (ovpn-116-120.ams2.redhat.com [10.36.116.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 327CD100164D;
 Thu, 23 Jan 2020 17:42:20 +0000 (UTC)
Date: Thu, 23 Jan 2020 18:42:17 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/s390x: Add a more verbose comment about
 get_machine_class() and the wrappers
Message-ID: <20200123184217.21c0503a.cohuck@redhat.com>
In-Reply-To: <20200123170256.12386-1-thuth@redhat.com>
References: <20200123170256.12386-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: VKrPNoDkNa6ETS99cjkW6A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 18:02:56 +0100
Thomas Huth <thuth@redhat.com> wrote:

> While working on the "Enable adapter interruption suppression again"
> recently, I had to discover that the meaning of get_machine_class()
> and the related *_allowed() wrappers is not very obvious. Add a more
> verbose comment here to clarify how these should be used.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index e0e28139a2..7fb389f0e5 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -505,6 +505,18 @@ static inline void machine_set_dea_key_wrap(Object *obj, bool value,
>  
>  static S390CcwMachineClass *current_mc;
>  
> +/*
> + * Get the class of the s390-ccw-virtio machine that is currently in use.
> + * Note: libvirt is using the "none" machine to probe for the features of the
> + * host CPU, so in case this is called with the "none" machine, the function
> + * returns the TYPE_S390_CCW_MACHINE base class. In this base class, all the
> + * various "*_allowed" variables are enabled, so that the *_allowed() wrappers
> + * below return the correct default value for the "none" machine.

Maybe add a blank line here for readability? (Can do so while applying.)

> + * Attention! Do *not* add additional new wrappers for CPU features (e.g. like
> + * the ri_allowed() wrapper) via this mechanism anymore. CPU features should
> + * be handled via the CPU models, i.e. checking with cpu_model_allowed() during
> + * CPU initialization and s390_has_feat() later should be sufficient.
> + */
>  static S390CcwMachineClass *get_machine_class(void)
>  {
>      if (unlikely(!current_mc)) {
> @@ -521,19 +533,16 @@ static S390CcwMachineClass *get_machine_class(void)
>  
>  bool ri_allowed(void)
>  {
> -    /* for "none" machine this results in true */
>      return get_machine_class()->ri_allowed;
>  }
>  
>  bool cpu_model_allowed(void)
>  {
> -    /* for "none" machine this results in true */
>      return get_machine_class()->cpu_model_allowed;
>  }
>  
>  bool hpage_1m_allowed(void)
>  {
> -    /* for "none" machine this results in true */
>      return get_machine_class()->hpage_1m_allowed;
>  }
>  

Looks good to me, but will wait for a review or two.


