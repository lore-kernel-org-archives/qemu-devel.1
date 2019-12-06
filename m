Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55713C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 05:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8C420707
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 05:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXa3mXzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8C420707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1id5nZ-0000pd-57
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 00:05:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1id5mu-0000NY-EY
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:04:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1id5mt-0000DZ-3b
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:04:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54715
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1id5ms-00009h-RV
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 00:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575608657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=plxeAknv5eed5jstIZjsz0Oc2gIbhJcbeKzCEy/zK0w=;
 b=cXa3mXzOkSyA+93j/wDlV6YKGilf5S/O4eFYvZrvLMWDtDzurXEXV/kbkeymDCtkV5+YJj
 Se8jwSjJbXLUfImUSOLiT1a8GvA6bXgSOOH/wKA5qjiONqy7akYQRmi7G5WOH9/4JcZRf2
 nX0p/+8ZXskCLJfqzFxPecvPagoGxyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-cffz70JrPxSuMIOrD3vHqg-1; Fri, 06 Dec 2019 00:04:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90CA31005502;
 Fri,  6 Dec 2019 05:04:15 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-97.ams2.redhat.com [10.36.116.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8967065F40;
 Fri,  6 Dec 2019 05:04:05 +0000 (UTC)
Subject: Re: [libvirt] [PATCH 1/3] hw/i386: Remove the deprecated machines
 0.12 up to 0.15
To: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20191205160652.23493-1-thuth@redhat.com>
 <20191205160652.23493-2-thuth@redhat.com>
 <ae470823-ed46-ce15-9902-671b6b1f0989@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6ba48a97-67c8-c8eb-e8c7-ea06e5f9ce65@redhat.com>
Date: Fri, 6 Dec 2019 06:04:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ae470823-ed46-ce15-9902-671b6b1f0989@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: cffz70JrPxSuMIOrD3vHqg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On 05/12/2019 23.00, Eric Blake wrote:
> On 12/5/19 10:06 AM, Thomas Huth wrote:
>> They can't be used reliable for live-migration anymore (see
>> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04516.html
>> for details) and have been marked as deprecated since QEMU v4.0,
>> so time to remove them now.
>>
>> And while we're at it, mark the remaining pc-1.x machine types
>> as deprecated now, too, so that we finally only have "pc-i440fx"
>> and "pc-q35" machine types left (apart from the non-versioned
>> "isapc" and "microvm") once we removed them in a couple of releases.
> 
> Did you mean s/removed/remove/ ?

Yes :-)

 Thomas


