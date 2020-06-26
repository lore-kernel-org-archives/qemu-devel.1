Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35679C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00EFF20706
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoUoH1RS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EFF20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqZX-0000et-8b
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1joqYh-0007ym-0E
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:46:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59907
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1joqYe-0006br-Lz
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593186387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZVClUSSwocLX08CzAt+OlHSvE9IJQxOD1nAt9dC0Hic=;
 b=YoUoH1RSQBYK4YLZEGNxIsCD17n8eLN4t2GHMK2nBM3DajN26YkApVST6ISZQWWrbkHXPz
 rk16D3GtCrQRbyS9ezqBvsipLjN7rCGkXIiRZ2nJVNMyWOaJ8wSbSIHmJcwtfSxE2FUTDD
 Gvrfl8iatbwrM2Bltbv7hD4mN/6Gs/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-5-j0Yyh8KaNbivJRIPGO0LZw-1; Fri, 26 Jun 2020 11:46:25 -0400
X-MC-Unique: j0Yyh8KaNbivJRIPGO0LZw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5899A8015FD;
 Fri, 26 Jun 2020 15:46:24 +0000 (UTC)
Received: from localhost (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E34BE71688;
 Fri, 26 Jun 2020 15:46:23 +0000 (UTC)
Date: Fri, 26 Jun 2020 16:46:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v9 0/5] vhost-user block device backend implementation
Message-ID: <20200626154622.GC316372@stefanha-x1.localdomain>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
 <20200619120746.GA2422025@stefanha-x1.localdomain>
 <20200625124656.ddca4ofgfhdgoerj@Rk>
MIME-Version: 1.0
In-Reply-To: <20200625124656.ddca4ofgfhdgoerj@Rk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 08:46:56PM +0800, Coiby Xu wrote:
> On Fri, Jun 19, 2020 at 01:07:46PM +0100, Stefan Hajnoczi wrote:
> > On Mon, Jun 15, 2020 at 02:39:02AM +0800, Coiby Xu wrote:
> > > v9
> > >  - move logical block size check function to a utility function
> > >  - fix issues regarding license, coding style, memory deallocation, e=
tc.
> >=20
> > I have replied with patches that you can consider squashing into your
> > series. I was testing this patch series and decided it was easier to
> > send code than to go back and write review comments since I was already
> > on a git branch.
> >=20
> > My patches can be combined into your original patches using "git rebase
> > -i" and the "fixup" or "squash" directive.
> >=20
> > Please add my Signed-off-by: line to affected patches when squashing
> > patches so that the git log records that I have confirmed that I have
> > permission to contribute this code.
> >=20
> > If you have questions about any of the patches, please let me know.
>=20
> Besides your Signed-off-by: line, shouldn't I also add copyright info to
> the affected files as follows?
>=20
>  * Copyright (c) 2020 Coiby Xu <coiby.xu@gmail.com>
>  *
>  * Copyright (c) 2020 Red Hat, Inc., Stefan Hajnoczi <stefanha@redhat.com=
>

The following would be good:

 * Copyright (c) 2020 Red Hat, Inc.

Thanks,
Stefan

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl72GE4ACgkQnKSrs4Gr
c8jhNAf+Ka7gRUT2JVdkP99vayZYD4tMVVRKSxi8QBOWzUvbLR7YFecmfENyNZiN
YBvTWdeDovy4LanMH7jX3ow3BAWFJZNPscwa5Z+NRrkufvQujRWBb20FtuyTGRw5
PqRmQ3RWtHte/jjsP49r0QoWxyv8R1HjF00zG9KzO0Pn9OBWfk5eHbw5X04SN83h
IJXtmP0shV9TeHndEhO2TFKd27bDk2RAv+7kMTwVCw5MwJQtnswW8LK/a9jYxAnL
mPVlbbBwzoPLLOWw/bjjG+Q3GYScZIjzus6TQ1PixvW5ZTuDQMYvB1U099Fx6mdu
SwgCJvEuvwUGFB/3xtNdHzq39w/XsA==
=NElB
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--


