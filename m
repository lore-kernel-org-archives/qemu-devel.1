Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49C7C04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 08:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C158926927
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 08:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C158926927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59788 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXibb-00083R-Rx
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 04:46:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hXiZa-0006d5-6a
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hXiOY-0007XD-Gc
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:32:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hXiOY-0007Wk-BD
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:32:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D09E27EBB1;
	Mon,  3 Jun 2019 08:32:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-223.ams2.redhat.com
	[10.36.117.223])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 896444E6CD;
	Mon,  3 Jun 2019 08:32:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 1B39411386A0; Mon,  3 Jun 2019 10:32:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stafford Horne <shorne@gmail.com>
References: <20190529150853.9772-1-armbru@redhat.com>
	<20190529150853.9772-3-armbru@redhat.com>
	<20190531033601.GB3379@lianli.shorne-pla.net>
Date: Mon, 03 Jun 2019 10:32:35 +0200
In-Reply-To: <20190531033601.GB3379@lianli.shorne-pla.net> (Stafford Horne's
	message of "Fri, 31 May 2019 12:36:01 +0900")
Message-ID: <87ftort6fw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Mon, 03 Jun 2019 08:32:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] MAINTAINERS: Improve section headlines
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stafford Horne <shorne@gmail.com> writes:

> On Wed, May 29, 2019 at 05:08:52PM +0200, Markus Armbruster wrote:
>> When scripts/get_maintainer.pl reports something like
>> 
>>     John Doe <jdoe@example.org> (maintainer:Overall)
>> 
>> the user is left to wonder *which* of our three "Overall" sections
>> applies.  We have three, one each under "Guest CPU cores (TCG)",
>> "Guest CPU Cores (KVM)", and "Overall usermode emulation".
>> 
>> Rename sections under
>> 
>> * "Guest CPU cores (TCG)" from "FOO" to "FOO CPU cores (TCG)"
>> 
>> * "Guest CPU Cores (KVM)" from "FOO" to "FOO CPU cores (KVM)"
>> 
>> * "Guest CPU Cores (Xen)" from "FOO" to "FOO CPU cores (Xen)"
>> 
>> * "Architecture support" from "FOO" to "FOO general architecture
>>   support"
>> 
>> * "Tiny Code Generator (TCG)" from "FOO target" to "FOO TCG target"
>> 
>> While there,
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  MAINTAINERS | 78 ++++++++++++++++++++++++++---------------------------
>>  1 file changed, 39 insertions(+), 39 deletions(-)
>
> ... 
>
>> -OpenRISC
>> +OpenRISC CPU cores (TCG)
>>  M: Stafford Horne <shorne@gmail.com>
>>  S: Odd Fixes
>>  F: target/openrisc/
>>  F: hw/openrisc/
>>  F: tests/tcg/openrisc/
>>  
>
> As directories listed there I look over both target/ (TCG?) and hw/.

Same for ARM, LM32, MicroBlaze, MIPS, Moxie, ...

> Would it be better to be 'OpenRISC general architecture'?

Valid question.  Peter, do you have an opinion?

