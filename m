Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7994CC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EECF20752
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 14:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ip1PjZUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EECF20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51941 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEa7G-0006UV-Fl
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 10:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEa4d-0002Rv-Ss
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:53:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEa4c-0003F9-MG
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:53:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29285)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEa4c-0003B7-Gp
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 10:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584543214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zKi3TyfkiI1I+VC6LbsCHTB1Al0Ff40x7b6LPd1VdgY=;
 b=ip1PjZUzlmDX0j9aZfhQVZE9bnVKqyF8oOBUpDcNz9SCOGt+9s9Sly/MbBnp4BUjV4vEbj
 pbpedkmUjPN+cX7AUIOx8Et4NoMWpdTJ9smhAvA7MEUVbJizqOgLTlQVOuXggRszlArAVa
 AzaIVz0miQw7CWmv/ZApk5KC5BVX/cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-_2Ib7d4MPZO_bwokGs_9yg-1; Wed, 18 Mar 2020 10:53:32 -0400
X-MC-Unique: _2Ib7d4MPZO_bwokGs_9yg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EE9E1085951;
 Wed, 18 Mar 2020 14:53:23 +0000 (UTC)
Received: from gondolin (ovpn-113-129.ams2.redhat.com [10.36.113.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2BB560C63;
 Wed, 18 Mar 2020 14:53:21 +0000 (UTC)
Date: Wed, 18 Mar 2020 15:53:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v10 15/16] docs: system: Add protvirt docs
Message-ID: <20200318155318.0c80acd2.cohuck@redhat.com>
In-Reply-To: <20200318143047.2335-16-frankja@linux.ibm.com>
References: <20200318143047.2335-1-frankja@linux.ibm.com>
 <20200318143047.2335-16-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

On Wed, 18 Mar 2020 10:30:46 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's add some documentation for the Protected VM functionality.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  docs/system/s390x/protvirt.rst | 59 ++++++++++++++++++++++++++++++++++
>  docs/system/target-s390x.rst   |  5 +++
>  2 files changed, 64 insertions(+)
>  create mode 100644 docs/system/s390x/protvirt.rst

(...)

> +Booting from the image supplied on the QEMU command line requires that
> +the file passed via -kernel has the same memory layout as would result
> +from the disk boot. This memory layout includes the encrypted
> +components (kernel, initrd, cmdline), the stage3a loader and
> +metadata. In case this boot method is used, the command line
> +options -initrd and -cmdline are ineffective. The preparation of a PVM
> +image is done via the `genprotimg` tool from the s390-tools package.

I still think 'package' is not a good name (yes, I realize that
s390-tools' README uses that term as well :) I'd prefer 'collection' or
something like that, so it doesn't get confused with distro packages,
which may use a different name. But no strong opinion.

> diff --git a/docs/system/target-s390x.rst b/docs/system/target-s390x.rst
> index 4c8b7cdd66154d26..8d97158dc804af1c 100644
> --- a/docs/system/target-s390x.rst
> +++ b/docs/system/target-s390x.rst
> @@ -24,3 +24,8 @@ or vfio-ap is also available.
>  .. toctree::
>     s390x/vfio-ap
>  
> +Architectural features
> +~~~~~~~~

Architecture features
=====================

?

> +
> +.. toctree::
> +   s390x/protvirt

Otherwise, looks good to me.


