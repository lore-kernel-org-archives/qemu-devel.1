Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B6FC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D0820705
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2sWcOqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D0820705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdQ3-0004VY-Jm
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jVdM5-0007D5-T9
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:50:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53410
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jVdM4-0001wh-E4
 for qemu-devel@nongnu.org; Mon, 04 May 2020 11:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588607402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ye2lfou3BuwqL2jbnkJ0TJG/I2iRslPFg1PmjsAfgo0=;
 b=I2sWcOqQUPD0c/e70JzQ7Xyrh58TmaWxz9nHiCxlvVG3LgJEDp19nJZzSyWRcagzzKjTcn
 lu6Z9PbR/AIzewKvzfS3sRiFdX6lryXTNyZ8Peh4judRrrF0bLc52aAX/2zPqxIBIx1XIq
 3qMwaMP9jbVl8rAQXzGxWC3QD6cUgfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-zGnsOp9aOm6ywPpmeFfCjw-1; Mon, 04 May 2020 11:49:58 -0400
X-MC-Unique: zGnsOp9aOm6ywPpmeFfCjw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C86348018A2;
 Mon,  4 May 2020 15:49:57 +0000 (UTC)
Received: from localhost (ovpn-113-75.ams2.redhat.com [10.36.113.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D06663F80;
 Mon,  4 May 2020 15:49:56 +0000 (UTC)
Date: Mon, 4 May 2020 16:49:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v5 0/5] vhost-user block device backend implementation
Message-ID: <20200504154955.GA363114@stefanha-x1.localdomain>
References: <20200309100342.14921-1-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200309100342.14921-1-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2020 at 06:03:37PM +0800, Coiby Xu wrote:
> v5:
>  * re-use vu_kick_cb in libvhost-user
>  * keeping processing VhostUserMsg in the same coroutine until there is
>    detachment/attachment of AIOContext
>  * Spawn separate coroutine for each VuVirtqElement
>  * Other changes including relocating vhost-user-blk-server.c, coding
>    style etc.

Hi Coiby,
Sorry I haven't fully reviewed this series yet. Do you have a new
revision that I should review instead?

Thanks,
Stefan

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6wOaMACgkQnKSrs4Gr
c8ioCggArDKQAK6LsDfqnx1Uzw1admD5/l7iylpNhh2Q21PmOtlKysF7WOZZv+9S
7DHktsPTfTaI84NAvljjL1vGvekUdNbzsc5B+UYm1J6dKpzsn2473W1rauKjwVOC
/nuA+jT7P8N7A91pIoNcaRijvQusbpLwBrG1S9ip0nQP+yKg1Au35cN6wLu29iw5
3AGND4BiSa9pivEpfhZytBoicABGffwTeftcg1x+c4geomgffhJ2MDAQIwchJmCq
Q8vA3sTVo1iu0/nnBiHfFuPOzRQDKq/bejtxGPz75mZHAiZYPSUB3Dz8H/ireLS+
K0Qz3/hvx8DWrV+A+1VztdGANhmRpA==
=6bvZ
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--


