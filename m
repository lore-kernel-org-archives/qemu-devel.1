Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D610CC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:31:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A6E20884
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A6E20884
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlrpS-0004Ie-Sz
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 06:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jlron-0003ld-Uz; Thu, 18 Jun 2020 06:30:49 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:41147)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jlrok-0006U8-Vz; Thu, 18 Jun 2020 06:30:49 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 41C8674633E;
 Thu, 18 Jun 2020 12:30:42 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1569B746333; Thu, 18 Jun 2020 12:30:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 140877456F8;
 Thu, 18 Jun 2020 12:30:42 +0200 (CEST)
Date: Thu, 18 Jun 2020 12:30:42 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 2/2] scripts/tracetool: Add plainlog backend
In-Reply-To: <20200618090741.GC671599@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2006181221560.72823@zero.eik.bme.hu>
References: <20200617134505.9D06E7482D3@zero.eik.bme.hu>
 <20200618073124.GA1956319@stefanha-x1.localdomain>
 <20200618090741.GC671599@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2084174723-1592476242=:72823"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

--3866299591-2084174723-1592476242=:72823
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 18 Jun 2020, Daniel P. Berrangé wrote:
> On Thu, Jun 18, 2020 at 08:31:24AM +0100, Stefan Hajnoczi wrote:
>> On Wed, Jun 17, 2020 at 03:36:29PM +0200, BALATON Zoltan wrote:
>>> Add a backend that is the same as the log backend but omits the
>>> process id and timestamp so logs are easier to read and diff-able.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>  scripts/tracetool/backend/plainlog.py | 48 +++++++++++++++++++++++++++
>>>  1 file changed, 48 insertions(+)
>>>  create mode 100644 scripts/tracetool/backend/plainlog.py
>>>
>>> diff --git a/scripts/tracetool/backend/plainlog.py b/scripts/tracetool/backend/plainlog.py
>>> new file mode 100644
>>> index 0000000000..40bbfa6d76
>>> --- /dev/null
>>> +++ b/scripts/tracetool/backend/plainlog.py
>>> @@ -0,0 +1,48 @@
>>> +# -*- coding: utf-8 -*-
>>> +
>>> +"""
>>> +Stderr built-in backend, plain log without proc ID and time.
>>> +"""
>>> +
>>> +__author__     = "Llu????s Vilanova <vilanova@ac.upc.edu>"
>>> +__copyright__  = "Copyright 2012-2017, Llu????s Vilanova <vilanova@ac.upc.edu>"
>>
>> There is a Unicode issue here, Lluís' name is not printed correctly.

It's just an issue with the email formatting, should be OK if you read it 
in UTF8 which is the default on most machines nowaday just forgot to add 
corresponding email header.

>>> +__license__    = "GPL version 2 or (at your option) any later version"
>>> +
>>> +__maintainer__ = "Stefan Hajnoczi"
>>> +__email__      = "stefanha@linux.vnet.ibm.com"
>>> +
>>> +
>>> +from tracetool import out
>>> +
>>> +
>>> +PUBLIC = True
>>> +
>>> +
>>> +def generate_h_begin(events, group):
>>> +    out('#include "qemu/log-for-trace.h"',
>>> +        '')
>>> +
>>> +
>>> +def generate_h(event, group):
>>> +    argnames = ", ".join(event.args.names())
>>> +    if len(event.args) > 0:
>>> +        argnames = ", " + argnames
>>> +
>>> +    if "vcpu" in event.properties:
>>> +        # already checked on the generic format code
>>> +        cond = "true"
>>> +    else:
>>> +        cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
>>> +
>>> +    out('    if (%(cond)s && qemu_loglevel_mask(LOG_TRACE)) {',
>>> +        '        qemu_log("%(name)s " %(fmt)s "\\n" %(argnames)s);',
>>> +        '    }',
>>> +        cond=cond,
>>> +        name=event.name,
>>> +        fmt=event.fmt.rstrip("\n"),
>>> +        argnames=argnames)
>>
>> It is not necessary to introduce a new backend. There could be an option
>> that controls whether or not the timestamp/tid is printed. For example,
>> -trace timestamp=off or maybe the timestmap/tid can be integrated into
>> qemu_log() itself so that it's used more consistently and a -d timestamp
>> option enables it.
>
> QEMU already has a "-msg timestamp=on|off" option that controls whether
> error reports on stderr get a timestamp. I think it is probably reasonable
> for this existing option to apply to anything QEMU prints to stdout/err,
> and thus we could wire it up for qemu_log().

I don't know how to do that so can you submit a patch please? It would be 
preferable if an additional command line option wasn't necessary to print 
logs without timestamps (so changing the defailt to that if you don't mind 
changing current trace behaviour) or the default could be set at configure 
time like with this patch --enable-trace-backends=plainlog sets that 
(although this does not have option to change it at runtime).

Regards,
BALATON Zoltan
--3866299591-2084174723-1592476242=:72823--

