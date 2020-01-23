Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3118DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB4321D7E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 20:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gn6ox7wa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB4321D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuil2-0002zN-4K
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 15:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iuiSi-0007nW-HP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:48:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iuiO0-0006mS-HG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:43:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30876
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iuiO0-0006mE-Ca
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:43:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579808607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VmpSAuMroMMlOYZ54jRYwHYbXrR6QACNI4JoAjhMFgs=;
 b=Gn6ox7waRZvJL1oia0InMuCnOCp9wF/z36iTMG6BM8TqpWAFNBypLZI1YNC0Oi7NUG5WHu
 zrr980XhUbTavqfQXphurO3DoZWAyGTn7SOVi7XvjeUmBhtfufGkrdw8lUMXEO3wR0YeZy
 kU+a1xDaKWKl8LmW+INLab3Z6aeeaBE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-ReSnt0BwNh-FeVR0_w1Pcg-1; Thu, 23 Jan 2020 14:43:21 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAF7810120A1;
 Thu, 23 Jan 2020 19:43:20 +0000 (UTC)
Received: from [10.3.117.16] (ovpn-117-16.phx2.redhat.com [10.3.117.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCB7D81207;
 Thu, 23 Jan 2020 19:43:15 +0000 (UTC)
Subject: Re: [qemu-web PATCH v2] Add "Security Process" information to the
 main website
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200123171150.12782-1-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b24abc8e-032c-c95f-89ae-c6480cee8b3c@redhat.com>
Date: Thu, 23 Jan 2020 13:43:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200123171150.12782-1-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ReSnt0BwNh-FeVR0_w1Pcg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, sstabellini@kernel.org,
 pmatouse@redhat.com, pjp@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/23/20 11:11 AM, Thomas Huth wrote:
> One reporter of a security issue recently complained that it might not
> be the best idea to store our "Security Process" in the Wiki. Well, while
> the page in the Wiki is protected (so that only some few people can edit
> it), it is still possible that someone might find a bug in the Wiki
> software to alter the page contents...
> Anyway, it looks more trustworthy if we present the "Security Process"
> information in the static website instead. Thus this patch adds the
> information from the wiki to the Jekyll-based website now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Improved some sentences as suggested by Paolo
> 

> +### Publication embargo
> +
> +As a security issue reported, that is not already publically disclosed

publicly

> +elsewhere, has an embargo date assigned and communicated to reporter. Embargo

Reads awkwardly. I'd suggest:

If a security issue is reported that is not already publicly disclosed, 
an embargo date may be assigned and communicated to the reporter.

> +periods will be negotiated by mutual agreement between members of the security
> +team and other relevant parties to the problem. Members of the security contact
> +list agree not to publically disclose any details of the security issue until

publicly

> +the embargo date expires.
> +

> +
> +For  example, consider upstream commit [9201bb9 "sdhci.c: Limit the maximum
> +block size"](http://git.qemu.org/?p=qemu.git;a=commit;h=9201bb9), an of out of
> +bounds (OOB) memory access (ie. buffer overflow) issue that was found and fixed
> +in the SD Host  Controller emulation (hw/sd/sdhci.c).

Odd double space.

> +
> +On the surface, this bug appears to be a genuine security flaw, with potentially
> +severe implications. But digging further down, there are only two ways to use
> +SD Host Controller emulation, one is via 'sdhci-pci' interface and the other
> +is via 'generic-sdhci' interface.
> +
> +Of these two, the 'sdhci-pci' interface had actually been disabled by default
> +in the upstream QEMU releases (commit [1910913 "sdhci: Make device "sdhci-pci"
> +unavailable with -device"](http://git.qemu.org/?p=qemu.git;a=commit;h=1910913)
> +at the time the flaw was reported; therefore, guests could not possibly use
> +'sdhci-pci' for any  purpose.

and again.


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


