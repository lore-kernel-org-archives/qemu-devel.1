Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1934C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB372071A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7xBxM1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB372071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKQ7e-0005oH-AH
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 14:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kKQ5J-0003Mw-GO
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kKQ5H-0002If-Eu
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600711117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WDRa/yB+rPwrpk/BcOyE9u9KfnPnLd8OTsPjnWdZ784=;
 b=U7xBxM1nmba66UkGbhcdBOTWchwZaXtyTboEGjdxi9WsD0RMYDNSK9QzYbut58fquI0lNh
 HkH93o0iGY9BT6KkrTxGO+W76lmDDAJAuzrkdkWC4tiAdojTFr/qOwKymsK6Jaq9R/uep2
 1M4JBzAkj0o4ZLXKEIQ+Avzl24PQGkA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-GosDdAlrMx6adlH-8AVz0g-1; Mon, 21 Sep 2020 13:57:22 -0400
X-MC-Unique: GosDdAlrMx6adlH-8AVz0g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 640801005E66;
 Mon, 21 Sep 2020 17:57:21 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B9405D9CD;
 Mon, 21 Sep 2020 17:57:08 +0000 (UTC)
Date: Mon, 21 Sep 2020 13:57:06 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: Bottleneck problem to merge Python patches
Message-ID: <20200921175706.GA8403@localhost.localdomain>
References: <20200828104102.4490-1-ahmedkhaledkaraman@gmail.com>
 <20200828104102.4490-2-ahmedkhaledkaraman@gmail.com>
 <CAL1e-=iA95PR-mM9E+nfsvFRJLhQsj5Q9qPAM=7QS9mg-QvcbQ@mail.gmail.com>
 <6ad83ff4-1b4f-69f0-7dbe-85680e2f403e@amsat.org>
MIME-Version: 1.0
In-Reply-To: <6ad83ff4-1b4f-69f0-7dbe-85680e2f403e@amsat.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "ldoktor@redhat.com" <ldoktor@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, Ben Widawsky <ben@bwidawsk.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 "aleksandar.qemu.devel@gmail.com" <aleksandar.qemu.devel@gmail.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>, Willian Rampazzo <wrampazz@redhat.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2020 at 01:17:06PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi Aleksandar,
>=20
> (extending the Cc list to broader audience)
>=20
> On 9/18/20 10:33 PM, Aleksandar Markovic wrote:
> >=20
> > On Friday, August 28, 2020, Ahmed Karaman <ahmedkhaledkaraman@gmail.com
> > <mailto:ahmedkhaledkaraman@gmail.com>> wrote:
> >=20
> >     - Apply pylint and flake8 formatting rules to the script.
> >     - Use 'tempfile' instead of '/tmp' for creating temporary files.
> >=20
> >     ---
> >=20
> > Hello, folks.
> >=20
> > This series seems forgotten. Can some of you perhaps take a look,
> > review, and possibly integrate some patches in a pull request?
> >=20
> > Ahmed invested quite of time to improve the functionality and quality o=
f
> > scripts, and they are truly useful for developers interested in
> > performance measurement.
>=20
> The Python patches are indeed being merged slowly, but are not
> forgotten :) Eduardo sent just a pull request *yesterday* for
> patches he had queued *before* QEMU 5.1, that is more than 1 year
> ago!
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg742228.html
>=20
> I hope he will be able to process the other Python patches sent
> the last 12 months. He raised the problem few month ago saying he
> was overwhelmed and was looking for help from the community.
> Cleber helped a pair of times, I helped once, but then nobody
> popped up volunteering.
>

Yes, Python patches are not forgotten... they have been haunting me
every day and night for the last few months.  I have a *lot* of blame
to take here, so my sincere apologies.

One word of hope is that my resources (which were exhausted during the
last months towards the Avocado 82.0 LTS release, released last week)
are now freed.  And *a lot* of the Avocado features were eyeing QEMU,
so it's just natural that I will (because I want and have to) get
back to being more active and responsive.

> I agree this is a community problem, nobody wants to become the
> de-facto Python maintainer. Current maintainers are already busy
> solving problem with low-level languages such C.
> As a project, QEMU is evolving, using more and more Python, switched
> to Meson, we might have Rust code too. Learning that for current
> maintainers takes time. I guess we lack new contributors/maintainers
> with interest in Python & QEMU.
>=20
> This is my simple/rough analysis, as John had the same problem
> 2/3 months ago, his patches were on the list unreviewed for various
> weeks. Same problem with Avocado patches, Lukas sent a series a bit
> before Ahmed and it is still unreviewed:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg737272.html
>

ACK.  This is a good real example of my previous abstract explanation
above.

So, besides me getting back with more resources to review and maintain
the Python pathes, I have also requested Willian Rampazzo (thanks!) to
keep an eye on those patches and help with reviews.

> Alex Benn=E9e recently said:
>=20
>  "review time is the currency of qemu-devel ;-)"
>=20
> We might be failing at explaining new contributors the importance
> of peer-review, as this helps a lot maintainers. It is described
> in the wiki but maybe new contributors don't read it, we don't
> remember them to:
> https://wiki.qemu.org/Contribute/SubmitAPatch#Participating_in_Code_Revie=
w
> and:
> https://wiki.qemu.org/Contribute/SubmitAPatch#Return_the_favor
>=20
> My 2 cents...
>=20
> Regards,
>=20
> Phil.
>

So while more help is always welcome, I do sincerely hope with myself
and Willian back into the loop, the Python patches won't lag behind
anymore.

And thanks for raising the awareness of the issue Phil!

- Cleber.

> >=20
> > Thanks,
> > Aleksandar
>=20

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9o6W8ACgkQZX6NM6Xy
CfMvVw//THGuneja1obdGViVG1S5vTZsH+Sp9iAcUM/ASXgtQq6J8+IF4xicHS0l
R+Hf6du7evFpt+G6UKZRpfIQIUcmCRzitfVpMLT0vwSwjHMA2AFC6BddRp1oh1c5
reA7uGgc7FDu28n4m2rTMCiOYMD4H2lO+qwume9HXAmDT5WugQUm/Zc0iNARHVd7
onmlEBtL+FtRMrGmFBGVfZjhPhTIfSB78PALu5lsmqB1xRhgP5kEy/Lc/lM6emPq
16HSt5ocqqFMNkV0uT+Zlz60TzVkQBCsw1ZIg+6kadk/6SA9MudZo/jTKuUSWGIr
a+6FOlo5qqPCC4Czy0oMQM6a54fFC3saBNSW3vNg5e+fR7UbIuyrWrIZPeELCPv4
x5q5JBSOHrAouHQY3lpku8oPBjQyZwMrXGeJ79z/lS+yBaPo4qqnBhYQhtVxK5te
1Ra78EeMThgwbv+/lxzTn+/ZeYrjZJso+pl1IJE98YS8gtId5mNfC967n55J01xP
un+tuu7BCb+xVU981NDvpdnc92YGgfwjPKzsiunm3x+/WYdR2avNglMNtJy0Diar
RI5cwuvloEL4ENgRFVBV9oQQLBhwCYZXus8L5F13GOxC8j4dm4jwkl7bIk0GqYKk
lHolp6xxgkNkpT2F6mRuXmgku/Mh6vXK/Pk8imJ6+ubq6PMz/qE=
=V4GJ
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--


