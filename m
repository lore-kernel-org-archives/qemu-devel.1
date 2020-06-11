Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F62C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45680206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8K5B8q3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45680206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPAl-0005Xy-Hb
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 11:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jjP7U-0002lw-DK
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:27:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56716
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jjP7T-0006t0-Hg
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591889274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iOuRNHW+WyoFbF+PCqVQ+D5H0ALqjdbz9NU34BtGj9M=;
 b=S8K5B8q3ipGdwhjMoNxJN+K/EIRT1BIC9Zx6AZ7uMmHe2+BiD0llcSDswgllhiL6OnmaGh
 CdwfqRC4tpa8bXQLPIAcAvDKw0cMvXmxfG3LQPlA84Dd6i9sPJqpjf9AUOF3tdrPq5cZe9
 0i/JRxt8Hvz331DkT0N28Jl2/uWbHVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-tGVukNykM9uMBpi3bjWYEg-1; Thu, 11 Jun 2020 11:27:47 -0400
X-MC-Unique: tGVukNykM9uMBpi3bjWYEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0398A872FE2;
 Thu, 11 Jun 2020 15:27:46 +0000 (UTC)
Received: from localhost (ovpn-114-102.ams2.redhat.com [10.36.114.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98FCA28541;
 Thu, 11 Jun 2020 15:27:45 +0000 (UTC)
Date: Thu, 11 Jun 2020 16:27:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v8 0/4] vhost-user block device backend implementation
Message-ID: <20200611152744.GD77457@stefanha-x1.localdomain>
References: <20200604233538.256325-1-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200604233538.256325-1-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OROCMA9jn6tkzFBc"
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2020 at 07:35:34AM +0800, Coiby Xu wrote:
> v8
>  - re-try connecting to socket server to fix asan error
>  - fix license naming issue

Great, thanks for posting these patches!

I have posted feedback. I'd like to merge this soon. If you are busy I
can send you patches that address the comments I've made, please let me
know.

Thanks,
Stefan

--OROCMA9jn6tkzFBc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7iTXAACgkQnKSrs4Gr
c8ifNwgAmpAEViE2glv4UKvGmABxjedq3RhX6QK1RPI2fHa5v3L1DpE5qaLPq0f+
fuGGtuv/hrxqR8IUlO3v5GQ5Zj20929zw1FuaIVJcpLJCqeIsolETv4PNEEXZBdo
2HoywwIXcjBu5ZC3aeguj+5meZWB/+yrOyk39hzgIPrfedqDU+NbQdDX4NypTeyW
3rq9yC6ctQV8dExClhq995EXwIVcwoh1ixY/x8bwt51HCQCM/h8e0jlAqpwpnT/6
WicPAOxOU+0TXIkUe8BmA6O/yhGECflGBdMC8Bqa0VCIZOJ/SE6ocl3O7WLnjbJf
Tpmq2cxgebc7+OUJuE2wVrq2zVatkg==
=S/ja
-----END PGP SIGNATURE-----

--OROCMA9jn6tkzFBc--


