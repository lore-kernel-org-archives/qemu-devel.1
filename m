Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E92C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 17:54:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0893821527
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 17:54:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0893821527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlcH1-0006nX-BK
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 13:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jlcG6-0005Ib-QF; Wed, 17 Jun 2020 13:53:58 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:54196)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jlcG3-0000OC-7h; Wed, 17 Jun 2020 13:53:58 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 27670746333;
 Wed, 17 Jun 2020 19:53:50 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 01879745702; Wed, 17 Jun 2020 19:53:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F3D1F7456F8;
 Wed, 17 Jun 2020 19:53:49 +0200 (CEST)
Date: Wed, 17 Jun 2020 19:53:49 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 2/2] scripts/tracetool: Add plainlog backend
In-Reply-To: <87k105wvhr.fsf@linaro.org>
Message-ID: <alpine.BSF.2.22.395.2006171945230.14527@zero.eik.bme.hu>
References: <20200617134505.9D06E7482D3@zero.eik.bme.hu>
 <87k105wvhr.fsf@linaro.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-2062769975-1592416073=:14527"
Content-ID: <alpine.BSF.2.22.395.2006171947570.14527@zero.eik.bme.hu>
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 13:53:50
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2062769975-1592416073=:14527
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.BSF.2.22.395.2006171947571.14527@zero.eik.bme.hu>

On Wed, 17 Jun 2020, Alex Bennée wrote:
> Did this patch get separated from a larger series (2/2)?

No sorry, just used format-patch for two unrelated patches and forgot to 
remove this. This patch is standalone and Philippe pointed out the other 
one labelled 1/2 is not needed as there's already a similar patch queued.

>> Add a backend that is the same as the log backend but omits the
>> process id and timestamp so logs are easier to read and diff-able.
>
> I'd argue for this to be the behaviour of plain log (given it's mixing
> with other log output). If not then maybe plainlog would be the default
> log type if nothing is passed to configure?

I'd like if the default log backend was not adding timestamps and random 
numbers to log messages for easier digesting and diffing but the current 
log backend does that and maybe there are people who like that default so 
instead of making them need to change their ways I'm proposing this 
backend that those who like plain logs can use instead. That's a less 
disruptive change than changing the default log backend but if others want 
that I'm fine with that too.

Regards,
BALATON Zoltan

>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  scripts/tracetool/backend/plainlog.py | 48 +++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>  create mode 100644 scripts/tracetool/backend/plainlog.py
>>
>> diff --git a/scripts/tracetool/backend/plainlog.py b/scripts/tracetool/backend/plainlog.py
>> new file mode 100644
>> index 0000000000..40bbfa6d76
>> --- /dev/null
>> +++ b/scripts/tracetool/backend/plainlog.py
>> @@ -0,0 +1,48 @@
>> +# -*- coding: utf-8 -*-
>> +
>> +"""
>> +Stderr built-in backend, plain log without proc ID and time.
>> +"""
>> +
>> +__author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
>> +__copyright__  = "Copyright 2012-2017, Lluís Vilanova <vilanova@ac.upc.edu>"
>> +__license__    = "GPL version 2 or (at your option) any later version"
>> +
>> +__maintainer__ = "Stefan Hajnoczi"
>> +__email__      = "stefanha@linux.vnet.ibm.com"
>> +
>> +
>> +from tracetool import out
>> +
>> +
>> +PUBLIC = True
>> +
>> +
>> +def generate_h_begin(events, group):
>> +    out('#include "qemu/log-for-trace.h"',
>> +        '')
>> +
>> +
>> +def generate_h(event, group):
>> +    argnames = ", ".join(event.args.names())
>> +    if len(event.args) > 0:
>> +        argnames = ", " + argnames
>> +
>> +    if "vcpu" in event.properties:
>> +        # already checked on the generic format code
>> +        cond = "true"
>> +    else:
>> +        cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
>> +
>> +    out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
>> +        '        qemu_log("%(name)s " %(fmt)s "\\n" %(argnames)s);',
>> +        '    }',
>> +        cond=cond,
>> +        name=event.name,
>> +        fmt=event.fmt.rstrip("\n"),
>> +        argnames=argnames)
>> +
>> +
>> +def generate_h_backend_dstate(event, group):
>> +    out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
>> +        event_id="TRACE_" + event.name.upper())
>
>
>
--3866299591-2062769975-1592416073=:14527--

