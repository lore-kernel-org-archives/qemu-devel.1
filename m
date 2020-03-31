Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F1EC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A5F20B80
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 08:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/pt1MJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A5F20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJBrW-0007B8-AF
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 04:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJBp2-0005OO-Tg
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJBoz-0002we-Ev
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:00:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21354
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJBoz-0002wG-Az
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 04:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585641628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rtx7dc7czJ6OdYOCXCWTlNmb3aCnPdlq+Q+M1B8y4eI=;
 b=c/pt1MJY5Yd8uFu6iPtX2kAkGgBJR7cITICQ+k9BIGe8pPlX0KKos7GroDQsF7VhBMXcCw
 kGGn4Wsptb8Z0S+0VDbPqTrGgpVBaeffF9DvNihW3EzoHKtwnYmsrVZ9DyVL8a+yDxp5Mv
 Hm+yC2MONcbs1BmCby2uEhQF3+TDh/A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-mim02LlVMhqkY3QPE9XmUA-1; Tue, 31 Mar 2020 04:00:27 -0400
X-MC-Unique: mim02LlVMhqkY3QPE9XmUA-1
Received: by mail-wm1-f72.google.com with SMTP id w9so390908wmi.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 01:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A6GvF3x3fYn2E9FkuGW6iJo47NwPAS175Bye9CElTaM=;
 b=mkG2CnG3qaxZGPXXh/sq7YMDpBlGJkgJihYRlrMzSvCTSy3ux/S/KBo6HilSr5x1Jm
 Ht0H8llehWuWak5Gn3bHkeMjtTG+t3XAXSSk8zIMrdTrRGSz4GhkRf5++R+mIEOrni+p
 tXFGT5Q9Mru1f47BUmKoKec97kg58yZoDEpmQILY2bHJmHi5abmzErKwJsJs724eS9BZ
 GiEPLO3Lu0nqD57RaPajajIPfsTn8IdFur0EqfG2FMmQk3M+Cssu4+A2eqZm2D3nJHmM
 2DWwJCXsLzU7LpIoaCYXrQkpS1EYWTpwWHSsU8qOtZXy8wGdy/9nCJnZNvUA9lQwAz2s
 5YXg==
X-Gm-Message-State: ANhLgQ2TP6S82Up0u+VUgMIwcGUryhP4/YBCS0zUXpnYdUggsh7i6X0G
 EZL/yvCcDYz2M3NbEbCPwsz2lKM4SSgQdOfoZ3VDlDVndTk1gyIJmjBmfeC+JlYBJ2LL159DYo8
 6I6ziJJbW6AtLeiY=
X-Received: by 2002:adf:a54a:: with SMTP id j10mr19826199wrb.188.1585641625679; 
 Tue, 31 Mar 2020 01:00:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvDiW+peZLusClIOuajNz0uCaFM9qAC+JmxeMdwyz97MIF1ngH+TPiVwMxu65iEFWuBxZ4H7Q==
X-Received: by 2002:adf:a54a:: with SMTP id j10mr19826181wrb.188.1585641625510; 
 Tue, 31 Mar 2020 01:00:25 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id t16sm26533891wra.17.2020.03.31.01.00.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 01:00:25 -0700 (PDT)
Subject: Re: [PATCH v10 06/14] iotests: alphabetize standard imports
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200331000014.11581-1-jsnow@redhat.com>
 <20200331000014.11581-7-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <902f392e-58bf-a44b-bdb2-516f1956cb87@redhat.com>
Date: Tue, 31 Mar 2020 10:00:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331000014.11581-7-jsnow@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 armbru@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/31/20 2:00 AM, John Snow wrote:
> I had to fix a merge conflict, so do this tiny harmless thing while I'm
> here.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
> index 51f84475d9..e6f9f62b2b 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -16,19 +16,19 @@
>   # along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   #
>  =20
> +import atexit
> +from collections import OrderedDict
> +import faulthandler
> +import io
> +import json
> +import logging
>   import os
>   import re
> +import signal
> +import struct
>   import subprocess
> -import unittest
>   import sys
> -import struct
> -import json
> -import signal
> -import logging
> -import atexit
> -import io
> -from collections import OrderedDict
> -import faulthandler
> +import unittest

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>  =20
>   # pylint: disable=3Dimport-error, wrong-import-position
>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'py=
thon'))
>=20


