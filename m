Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743B4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:38:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4102220775
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 10:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2K7992L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4102220775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jolkA-0002vj-I5
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 06:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1joljA-0001hc-Eg
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:37:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49868
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jolj8-0005vf-CC
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 06:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593167817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0wYhW9tVA6tTlmUW5tnp505Hx7+JzYALdKZkkTnQMdA=;
 b=L2K7992LwHcaE3CRn0/pZq7cTQ2Xjfeme+i5/lVp3kRUyl6hQpHujqUGvxFQA1m89Ufx+u
 tvUF8jT2n5wPDb01Yk1VM9rOTpFjwhTefHIsivyr8GsIz6G+J6iwdGBn96QeAuCZM6UWe6
 kXhF1xN8jvv+qnznAHp5DZxotwdmxvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-wvoLeyBoPCiWUrQOf4vSMQ-1; Fri, 26 Jun 2020 06:36:55 -0400
X-MC-Unique: wvoLeyBoPCiWUrQOf4vSMQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14539107ACCD;
 Fri, 26 Jun 2020 10:36:54 +0000 (UTC)
Received: from localhost (ovpn-114-181.ams2.redhat.com [10.36.114.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97A0E10023A0;
 Fri, 26 Jun 2020 10:36:52 +0000 (UTC)
Date: Fri, 26 Jun 2020 11:36:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 01/17] block/nvme: Avoid further processing if trace
 event not enabled
Message-ID: <20200626103651.GH281902@stefanha-x1.localdomain>
References: <20200625184838.28172-1-philmd@redhat.com>
 <20200625184838.28172-2-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200625184838.28172-2-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:55:55
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2020 at 08:48:22PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Avoid further processing if TRACE_NVME_SUBMIT_COMMAND_RAW is
> not enabled.

Why?

This saves 8 trace events, each with 8 arguments. I guess the intent is
to improve performance. Did you measure an improvement?

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl71z8MACgkQnKSrs4Gr
c8g1nQf/RSgMRGsjTPgdf78ZwZIxX5hHeQJjsYKAUpmmhZ8GeIGEHizGIPZaEJ/y
71Zvm8uw8aPlrljfLdrUWWq4JmQkP0v6H78a6ldfbnbBFVCILj+gJLtelzkjEXY5
JMMkOXQqNeiXhLt9Zr6vTY/U3dWDxvw4m/d9AHliB3R3aD+AUhHnNrPFGNaEb6im
FN+GnuTPPGNph354EJWsYoY/b4G/X9AK+I0CtfVzhH+b3Oz7vmptBeWoI3ShhQV+
YGtYVuK3ges9UJ2f83gk+HWDPm1Ifw0OoF71k7zREC3XW9N9R0yFHSoHPHfQSFSm
97lAZh5RUmc/4X75hLNfQhMYxc7mPg==
=QNSI
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--


