Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB757C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 09:52:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D5B206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 09:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D5B206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38393 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYSao-0005tW-Kz
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 05:52:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hYSZz-0005cm-Kj
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hYSZy-0001pR-NW
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:51:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hYSZy-0001kk-Hr
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:51:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1B80451471;
	Wed,  5 Jun 2019 09:51:33 +0000 (UTC)
Received: from [10.40.204.44] (ovpn-204-44.brq.redhat.com [10.40.204.44])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2B5425D9CC;
	Wed,  5 Jun 2019 09:51:27 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org
References: <20190316234456.18140-1-philmd@redhat.com>
	<97745dfa-ceaf-6572-59ba-a37e8f3c1e89@redhat.com>
	<097f4f90-b190-93d3-5c72-756fb29f7cc3@redhat.com>
	<8e8abf8a-ba65-c03f-54e3-865f2919c4bd@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <79eb0459-c8cd-bb44-4f3c-4ba7364b706c@redhat.com>
Date: Wed, 5 Jun 2019 11:51:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8e8abf8a-ba65-c03f-54e3-865f2919c4bd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Wed, 05 Jun 2019 09:51:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1 0/2] hw/alpha: Add the CY82C693UB
 southbridge in Kconfig
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/05/2019 18:05, Philippe Mathieu-Daud=C3=A9 wrote:
> On 5/8/19 10:16 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Paolo, Thomas,
>>
>> On 4/29/19 1:29 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> CC'ing Thomas who is a Kconfig expert.
>>>
>>> On 3/17/19 12:44 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> Explicit the CY82C693UB southbridge used by the 264DP.
>>>>
>>>> Philippe Mathieu-Daud=C3=A9 (2):
>>>>   hw/isa/southbridge: Add the Cypress 82C693UB chipset
>>>>   hw/alpha/Kconfig: The 264DP machine use a CY82C693UB southbridge
>>
>> This series does not fix anything, but makes the kconfig graph cleaner=
.
>=20
> Ping?
>=20

You should merge the two patches: it will make clearer why you can
remove the flags from DP264 as we can see they are added in CY82C693UB.

I think it can also go through trivial.

Thanks,
Laurent

