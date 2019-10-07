Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A94C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 09:33:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6EFB21655
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 09:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EFB21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHPOO-0001mZ-15
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 05:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iHPNj-0001MW-SU
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iHPNh-0000AM-2D
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:32:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47640)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iHPNg-0000AG-Qd
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 05:32:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DF68A1107;
 Mon,  7 Oct 2019 09:32:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA3CF5D9CD;
 Mon,  7 Oct 2019 09:32:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A23D1138648; Mon,  7 Oct 2019 11:32:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v5 01/10] hw/virtio: Factorize virtio-mmio headers
References: <20191002113103.45023-1-slp@redhat.com>
 <20191002113103.45023-2-slp@redhat.com>
 <96ff1ae1-fc3f-af56-08bd-a8b821385572@redhat.com>
 <87ftkahxyo.fsf@redhat.com>
 <099a33d3-c1ab-f1c9-65e1-7dbd396a4817@redhat.com>
Date: Mon, 07 Oct 2019 11:32:03 +0200
In-Reply-To: <099a33d3-c1ab-f1c9-65e1-7dbd396a4817@redhat.com> (Eric Blake's
 message of "Thu, 3 Oct 2019 08:11:54 -0500")
Message-ID: <877e5gj3zg.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 07 Oct 2019 09:32:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, ehabkost@redhat.com,
 Sergio Lopez <slp@redhat.com>, mst@redhat.com, lersek@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com,
 imammedo@redhat.com, sgarzare@redhat.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> On 10/3/19 6:26 AM, Sergio Lopez wrote:
>>
>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>>
>>> On 10/2/19 1:30 PM, Sergio Lopez wrote:
>>>> Put QOM and main struct definition in a separate header file, so it
>>>> can be accessed from other components.
>>>>
>>>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>
>>>> +
>>>> +#ifndef QEMU_VIRTIO_MMIO_H
>>>> +#define QEMU_VIRTIO_MMIO_H
>>>
>>> I'd rather use HW_VIRTIO_MMIO_H
>>
>> Looks like there isn't a consensus in this regard:
>>
>> $ grep "ifndef" *
>
>>
>> Do we have an actual policy written somewhere?
>
> Past history shows several cleanups near commit fe2611b016, including
> commit c0a9956b which mentions scripts/clean-header-guards
> specifically for this purpose.  So yes, we have a policy, although it
> is not always enforced in a timely manner.

We haven't adopted a strict policy.

I created clean-header-guards.pl to help me tidy up the resulting mess
somewhat.  The script can clean up "untidy" header guards.  This may
involve replacing the guard symbol.  It derives the replacement symbol
from the file name the obvious way: convert a-z to A_Z, replace any
character that isn't okay in an identifier by '_'.  Guard symbols chosen
that way are fairly unlikely to collide.

Existing guard symbols often omit directories, and the script tolerates
that.  For instance, in sub/dir/base.h, anything ending in BASE_H is
considered tidy enough.  Might be a bad idea.

I wouldn't go as far as calling this a policy.  Perhaps it should be.


commit 2dbc4ebc1712a5cf9e6a36327dce0b465abd5bbe
Author: Markus Armbruster <armbru@redhat.com>
Date:   Tue Jun 28 13:07:36 2016 +0200

    scripts: New clean-header-guards.pl
=20=20=20=20
    The conventional way to ensure a header can be included multiple times
    is to bracket it like this:
=20=20=20=20
        #ifndef HEADER_NAME_H
        #define HEADER_NAME_H
        ...
        #endif
=20=20=20=20
    where HEADER_NAME_H is a symbol unique to this header.
=20=20=20=20
    The endif may be optionally decorated like this:
=20=20=20=20
        #endif /* HEADER_NAME_H */
=20=20=20=20
    Unconventional ways present in our code:
=20=20=20=20
    * Identifiers reserved for any use:
        #define _FILEOP_H
=20=20=20=20
    * Lowercase (bad idea for object-like macros):
        #define __linux_video_vga_h__
=20=20=20=20
    * Roundabout ways to say the same thing (and hide from grep):
        #if !defined(__PPC_MAC_H__)
        #endif /* !defined(__PPC_MAC_H__) */
=20=20=20=20
    * Redundant values:
        #define HW_ALPHA_H 1
=20=20=20=20
    * Funny redundant values:
        # define PXA_H                 "pxa.h"
=20=20=20=20
    * Decorations with bangs:
=20=20=20=20
        #endif /* !QEMU_ARM_GIC_INTERNAL_H */
=20=20=20=20
      The negation actually makes sense, but almost all our header guard
      #endif decorations don't negate.
=20=20=20=20
    * Useless decorations:
=20=20=20=20
       #endif  /* audio.h */
=20=20=20=20
    Header guards are not the place to show off creativity.  This script
    normalizes them to the conventional way, and cleans up whitespace
    while there.  It warns when it renames guard symbols, and explains how
    to find occurences of these symbols that may have to be updated
    manually.
=20=20=20=20
    Another issue is use of the same guard symbol in multiple headers.
    That's okay only for headers that cannot be used together, such as the
    *-user/*/target_syscall.h.  This script can't tell, so it warns when
    it sees a reuse.
=20=20=20=20
    The script also warns when preprocessing a header with its guard
    symbol defined produces anything but whitespace.
=20=20=20=20
    The next commits will put the script to use.
=20=20=20=20
    Signed-off-by: Markus Armbruster <armbru@redhat.com>
    Reviewed-by: Richard Henderson <rth@twiddle.net>

