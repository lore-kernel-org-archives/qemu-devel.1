Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614F7C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 13:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA1320848
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 13:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEQ0XEa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA1320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1VVT-000265-D3
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 08:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1j1VUQ-00012W-3g
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 08:22:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1j1VUO-0002AG-WD
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 08:22:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46210
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1j1VUO-00028F-SW
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 08:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581427328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uMUT90L3M0xQPN7orCe2kyL1JTF22Xnvhs+pYaON+CM=;
 b=XEQ0XEa/23MvI9RlS9w1S/GwISIbL/JtMg0FgKN45SW2yO4qJY/H5fpy4EIQu4v/u39LP4
 +P83usC0cDtn74QFEBd/sqDt/P4BmMBkOXSt5xq/A+GGoHeVSRx5KG0mbb46UWwWI3bD74
 tPnRrAHzfeXUtVcxFVMvMUYguSoZ2+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-M4X-ewZmPUefhn-WbH6l6Q-1; Tue, 11 Feb 2020 08:22:07 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC6F213E5;
 Tue, 11 Feb 2020 13:22:05 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F56A26FA3;
 Tue, 11 Feb 2020 13:21:56 +0000 (UTC)
Subject: Re: [RFC 1/2] tpm: Let the TPM TIS device be usable on ARM
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200210131523.27540-1-eric.auger@redhat.com>
 <20200210131523.27540-2-eric.auger@redhat.com>
 <5cbd1960-6138-f4d0-948f-1983cb0f93b0@redhat.com>
 <e69f69c5-40f5-1fe5-f298-129324cc7055@redhat.com>
 <CAFEAcA_TJ5gDMRNK=O-iaqksYL_aQFu7repo7wKi7pGb-A9cYQ@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <33a8885f-8367-b37a-a18b-564fa73f0504@redhat.com>
Date: Tue, 11 Feb 2020 14:21:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_TJ5gDMRNK=O-iaqksYL_aQFu7repo7wKi7pGb-A9cYQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: M4X-ewZmPUefhn-WbH6l6Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Eric Auger <eric.auger.pro@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, ardb@kernel.org,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 2/11/20 11:56 AM, Peter Maydell wrote:
> On Tue, 11 Feb 2020 at 08:35, Auger Eric <eric.auger@redhat.com> wrote:
>>
>> Hi Philippe,
>>
>> On 2/11/20 9:25 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> You don't need much to remove the RFC tag:
>>>
>>> - rename TYPE_TPM_TIS as TYPE_TPM_TIS_ISA
>>> - rename TPMState as TPMCommonState, add an abstract TYPE_TPM_TIS
>>> parent, let TYPE_TPM_TIS_ISA be a child
>>> - add TYPE_TPM_TIS_SYSBUS also child.
>> Yes I tried my luck without too much hopes ;-)
>=20
> There should be a few existing examples in the tree
> of devices that we provide in a sysbus and also
> an isa or pci flavour, that you can use as templates
> for how to structure the device.
Yes I found some. Thank you.

Eric

>=20
> -- PMM
>=20


