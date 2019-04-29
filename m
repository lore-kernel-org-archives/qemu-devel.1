Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2B8C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FCAF205F4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FCAF205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57592 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL6Ey-0001fH-H9
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 09:22:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hL6E9-0001HD-Q6
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hL6E8-0006wA-NA
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:21:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hL6E8-0006vj-Eg
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:21:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B231F3007C43;
	Mon, 29 Apr 2019 13:21:47 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-111.ams2.redhat.com [10.36.116.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6A8E65D6A9;
	Mon, 29 Apr 2019 13:21:41 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>,
	=?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20180830143348.10595-1-marcandre.lureau@redhat.com>
	<20181213032452.GA25689@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
	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
Organization: Red Hat
Message-ID: <0942d4a4-f264-fd42-0b2d-994c331a000c@redhat.com>
Date: Mon, 29 Apr 2019 15:21:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20181213032452.GA25689@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="OOs2s2PrFc2V10gfGUCZqVrIFnSMCxOaz"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 29 Apr 2019 13:21:47 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] seccomp: check TSYNC host capability
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
Cc: otubo@redhat.com, qemu-devel@nongnu.org,
	Andrea Bolognani <abologna@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429132132.o-p3sHQpFxfcs00cNJUSHgNcIH_nO3dwW3viNU5sJRo@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OOs2s2PrFc2V10gfGUCZqVrIFnSMCxOaz
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13/12/2018 04.24, David Gibson wrote:
> On Thu, Aug 30, 2018 at 04:33:48PM +0200, Marc-Andr=E9 Lureau wrote:
>> Remove -sandbox option if the host is not capable of TSYNC, since the
>> sandbox will fail at setup time otherwise. This will help libvirt, for=

>> ex, to figure out if -sandbox will work.
>>
>> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>=20
> This seems to have introduced a regression, which I found when
> preparing a ppc pull request.  Specifically when running with RHEL7 on
> a POWER host, using "-sandbox off" which one of my tests did, causes a
> cryptic error followed by a SEGV:
>=20
> $ ./ppc64-softmmu/qemu-system-ppc64 -sandbox off
> qemu-system-ppc64: -sandbox off: There is no option group 'sandbox'
> Segmentation fault
> $ ./x86_64-softmmu/qemu-system-x86_64 -sandbox off
> qemu-system-x86_64: -sandbox off: There is no option group 'sandbox'
> Segmentation fault
>=20
> I think the problem is that while this wrapped one use of the sandbox
> option group to produce a sensible error, it didn't do the same for
> another call to qemu_opts_parse_noisily():
>=20
> (gdb) bt
> #0  0x00000000105b36d8 in opts_parse (list=3D0x0, params=3D0x3ffffffffa=
b5 "off", permit_abbrev=3Dtrue, defaults=3Dfalse, errp=3D0x3ffffffff080)
>     at util/qemu-option.c:829
> #1  0x00000000105b3b74 in qemu_opts_parse_noisily (list=3D<optimized ou=
t>, params=3D<optimized out>, permit_abbrev=3D<optimized out>) at util/qe=
mu-option.c:890
> #2  0x0000000010024964 in main (argc=3D<optimized out>, argv=3D<optimiz=
ed out>, envp=3D<optimized out>) at vl.c:3589
>=20
> I'm guessing RHEL7 triggers it because that has a version of
> libseccomp that doesn't support the feature needed to complete
> registration (maybe on ppc host only; I haven't had a chance to try on
> an x86 RHEL7 host).

Andrea reported the same issue again today with QEMU v4.0 ...
Marc-Andr=E9, have you ever had another look into this issue?

 Thomas



--OOs2s2PrFc2V10gfGUCZqVrIFnSMCxOaz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJcxvpkAAoJEC7Z13T+cC21GDAQAI0wQTB/cTSp52kJW+pesPkp
MXGBy2jfe9T/3hSJg7dRIpkq2AfKoGG9ORSKo6Dztlh+k5GlJGv5MWfy1eNjCRqT
diJgadtpmbxa+ntrLZR90eqYI4aHEqbpbsZsSMBhEbfSRyZCoY6R6DIhih/coCx2
85NasoXBybzYNvHFNNmpr0tzFMIFI+huW5tmv62Gsq4HiF47XchXBAccQKINteP/
OhWN5XJWDl/AP/zhC+us43DvpLglGrN2cYSvxtLnQQo5TY+ZvTBEMqiXzaWTzUbA
OIgcW8SAS0NrP8/0RUsgDug7PsGzq76tG3O6hUL8Gux560v/sp4eEfaSjdC6U3xs
VA4ft+ggtUI4zInQUIDyw/QAzKd27nmPlwgDSO6zowwk5pPFON+7qp2UoJuYiIDN
qvKYLttvBLrTa1vE7eMVHaTn2SKpQ+4jbGCFU7tI6EZJ0REpDgkng9UrniC6Goam
L6ZdldkTWxPl/swEYY89n1M3DrvhJ5LMM157EXN/9YxmqbNCqoSkNyi1iGiDAUEZ
RuQX1heQssKMuDU653+SxKWqW/YnHSZYbFkb4wgt8CIbOKAwKtk//VEamYLzEaqt
7ga47EFdgpi0HcZovhdJKonZfoJcrnaEgNak//SvK4OIs8gkairK1Ai7OfQxeGk5
upLG9vctfsd0a5Hd9RYD
=BuqW
-----END PGP SIGNATURE-----

--OOs2s2PrFc2V10gfGUCZqVrIFnSMCxOaz--

