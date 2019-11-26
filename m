Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A71FC432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515A62068E
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 22:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWgTO4EQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515A62068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZj6P-0004zM-I7
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 17:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iZj4P-0003hQ-JD
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:12:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iZj4O-0004Cr-5D
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:12:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38034
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iZj4O-0004Bc-18
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 17:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574806345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ry89hNMRckQQ1DrjWOEsd0hNL/DBGQ45QobQXhz0/20=;
 b=cWgTO4EQ47uneSZ6bjDcvUHn3l89Iy+DGC2O+s3DMEOfTO2MTwCancEFzlyGQzYXCVJhjw
 dxazidvNKenaebE/8ePA83UX1zRNqdJcwzl6d9Y9RI7qD9DqqI2JXKIaQZQx0yKgGIThz6
 TBcuJtPlWya+4wUFTGmnZHq6XcL5LKw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-e5-03mjRNuC1I4NtbLBZYQ-1; Tue, 26 Nov 2019 17:12:18 -0500
Received: by mail-ed1-f70.google.com with SMTP id l1so12031641ede.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 14:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ry89hNMRckQQ1DrjWOEsd0hNL/DBGQ45QobQXhz0/20=;
 b=ImnsgmTbs9J1mUyGSAaBeAU8efj+LXjoh5FQUoSSWbHWEruDSJjZf//Cg1uIS8miqW
 CFZSc39lRKR2MRhqNlw6A+U8s4+Jcyf+9ay7XVueRsCbm8IOeUbLc+9ypNpRj5oi6Sva
 ItPjzUuTPmm3AldnYX4r5U0/6AgMAuo4mAIdAsH8/FaBDlW7lBZ3wuRil+OvWlqBiVGH
 VRY1LRQQlrDgg8m1I+jeyHyP9yDZlSFQgvzIRc1NCmiNSfiRH0Qdl7sy44TmkfzjA0dm
 NDyvnehEP0NQ6h9O5adiqEQZ5ieX6jzeX1UmK/a6sPCs6kQU3rv+Z6ZtI8PC5foCQVFv
 JSUg==
X-Gm-Message-State: APjAAAWasXSN18LP79UyCJDeCaJNEvHRYYJvO2nCxdE5UrMc9n80J7Lk
 AtDPF5tlitt5PUtbU7EXOPyz/7PrvbgqI3GGwaAviFlkBG4vEluL8e7x5M5tYYc6sfQsxfnEwRT
 C26yEGsPYCS84lWgqCWX+7q7vxUNHyG8=
X-Received: by 2002:a17:907:38e:: with SMTP id
 ss14mr44647630ejb.319.1574806337502; 
 Tue, 26 Nov 2019 14:12:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqy1IJgdf+lkk51LG/zQ4tm/STT1zYHikNErLwzDfofMUqK7DxNDjuyawYycxBaISy9jtLNIsnc2hwOgpjWQxsM=
X-Received: by 2002:a17:907:38e:: with SMTP id
 ss14mr44647601ejb.319.1574806337172; 
 Tue, 26 Nov 2019 14:12:17 -0800 (PST)
MIME-Version: 1.0
References: <157475994490.31055.5778115059405326734@37313f22b938>
 <e5352867-943c-6010-4700-78a0e25cea10@redhat.com>
In-Reply-To: <e5352867-943c-6010-4700-78a0e25cea10@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 26 Nov 2019 23:12:05 +0100
Message-ID: <CABgObfaETGKLuHnTHbY+kuAhnA3qZ6nw6sHUfcj6R=6weiTmPQ@mail.gmail.com>
Subject: Re: [PULL 0/5] i386 patches for QEMU 4.2-rc
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-MC-Unique: e5-03mjRNuC1I4NtbLBZYQ-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/alternative; boundary="0000000000005153db0598472cd5"
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
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005153db0598472cd5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 26 nov 2019, 23:04 Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> h=
a
scritto:

> On 11/26/19 10:19 AM, no-reply@patchew.org wrote:
> > Patchew URL:
> https://patchew.org/QEMU/20191126085936.1689-1-pbonzini@redhat.com/
> >
> > This series failed the docker-quick@centos7 build test. Please find the
> testing commands and
> > their output below. If you have Docker installed, you can probably
> reproduce it
> > locally.
> >
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #!/bin/bash
> > make docker-image-centos7 V=3D1 NETWORK=3D1
> > time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >
> >    TEST    check-unit: tests/test-thread-pool
> > wait_for_migration_fail: unexpected status status=3Dwait-unplug
> allow_active=3D1
> > **
> >
> ERROR:/tmp/qemu-test/src/tests/migration-test.c:908:wait_for_migration_fa=
il:
> assertion failed: (result)
> > ERROR - Bail out!
> ERROR:/tmp/qemu-test/src/tests/migration-test.c:908:wait_for_migration_fa=
il:
> assertion failed: (result)
> > make: *** [check-qtest-aarch64] Error 1
>
> Should we worry about this error?
>

Possibly, but seeing as this series only affect x86 (and really only macOS
except for the tweak to VMX features) it is certainly pre-existing.

Paolo

>
> [...]
> > real    9m26.610s
> > user    0m8.328s
> >
> >
> > The full log is available at
> >
> http://patchew.org/logs/20191126085936.1689-1-pbonzini@redhat.com/testing=
.docker-quick@centos7/?type=3Dmessage
> .
>
>

--0000000000005153db0598472cd5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 26 nov 2019, 23:04 Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On 11/26/19 10:19 AM, <a href=
=3D"mailto:no-reply@patchew.org" target=3D"_blank" rel=3D"noreferrer">no-re=
ply@patchew.org</a> wrote:<br>
&gt; Patchew URL: <a href=3D"https://patchew.org/QEMU/20191126085936.1689-1=
-pbonzini@redhat.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">http=
s://patchew.org/QEMU/20191126085936.1689-1-pbonzini@redhat.com/</a><br>
&gt; <br>
&gt; This series failed the docker-quick@centos7 build test. Please find th=
e testing commands and<br>
&gt; their output below. If you have Docker installed, you can probably rep=
roduce it<br>
&gt; locally.<br>
&gt; <br>
&gt; =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D<br>
&gt; #!/bin/bash<br>
&gt; make docker-image-centos7 V=3D1 NETWORK=3D1<br>
&gt; time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1<br=
>
&gt; =3D=3D=3D TEST SCRIPT END =3D=3D=3D<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 TEST=C2=A0 =C2=A0 check-unit: tests/test-thread-pool<br>
&gt; wait_for_migration_fail: unexpected status status=3Dwait-unplug allow_=
active=3D1<br>
&gt; **<br>
&gt; ERROR:/tmp/qemu-test/src/tests/migration-test.c:908:wait_for_migration=
_fail: assertion failed: (result)<br>
&gt; ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/migration-test.c:908:=
wait_for_migration_fail: assertion failed: (result)<br>
&gt; make: *** [check-qtest-aarch64] Error 1<br>
<br>
Should we worry about this error?<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Possibly, but seeing as this series only a=
ffect x86 (and really only macOS except for the tweak to VMX features) it i=
s certainly pre-existing.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Paolo</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
[...]<br>
&gt; real=C2=A0 =C2=A0 9m26.610s<br>
&gt; user=C2=A0 =C2=A0 0m8.328s<br>
&gt; <br>
&gt; <br>
&gt; The full log is available at<br>
&gt; <a href=3D"http://patchew.org/logs/20191126085936.1689-1-pbonzini@redh=
at.com/testing.docker-quick@centos7/?type=3Dmessage" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">http://patchew.org/logs/20191126085936.1689-1-pbo=
nzini@redhat.com/testing.docker-quick@centos7/?type=3Dmessage</a>.<br>
<br>
</blockquote></div></div></div>

--0000000000005153db0598472cd5--


