Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05E7C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B717521773
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 12:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B717521773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53094 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT4Gx-0006dC-1G
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 08:53:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hT4G9-0006EN-A3
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hT4G7-0005Xz-An
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:52:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hT4G5-0005Ud-DR
	for qemu-devel@nongnu.org; Tue, 21 May 2019 08:52:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBBBC3E2B0;
	Tue, 21 May 2019 12:52:44 +0000 (UTC)
Received: from [10.40.205.57] (unknown [10.40.205.57])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7703278482;
	Tue, 21 May 2019 12:52:43 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
References: <1557953433-19663-1-git-send-email-pbonzini@redhat.com>
	<1557953433-19663-19-git-send-email-pbonzini@redhat.com>
	<20190521115259.GK25835@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <f0d7e267-5f21-927a-ee38-2330fde5a419@redhat.com>
Date: Tue, 21 May 2019 14:52:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190521115259.GK25835@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Tue, 21 May 2019 12:52:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 18/21] build: don't build hardware objects
 with linux-user
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
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/05/2019 13:52, Daniel P. Berrang=C3=A9 wrote:
> On Wed, May 15, 2019 at 10:50:30PM +0200, Paolo Bonzini wrote:
>> From: Laurent Vivier <lvivier@redhat.com>
>>
>> Some objects are only needed for system emulation and tools.
>> We can ignore them for the user mode case
>>
>> Update tests to run accordingly: conditionally build some tests
>> on CONFIG_BLOCK.
>>
>> Some tests use components that are only built when softmmu or
>> block tools are enabled, not for linux-user. So, if these components
>> are not available, disable the tests.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> Message-Id: <20190401141222.30034-6-lvivier@redhat.com>
>> ---
>>   Makefile               |  4 +++
>>   Makefile.objs          | 14 +++++---
>>   tests/Makefile.include | 90 +++++++++++++++++++++++++---------------=
----------
>>   3 files changed, 58 insertions(+), 50 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 1851f8c..155f066 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -87,6 +87,10 @@ endif
>>  =20
>>   include $(SRC_PATH)/rules.mak
>>  =20
>> +# notempy and lor are defined in rules.mak
>> +CONFIG_TOOLS :=3D $(call notempty,$(TOOLS))
>> +CONFIG_BLOCK :=3D $(call lor,$(CONFIG_SOFTMMU),$(CONFIG_TOOLS))
>=20
> IMHO calling this CONFIG_BLOCK is a really poor choice, as
> the decision is completely unrelated to block modules. It
> made really confused when trying to understand why all the
> crypto or auth code had been made conditional on the block
> drivers.  The block code is just one part of QEMU that
> is used in tools & softmmu.
>=20
> It would be better as CONFIG_SOFTMMU_TOOLS, or
> CONFIG_NOT_USER, or something else.

Do you think it's worth a patch to change the name?

Thanks,
Laurent

