Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80561CA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 04:22:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404A320663
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 04:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eqvo0jkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404A320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOwXg-000678-GK
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 00:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1iOwWr-0005Sz-9X
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 00:21:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1iOwWo-0001re-Tw
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 00:21:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50790
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1iOwWo-0001qq-MR
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 00:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572236472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r9quktif4d9lbvkITU5AxhoKyQLburVuJ2QSyA2WFGU=;
 b=Eqvo0jkLyu1pBdr+rsf9H35l87GlnS0vf+Ocok6cr1Q23WYq+dmBBs+4TDVzAmrBPQzyt0
 I17Y3LDvVOavR0pl0f9eS2EqGbQbWQa/f5oYcTWn3qufept5f+GURjbnzy+ZGoZJ1b++oU
 vzFe6SkDElygMvMLBFQTFDqWrQ3k3OA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-o7NlLtlXMTqEfVehsxkPNg-1; Mon, 28 Oct 2019 00:21:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBDA65E4;
 Mon, 28 Oct 2019 04:21:08 +0000 (UTC)
Received: from [10.72.12.246] (ovpn-12-246.pek2.redhat.com [10.72.12.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA20960925;
 Mon, 28 Oct 2019 04:21:04 +0000 (UTC)
Subject: Re: [PATCH v2] net: add tulip (dec21143) driver
To: "Michael S. Tsirkin" <mst@redhat.com>, Sven Schnelle <svens@stackframe.org>
References: <20191022155413.4619-1-svens@stackframe.org>
 <20191025074243-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <13faadf6-64d1-bc6c-5110-79bef99055a0@redhat.com>
Date: Mon, 28 Oct 2019 12:21:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191025074243-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: o7NlLtlXMTqEfVehsxkPNg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/10/25 =E4=B8=8B=E5=8D=887:43, Michael S. Tsirkin wrote:
> On Tue, Oct 22, 2019 at 05:54:13PM +0200, Sven Schnelle wrote:
>> This adds the basic functionality to emulate a Tulip NIC.
> Jason, do you want to queue this?
>
> Overall ok so
>
> Acked-by: Michael S. Tsirkin<mst@redhat.com>
>

Yes, I've queued V3 of this.

Thanks


