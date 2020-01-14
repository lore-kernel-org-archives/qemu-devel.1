Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D48C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6890A24672
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 10:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwrZ8XAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6890A24672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irJkc-0002m1-AC
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 05:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1irJj3-0001D9-MT
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:47:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1irJiy-0007dq-Jt
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:47:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42333
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1irJiy-0007de-Ff
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 05:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578998823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=9ys/WjYoP5fbJR0Ho7a9eHHyfkiHcrgkgpsgzEkoN5c=;
 b=dwrZ8XAgH8QT5uWtEk9BBUZuHQeCHpRlTA0Znvub8Wk9L8ZIVuDJe8VJX0Cd4m1cHJ2bH/
 b1H0NfJ2DRwv2LTMNbaLccStyosn1XEwY+groUfCJtdrtheuLfM2j2we/dxGuIW8+SoVbN
 fPobIL6RxJli4etkMHTEIpEJbwIDNAM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-x-qpWO02NnuTab6MuvhwWQ-1; Tue, 14 Jan 2020 05:47:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8FE518CA26C
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 10:47:00 +0000 (UTC)
Received: from thuth.remote.csb (unknown [10.36.118.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3227184329;
 Tue, 14 Jan 2020 10:46:52 +0000 (UTC)
Subject: Re: [PATCH v2] hw/usb: Introduce Kconfig switches for the CCID card
 devices
To: Gerd Hoffmann <kraxel@redhat.com>
References: <20191211102029.1772-1-thuth@redhat.com>
 <20200107073607.zaeag7giehjm7t52@sirius.home.kraxel.org>
 <20200113094423.xljgmdxrvm676oyq@sirius.home.kraxel.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <bb5c47a4-5210-638d-5b6c-906f945da941@redhat.com>
Date: Tue, 14 Jan 2020 11:46:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200113094423.xljgmdxrvm676oyq@sirius.home.kraxel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: x-qpWO02NnuTab6MuvhwWQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/01/2020 10.44, Gerd Hoffmann wrote:
> On Tue, Jan 07, 2020 at 08:36:07AM +0100, Gerd Hoffmann wrote:
>> On Wed, Dec 11, 2019 at 11:20:29AM +0100, Thomas Huth wrote:
>>> In our downstream distribution of QEMU, we need more fine-grained
>>> control on the set of CCID card devices that we want to include.
>>> So let's introduce some proper Kconfig switches that it is easier
>>> to disable them without modifying the corresponding Makefile.objs.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>
>> Added to usb queue.
> 
> Oops, this patch breaks "make check" on openbsd (make
> TARGET_LIST=x86_64-softmmu vm-build-openbsd).  Unqueued.

Sorry, I missed that tests/qtest/usb-hcd-xhci-test.c uses the "usb-ccid"
device ... I'll fix my patch and send a v3.

 Thomas


