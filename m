Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3DEC43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7031720645
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 15:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7031720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52234 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfQjW-00036k-FO
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 11:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40134)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hfQgC-0001ne-OA
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hfQgA-0007c0-Sp
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 11:14:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1hfQfv-0006GM-9a; Mon, 24 Jun 2019 11:14:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3FC8730872EE;
 Mon, 24 Jun 2019 15:14:30 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04EAE19C6A;
 Mon, 24 Jun 2019 15:14:23 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190620122132.10075-1-philmd@redhat.com>
 <20190620122132.10075-2-philmd@redhat.com>
 <6a0086e7-79ea-fc5e-6359-c1d4d256bf6e@redhat.com>
Message-ID: <ebe04ce2-0e0a-c764-e235-3aabd420439e@redhat.com>
Date: Mon, 24 Jun 2019 17:14:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6a0086e7-79ea-fc5e-6359-c1d4d256bf6e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Mon, 24 Jun 2019 15:14:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 1/3] hw/firmware: Add Edk2Crypto and
 edk2_add_host_crypto_policy()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/24/19 16:53, Laszlo Ersek wrote:
> (+Daniel)
>=20
> On 06/20/19 14:21, Philippe Mathieu-Daud=C3=A9 wrote:

>>   $ qemu-system-x86_64 \
>>       --object edk2_crypto,id=3Dhttps,\
>>               ciphers=3D/etc/crypto-policies/back-ends/openssl.config,=
\
>>               cacerts=3D/etc/pki/ca-trust/extracted/edk2/cacerts.bin

(12) Regarding the command line. It just occurs to me that Daniel
suggested [*] that libvirt should not be taught about this feature
specifically.

Thus, I think we need properties that are "smarter" than plain
user-specified strings:

- they should have default values (the ones your example includes above)

- for each of the properties: if the default pathname fails to identify
a file, then treat it as a normal situation (leave the corresponding
fields NULL)

- if the user overrides the default, and the pathname resolution fails,
then that should generate an error

- the user should be permitted to override the default such that the
corresponding setting is disabled (i.e. no error, but also no loading)


It's too bad that I'm not sure about the right way to implement this. It
reminds me of On/Off/Auto, but only vaguely.

In fact, if we never want to teach libvirt about this feature, then we
essentially expect QEMU to auto-load these files, whenever they exist --
even if the guest ends up booting something other than edk2 firmware!

[*] https://bugzilla.redhat.com/show_bug.cgi?id=3D1536624#c11 --
unfortunately, this is a private RHBZ :(

Thanks
Laszlo

