Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83278C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:21:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ADBC206A1
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 13:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="e2DJudU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ADBC206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Jbi-0001qI-3Z
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 09:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i7Ja5-0000hh-Sz
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:19:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1i7Ja4-0004d0-Cl
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:19:45 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:43942)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1i7Ja3-0004ci-Vx
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 09:19:44 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
 [IPv6:2a02:6b8:0:1402::301])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 8A8E72E14E2;
 Mon,  9 Sep 2019 16:19:42 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 OCyEYT7YAP-JeCih66W; Mon, 09 Sep 2019 16:19:42 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1568035182; bh=plX4OqAkVskW/z7abEG4oaoiDJifpihDA/o54WeHG8M=;
 h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
 b=e2DJudU5mRDX5qqhalkaTlH257TPB3y32DhZFkglGoi4Di6Sz9zLFgq11K5IKPrir
 Ps0SICcl6PPmDD8cZWRw+ZhP5y+1Cax/ksG1d97oauGHZDtejahHSy15WurjGBtcYr
 YjJCK7GkVT9pwBfmSnhnyJ0KulxVe3uCARtKmuuU=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1o.mail.yandex.net (localhost [::1])
 by mxbackcorp1o.mail.yandex.net with LMTP id TcoldGdW8H-DJNwPVh7
 for <yury-kotov@yandex-team.ru>; Mon, 09 Sep 2019 16:19:30 +0300
Received: by vla1-6bb9290e4d68.qloud-c.yandex.net with HTTP;
 Mon, 09 Sep 2019 16:19:30 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Dr. David Alan Gilbert <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Stefan Weil <sw@weilnetz.de>, Thomas Huth <thuth@redhat.com>
In-Reply-To: <08fe56ae-7f8c-2223-f3cd-4b4b118586bf@redhat.com>
References: <20190909104948.30253-1-yury-kotov@yandex-team.ru>
 <08fe56ae-7f8c-2223-f3cd-4b4b118586bf@redhat.com>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 09 Sep 2019 16:19:40 +0300
Message-Id: <3404511568035170@vla1-6bb9290e4d68.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 77.88.29.217
Subject: Re: [Qemu-devel] [PATCH v6 0/3] High downtime with 95+ throttle pct
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Sorry, patchew found a leak in the auto converge test. I fixed it in v7.

Also, there are two other fails, but it seems these are not related to
my changes:

Fail 1:
https://patchew.org/logs/20190909104948.30253-1-yury-kotov@yandex-team.ru=
/testing.docker-mingw@fedora/?type=3Dmessage
...
                /tmp/qemu-test/src/qemu.nsi
File: "/tmp/qemu-test/src\README" -> no files found.
Usage: File [/nonfatal] [/a] ([/r] [/x filespec [...]] filespec [...] |
   /oname=3Doutfile one_file_only)
Error in script "/tmp/qemu-test/src/qemu.nsi" on line 122 -- aborting cre=
ation process
...

Fail 2:
https://patchew.org/logs/20190909104948.30253-1-yury-kotov@yandex-team.ru=
/testing.asan/?type=3Dmessage
...
SUMMARY: AddressSanitizer: stack-use-after-scope /tmp/qemu-test/src/tests=
/test-char.c:762:50 in char_socket_server_test
...

Regards,
Yury

09.09.2019, 14:31, "Paolo Bonzini" <pbonzini@redhat.com>:
> On 09/09/19 12:49, Yury Kotov wrote:
>> =C2=A0Hi,
>>
>> =C2=A0V6:
>> =C2=A0* Fix "Add qemu_cond_timedwait" patch:
>> =C2=A0=C2=A0=C2=A0- Changed return type for qemu_cond_timedwait (void =
-> bool)
>> =C2=A0=C2=A0=C2=A0- Added details in commit message
>>
>> =C2=A0V5:
>> =C2=A0* Updated sleep loop in throttle_thread at the suggestion of Pao=
lo Bonzini
>> =C2=A0* Fixed hanging of test
>>
>> =C2=A0V4:
>> =C2=A0* The test was simplified to prevent false fails.
>>
>> =C2=A0V3:
>> =C2=A0* Rebase fixes (migrate_set_parameter -> migrate_set_parameter_i=
nt)
>>
>> =C2=A0V2:
>> =C2=A0* Added a test
>> =C2=A0* Fixed qemu_cond_timedwait for qsp
>>
>> =C2=A0I wrote a test for migration auto converge and found out a stran=
ge thing:
>> =C2=A01. Enable auto converge
>> =C2=A02. Set max-bandwidth 1Gb/s
>> =C2=A03. Set downtime-limit 1ms
>> =C2=A04. Run standard test (just writes a byte per page)
>> =C2=A05. Wait for converge
>> =C2=A06. It's converged with 99% throttle percentage
>> =C2=A07. The result downtime was about 300-600ms <<<<
>>
>> =C2=A0It's much higher than expected 1ms. I figured out that cpu_throt=
tle_thread()
>> =C2=A0function sleeps for 100ms+ for high throttle percentage (>=3D95%=
) in VCPU thread.
>> =C2=A0And it sleeps even after a cpu kick.
>>
>> =C2=A0Fixed it by using timedwait for ms part of sleep.
>> =C2=A0E.g timedwait(halt_cond, 1ms) + usleep(500).
>
> Queued, thanks.
>
> Paolo


