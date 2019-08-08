Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EBBC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 04:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3687A21743
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 04:27:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3687A21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hva1r-0006NM-Iv
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 00:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48311)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hva1U-0005yH-MO
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 00:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hva1T-0005F8-On
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 00:27:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hva1T-0005Ep-Jo
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 00:27:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C48EA64D28;
 Thu,  8 Aug 2019 04:27:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D3695C21A;
 Thu,  8 Aug 2019 04:27:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A4596113864E; Thu,  8 Aug 2019 06:27:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-13-armbru@redhat.com>
 <d822b034-f283-5945-da5d-4fe3bc767f2b@redhat.com>
 <fd6a172e-1c79-5c0a-c9ba-3dbc671dc72f@redhat.com>
Date: Thu, 08 Aug 2019 06:27:16 +0200
In-Reply-To: <fd6a172e-1c79-5c0a-c9ba-3dbc671dc72f@redhat.com> (Eric Blake's
 message of "Wed, 7 Aug 2019 16:06:50 -0500")
Message-ID: <87pnlgl1sr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 08 Aug 2019 04:27:30 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 12/29] Include hw/irq.h a lot less
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 8/7/19 8:04 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 8/6/19 5:14 PM, Markus Armbruster wrote:
>>> In my "build everything" tree, changing hw/irq.h triggers a recompile
>>> of some 5400 out of 6600 objects (not counting tests and objects that
>>> don't depend on qemu/osdep.h).
>>>
>>> hw/hw.h supposedly includes it for convenience.  Several other headers
>>> include it just to get qemu_irq and.or qemu_irq_handler.
>>>
>>> Move the qemu_irq and qemu_irq_handler typedefs from hw/irq.h to
>>> qemu/typedefs.h, and then include hw/irq.h only where it's still
>>> needed.  Touching it now recompiles only some 500 objects.
>>>
>
>>>  /*
>>>   * Function types
>>>   */
>>>  typedef void SaveStateHandler(QEMUFile *f, void *opaque);
>>>  typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id=
);
>>> +typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
>
> Should we prefer a consistent form for function pointer typedefs?  Here,
> we've mixed 'rettype Name(params)' with 'rettype (*name)(params)'.

Which of the two difference I can see do you mean?

CamelCase vs. lower_case_with_underscore?

Parenthesis around the type name?  I wouldn't call that inconsistent, we
simply use parenthesis only when needed.

