Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22938C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 22:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A12520732
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 22:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3Ww1MtZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A12520732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXuH0-0001W1-Dw
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 18:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXuBA-0005R5-B9
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 18:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kXuB8-00031t-Sn
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 18:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603925059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1aVs3y7Fnp60Y6DhYxiytyl6hzCePqW8hMHHaP19Msc=;
 b=Z3Ww1MtZAG9fAZDSgsoZlQWf5x7vgHn/LchiMvODRSmDT24TVh1A4mKbhk3OX08s49HJUi
 A0eLKfYxcF9aEjYwUBY43eDq/23FSnAVtR5P5/VoBDQG2ZdHs9CakAvYWVG9/y3pmjan0e
 lkghoGHFDQ1bH81BbjbAVT+1ci7I7W4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-wxgFVjjDNiuD_I2_Ft9MMg-1; Wed, 28 Oct 2020 18:44:14 -0400
X-MC-Unique: wxgFVjjDNiuD_I2_Ft9MMg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AF3D804B77;
 Wed, 28 Oct 2020 22:44:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76A6F60C04;
 Wed, 28 Oct 2020 22:44:08 +0000 (UTC)
Date: Wed, 28 Oct 2020 18:44:06 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 13/15] python: move .isort.cfg into setup.cfg
Message-ID: <20201028224406.GF2549351@localhost.localdomain>
References: <20201020193555.1493936-1-jsnow@redhat.com>
 <20201020193555.1493936-14-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020193555.1493936-14-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yRA+Bmk8aPhU85Qt"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ben Widawsky <ben@bwidawsk.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 Rohit Shinde <rohit.shinde12194@gmail.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 20, 2020 at 03:35:53PM -0400, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+Z9DYACgkQZX6NM6Xy
CfMgXg/5AdMYaHUZIzxSZbPlvTSQGIVaAe912S8va9UxbSGLa6j60qvrfswxUiDq
oMW4EywIPrRzhgL4/7IyXm9AmsltKoJgb4V90CU6g41z1xAGL8ayPApvqR31hgOU
MQBQ+KEDIYfiYoX3PYdltDkSu/tkc2DTioE21GVAmrNwKWICXg+JNjSU0bwLlTvj
DGCva31HLVqYsZZJlFDKFhdXAK7G8vpI7731zQDbj13lgFdXirp/IBMRd95/W8qu
zw8Es15lK83B2CAuDZPChY27+9tLLUBIQersMiHFiU5v2XWtInfu/9vGzTt1xBO9
KFgzlMWvEh0VX7nKBNcld9XE7PG++43zZmxjMSCMZxCC6puMTuumLXFnPQgORzGf
DGEzWSX2SxbqHWDpwGZwXP1603AztIAVzwbxRIafA/3lDT56Fax9gAoKwGm69p87
fUa7/f9Lf011uaQS95JSgqNAZbSesm3KnZNjqBfptRwlO5hq55pGVgKBxZbNmP9d
iBYAF4DAvR9ngKQfpnYxydLiudAYvlRw3u+mPGGUYaQHjV5bqETzJ6/HhB+//OZu
Anq9Y0o5vKLiwhBgi+GvCNTCDHjNL/7rlMQW5tXk4/yRVmvNNws82uhqXhv+Zj/R
tkp+nbCj2cbXMfYm3u81zd1bQT8KGsycPOV2DcsV4tn9l449vPQ=
=n0s/
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--


