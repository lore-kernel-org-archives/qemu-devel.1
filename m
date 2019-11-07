Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D14C5DF61
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 10:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FB89206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 10:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HkZRYT8V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB89206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSedB-0007Gl-Dv
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 05:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iSebN-00066s-Fp
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:01:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iSebM-0006xl-3M
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:01:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36743
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iSebL-0006fk-LD
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:01:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573120872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CjtiJFMqRPtEEyqz1xy9FsujjbqGgKfbD3LUCJurxe0=;
 b=HkZRYT8V38ymgvNfsAhv2jKi7Icd4m/NG4edVSFSjtaoGngrwiihwgW9IdfZrJrnueutqt
 rYXU0RYqpma2iteTTR860rDE+K8TG5ORfWDMUvwErmvpBH4GAvy4nIoYL7TQY57eetZDJd
 adHXBsAj0mpVnNKd/rJE2puYhKubd5M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-RaoaMEL6OcaSu38eby0JIg-1; Thu, 07 Nov 2019 05:01:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD02B1800D7A;
 Thu,  7 Nov 2019 10:01:03 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7AFF0608AC;
 Thu,  7 Nov 2019 10:01:02 +0000 (UTC)
Message-ID: <2b5db879abff0c3b457953a60dd013ac8fd738c6.camel@redhat.com>
Subject: Re: [PATCH v2 03/21] iotests: Add _filter_json_filename
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Thu, 07 Nov 2019 12:01:01 +0200
In-Reply-To: <5defb1b6-7e1d-8be1-ec4c-ed8378d3ed9b@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
 <20191015142729.18123-4-mreitz@redhat.com>
 <f3822494defad291fa70000487c339f3f73317ca.camel@redhat.com>
 <5defb1b6-7e1d-8be1-ec4c-ed8378d3ed9b@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: RaoaMEL6OcaSu38eby0JIg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-11-07 at 09:59 +0100, Max Reitz wrote:
> On 06.11.19 16:44, Maxim Levitsky wrote:
> > On Tue, 2019-10-15 at 16:27 +0200, Max Reitz wrote:
> > > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > > ---
> > >  tests/qemu-iotests/common.filter | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >=20
> > > diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/co=
mmon.filter
> > > index 9f418b4881..63bc6f6f26 100644
> > > --- a/tests/qemu-iotests/common.filter
> > > +++ b/tests/qemu-iotests/common.filter
> > > @@ -227,5 +227,29 @@ _filter_qmp_empty_return()
> > >      grep -v '{"return": {}}'
> > >  }
> > > =20
> > > +_filter_json_filename()
> > > +{
> > > +    $PYTHON -c 'import sys
> > > +result, *fnames =3D sys.stdin.read().split("json:{")
> >=20
> > Very minor nitpick, maybe I would give 'fnames' a more generic name,
> > since its is just result of a split, thus not really a list of filename=
s.
> > Feel free to ignore that though.
>=20
> Hm...  It is a list of filenames, namely of all nested json:{}
> filenames.  I could call it fname_split, but I actually think fnames is
> not too wrong.

Makes sense, I guess leave it as is.

>=20
> In any case, thanks for reviewing again!

No problem! Thanks to you too for making these tests more generic,
this is IMHO very very good thing, especially with all the qcow2
corruptions we see recently.


Best regards,
=09Maxim Levitsky


>=20
> Max
>=20



