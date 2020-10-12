Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ABAC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 03:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7CE620757
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 03:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="baq17tS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CE620757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRoNI-00067v-0B
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 23:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kRoMg-0005hI-KB
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 23:19:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44728)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kRoMf-0004de-1N
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 23:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602472747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+DPrTkddoQaqU7KkoAdMv+HKMJHq05htLrPnYzchEeY=;
 b=baq17tS5hiA7gr0R57yNljgXo9Q96TK3dNt1i1OXwU15b5D58JAzDLINVsGg0bfUrMlryJ
 faiIVeUXOLYFlGj2tpkKkahgCnw0OwvD1nmFpkF5xNznUeidToE5HfEV0/zM4P55mOs5jZ
 M+CZFlulxlD2P8xQzPGY3nwksjvJ+5I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-ypTEaFK9N-SAJ3uetnZhFA-1; Sun, 11 Oct 2020 23:19:05 -0400
X-MC-Unique: ypTEaFK9N-SAJ3uetnZhFA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8E191868400
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 03:19:04 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53B627D4E3;
 Mon, 12 Oct 2020 03:19:01 +0000 (UTC)
Date: Sun, 11 Oct 2020 23:18:59 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] tests/acceptance: Test case for detecting -object
 crashes
Message-ID: <20201012031859.GC887538@localhost.localdomain>
References: <20201009202905.1845802-1-ehabkost@redhat.com>
 <8daa726a-a359-c533-acb0-e3294b4c8aa7@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8daa726a-a359-c533-acb0-e3294b4c8aa7@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 21:16:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2020 at 09:54:16AM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 10/9/20 10:29 PM, Eduardo Habkost wrote:
> > Add a simple test case that will run QEMU directly (without QMP)
> > just to check for crashes when using `-object`.
> >=20
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > Changes v1 -> v2:
> > * "Running command:" log message instead of "Command:" (Cleber)
> > * Use universal_newlines=3DTrue instead of encoding=3D'utf-8' (Cleber)
> > * Rename devices() to get_devices() (Cleber)
> > * Use @avocado.fail_on(subprocess.CalledProcessError) (Cleber)
> > * Reword test_crash() docstring (Cleber)
> > * Reorder imports
>=20
> Assuming:
> Based-on: <20201008202713.1416823-1-ehabkost@redhat.com>
>=20
> I get:
>=20
>  (1/2) tests/acceptance/object_option.py:ObjectOption.test_help:
> qemu-system-avr: No machine specified, and there is no default
> Use -machine help to list supported machines
> FAIL: CalledProcessError(1, ['./qemu-system-avr', '-object', 'help']) (0.=
19
> s)
>  (2/2) tests/acceptance/object_option.py:ObjectOption.test_crash:
> qemu-system-avr: No machine specified, and there is no default
> Use -machine help to list supported machines
> FAIL: CalledProcessError(1, ['./qemu-system-avr', '-object', 'help']) (0.=
18
> s)
>

Did you influence (test parameter?) the QEMU binary to be used?

Thanks,
- Cleber.

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+DyyMACgkQZX6NM6Xy
CfOrRw//dqpFKyItBOZwsEj9a5GyJUjqiujng9MRWEFr1fGDG1IvAjmdgoR1Ydpo
1MRySTdEQ9wLAK9UCBQEaTV94CoTM2E5C/+XLKTLjYj+HD89b/IM4CgEahrfV3tx
fIT4iBmzj5gOiDAfhHrkqww9gdMJz9C7VJZ1if69y19UXsRUKq7DYIDwU2uAjoO1
2errrjJz9LgFyE3i5rwmbV6vcyRp2JYeIyHSsMKEOHkMiHHJYE7fKWZgsBRCOUSs
RZiFvMQigXOLu8ieKwjHFyJtUbPf4O0ESrouoMPDRnYSUaqIDaDI0NzA/h5MmmfI
/JfPmDYYp9nabxrQnhJLwtcYsbLnGyuGlAk5mVXh58xNlSdUglZiSZcaV3UQdYXx
FCNRJPKxMzvV2xlkwPCJn4vZUtEjPijs4lrr2HwZFYm8uMvMJwYt76rivuRpilIP
lT8N6GYbKuo98nDF46EDJaAlMlhtLI0MF3XU41QOU/FxdtkHlHUqfuKJDPmcb1KS
lURv1xWdc8FSlZRUBpUkMzHcfFqJr+8HQ78GgZ2U2mXuMpRgqM8anePh+MML8Z5y
RKD/TlGS+58OIR1jTXqpui5uZhxQxcmv+bx8S4bxmEkGA5ww2o32cxmTMgw7zXsV
Q3FS1JbiSfqirYZZdzH89RIiiH4rOqG+FbgdDRxS7Cb/0O83WoY=
=suhd
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--


