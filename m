Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465B2C43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:22:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA48B207C3
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nid2d2cL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA48B207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKNeb-00018d-HL
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 11:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKNcu-000801-QX
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 11:21:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24654
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKNcm-0003zD-Gr
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 11:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600701663;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nTcc9zLMMRL2yllF9rObkHmX78uOtQwKG4y5MR7GRho=;
 b=Nid2d2cL56kRZPoiWS2FzxHu2C+J3WQSZ0AjQPo0NeXDn9CcDrED2mz9aKVftb6yBVhx1t
 wEmrISWrynYnOx1V4A77sb0ZcrpoVg8Nv/GrSjH+8R13E3UfnpgZLAdcWc66dF27vk3NG8
 TPiQlQzHCbe8vAsCWwmeLfLGqS0uAc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-ALvmCZF9NeePQ1ph4y97HQ-1; Mon, 21 Sep 2020 11:21:00 -0400
X-MC-Unique: ALvmCZF9NeePQ1ph4y97HQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ABBC1017DC9;
 Mon, 21 Sep 2020 15:20:59 +0000 (UTC)
Received: from localhost (ovpn-112-39.ams2.redhat.com [10.36.112.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A38D15D9CD;
 Mon, 21 Sep 2020 15:20:58 +0000 (UTC)
Date: Mon, 21 Sep 2020 16:20:57 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v10 0/7] vhost-user block device backend implementation
Message-ID: <20200921152057.GA171636@stefanha-x1.localdomain>
References: <20200918080912.321299-1-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200918080912.321299-1-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 11:10:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 18, 2020 at 04:09:05PM +0800, Coiby Xu wrote:
> v10
>  - Use a linked list of VuFdWatch objects to keep kick info [Stefan]
>  - Merge improvements and fixes from Stefan
>  - Rename libvhost-user's vu_message_read to vu_message_read_default [Kevin]
>  - When shutting down the client, wait for the coroutine of processing
>    vhost-user messages to be finished [Kevin]
>  - Allocate struct req_data on the heap [Kevin]
>  - Improve coding of qtest case [Thomas]
>  - Fix several memory leaks detected by ASAN

Great, thank you for sending this. I spent Friday looking at the first
few patches and running qemu-storage-daemon with this.

I will post a follow-up series with cleanups and port it to the new QAPI
block exports API (NBD, FUSE, vhost-user-blk, etc).

Kevin is currently on vacation but will be back soon. If he has no
further comments we could merge this.

Stefan

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9oxNkACgkQnKSrs4Gr
c8hXZQf/XPEu0bDZ0u5Sek7TNLCCvM81yvRs/GqmGBKe5jwlKVlwfpCuJZbesP41
hx6/BPDQBp9V8GLf5clGwYCiyCLB437CKQryAyaJWaY2sZ/mhpMiEbBlr+68j7bp
czvgoS85xQbNIxhFUx+QIIaNxPKH0+wCem3TrA2umxUwrfv4QZzlXDpGMVOuVfKm
Okfw14hw3JXNnhMhotDxLm1Xye/hC/DnlX4hSZ+FxMCwaAXe7pvTZFuEnhNjA5SM
nmmGwfZaCJHVzCnPipwx97/QOAtY/KuvDpN/pAcGxpQUtFTR4XO2CV/bPkfcRsbr
fPmwgrSUrBKaCqeqfdmvFHeCqJZAYg==
=oUKr
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--


