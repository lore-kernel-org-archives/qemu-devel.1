Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6259C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E4942078D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmEn0tQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E4942078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjKkg-0004tY-Oc
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 06:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jjKic-0003aI-Cg
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 06:45:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20368
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jjKia-0005zc-Fm
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 06:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591872355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T6um3N2m7x4g720xnP22JB/TaOI/Zn7yGcuyAZ5mjvM=;
 b=QmEn0tQNtOU99YcqPkbvpZKO49ZjK67AC5cCWurHThv9uc7SjMzvQByArq/T/MExKfmAUD
 Rs4QewfNC09watsDPy289j1cUlRVDFDM5T87dqBXT/axzjqMZ8Z1NswGqulmbVMFr2Jbhu
 yL/vmLNz3FHk322+pA4Lfk+mIJ6cq2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-Ih2ef08tNDymNt6q-FXeXA-1; Thu, 11 Jun 2020 06:45:52 -0400
X-MC-Unique: Ih2ef08tNDymNt6q-FXeXA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8084F8735C0;
 Thu, 11 Jun 2020 10:45:51 +0000 (UTC)
Received: from localhost (ovpn-114-102.ams2.redhat.com [10.36.114.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 114AC10013D0;
 Thu, 11 Jun 2020 10:45:50 +0000 (UTC)
Date: Thu, 11 Jun 2020 11:45:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v8 1/4] Allow vu_message_read to be replaced
Message-ID: <20200611104549.GA77457@stefanha-x1.localdomain>
References: <20200604233538.256325-1-coiby.xu@gmail.com>
 <20200604233538.256325-2-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200604233538.256325-2-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2020 at 07:35:35AM +0800, Coiby Xu wrote:
> Allow vu_message_read to be replaced by one which will make use of the
> QIOChannel functions. Thus reading vhost-user message won't stall the
> guest.
>=20
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  contrib/libvhost-user/libvhost-user-glib.c |  2 +-
>  contrib/libvhost-user/libvhost-user.c      | 11 ++++++-----
>  contrib/libvhost-user/libvhost-user.h      | 21 +++++++++++++++++++++
>  tests/vhost-user-bridge.c                  |  2 ++
>  tools/virtiofsd/fuse_virtio.c              |  4 ++--
>  5 files changed, 32 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7iC10ACgkQnKSrs4Gr
c8h1MAf/SE7A9o92H3rL0LH+9EqjVSqr4XERu56Xv7MtiQ/b0kUwewmGN1H1k0vt
Hxu/PCLvwVQ1ZO8VJb/GmCN2w5SToPeQ4GAIy1pal89qWJy4l+cp5L5+pj2Cg+MF
a/EXHnnWcka/exLHj7X08YOvvcsyt10Rx3COsrT03BtzxTQwYG1upVg4NK8RjNnO
Pbg06O8I+0SbgD/s4aWXzxLUu5mzeQIBjCmeJX3Yd+4KJIsz9r2Qz2Bq7+EAmRVG
BmXRhnggHHkrZsUpXdo0NU4Jo0pzUKgtbTXOvh4+1u5xyCH8cG5GNbVoexaVGBas
DDnrQmYmN1a/y6pfFnMds25wsDlqmw==
=yNB2
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--


