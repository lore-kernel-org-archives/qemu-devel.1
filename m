Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82250CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 08:48:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA762086D
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 08:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDQyw50q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA762086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ68G-0006zp-AK
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 04:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58536)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iQ66Z-0007vd-40
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iQ66W-000245-V7
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:46:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50108
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iQ66W-0001yT-ME
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572511607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fUkLfPHE9zExcZwIGDFSQRDzHSGXwjSlpVRCRJv9/ds=;
 b=ZDQyw50qlF91EraK9rYSL+u6Om26LHDdSmPwN5mXs+1qfjlApv9aZBUYbBzFvlbvJUUtKP
 JzwK0jc7kPlq5aDS6jcVrZ+i2qyLvmNcAlpi3ZbQOnC7Lqa/bYkzarJHF2FFaENrFBm+4Y
 Glx3LyrEqR356/WQ+0ui5kstLZoTWBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-DsYNwf9kPyOzYLvF01V55A-1; Thu, 31 Oct 2019 04:46:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E6871800D55
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 08:46:43 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-6.ams2.redhat.com
 [10.36.117.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CA05D600CE;
 Thu, 31 Oct 2019 08:46:36 +0000 (UTC)
Subject: Re: [PATCH 0/2] fw_cfg: Allow reboot-timeout=-1 again
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
References: <20191029170124.27981-1-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <cbc29fd8-66b7-7497-b9a1-f5741352113d@redhat.com>
Date: Thu, 31 Oct 2019 09:46:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191029170124.27981-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: DsYNwf9kPyOzYLvF01V55A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/19 18:01, Philippe Mathieu-Daud=C3=A9 wrote:
> Fix the '-1' special value, and add a test.
>=20
> Dr. David Alan Gilbert (1):
>   fw_cfg: Allow reboot-timeout=3D-1 again
>=20
> Philippe Mathieu-Daud=C3=A9 (1):
>   tests/fw_cfg: Test 'reboot-timeout=3D-1' special value
>=20
>  hw/nvram/fw_cfg.c   |  7 ++++---
>  tests/fw_cfg-test.c | 21 +++++++++++++++++++++
>  2 files changed, 25 insertions(+), 3 deletions(-)
>=20

series
Reviewed-by: Laszlo Ersek <lersek@redhat.com>


