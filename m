Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA03C3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 07:35:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDFE206E0
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 07:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDFE206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Qa4-0002fW-3u
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 03:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i1QXG-00012U-Sr
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 03:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i1QXF-0001pv-SJ
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 03:32:30 -0400
Received: from smtpe1.intersmtp.com ([213.121.35.75]:20804)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>) id 1i1QXF-0001nN-N5
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 03:32:29 -0400
Received: from tpw09926dag18h.domain1.systemhost.net (10.9.212.42) by
 BWP09926080.bt.com (10.36.82.111) with Microsoft SMTP Server (version=TLS1_2, 
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1713.5; Sat, 24
 Aug 2019 08:32:22 +0100
Received: from tpw09926dag18e.domain1.systemhost.net (10.9.212.18) by
 tpw09926dag18h.domain1.systemhost.net (10.9.212.42) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Sat, 24 Aug 2019 08:32:24 +0100
Received: from tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c]) by tpw09926dag18e.domain1.systemhost.net
 ([fe80::a946:6348:ccf4:fa6c%12]) with mapi id 15.00.1395.000; Sat, 24 Aug
 2019 08:32:24 +0100
From: <tony.nguyen@bt.com>
To: <crosa@redhat.com>, <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>
Thread-Topic: [Qemu-devel] [PATCH] configure: more resilient Python version
 capture
Thread-Index: AQHVWf2IBVB41ipN0UO2nwGMgqq8UKcJ5kps
Date: Sat, 24 Aug 2019 07:32:24 +0000
Message-ID: <1566631944235.10945@bt.com>
References: <20190823215451.26276-1-crosa@redhat.com>
In-Reply-To: <20190823215451.26276-1-crosa@redhat.com>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.187.101.40]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 213.121.35.75
Subject: Re: [Qemu-devel] [PATCH] configure: more resilient Python version
 capture
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
Cc: julio.montes@intel.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -python_version=3D$($python -V 2>&1 | sed -e 's/Python\ //')=0A=
> +python_version=3D$(python2 -c 'import sys; print("%d.%d.%d" % (sys.versi=
on_info[0], sys.version_info[1], sys.version_info[2]))' 2>/dev/null)=0A=
=0A=
On a Python 3 only system, configure will no longer print the version.=0A=
=0A=
e.g.         =0A=
/* snip */=0A=
install           install=0A=
python            python3 -B ()=0A=
slirp support     git =0A=
/* snip */=0A=
=0A=
> @@ -6511,6 +6511,7 @@ if ! $python -c 'import sys; sys.exit(sys.version_i=
nfo < (3,0))'; then=0A=
>    echo=0A=
>    echo "warning: Python 2 support is deprecated" >&2 =0A=
>    echo "warning: Python 3 will be required for building future versions =
of QEMU" >&2 =0A=
> +  python2=3D"y"=0A=
>  fi  =0A=
...=0A=
> -echo "PYTHON_VERSION=3D$python_version" >> $config_host_mak=0A=
> +echo "PYTHON2=3D$python2" >> $config_host_mak=0A=
...=0A=
> -ifneq ($(findstring v2,"v$(PYTHON_VERSION)"),v2)=0A=
> +ifneq ($(PYTHON2),y)=0A=
=0A=
Succinctly, if Python 3.=0A=
=0A=
We can further ween the world off Python 2 by replacing python2=3D"y" for =
=0A=
python3=3D"y" and PYTHON2 for PYTHON3.=

