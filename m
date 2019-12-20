Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FF4C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A38AC20866
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AeitFl6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38AC20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiLav-00053v-Mk
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 11:57:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iiLa1-0003ny-NM
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:56:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iiLa0-0002oy-81
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:56:45 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23576
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iiLa0-0002my-36
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:56:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576861003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IpdkpY65tRP8q7UJ0txP3ogqAmfPMz5QOEyWm9W9H1I=;
 b=AeitFl6hRIY6FzOh93rgKaxMEGqPSLBvwLfHtlrkYWpMzDDZdCk2CP9n9HUfpRcOVkEbsM
 bJ1XnZBK/uDwVkLQl2Zp16TDziV0kHItEUIaBIp8z8t0orFzNKERuU1ZrJD3zn0+KBexg+
 6udI7X5kLBss3z2aOK2lVVAWwHF5WXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-xKmCvYakPP2xar0kbbZ_kw-1; Fri, 20 Dec 2019 11:56:39 -0500
X-MC-Unique: xKmCvYakPP2xar0kbbZ_kw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01EC5800D48;
 Fri, 20 Dec 2019 16:56:37 +0000 (UTC)
Received: from localhost (ovpn-116-10.gru2.redhat.com [10.97.116.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D80D25C1B2;
 Fri, 20 Dec 2019 16:56:28 +0000 (UTC)
Date: Fri, 20 Dec 2019 13:56:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Can we retire Python 2 now?
Message-ID: <20191220165627.GV498046@habkost.net>
References: <8736dfdkph.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736dfdkph.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 20, 2019 at 05:29:30PM +0100, Markus Armbruster wrote:
> Python 2 EOL is only a few days away[*].  We made configure bitch about
> it in commit e5abf59eae "Deprecate Python 2 support", 2019-07-01.  Any
> objections to retiring it now, i.e. in 5.0?

Thanks for the reminder!

I'll be honest: even if somebody in this list objects to dropping
Python 2 support, I'm not willing to be maintainer of a Python 2
codebase in 2020.  The only reason for not doing it in 4.1 was
the tests/vm/netbsd breakage we took very long to debug and fix.

I have just submitted this pull request:

  Subject: [PULL 0/2] Require Python >= 3.5 to build QEMU
  https://lore.kernel.org/qemu-devel/20191220165141.2207058-1-ehabkost@redhat.com/

> 
> Cc'ing everyone who appears to be maintaining something that looks like
> a Python script.
> 
> [*] https://pythonclock.org/

-- 
Eduardo


