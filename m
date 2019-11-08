Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A63FA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:21:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB4D21882
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 15:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNCvkc1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB4D21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT655-00081m-UA
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 10:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iT5rZ-0000mf-TN
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iT5rY-0000cx-Nv
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:07:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53524
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>) id 1iT5rY-0000bN-Kt
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 10:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573225668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vUnIBPXaVK5rgwpSnWNHv9XKDwdAafL3/CAVfQW4a3Q=;
 b=eNCvkc1FqPBfLQKNNua+rPoIwL3gj5nndkKpnYPJix8h/Rjisd9Rpm1+7A9wgMkNU7nDam
 G9X0bD8eZsxWrEe1EtXSbiUmrIzsKsexa4i2BMGeFbrr4Y7jTJ+T11M6szmfHyM3rZUHlY
 AjQoScRCLQB3za9elZFRCTLoE0eAV0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-YgJbfNyhMD6NLO_ZnjdZMA-1; Fri, 08 Nov 2019 10:07:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C977D477;
 Fri,  8 Nov 2019 15:07:43 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 641AB600CA;
 Fri,  8 Nov 2019 15:07:35 +0000 (UTC)
Message-ID: <adcb2b6e5a28573c762f8b0d73541ae12d16fc0d.camel@redhat.com>
Subject: Re: [PATCH v2 00/11] RFC crypto/luks: encryption key managment
 using amend interface
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Fri, 08 Nov 2019 17:07:35 +0200
In-Reply-To: <fb2cd2e0-2718-215f-d6af-59b64b229b4f@redhat.com>
References: <20190912223028.18496-1-mlevitsk@redhat.com>
 <fb2cd2e0-2718-215f-d6af-59b64b229b4f@redhat.com>
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: YgJbfNyhMD6NLO_ZnjdZMA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel
 P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-10-04 at 21:10 +0200, Max Reitz wrote:
> On 13.09.19 00:30, Maxim Levitsky wrote:
> > This patch series is continuation of my work to add encryption
> > key managment to luks/qcow2 with luks.
> >=20
> > This is second version of this patch set.
> > The changes are mostly addressing the review feedback,
> > plus I tested (and fixed sadly) the somewhat ugly code
> > that allows to still write share a raw luks device,
> > while preveting the key managment from happening in this case,
> > as it is unsafe.
> > I added a new iotest dedicated to that as well.
> >=20
> > Best regards,
> > =09Maxim Levitsky
>=20
> At least for an RFC looks good from my perspective.  I didn=E2=80=99t loo=
k at
> the crypto things very closely (assuming Dan would do so), and I didn=E2=
=80=99t
> check the iotests in detail.  (But it definitely doesn=E2=80=99t look lik=
e they
> lack in breadth.  Maybe I=E2=80=99d like to see a test that you cannot ha=
ve
> other useful nodes attached to the LUKS or qcow2 node while the
> amendment process is ongoing (because CONSISTENT_READ is unshared).  But
> that=E2=80=99s the only thing I can think of.)
Could you elaborate on this?=20

Inside the same process several users can access that luks node at the same
time while one of them changes encryption keys, since this doesn't affect I=
O of the data.

Two users in same process I was *I think* told that can't do the amend in t=
he same time
since qmp is protected with a lock. However since I use a block job (to be =
consistent with blockdev-create)
I wonder if several qmp amend commands couldn't race one with another. Thes=
e jobs is running
on the block device AIO context (I changed this recently after a review), b=
ut stil I am not sure
there can't be a race.

And when there is access to the same image from multiple processes, I do ha=
ve a test that
checks that as long as more that one process has the image open, noone can =
change the encryption keys
(this is only relevant for raw luks format, since for qcow2 this is forbidd=
en anyway).

I probably missed something though.

Best regards,
=09Maxim Levitsky



>=20
> Max
>=20



