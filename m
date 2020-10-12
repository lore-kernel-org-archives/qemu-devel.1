Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F889C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 21:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5572076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 21:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3t1ZL9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5572076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS5EZ-0002JF-1V
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 17:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kS5Dl-0001KE-OR
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 17:19:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kS5Di-00081Y-J0
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 17:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602537540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+D1RiTKEbmIYvN/ut92k4RWYEoKo791iBBCM7QzTxJE=;
 b=M3t1ZL9bjArEEexidcJogHrulef1V/PCeStTlPWsyO74gn3RmiR0IsVDcFXVo/5NjJAwc+
 9hCdMMG1GLGYntqROPjqaGu2ihKBAn3/n/GyHtJfGTX++j5AGqFqM2Y5LzG8eSz/1jcQzo
 lJu/XODolcCAarQY+Kdzq6PxFUxBFi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-g00OBAC8MOGrp9SOOaxNQw-1; Mon, 12 Oct 2020 17:18:55 -0400
X-MC-Unique: g00OBAC8MOGrp9SOOaxNQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88872CE2F2;
 Mon, 12 Oct 2020 21:18:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B7B6D5D98A;
 Mon, 12 Oct 2020 21:18:50 +0000 (UTC)
Date: Mon, 12 Oct 2020 17:18:49 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH 3/3] Acceptance tests: show test report on GitLab CI
Message-ID: <20201012211849.GA960048@localhost.localdomain>
References: <20201009205513.751968-1-crosa@redhat.com>
 <20201009205513.751968-4-crosa@redhat.com>
 <d5ffb1b7-5516-ffdf-a78e-91a8cda7fac7@redhat.com>
 <87tuuzzj3x.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87tuuzzj3x.fsf@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 16:33:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2020 at 02:09:22PM +0100, Alex Benn=E9e wrote:
>=20
> Philippe Mathieu-Daud=E9 <philmd@redhat.com> writes:
>=20
> > On 10/9/20 10:55 PM, Cleber Rosa wrote:
> >> Avocado will, by default, produce JUnit files.  Let's ask GitLab
> >> to present those in the web UI.
> >
> > https://gitlab.com/philmd/qemu/-/pipelines/200764992/test_report
> >
> > Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>=20
> That's awesome - I wonder if the tap reports can also be read?
>

Not according to:

   https://docs.gitlab.com/ee/ci/pipelines/job_artifacts.html#artifactsrepo=
rts

But, I'm working on further integrating Avocado to other types of
tests in QEMU, so users can choose to run test jobs with any
combination of test types.

A very rough PoC with some unit tests (that generate TAP) being run
by Avocado, and the JUnit report being displayed, can be seen here:

   https://gitlab.com/cleber.gnu/qemu/-/pipelines/201609047/test_report

The grand vision is, among other things, to be able run tests related
to a given subsystem or feature, say "migration", no matter what type
of tests they are.

Cheers,
- Cleber.

> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
>=20
> --=20
> Alex Benn=E9e
>=20

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+EyDYACgkQZX6NM6Xy
CfPghQ//Uaf3LrdM99O4IapgzP5sJXhECf8vDRuP3SIVdmhIv8j+7L1sFkmxfYq/
zW8gbHLWc7icdPLWFe4Yzhj5jfndA9ArhACfF/tXLdEQ6mKcwxobPaKBxCo2bU/o
+q25Td20FJgc4c4VPsbDyZww5SxtsTABfme1qU1EKj7blyz7Ecl7XmPlcahFwXVG
1dvgyAe+orBg1fSUD2fohkeC9Ge/kuv931iksmq1kOnlEJX4XIrwtdnYAVyLz8dw
Y52mL5zIGTWZ3SmLl0KbCtV1VJvLUk7awMPsTCs64QnwBYTACdq67WU0tc7PvDvI
EPLhohLoKaFmd4SH5tHJvnDce33spQazEQuuR83g8QTOGTUsFRF8zFx5CwfFhMOu
jdTTgCt4vVFuVUMevSHoEI6ifIPWrmnL1MHagZ7ACdPty9yx8p8d+P4tlEKIrh6G
FXGHHKi3WVlSpQ5yzmDXdKLNlmXYs8+Vai8TDGaFD72biWH9kbYPh1z7t41YPeJi
gunyqX4m66aJ4ur6zLy9cPQG3Ae6WJm1xOirqwOUqjXcD0Xpx6EecqBM86x4BfAn
5b3oVwmyBRHyDQdKfgsG7T2f46xHVRSW9WV0pauJ+4Wph3UoA5UUs+rISC6UiNS+
2n/YGoatYmcTCB+LEZT+fgfQCqV91pbPLkULm3FMxfIDZvKFTJw=
=qlfJ
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--


