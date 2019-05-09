Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65310C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:19:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30B0F216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:19:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B0F216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50215 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOeGr-00015E-7q
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:19:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOeFx-0000lu-8t
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOeFw-0007U8-Ao
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:18:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hOeFw-0007RV-5e
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:18:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53B493079B73;
	Thu,  9 May 2019 08:18:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8C9005B680;
	Thu,  9 May 2019 08:18:15 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id C301111AA3; Thu,  9 May 2019 10:18:14 +0200 (CEST)
Date: Thu, 9 May 2019 10:18:14 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190509081814.dptmmhw7fkqazud3@sirius.home.kraxel.org>
References: <20190508085645.11595-1-kraxel@redhat.com>
	<20190508085645.11595-4-kraxel@redhat.com>
	<53e70dc0-db41-9949-4014-b5efed2fe79f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <53e70dc0-db41-9949-4014-b5efed2fe79f@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 09 May 2019 08:18:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 03/13] tests/vm: send locale environment
 variables over ssh
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> "gmake check" then also finally failed:
>=20
> --- /home/qemu/qemu-test.AOvcgx/src/tests/qapi-schema/unicode-str.err
> 2019-05-09 05:56:17.000000000 +0000
> +++ -	2019-05-09 06:12:54.451392000 +0000
> @@ -1 +1 @@
> -tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '=E9=
'
> +tests/qapi-schema/unicode-str.json:2: 'command' uses invalid name '\xe=
9'

Well, that failure disappeared in my tests.  But that'll probably only wo=
rks
in case the guest actually has support for the given locale.

> Note that if you just wanted to fix the python3 utf-8 problem with this
> patch here, there is a separate fix available for that problem already:
>=20
>  https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01247.html

Ah, ok.  Guess I can drop the patch then.

cheers,
  Gerd


