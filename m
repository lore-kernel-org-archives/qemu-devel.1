Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0E9C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5543F206EC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 13:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X34BWuyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5543F206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRF78-0004ix-Bu
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 09:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46604)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRF5q-0003SS-B2
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRF5p-000385-Dk
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41066
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRF5o-00031y-Ul
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 09:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587560827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcCjQOE0gcVH61EVbKeIJqeGD2Uvj8E8az4W3n2Grpo=;
 b=X34BWuyrwQNZniY/pkE6R+CITSpO33r8w8z8jT/X+birDchWo24EHuVHInIlY/p/zMJRNg
 gprYN75KC7IchXLVgNb3IHsd4bn2rDDclWG87ERvAQdxVgmGxoSN4KKUMp76NFybIX0la9
 YGtf0BMTAgb1jEhQZmD6f6UpGw56pgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-q9Sci7QbPqSNATQkTOmLkg-1; Wed, 22 Apr 2020 09:07:04 -0400
X-MC-Unique: q9Sci7QbPqSNATQkTOmLkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A19918CA263;
 Wed, 22 Apr 2020 13:07:03 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-212.ams2.redhat.com [10.36.114.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50E2960C88;
 Wed, 22 Apr 2020 13:07:01 +0000 (UTC)
Date: Wed, 22 Apr 2020 15:06:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v3 06/10] iotests: add testfinder.py
Message-ID: <20200422130659.GB7155@linux.fritz.box>
References: <20200421073601.28710-1-vsementsov@virtuozzo.com>
 <20200421073601.28710-7-vsementsov@virtuozzo.com>
 <20200421165647.GE22440@linux.fritz.box>
 <024af11c-180a-2ef6-fbab-fe31107d4438@virtuozzo.com>
 <20200422115310.GA7155@linux.fritz.box>
 <bebaad72-1c40-36e2-b562-edfc69196326@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <bebaad72-1c40-36e2-b562-edfc69196326@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 02:57:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 22.04.2020 um 14:49 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 22.04.2020 14:53, Kevin Wolf wrote:
> > Am 22.04.2020 um 07:35 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > 21.04.2020 19:56, Kevin Wolf wrote:
> > > > Am 21.04.2020 um 09:35 hat Vladimir Sementsov-Ogievskiy geschrieben=
:
> > > > > +if __name__ =3D=3D '__main__':
> > > > > +    if len(sys.argv) =3D=3D 2 and sys.argv[1] in ['-h', '--help'=
]:
> > > > > +        TestFinder.argparser.print_help()
> > > > > +        exit()
> > > > > +
> > > > > +    tests, remaining_argv =3D find_tests(sys.argv[1:])
> > > > > +    print('\n'.join(tests))
> > > > > +    if remaining_argv:
> > > > > +        print('\nUnhandled options: ', remaining_argv)
> > > >=20
> > > > I think unhandled options shouldn't be considered an error and we
> > > > shouldn't even try to find and display any tests then. I'd either p=
rint
> > > > the help text or have an error message that refers to --help.
> > >=20
> > > As I considered running this script as executable for testing purpose=
s, it's
> > > good to know, which options are not handled..
> >=20
> > Yes, that makes sense. I just think it should be an error and not just
> > an additional hint at the end.
> >=20
>=20
> It's not and error, as usual case will leave some arguments for
> TestEnv and TestRunner.  Assume you run ./check with some arguments..
>
> And it works bad. You assume that problem is in testfinder.py. Then,
> you just take the entire list of options and call ./testfinder.py with
> them. And it shows, how it parses its arguments, and what is reminded.
> Seems correct and shouldn't be an error.

Hm, I didn't consider this use case. Fair enough then.

> Still, maybe better to print unhandled options first, to be more
> noticeable.

Actually, I think it's more noticeable at the end when you execute the
script standalone, especially when it prints a long list.

Kevin


