Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA06FC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4032168B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 11:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4032168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52992 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU8jt-0000nh-UZ
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 07:51:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hU8im-00007R-Vo
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hU8ih-0007B8-75
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:50:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hU8ih-0007Av-1w
	for qemu-devel@nongnu.org; Fri, 24 May 2019 07:50:43 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C8B7230917AA;
	Fri, 24 May 2019 11:50:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 694BF5C239;
	Fri, 24 May 2019 11:50:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 39F101138648; Fri, 24 May 2019 13:50:38 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190523081538.2291-1-armbru@redhat.com>
	<20190523081538.2291-2-armbru@redhat.com>
	<f109f025-420a-536a-bb50-804d9ca2c69a@redhat.com>
Date: Fri, 24 May 2019 13:50:38 +0200
In-Reply-To: <f109f025-420a-536a-bb50-804d9ca2c69a@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri,
	24 May 2019 07:15:42 +0200")
Message-ID: <875zq0ax69.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Fri, 24 May 2019 11:50:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC v4 1/7] Makefile: Remove code to smooth
 transition to config.status
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Markus,
>
> On 5/23/19 10:15 AM, Markus Armbruster wrote:
>> When commit bdf523e6923 made configure generate config.status, it
>> added a fallback to Makefile to smooth the transition, with a TODO
>> "code can be removed after QEMU 1.7."  It's been more than five years.
>> Remove it.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  Makefile | 9 +--------
>>  1 file changed, 1 insertion(+), 8 deletions(-)
>>=20
>> diff --git a/Makefile b/Makefile
>> index 155f066a20..8ec833a5fb 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -69,14 +69,7 @@ CONFIG_ALL=3Dy
>>=20=20
>>  config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios $(SRC_PATH)/=
VERSION
>>  	@echo $@ is out-of-date, running configure
>> -	@# TODO: The next lines include code which supports a smooth
>> -	@# transition from old configurations without config.status.
>> -	@# This code can be removed after QEMU 1.7.
>> -	@if test -x config.status; then \
>> -	    ./config.status; \
>> -        else \
>> -	    sed -n "/.*Configured with/s/[^:]*: //p" $@ | sh; \
>> -	fi
>> +	./config.status
>
> We could prepend a '@' since we already describe what this rule does
> ("config-host.mak is out-of-date, running configure").

You're right, my patch loses the @.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!

[...]

