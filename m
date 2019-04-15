Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB57C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:29:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CAAA2070D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 10:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CAAA2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47911 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFys4-0007Ov-GU
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 06:29:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hFyr7-0006u6-8v
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hFyr6-0003bg-8u
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:28:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hFyr4-0003ZZ-US
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 06:28:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60C0B3092654;
	Mon, 15 Apr 2019 10:28:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.22.189])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 17442608C2;
	Mon, 15 Apr 2019 10:28:40 +0000 (UTC)
Date: Mon, 15 Apr 2019 11:28:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190415102838.GH5718@redhat.com>
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-13-richard.henderson@linaro.org>
	<6ea1d95e-f5c7-7b14-04c7-07699e9d564a@redhat.com>
	<66f73b23-11cc-b5b3-e4ca-34776a4faf32@linaro.org>
	<bed878ef-0ce1-1081-a4cb-88b7775d1433@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <bed878ef-0ce1-1081-a4cb-88b7775d1433@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 15 Apr 2019 10:28:44 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 12/23] linux-user: Call qcrypto_init if
 not using -seed
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415102838.I-IJFfDvuqqUmSRYbxz7zyZeM88HiGD7hRwg79_mbJc@z>

On Mon, Apr 15, 2019 at 12:23:18PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 4/13/19 8:44 AM, Richard Henderson wrote:
> > On 4/10/19 11:49 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> -    if (seed_optarg !=3D NULL) {
> >>> -        qemu_guest_random_seed_main(seed_optarg, &error_fatal);
> >>> +    {
> >> Since 7be41675f7c we use gnu99 C, so this extra block indentation ca=
n be
> >> removed.
> >>
> >>> +        Error *err =3D NULL;
> >>> +        if (seed_optarg !=3D NULL) {
> >>> +            qemu_guest_random_seed_main(seed_optarg, &err);
> >>> +        } else {
> >>> +            /* ??? Assumes qcrypto is only used by qemu_guest_getr=
andom.  */
> >>> +            qcrypto_init(&err);
> >>> +        }
> >>> +        if (err) {
> >>> +            error_reportf_err(err, "cannot initialize crypto: ");
> >>> +            exit(1);
> >>> +        }
> >>>      }
> >=20
> > I could, but it also limits the scope, which is of more importance to=
 variables
> > who have their address taken.  It means that their storage could (in =
theory) be
> > shared with objects not overlapping in scope.
>=20
> Fine then.
>=20
> I think your '???' comment is appropriate but I'd rather let Daniel
> opinate. Except that comment, for the rest:

In linux-user context, afaik, the random APIs are the only stuff that
will be used, none of the hash or cipher stuff is needed.

>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

