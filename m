Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8626BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50AAA20708
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 21:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AE0dUo0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AAA20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixH4Y-0002ZB-FQ
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 16:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kchamart@redhat.com>) id 1ixH3x-00027s-Q0
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kchamart@redhat.com>) id 1ixH3v-00066g-H4
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:09:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55223
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1ixH3v-00064p-CK
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 16:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580418558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZ7++HqgHvjnupont+kkdEqfdJ8OccOOfmafIhzm2kk=;
 b=AE0dUo0iHl4tREqBeB9fONbtfNM2fOUuSW1oRkQwOhNoOBgJD2ZDR5sYhfr5pBTYCGoheL
 UW6WMHkKKE3Gupsl7Ghu0cCVb8ki+zUg25oVV3dNbAnfTy5s5R0RlW2HZgRVnkXr1SqakW
 ROnicwekN80+4mZQLtFWQxLm/i1M5mE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-n5V4C0A3OnaT-Het2-G4lA-1; Thu, 30 Jan 2020 16:09:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F35F182B8E3;
 Thu, 30 Jan 2020 21:09:12 +0000 (UTC)
Received: from paraplu.localdomain (unknown [10.36.118.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 381D21036B2C;
 Thu, 30 Jan 2020 21:09:04 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
 id 6A9D63E04B8; Thu, 30 Jan 2020 22:09:02 +0100 (CET)
Date: Thu, 30 Jan 2020 22:09:02 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Improving QOM documentation [Was: Re: Making QEMU easier for
 management tools and applications]
Message-ID: <20200130210902.GA25927@paraplu>
References: <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
 <20200115121953.GJ93923@redhat.com>
 <874kwwvmuv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <874kwwvmuv.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: n5V4C0A3OnaT-Het2-G4lA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, ehabkost@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 15, 2020 at 03:02:48PM +0100, Markus Armbruster wrote:
> Daniel P. Berrang=E9 <berrange@redhat.com> writes:

[Changed the subject-line to indicate deviation from the original
topic.]

[...]

> > Libvirt is of course happy to switch to something else instead of
> > qom-set for these features if QEMU wants to provide a safer
> > alternative.
>=20
> Noted.
>=20
> libvirt's use of qom-set is okay.  What's not okay is the near-complete
> lack of QOM documentation, its poor QMP interface, in part due to
> non-integration with QAPI, and last but not least the lack of QOM
> leadership leaving it adrift.

What can be done to improve QOM documentation (or lack thereof)?

From a couple of hurried `grep` queries in the QEMU tree, there seems to
be no explicit qom.rst|txt, or qemu-object-model.txt|rst or some such.
(I hope I haven't missed any other files.)

Let's dig further.  Ah, I come across this helpful 2016 blog post[1]
("An incomplete list of QEMU APIs") by Eduardo from my bookmarks.  Here
I get some clues:

(a) In the section titled "QOM", Eduardo writes:

        "QOM is short for QEMU Object Model and was introduced in 2011.
        It is heavily documented on its header file
        [include/qom/object.h]"=20

    Opening qom/object.h[2], indeed there is copious amounts of docs,
    expressed as commented-out text.  Two questions:

    - How much of this is still accurate?  (Sorry, if that's a loaded
      question.)

    - If at least 60% is still accurate, is it valuable to extract and
      publish it as rendered rST, as part of the on-going QEMU Docs
      improvement?

(b) The other clue is also from the same post, where Eduardo provides
    pointers to past KVM Forum presentations by MarkusA, PaoloB,
    AndreasF on QOM, Qdev et al.

    Is it worth slapping all these references (with a clear intro and
    outro) into a qom.rst file in QEMU tree, even if only for
    reference/context?  Or are these references, in-tree docs in
    object.h out-of-date beyond repair? =20

If it is useful, I'm happy to get the initial doc going, secure in the
knowledge that more clueful people than me will chip in during the
review :-)

[1] https://habkost.net/posts/2016/11/incomplete-list-of-qemu-apis.html
[2] https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dinclude/qom/object.h
[3] http://www.linux-kvm.org/images/9/90/Kvmforum14-qom.pdf

--=20
/kashyap


