Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBF2C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2011F206BB
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 13:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2011F206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHpKV-00057D-1r
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 09:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iHpJh-0004Ve-Kw
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iHpJf-0003Ew-IS
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:14:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50514)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iHpJf-0003Dd-8w
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 09:14:15 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5267D9B29A
 for <qemu-devel@nongnu.org>; Tue,  8 Oct 2019 13:14:14 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id c188so958861wmd.9
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 06:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=9nBdxAt72RxYBtnsIbwHT3X71d9UE2vfBH9T8oTj9M0=;
 b=nc47UUv0t1RD541dQ0ISQzysC11ViOuoEST+4K+O4qM1RnKyRf0FzsYH4lN5FM+2jO
 aj7gfRcYLkH0ZTW77zhTUdAKaPLB6Z9q/aZnhrYJFiEUllzzLDHgTPA0sajrNOzY0QxO
 kP89ClbDXkUS6KLhU48MJMPxeTzpYbtW/UcbgCz/wIm55Vsl3vykeZ0jmHTbEJnxNy4v
 wlK639udO2Ma4EGIWS/JMZzj3iqdbLwDuEOOvokb8mHmL4Orqdg9z9BdqXtg9gABuvJW
 Pua+WfF8jEcKXgX/76YKQlgP63cuLx6680/566JoZCe4fA+Oo3njk8Ft8q/aybFEqPt/
 SmOQ==
X-Gm-Message-State: APjAAAWaYo/wan1bst7mktAT84SPOpCTUd4zKkRiGAEMJ8DMXnKcPuVZ
 mkTx6cumZRkikIA5+YEdtDPEx+qJXU089hnWPjw2MYmJY6+aQUR/1NxNc4GwaKmsWGF4902bUJr
 xBB8W52K2QfBwUzc=
X-Received: by 2002:a5d:630d:: with SMTP id i13mr5797596wru.230.1570540453069; 
 Tue, 08 Oct 2019 06:14:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxy3c+auPTViSyzWf/xk+u0lPQ0nnhDnSopde30h/TghfqjQ7BQfbmgeeppyTSEoBCTUD2bLQ==
X-Received: by 2002:a5d:630d:: with SMTP id i13mr5797576wru.230.1570540452882; 
 Tue, 08 Oct 2019 06:14:12 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id o19sm4420325wmh.27.2019.10.08.06.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 06:14:12 -0700 (PDT)
References: <157020969258.31166.12339648498600507707@8230166b0665>
 <c273fcaf-4e43-b964-b537-d57bfac2738b@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 00/10] Introduce the microvm machine type
In-reply-to: <c273fcaf-4e43-b964-b537-d57bfac2738b@redhat.com>
Date: Tue, 08 Oct 2019 15:14:03 +0200
Message-ID: <87pnj71isk.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: ehabkost@redhat.com, mst@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, imammedo@redhat.com, rth@twiddle.net,
 lersek@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 04/10/19 19:21, no-reply@patchew.org wrote:
>> qemu-system-x86_64: missing kernel image file name, required by microvm
>> Broken pipe
>> /tmp/qemu-test/src/tests/libqtest.c:140: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
>> ERROR - too few tests run (expected 7, got 4)
>> make: *** [check-qtest-x86_64] Error 1
>> make: *** Waiting for unfinished jobs....
>>   TEST    iotest-qcow2: 159
>>   TEST    iotest-qcow2: 161
>> ---
>>     raise CalledProcessError(retcode, cmd)
>
> I think this needs some kind of blacklisting?

I solved this issue by allowing a microvm machine to be started without
a kernel filename (now that we always rely on a FW, we can do that ;-)

Cheers,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2ci5sACgkQ9GknjS8M
AjVxhA//ajqhTRXX3Tn818TptRJ7bDP5V3FrxlrTyqPFKb5IVdDFLQPQRcFCc0ps
f2Il52z/lZrdVNW6smdb2Q9jcJO3m6pZP+8oOL+0gkLkzaDxDtVZwSpJUWR1PCfU
u88N/JH9Qp5Iv4JI84METtAqozdQCcrBorSPGKrJoyFgOqE+yXY4hPZOOQP1ogtl
1x/Rv228y2qAaOTqUll4+Cn5SN+zEaTg+J+1JJJzvX5Ap34r4FwTvf0woxEvGcHX
P9KBAAlvrkDwWK+DAGObpQXzloqOPRjrMMgJqrh5qp/zUKaNgLyrlV+R+RWowq8A
aOsCVlmasGYbnb4AViT2bMXK1l7eyc2tCYJoxCkbzJev5FuvZxFAb7joya2xR7jJ
PVD6j7xTkQawXWhFk83a9TnEloy2QPbJnAhFEUz02LnENJuRKJH16KXbivuEFWlz
S/ETUrqelRxpV0MVBixJ4IxxgqTXXECGzY4UhapSiHD+u9F8TFmHjMUHlORUXp7g
zIniX7fUwJKvN/HRLURyPRjOvfdxF+2Q8cY6RPrvNRrrWRsKAteL72idBT0ezPLt
jos1bVRBP9Bn7YMfJkSpJF09zkbWK8uznGDXAovn4PTglKk0Wgd3Hyho73SSQLx+
ajXgnzB0Lc0Z/vi5Nr/Upoj0LD/EoF1Ci55bcPo+JeGw47gsWJM=
=NU/z
-----END PGP SIGNATURE-----
--=-=-=--

