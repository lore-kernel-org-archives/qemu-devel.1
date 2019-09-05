Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1928C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 07:07:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6ACA20870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 07:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6ACA20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5ls3-0004X7-Rk
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 03:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i5lrJ-0003yD-Mj
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 03:07:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i5lrG-0000aN-P4
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 03:07:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60944)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1i5lrG-0000Yn-Fv
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 03:07:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0C4E13CA16
 for <qemu-devel@nongnu.org>; Thu,  5 Sep 2019 07:07:05 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-96.ams2.redhat.com [10.36.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 949CA5D9CA;
 Thu,  5 Sep 2019 07:07:00 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20190904130047.25808-1-thuth@redhat.com>
 <20190904130047.25808-6-thuth@redhat.com>
 <20190904185130.GE26826@stefanha-x1.localdomain>
 <42f1e032-36de-2692-b425-9bb14303c9ea@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <3fa65b23-c04c-5093-3dad-b5f6e5f1ea96@redhat.com>
Date: Thu, 5 Sep 2019 09:06:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <42f1e032-36de-2692-b425-9bb14303c9ea@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5C3Iy0FJDJ8LVCxkq5NgpIts6xQHP9Z5T"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 05 Sep 2019 07:07:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 5/6] tests/libqtest: Move global_test
 wrapper function into a separate header
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5C3Iy0FJDJ8LVCxkq5NgpIts6xQHP9Z5T
Content-Type: multipart/mixed; boundary="VywI4MBH7Ux9Eyz6MkKc7Bw5G50O53A7D";
 protected-headers="v1"
From: Thomas Huth <thuth@redhat.com>
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <3fa65b23-c04c-5093-3dad-b5f6e5f1ea96@redhat.com>
Subject: Re: [PATCH v2 5/6] tests/libqtest: Move global_test wrapper function
 into a separate header
References: <20190904130047.25808-1-thuth@redhat.com>
 <20190904130047.25808-6-thuth@redhat.com>
 <20190904185130.GE26826@stefanha-x1.localdomain>
 <42f1e032-36de-2692-b425-9bb14303c9ea@redhat.com>
In-Reply-To: <42f1e032-36de-2692-b425-9bb14303c9ea@redhat.com>

--VywI4MBH7Ux9Eyz6MkKc7Bw5G50O53A7D
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04/09/2019 21.09, Eric Blake wrote:
> On 9/4/19 1:51 PM, Stefan Hajnoczi wrote:
>> On Wed, Sep 04, 2019 at 03:00:46PM +0200, Thomas Huth wrote:
>>> diff --git a/tests/libqtest-single.h b/tests/libqtest-single.h
>>> new file mode 100644
>>> index 0000000000..49259558a5
>>> --- /dev/null
>>> +++ b/tests/libqtest-single.h
>=20
>>> +static inline QTestState *qtest_start(const char *args)
>>> +{
>>> +    global_qtest =3D qtest_init(args);
>>
>> Where are global_qtest and qtest_init() declared?  I would expect
>> compilation to fail if a .c file included just "libqtest-single.h".
>=20
> In patch 5, "libqtest.h" declares global_qtest, then includes
> "libqtest-single.h"; no file includes it standalone.  Then in patch 6,
> the roles are swapped; "libqtest-single.h" declares global_qtest and
> includes "libqtest.h".  But yes, the commit message could do better in
> explaining this.

Right. Let me add something like this to the patch description here:

"The new header is only included from libqtest.h for now, so that there
is no difference to the users of libqtest.h yet. In the next patch, we
will switch this, so that the users of the global_qtest-related
functions will be using libqtest-single.h directly and libqtest.h
becomes completely independent of this."

 Thomas


--VywI4MBH7Ux9Eyz6MkKc7Bw5G50O53A7D--

--5C3Iy0FJDJ8LVCxkq5NgpIts6xQHP9Z5T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJ7iIR+7gJQEY8+q5LtnXdP5wLbUFAl1wtBMACgkQLtnXdP5w
LbWiUg/+JjX2z+8eDPr8oBfavTNkT8r/huM6Jbx0jmRcyV/+b3BiBiYo9PdxGDkg
scL/FM9AlMsF/Y06tzFFIlgoRuJtWah/XdyCgXHULaH1G7HLnXNnQQjOZL0dhDod
kNvCO6AlTYyi/dkUA4zGgNW5fI20d3wDu7Em1XIU5I96KE/DZR1qNhgB1t4Rptq9
lZL3PE+WbpQ2UEiJ5DWuknWo9ef+nesQoYcXZEHdejCVQ70yZ0dhWoo5WbvaaABB
49w3mcrVqzgtfonUfQXXacWjfPiKawhWakEI3pU1rIN6hRvJPI4F+EOALBM6aJHK
QLkh6bzWDJG+L1/sIQQXga1tejhTyNo0kaFPBI32VLIBW1R2DvQ+lt6mDjiYbMwQ
kkWyWuBbCD1FlV3M0a+WPNbxc/w9GSQQ7zOljYq7Y+uknCgJIjH4N5RpT4R9+m6G
frVMfLYqT/fw9wlKfd1CVXWbpuPjKiEkyiizEfGEePMtdtf5MElxSFIEZQis9Gry
QucWmYa75mmECCch3Yb1aVncoQmmGz0PdKRBaWt1KFKfeBX1/wUO4jtv7IIta5lX
99QOs5ojzoz0jb1YE5Brn2KRms01S9O5xPL8AA46SbOkMGOWZ1+/48oTmxvo04a2
wORoii4farjMnNDrTw7dcb8ogHdBnAJnXHUQ04q0h9yg0qH9TVw=
=njfM
-----END PGP SIGNATURE-----

--5C3Iy0FJDJ8LVCxkq5NgpIts6xQHP9Z5T--

