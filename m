Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2149DC3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 22:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE1D206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 22:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hp0GX+yc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE1D206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9zDV-0007T4-3Y
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 17:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1j9zCl-00071W-Rn
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 17:43:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1j9zCk-0008Lt-Qu
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 17:42:59 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28106
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1j9zCk-0008KG-NG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 17:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583448177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Tx8fEiZZQAdn2hzwv+4RuJKq4J/WbqP4eTHnZujM9g=;
 b=hp0GX+ycuMWrvhC+QiSdVHgctVrrY39KuP3jdyj2KNhTqts2x0lus9jHFjqDS5i3BRORWu
 k7Y0zQXDv4pDRHOdzEKdgEIJhTI6Ff1Cmxijt6pLCtpjtMaEXMQLsCropyLV4yviOvqa8L
 nYKtgq5Yg9QKhF4mTStzih78wmuQPc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-L87OZaaDPkmbcfWrtZVrNQ-1; Thu, 05 Mar 2020 17:42:51 -0500
X-MC-Unique: L87OZaaDPkmbcfWrtZVrNQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D14CA18FF669
 for <qemu-devel@nongnu.org>; Thu,  5 Mar 2020 22:42:50 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-216.ams2.redhat.com
 [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 311B090796;
 Thu,  5 Mar 2020 22:42:46 +0000 (UTC)
Subject: Re: [PULL 1/1] qxl: introduce hardware revision 5
To: Yuri Benditovich <ybendito@redhat.com>
References: <20200213090627.2181-1-kraxel@redhat.com>
 <20200213090627.2181-2-kraxel@redhat.com>
 <bb1f9cbb-7f98-e955-c55d-abc36e788902@redhat.com>
 <1472901155.11933269.1583395037984.JavaMail.zimbra@redhat.com>
 <e69ea9ab-9fc1-ca12-c7ab-50e094c1c782@redhat.com>
 <1043730203.12069417.1583435373924.JavaMail.zimbra@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <32401434-146d-f049-cd61-9e5ba574f1fd@redhat.com>
Date: Thu, 5 Mar 2020 23:42:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1043730203.12069417.1583435373924.JavaMail.zimbra@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: qemu-devel@nongnu.org, Yan Vugenfirer <yvugenfi@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/05/20 20:09, Yuri Benditovich wrote:

> This is the latest release 
> https://www.spice-space.org/download/windows/qxl-wddm-dod/qxl-wddm-dod-0.19/ 

"spice-qxl-wddm-dod-0.19-8.1-compatible.zip" solved the issue in my
Windows 8.1 and Windows Server 2012 R2 guests.

"spice-qxl-wddm-dod-0.19.zip" solved the issue in my Windows 10 guest.

The driver updates were painless.

Thanks!
Laszlo


