Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8868C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 22:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B07FF2467B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 22:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rn2vMMIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B07FF2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iczE2-0005Hr-Gv
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 17:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iczB7-0003vR-5r
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 17:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iczB0-0001ke-2Z
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 17:00:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23173
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iczAz-0001ge-QX
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 17:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575583242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJaZ6ckDnu2KNwFkAbDqp0R85Ol0a66ACiFalkjmurw=;
 b=Rn2vMMIoWFjs3tsj6aZo1kjefUo1gp2kGmFo6VuV6ga47oat3L4iwmiiznZ3Ic4ISQQMNZ
 xWqWiJJn/Gl6PFtutnn6/82R4d5PPXVvXt51Z/42Wl5CmQF7stVX5ie/0VfPrUdO0y/qdh
 tyMVxg/SUD8ezt1BT1KeVZ1Jy/6JOuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-3--SiK6EMNq1cp8JTsH66g-1; Thu, 05 Dec 2019 17:00:39 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEE94DBA9;
 Thu,  5 Dec 2019 22:00:36 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B8AF10372DB;
 Thu,  5 Dec 2019 22:00:36 +0000 (UTC)
Subject: Re: [libvirt] [PATCH 1/3] hw/i386: Remove the deprecated machines
 0.12 up to 0.15
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20191205160652.23493-1-thuth@redhat.com>
 <20191205160652.23493-2-thuth@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ae470823-ed46-ce15-9902-671b6b1f0989@redhat.com>
Date: Thu, 5 Dec 2019 16:00:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205160652.23493-2-thuth@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 3--SiK6EMNq1cp8JTsH66g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 10:06 AM, Thomas Huth wrote:
> They can't be used reliable for live-migration anymore (see
> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04516.html
> for details) and have been marked as deprecated since QEMU v4.0,
> so time to remove them now.
> 
> And while we're at it, mark the remaining pc-1.x machine types
> as deprecated now, too, so that we finally only have "pc-i440fx"
> and "pc-q35" machine types left (apart from the non-versioned
> "isapc" and "microvm") once we removed them in a couple of releases.

Did you mean s/removed/remove/ ?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


