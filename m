Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1321C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:58:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772DE20665
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772DE20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwx1-00076s-BL
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49737)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iAwgg-0004W6-Df
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iAwgf-0003nz-2D
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:41:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37772)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iAwgS-0003ZD-UB; Thu, 19 Sep 2019 09:41:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 413C7109EFC3;
 Thu, 19 Sep 2019 13:41:18 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41CFD1001281;
 Thu, 19 Sep 2019 13:40:59 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190918130244.24257-1-vsementsov@virtuozzo.com>
 <abb14088-6af2-5db2-da0d-0948fd4ac81c@redhat.com>
 <20190919091720.GB10163@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <57483252-273c-4606-47a8-eddeb840109a@redhat.com>
Date: Thu, 19 Sep 2019 08:40:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919091720.GB10163@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Thu, 19 Sep 2019 13:41:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] error: auto propagated local_err
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
Cc: fam@euphon.net, peter.maydell@linaro.org, mst@redhat.com,
 codyprime@gmail.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 armbru@redhat.com, kraxel@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
 quintela@redhat.com, david@redhat.com, mdroth@linux.vnet.ibm.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, marcandre.lureau@redhat.com,
 rth@twiddle.net, farman@linux.ibm.com, groug@kaod.org, dgilbert@redhat.com,
 alex.williamson@redhat.com, qemu-arm@nongnu.org, stefanha@redhat.com,
 jsnow@redhat.com, david@gibson.dropbear.id.au,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, berrange@redhat.com,
 cohuck@redhat.com, qemu-s390x@nongnu.org, sundeep.lkml@gmail.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 4:17 AM, Kevin Wolf wrote:
> Am 18.09.2019 um 19:10 hat Eric Blake geschrieben:
>> On 9/18/19 8:02 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> + */
>>> +#define MAKE_ERRP_SAFE(errp) \
>>> +g_auto(ErrorPropagationStruct) (__auto_errp_prop) = {.errp = (errp)}; \
>>> +if ((errp) == NULL || *(errp) == error_abort || *(errp) == error_fatal) { \
>>> +    (errp) = &__auto_errp_prop.local_err; \
>>> +}
>>
>> Not written to take a trailing semicolon in the caller.
>>
>> You could even set __auto_errp_prop unconditionally rather than trying
>> to reuse incoming errp (the difference being that error_propagate() gets
>> called more frequently).
> 
> I think this difference is actually a problem.
> 
> When debugging things, I hate error_propagate(). It means that the Error
> (specifically its fields src/func/line) points to the outermost
> error_propagate() rather than the place where the error really happened.
> It also makes error_abort completely useless because at the point where
> the process gets aborted, the interesting information is already lost.

Okay, based on that, I see the following desirable semantics:

Caller: one of 4 calling paradigms:

pass errp=NULL (we don't care about failures)
pass errp=&error_abort (we want to abort() as soon as possible as close
to the real problem as possible)
pass errp=&error_fatal (we want to exit(), but only after collecting as
much information as possible)
pass errp = anything else (we are collecting an error for other reasons,
we may report it or let the caller decide or ...)

Callee: we want a SINGLE paradigm:

func (Error **errp)
{
    MAKE_ERRP_SAFE();

    now we can pass errp to any child function, test '*errp', or do
anything else, and we DON'T have to call error_propagate.

I think that means we need:

#define MAKE_ERRP_SAFE() \
  g_auto(...) __auto_errp = { .errp = errp }; \
  do { \
    if (!errp || errp == &error_fatal) { errp = &__auto_errp.local; } \
  } while (0)

So back to the caller semantics:

if the caller passed NULL, we've redirected errp locally so that we can
use *errp at will; the auto-cleanup will free our local error.

if the caller passed &error_abort, we keep errp unchanged.  *errp tests
will never trigger, because we'll have already aborted in the child on
the original errp, giving developers the best stack trace.

if the caller passed &error_fatal, we redirect errp.  auto-cleanup will
then error_propagate that back to the caller, producing as much nice
information as possible.

if the caller passed anything else, we keep errp unchanged, so no extra
error_propagate in the mix.

> 
> So I'd really like to restrict the use of error_propagate() to places
> where it's absolutely necessary. Unless, of course, you can fix these
> practical problems that error_propagate() causes for debugging.
> 
> In fact, in the context of Greg's series, I think we really only need to
> support hints for error_fatal, which are cases that users are supposed
> to see. We should exclude error_abort in MAKE_ERRP_SAFE() because these
> are things that are never supposed to happen. A good stack trace is more
> important there than adding a hint to the message.

We also want to handle the caller passing NULL, so that we no longer
have to introduce 'Error *local_error = NULL' everywhere.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

