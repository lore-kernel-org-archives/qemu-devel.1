Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CADC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02A982068F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/FOvu2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A982068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDlW-0003et-Fl
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iYDHy-0007ig-3F
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iYDHx-0007BP-0R
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:04:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42068
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iYDHv-0007Ai-6p
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:04:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574445849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ySQG7cWfZzQZtFgz6Kd7R0X6Od/SAAdpMuSXT2y/ezA=;
 b=U/FOvu2q/xEAc6MX4WiX/JO4+b9oOhlVPh7fPzepJfLYj2hK6WcOcpMXRXfD8lGwFTOOEa
 UBLmuAf/CLORjvXXHZhbKsYbIRmz+LfeHJ2ByGmGN7YKGbA2IqN206XvB0wn9IDRBL8izU
 vvMTePp69pDC1Ikbx567bYvthZ3iubY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-AzbpoG_nMVGOeAKCsUjPrA-1; Fri, 22 Nov 2019 13:04:08 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FCD31800D41;
 Fri, 22 Nov 2019 18:04:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-84.ams2.redhat.com
 [10.36.116.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A46DC28DFE;
 Fri, 22 Nov 2019 18:03:57 +0000 (UTC)
Subject: Re: [RFC PATCH-for-5.0] hw/pci-host: Add Kconfig selector for IGD
 PCIe pass-through
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191122172201.11456-1-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f25d1c9b-e481-2cd3-ce90-3c2d15505406@redhat.com>
Date: Fri, 22 Nov 2019 19:03:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191122172201.11456-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: AzbpoG_nMVGOeAKCsUjPrA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/11/2019 18.22, Philippe Mathieu-Daud=C3=A9 wrote:
> Introduce a kconfig selector to allow builds without Intel
> Integrated Graphics Device GPU PCIe passthrough.
> We keep the default as enabled.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> RFC because to be able to use the Kconfig-generated
> "config-devices.h" header we have to move this device
> out of $common-obj and build i440fx.o on a per-target
> basis, which is not optimal...

IMHO you should move the code out of i440fx.o and into a separate file
if possible. That's hopefully cleaner than #ifdeffing here, and you
hopefully only need to move the new code into "obj-" and can keep
i440fx.o in common-obj.

 Thomas


