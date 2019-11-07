Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352CDC43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050B32087E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/lKDT3p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050B32087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSnYG-0005aM-Vy
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 14:34:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51758)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iSnVu-0003ep-90
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:32:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iSnVp-0002x7-Mg
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:32:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57778
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iSnVo-0002ve-T9
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573155127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x4JupZN51xQJAmN9k43J70Vc8dSEcR06TByvDZ0NiUY=;
 b=T/lKDT3pv/L8Tin8CKSo4aMqIsHfnZaey4sq8xleWwP3ZXs+BeNQHPaKc+9R89leI7ghQf
 bLcnXc0oOXJgS0ivKOfnMSLo6THWjctBB6qonJ4ApLYPAI/Zs1NhcZEkgN7HWtOlcP/l2G
 QgN5/z7XyV4aQe+Yid8d9nuTsXJ+R5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-vOBXN-JKMQ2rD0TJMMjkwg-1; Thu, 07 Nov 2019 14:32:04 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEDB5107ACC3;
 Thu,  7 Nov 2019 19:32:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-31.ams2.redhat.com
 [10.36.116.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BF523DA3;
 Thu,  7 Nov 2019 19:31:56 +0000 (UTC)
Subject: Re: [PATCH-for-4.1? 0/7] vl: Allow building with CONFIG_BLUETOOTH
 disabled
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20190712133928.21394-1-philmd@redhat.com>
 <421f2fb2-6e8d-7579-029a-e8de726c6a5e@redhat.com>
 <56d102b4-3f55-7070-c012-56ad65138873@redhat.com>
 <CAFEAcA8axpVeXjWV+2cz8PL-gR_6GvU=i0BMt01pYhff_1LOwQ@mail.gmail.com>
 <4ed2e2b7-91b0-197f-7532-bf9daac075bf@redhat.com>
 <d79cec06-ff17-a118-7bf9-91ae1791c014@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <831c720f-17b7-c19d-292c-4832b7d8b1b8@redhat.com>
Date: Thu, 7 Nov 2019 20:31:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <d79cec06-ff17-a118-7bf9-91ae1791c014@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: vOBXN-JKMQ2rD0TJMMjkwg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Miroslav Rezanina <mrezanin@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/11/2019 20.09, Philippe Mathieu-Daud=C3=A9 wrote:
[...]
> Bluetooth is dead, long live BT!
>=20
> v4.2.0-rc0 just got tagged. We should stop linking unmaintained dead=20
> code. If nobody step in to nuke BT, we should consider applying this=20
> series before we release QEMU 5.0 with dead Bluetooth. This approach is=
=20
> still better than burying our head in the sand.

FWIW, I'm planning to send some patches to remove the bluetooth code in=20
the 5.0 development cycle. Unless you want to beat me to it. But I don't=20
think it makes sense to still make this configurable. The bluetooth code=20
has been marked as deprecated for a while now, and nobody spoke up that=20
they are still using it (and as far as I can tell, it's currently not=20
usable anymore anyway), so it should simply be removed now.

  Thomas


