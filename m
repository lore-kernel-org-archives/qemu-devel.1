Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B59C47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 19:48:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D63E9206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 19:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZTO3QEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63E9206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYEQ1-0005xJ-Uf
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 15:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jYEJe-00021l-V5
 for qemu-devel@nongnu.org; Mon, 11 May 2020 15:42:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54339
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jYEJc-00010H-Q9
 for qemu-devel@nongnu.org; Mon, 11 May 2020 15:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589226135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oOh2Z7/M0Scy2VhE1vh2P6Ofb/aNSQeEkWCfPFiyStQ=;
 b=eZTO3QEO/49KihflSwSKW2c1/NTFsANGrcyVRCngfDCqqQyKPEQUoWVNDgDXq6ZBcF6r3o
 G1lDXFlnLrM1N4Xj7GVHrlXKQO1mBwlRNknZzTF4bdmzBcsH7nPchS4nv1zNaseW95dgmH
 w6XtffC+3rYWGR5DaxWMvRndgNz4fTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-Ycbk1aNhOuef7Tn96R4PIw-1; Mon, 11 May 2020 15:42:12 -0400
X-MC-Unique: Ycbk1aNhOuef7Tn96R4PIw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C63E8014C0;
 Mon, 11 May 2020 19:42:10 +0000 (UTC)
Received: from localhost (unknown [10.40.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 345611000232;
 Mon, 11 May 2020 19:42:01 +0000 (UTC)
Date: Mon, 11 May 2020 21:41:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH v26 01/10] acpi: nvdimm: change NVDIMM_UUID_LE to a
 common macro
Message-ID: <20200511214157.6a64526a@redhat.com>
In-Reply-To: <777c44a0-b977-a8fe-a3c6-5b217e9093af@huawei.com>
References: <20200507134205.7559-1-gengdongjiu@huawei.com>
 <20200507134205.7559-2-gengdongjiu@huawei.com>
 <4f29e19c-cb37-05e6-0ae3-c019370e090b@redhat.com>
 <777c44a0-b977-a8fe-a3c6-5b217e9093af@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 00:05:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com,
 kvm@vger.kernel.org, mst@redhat.com, mtosatti@redhat.com,
 qemu-devel@nongnu.org, ehabkost@redhat.com, linuxarm@huawei.com,
 shannon.zhaosl@gmail.com, zhengxiang9@huawei.com, qemu-arm@nongnu.org,
 Jonathan.Cameron@huawei.com, pbonzini@redhat.com,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 May 2020 22:05:28 +0800
gengdongjiu <gengdongjiu@huawei.com> wrote:

> >> +=C2=A0=C2=A0=C2=A0 (node3), (node4), (node5) }
> >> +
> >> =C2=A0 #define UUID_FMT "%02hhx%02hhx%02hhx%02hhx-" \
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%02hhx%02hhx-%02hhx%02hhx-" \
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%02hhx%02hhx-" \
> >> diff --git a/slirp b/slirp
> >> index 2faae0f..55ab21c 160000
> >> --- a/slirp
> >> +++ b/slirp
> >> @@ -1 +1 @@
> >> -Subproject commit 2faae0f778f818fadc873308f983289df697eb93
> >> +Subproject commit 55ab21c9a36852915b81f1b41ebaf3b6509dd8ba =20
> >=20
> > The SLiRP submodule change is certainly unrelated. =20
>=20
> Thanks Philippe's review and comments. I submitted another patchset "[PAT=
CH RESEND v26 00/10] Add ARMv8 RAS virtualization support in QEMU" to fix i=
t, please review that patchset.

for future, adding RESEND doesn't make sence here. If you change patches th=
en just bump version.
>=20
> >=20
> >=20
> > .
> >  =20
>=20


