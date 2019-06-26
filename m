Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6CDC48BD8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:28:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEBC821738
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBC821738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg72D-00032F-3M
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52412)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hg6wz-0006gY-Q8
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hg6wx-0001XL-Dx
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:22:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hg6wx-0000ZY-6X
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:22:55 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 57A6C308623A;
 Wed, 26 Jun 2019 12:22:25 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A5407608C1;
 Wed, 26 Jun 2019 12:22:16 +0000 (UTC)
Date: Wed, 26 Jun 2019 13:22:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190626122214.GD29008@redhat.com>
References: <f8f439b4-3835-686c-2c1e-20fe78d6bbf1@redhat.com>
 <d75c0641-01a3-ac5c-2f4d-b41505747815@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d75c0641-01a3-ac5c-2f4d-b41505747815@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 26 Jun 2019 12:22:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] trace: floating-point values blacklisted
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?utf-8?B?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 26, 2019 at 01:57:43PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> [I forgot to Cc the list, resending]
>=20
> Hi Stefan, Llu=C3=ADs,
>=20
> When trying to add a trace event to report a float value, I get:
>=20
> trace-events:11: Argument type 'float' is not in whitelist. Only
> standard C types and fixed size integer types should be used. struct,
> union, and other complex pointer types should be declared as 'void *'
> Traceback (most recent call last):
>   File "./scripts/tracetool.py", line 152, in <module>
>     main(sys.argv)
>   File "./scripts/tracetool.py", line 143, in main
>     events.extend(tracetool.read_events(fh, arg))
>   File "./scripts/tracetool/__init__.py", line 365, in read_events
>     event =3D Event.build(line)
>   File "./scripts/tracetool/__init__.py", line 283, in build
>     args =3D Arguments.build(groups["args"])
>   File "./scripts/tracetool/__init__.py", line 133, in build
>     validate_type(arg_type)
>   File "./scripts/tracetool/__init__.py", line 86, in validate_type
>     "declared as 'void *'" % name)
>=20
> Floating-point types are specified in the optional Annex F of the
> standard ("IEC 60559 floating-point arithmetic").
>=20
> Is there a specific reason to not trace them, or simply nobody ever had
> to trace them?

Not all trace backends support floating point data types.

Systemtap for example has only strings or integers as basic types.

For tracing floating point the normal approach would be to convert it
to fixed point, using a pair of integers, one for the decimal part and
one for the frational part.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

