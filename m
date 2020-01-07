Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384C5C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 063092081E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 15:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILiNSs+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063092081E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ior8B-0006E1-1B
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 10:50:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ioqiS-00070K-RB
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:24:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ioqiR-0008Bo-OL
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:24:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57770
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ioqiR-0008Bc-Kq
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 10:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578410659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=eyI6IrmGtgDL0Dm7RY9WxYMx59MA2vxRThYFXcDX020=;
 b=ILiNSs+G7ZXiPDJD5jBZHE8bANck9nd814EDE+s8TJo15xEvVwN1mOcmNYp1y6nKVbM44o
 AiygYaBOsdwYH2m0/OOV5Mw/cTHryzb3g1WWvkIlu/lRedi3XrBzTTIYdsiWzXVaTiqr1g
 wnJ5Crpfxn7PFXSJL5PnwQK9N+iCRjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-VNK2WNSNM5eKrhYRv34eTQ-1; Tue, 07 Jan 2020 10:24:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ABEC10054E3;
 Tue,  7 Jan 2020 15:24:17 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-116.ams2.redhat.com [10.36.116.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEE7D272D3;
 Tue,  7 Jan 2020 15:24:10 +0000 (UTC)
Subject: Re: [PATCH v1 5/6] travis.yml: Detach build and test steps
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200107135311.5215-1-alex.bennee@linaro.org>
 <20200107135311.5215-6-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <708b652e-83d3-f9b8-aa83-9d70d7b3e96c@redhat.com>
Date: Tue, 7 Jan 2020 16:24:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200107135311.5215-6-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: VNK2WNSNM5eKrhYRv34eTQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/01/2020 14.53, Alex Benn=C3=A9e wrote:
> From: Wainer dos Santos Moschetta <wainersm@redhat.com>
>=20
> Currently build and test commands are a single step in a
> Travis's `script` block. In order to see the output
> of the tests one needs to scroll down the log to find where
> the build messages ended and the limit is not clear. If
> they were in different steps then Travis would print the
> result build command, which can be easily grep'ed.
>=20
> So this change is made to detach those commands
> to ease the visualization of the output.
>=20
> Note that all steps on the `script` block is executed regardless
> if one previous has failed. To overcome it, let's save the
> return code of the build then check whether succeed or failed on
> the test step.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Message-Id: <20191230184327.2800-3-wainersm@redhat.com>
> ---
>  .travis.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 93838bf0f8b..848a2714efe 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -94,7 +94,8 @@ before_script:
>    - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>    - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { cat config.log &&=
 exit 1; }
>  script:
> -  - make -j3 && travis_retry ${TEST_CMD}
> +  - BUILD_RC=3D0 && make -j3 || BUILD_RC=3D$?

What about using "|| exit 1" instead of "|| BUILD_RC=3D$?" ?

> +  - if [ "$BUILD_RC" -eq 0 ] ; then travis_retry ${TEST_CMD} ; else $(ex=
it $BUILD_RC); fi
>  after_script:
>    - if command -v ccache ; then ccache --show-stats ; fi
> =20
>=20

 Thomas


