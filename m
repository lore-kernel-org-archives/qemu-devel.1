Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B87C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:32:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7124C21907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 09:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7124C21907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAsnl-0006Dk-Ge
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 05:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44227)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iAsn0-0005jh-LX
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iAsmz-0005gV-PS
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 05:31:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1iAsmx-0005fG-N9; Thu, 19 Sep 2019 05:31:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 07558302C068;
 Thu, 19 Sep 2019 09:31:47 +0000 (UTC)
Received: from localhost (unknown [10.36.118.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C53E561371;
 Thu, 19 Sep 2019 09:31:40 +0000 (UTC)
Date: Thu, 19 Sep 2019 10:31:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190919093140.GB3606@stefanha-x1.localdomain>
References: <20190918132112.10418-1-stefanha@redhat.com>
 <20190918132112.10418-3-stefanha@redhat.com>
 <3fc89857-c46b-dbe1-194e-89dcbe2cd679@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <3fc89857-c46b-dbe1-194e-89dcbe2cd679@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 19 Sep 2019 09:31:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 2/3] trace: Remove trailing newline in events
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 05:51:16PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 9/18/19 3:21 PM, Stefan Hajnoczi wrote:
> > Reviewed-by: John Snow <jsnow@redhat.com>
> > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> > Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > Message-id: 20190916095121.29506-2-philmd@redhat.com
> > Message-Id: <20190916095121.29506-2-philmd@redhat.com>
>=20
> Out of curiosity, how do you end up with 2 slightly different
> message-id? Using two different tools in series? (Thinking about
> unifying these tools format).

I'm not sure what happened here :P.

Stefan

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2DSvsACgkQnKSrs4Gr
c8iVWAgAh5tllixqq+xklxP0nhmJHcmB0+pHwFGf2xMNVWwc37aKOlym5fFkK2p/
Tulo6zbhqjxZIUBC0h6WsOejOP7weZIQsv9JCQBM7WbNMuu7h5n2Kdu6TQ5vxoaW
DoCKkAKf6yZm3PdOSbbz0oAMNqcN5/R8tb/HzfabXfl3/xI0SzUJa+wHXuz7DWy5
mH73h5zy9yfEW7JXPDCMBpkfTMNf141oh28NfjPpFn+Oskcp+K0D/lL4RQbDKUOu
/OkzBWyPWTR42EW0+tQNlVlXlj54svv8dlB5i9gXwjE+bp3vhwaajTxiQf4gV9y7
54TaePQy3KNgWZybAlid4m0kA6LoJw==
=zd5/
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--

