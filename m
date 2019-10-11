Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A26C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:15:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 713472190F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713472190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIq4p-0002Dv-I6
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 04:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iIq3S-0001Yi-4q
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iIq3R-0005NC-6r
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:13:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iIq3O-0005Jg-Em; Fri, 11 Oct 2019 04:13:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DE989307C820;
 Fri, 11 Oct 2019 08:13:36 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B22D65D6C8;
 Fri, 11 Oct 2019 08:13:35 +0000 (UTC)
Subject: Re: [PATCH 00/23] iotests: Add and use $SOCK_DIR
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191010152457.17713-1-mreitz@redhat.com>
 <5f346ee9-9ffe-7290-eb0e-50d2ab28d363@redhat.com>
 <ad97e658-2224-17e1-e7fd-383513244411@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <8b75df27-e0be-3f03-d945-9ddeea031cdd@redhat.com>
Date: Fri, 11 Oct 2019 10:13:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ad97e658-2224-17e1-e7fd-383513244411@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="snrZlGjZ2bANr5dLXP3id4OZ9Aedbdz0a"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 11 Oct 2019 08:13:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--snrZlGjZ2bANr5dLXP3id4OZ9Aedbdz0a
Content-Type: multipart/mixed; boundary="FKrIzlCTdDYZkWroSkRGK736nMutok4JT";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <8b75df27-e0be-3f03-d945-9ddeea031cdd@redhat.com>
Subject: Re: [PATCH 00/23] iotests: Add and use $SOCK_DIR
References: <20191010152457.17713-1-mreitz@redhat.com>
 <5f346ee9-9ffe-7290-eb0e-50d2ab28d363@redhat.com>
 <ad97e658-2224-17e1-e7fd-383513244411@redhat.com>
In-Reply-To: <ad97e658-2224-17e1-e7fd-383513244411@redhat.com>

--FKrIzlCTdDYZkWroSkRGK736nMutok4JT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/10/2019 10.03, Max Reitz wrote:
> On 11.10.19 09:27, Thomas Huth wrote:
>> On 10/10/2019 17.24, Max Reitz wrote:
>>> Hi,
>>>
>>> Perhaps the main reason we cannot run important tests such as 041 in =
CI
>>> is that when they care Unix sockets in $TEST_DIR, the path may become=

>>> too long to connect to them.
>>>
>>> To get by this problem, this series lets the check script create a ne=
w
>>> temporary directory (mktemp -d) and then makes the iotests use it for=

>>> all Unix sockets.
>>
>> Thanks a lot for tackling this!
>>
>> I gave it a try, and most tests work fine now indeed when I run them i=
n
>> a directory with a veeeery long file name.
>>
>> I still get an error with 028 though:
>=20
> Hm, I didn=E2=80=99t see any error for 028 or 055 myself.  028 makes us=
e of
> common.qemu, which uses FIFOs, and I thought there were exempt from thi=
s
> problem.  And for 055 I have no idea.
>=20
> Maybe just bugs in qemu? :-)

Yeah, maybe... anyway, both, 028 and 055, are not in the auto group, so
I think we simply could ignore these bugs for now.

 Thomas


--FKrIzlCTdDYZkWroSkRGK736nMutok4JT--

--snrZlGjZ2bANr5dLXP3id4OZ9Aedbdz0a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl2gOaoACgkQLtnXdP5w
LbXaShAAnt25KOcV7rjt17KwnGa/79t81UZ34+r4ODapUO0NraQr2EznxTJyDOce
+Fd+Y5UkPREPUik3VX2NOOPGcgumUc1mPAggufDOqeQGte4i0JEEDZVKkp0rmX5s
4HwVV8jroO6YSS5t8aDYQVOv0TWO1T+8rBEH3/FOA4rlooQO+UfYnYWa2z0QUWCe
s7kDdDlGzieD99BNhocNEeWV7i9fmaiuncua1e4EKe6pgZS10cGXeI7FWL8+VZDG
SUCcOSJqrIDVW0pGjF8Uc/Fr0z8qA3tk475NsOvY8WPKTi1518qLitnLqhHvuPTa
Lh0MlV0ISviJpF4Gd7LQtUJcA9W1Z6si/+NJ1TWXqm5naIdTCJp+LomcmG5iYpG/
ofb5zisFb537qaYb8R6UBqCbP/pf4b30zqT0llwWzbaaALmB6CwFe5habfzIzgpx
9OrfNNV5FsPtWZ7YIWvSZqtEbOTUx/x8LSrI26duTJ3Cghv0XB4NZCT4B7Ka1ZKc
v4JcA3VkPQv/xyQKm/XZPDq3+mQTNavlZG8WcRpZccg3PG308ZKsF/CGAIOToHGE
WtN/RtGFmKsOAxsd9tCTspriU9yShAhpV4mKbqKzggtdkAucLhtfxk0ENIrMs6hz
GovsICfTp4T8fERFKzIHPogW2qXapDrrpUcW8IbiYuSAZATgqEU=
=2n7G
-----END PGP SIGNATURE-----

--snrZlGjZ2bANr5dLXP3id4OZ9Aedbdz0a--

