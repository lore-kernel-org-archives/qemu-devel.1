Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B01FC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 22:02:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E609220856
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 22:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E609220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Yg7-0003zG-OT
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 18:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i0Yeg-000372-MG
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 18:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i0Yef-000332-JL
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 18:00:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i0Yec-0002zE-8Q; Wed, 21 Aug 2019 18:00:30 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 393D781F01;
 Wed, 21 Aug 2019 22:00:29 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B34AA60BF3;
 Wed, 21 Aug 2019 22:00:24 +0000 (UTC)
Message-ID: <0fa3706e8ecc560f189fa0c0af8a3dafa4e98f52.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 01:00:23 +0300
In-Reply-To: <daa54ca3-6b57-0201-fc8a-6102ea1c509b@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <daa54ca3-6b57-0201-fc8a-6102ea1c509b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 21 Aug 2019 22:00:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 00/13] RFC: luks/encrypted qcow2 key
 management
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-08-20 at 19:59 +0200, Max Reitz wrote:
> On 14.08.19 22:22, Maxim Levitsky wrote:
>=20
> [...]
>=20
> > Testing. This was lightly tested with manual testing and with few iot=
ests that I prepared.
> > I haven't yet tested fully the write sharing behavior, nor did I run =
the whole iotests
> > suite to see if this code causes some regressions. Since I will need =
probably
> > to rewrite some chunks of it to change to 'amend' interface, I decide=
d to post it now,
> > to see if you have other ideas/comments to add.
>=20
> I can see that, because half of the qcow2 tests that contain the string
> =E2=80=9Csecret=E2=80=9D break:
>=20
> Failures: 087 134 158 178 188 198 206
> Failed 7 of 13 tests
>=20
> Also, 210 when run with -luks.
>=20
> Some are just due to different test outputs (because you change
> _filter_img_create to filter some encrypt.* parameters), but some of
> them are due to aborts.  All of them look like different kinds of heap
> corruptions.
>=20
>=20
> I can fully understand not running all iotests (because only the
> maintainers do that before pull requests), but just running the iotests
> that immediately concern a series seems prudent to me (unless the serie=
s
> is trivial).
>=20
> (Just =E2=80=9C(cd tests/qemu-iotests && grep -l secret ???)=E2=80=9D t=
ells you which
> tests to run that may concern themselves with qcow2 encryption, for
> example.)
>=20
>=20
> So I suppose I=E2=80=99ll stop reviewing the series in detail and just =
give a
> more cursory glance from now on.

Sorry about that! I posted this as RFC, and the reason it is mostly done =
as opposed to typical RFC which might not
even contain any code was that for most of the time I was sure that API o=
f this is straightforward and won't need
any significant discussion, and in the last minute after I discussed with=
 Kevin on IRC one=20
obscure case of block backend permissions that was failing, he told me ab=
out the amend interface.
Next time I guess, when new a API is involved, I will post an API RFC fir=
st always and then start the implementation.

I fixed both issues that iotests uncovered locally, now all luks and most=
 qcow2 tests pass=20
(118 and 194 sometimes fail with qcow2, and this happens regardless of my=
 patches, and same for 162 which seems to fail
always now, also regardless of my patches.
I have a git head after the merge window opened so probably some bugs wer=
e added, and maybe already fixed)


The first issue was in 'qcrypto-luks: implement the encryption key manage=
ment'
where I accidentally stored the name of the secret without strdup'ing in =
the create flow, so I got double free,
which indeed caused the heap corruptions you have seen.

Basically this line:
    luks->secret =3D options->u.luks.key_secret;

The second issue as you mention is indeed the change in filters I did. Do=
 you agree with that change btw?
If you ask me, I would even change the filter further and filter all the =
image options from the qemu command line since these are test inputs anyw=
ay.
This allowed me to have the same test for both luks and qcow2 luks encryp=
ted test.

Also I didn't even expect you to run the iotests for me, but
rather just wanted a general RFC level feedback on the whole thing, that =
is why I even mentioned that I didn't run them.
So sorry for the trouble I caused!

I btw don't agree with you that only maintainers need to run all the iote=
sts fully.=20
I think that the patch submitter  should run all the tests that he can to=
 catch as many problems as he can,
_unless_ of course this is an RFC.


Best regards,
Thanks for the review,
Sorry again for the trouble,

Maxim Levitsky




