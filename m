Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78932C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:02:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E850206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 15:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqu6uHg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E850206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdb6A-0001Lv-DD
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 11:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jdb4k-0008JO-Oz
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:01:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25943
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jdb4j-0007AI-AE
 for qemu-devel@nongnu.org; Tue, 26 May 2020 11:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590505262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0H8zShkyHZ34e+kLKnFPjG67UAgJILajgJr1UU3bASc=;
 b=iqu6uHg8FktEuNWViex51e38aLpPgfwH1Iy1VvydOE1vxwKFfjygWApxA83ulIjiOP6v9G
 hKekbepYTOsL3YcZvT+XsZcKCr8QlIet6sWFq9jt4YAgrCtUsxsZ/dtEmrdIRDf5tQXnal
 /pQ3PS5VbyPFDuLs+S7UPGJlWwyALKc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-3CiJTGy6O2S-TC1EXk6Gpw-1; Tue, 26 May 2020 11:01:01 -0400
X-MC-Unique: 3CiJTGy6O2S-TC1EXk6Gpw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A12D464;
 Tue, 26 May 2020 15:00:59 +0000 (UTC)
Received: from localhost (unknown [10.40.208.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9CA36EDBA;
 Tue, 26 May 2020 15:00:49 +0000 (UTC)
Date: Tue, 26 May 2020 17:00:48 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 2/8] qapi/misc: Restrict LostTickPolicy enum to
 machine code
Message-ID: <20200526170048.5970b187@redhat.com>
In-Reply-To: <20200316000348.29692-3-philmd@redhat.com>
References: <20200316000348.29692-1-philmd@redhat.com>
 <20200316000348.29692-3-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:19:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 "Michael S.
 Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020 01:03:42 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  qapi/machine.json            | 32 ++++++++++++++++++++++++++++++++
>  qapi/misc.json               | 32 --------------------------------
>  include/hw/rtc/mc146818rtc.h |  2 +-
>  hw/core/qdev-properties.c    |  1 +
>  hw/i386/kvm/i8254.c          |  2 +-
>  5 files changed, 35 insertions(+), 34 deletions(-)
>=20
> diff --git a/qapi/machine.json b/qapi/machine.json
> index de05730704..07ffc07ba2 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -415,6 +415,38 @@
>  ##
>  { 'command': 'query-target', 'returns': 'TargetInfo' }
> =20
> +##
> +# @LostTickPolicy:
> +#
> +# Policy for handling lost ticks in timer devices.  Ticks end up getting
> +# lost when, for example, the guest is paused.
> +#
> +# @discard: throw away the missed ticks and continue with future injecti=
on
> +#           normally.  The guest OS will see the timer jump ahead by a
> +#           potentially quite significant amount all at once, as if the
> +#           intervening chunk of time had simply not existed; needless t=
o
> +#           say, such a sudden jump can easily confuse a guest OS which =
is
> +#           not specifically prepared to deal with it.  Assuming the gue=
st
> +#           OS can deal correctly with the time jump, the time in the gu=
est
> +#           and in the host should now match.
> +#
> +# @delay: continue to deliver ticks at the normal rate.  The guest OS wi=
ll
> +#         not notice anything is amiss, as from its point of view time w=
ill
> +#         have continued to flow normally.  The time in the guest should=
 now
> +#         be behind the time in the host by exactly the amount of time d=
uring
> +#         which ticks have been missed.
> +#
> +# @slew: deliver ticks at a higher rate to catch up with the missed tick=
s.
> +#        The guest OS will not notice anything is amiss, as from its poi=
nt
> +#        of view time will have continued to flow normally.  Once the ti=
mer
> +#        has managed to catch up with all the missing ticks, the time in
> +#        the guest and in the host should match.
> +#
> +# Since: 2.0
> +##
> +{ 'enum': 'LostTickPolicy',
> +  'data': ['discard', 'delay', 'slew' ] }
> +
>  ##
>  # @NumaOptionsType:
>  #
> diff --git a/qapi/misc.json b/qapi/misc.json
> index c18fe681fb..2725d835ad 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -7,38 +7,6 @@
> =20
>  { 'include': 'common.json' }
> =20
> -##
> -# @LostTickPolicy:
> -#
> -# Policy for handling lost ticks in timer devices.  Ticks end up getting
> -# lost when, for example, the guest is paused.
> -#
> -# @discard: throw away the missed ticks and continue with future injecti=
on
> -#           normally.  The guest OS will see the timer jump ahead by a
> -#           potentially quite significant amount all at once, as if the
> -#           intervening chunk of time had simply not existed; needless t=
o
> -#           say, such a sudden jump can easily confuse a guest OS which =
is
> -#           not specifically prepared to deal with it.  Assuming the gue=
st
> -#           OS can deal correctly with the time jump, the time in the gu=
est
> -#           and in the host should now match.
> -#
> -# @delay: continue to deliver ticks at the normal rate.  The guest OS wi=
ll
> -#         not notice anything is amiss, as from its point of view time w=
ill
> -#         have continued to flow normally.  The time in the guest should=
 now
> -#         be behind the time in the host by exactly the amount of time d=
uring
> -#         which ticks have been missed.
> -#
> -# @slew: deliver ticks at a higher rate to catch up with the missed tick=
s.
> -#        The guest OS will not notice anything is amiss, as from its poi=
nt
> -#        of view time will have continued to flow normally.  Once the ti=
mer
> -#        has managed to catch up with all the missing ticks, the time in
> -#        the guest and in the host should match.
> -#
> -# Since: 2.0
> -##
> -{ 'enum': 'LostTickPolicy',
> -  'data': ['discard', 'delay', 'slew' ] }
> -
>  ##
>  # @add_client:
>  #
> diff --git a/include/hw/rtc/mc146818rtc.h b/include/hw/rtc/mc146818rtc.h
> index 10c93a096a..58a7748c66 100644
> --- a/include/hw/rtc/mc146818rtc.h
> +++ b/include/hw/rtc/mc146818rtc.h
> @@ -9,7 +9,7 @@
>  #ifndef HW_RTC_MC146818RTC_H
>  #define HW_RTC_MC146818RTC_H
> =20
> -#include "qapi/qapi-types-misc.h"
> +#include "qapi/qapi-types-machine.h"
>  #include "qemu/queue.h"
>  #include "qemu/timer.h"
>  #include "hw/isa/isa.h"
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 2047114fca..59380ed761 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -4,6 +4,7 @@
>  #include "qapi/error.h"
>  #include "hw/pci/pci.h"
>  #include "qapi/qapi-types-block.h"
> +#include "qapi/qapi-types-machine.h"
>  #include "qapi/qapi-types-misc.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qemu/ctype.h"
> diff --git a/hw/i386/kvm/i8254.c b/hw/i386/kvm/i8254.c
> index 876f5aa6fa..22ba6149b5 100644
> --- a/hw/i386/kvm/i8254.c
> +++ b/hw/i386/kvm/i8254.c
> @@ -25,7 +25,7 @@
> =20
>  #include "qemu/osdep.h"
>  #include <linux/kvm.h>
> -#include "qapi/qapi-types-misc.h"
> +#include "qapi/qapi-types-machine.h"
>  #include "qapi/error.h"
>  #include "qemu/module.h"
>  #include "qemu/timer.h"


