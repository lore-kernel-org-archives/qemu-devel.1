Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2286DC33CA9
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 953E7206DA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 16:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXo+3aOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 953E7206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir2Bh-0002Ae-GH
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 11:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ir2Af-0000x0-Uh
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:02:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ir2Ae-0004uL-TL
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:02:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42615
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ir2Ae-0004sj-MX
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 11:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578931347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=oq2RtYpbivJnnR0KBDaFMnN3Z7ghku/ulIO0AJdA36Y=;
 b=aXo+3aOQoFrWsJYqmyVDI/TofADSv2gFqGLmcvs7NyKIqeAQweVBM+i2cddcc91mvMbzTM
 rj2q1I27Wd5ySLIRgz57xsPaub+G5QYkwd4njuC0jnVKaT6ht1RGMZnxjF6csQiZ8xN2cM
 1JgyHWrrp+5EwwTIVZrIlo1Nh6BaMA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-7MSM0SLjOguCRuhojdN9cg-1; Mon, 13 Jan 2020 11:02:26 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F820184C712;
 Mon, 13 Jan 2020 16:02:25 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-87.ams2.redhat.com [10.36.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 407DD7E58B;
 Mon, 13 Jan 2020 16:02:24 +0000 (UTC)
Subject: Re: [PATCH v2 1/1] s390x/event-facility.c: remove unneeded labels
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
References: <20200108144607.878862-1-danielhb413@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <00966969-db8b-3b1a-3584-d581bd8ef91c@redhat.com>
Date: Mon, 13 Jan 2020 17:02:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200108144607.878862-1-danielhb413@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 7MSM0SLjOguCRuhojdN9cg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/01/2020 15.46, Daniel Henrique Barboza wrote:
> 'out' label from write_event_mask() and and write_event_data()
> can be replaced by 'return'.
> 
> The 'out' label from read_event_data() can also be replaced.
> However, as suggested by Cornelia Huck, instead of simply
> replacing the 'out' label, let's also change the code flow
> a bit to make it clearer that sccb events are always handled
> regardless of the mask for unconditional reads, while selective
> reads are handled if the mask is valid.
> 
> CC: Cornelia Huck <cohuck@redhat.com>
> CC: Thomas Huth <thuth@redhat.com>
> CC: Halil Pasic <pasic@linux.ibm.com>
> CC: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>

Wow, that cleans up quite a bit of goto-spaghetti-code!

Reviewed-by: Thomas Huth <thuth@redhat.com>


