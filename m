Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33350C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D2924672
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csSOsLJq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D2924672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihun3-0003fD-3l
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:20:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55845)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihumK-00032q-Nv
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:19:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihumJ-0001tE-D9
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:19:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41591
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihumJ-0001oj-60
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576757978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PQQe0muAQAI1B029e94qJtuv2Ls00eHJ+7skmaOWXF0=;
 b=csSOsLJqkN/dAictMg3QhXvpu75Mrw5EHmFljzNQ7frsbPTvdbgcdjLMWHhELNjq9OF/Av
 aFitnNku/CveKBSnYCSN9iC2b2H9lRGOFMz4X/8iSAGXe1OQtIWW2bM5A6faDlZreFfPYK
 K0X9nmRtQf3HQTTmxAijaV7bkZtNsu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-jnm0HGmsNS6jROB153rqDg-1; Thu, 19 Dec 2019 07:19:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05426800D41;
 Thu, 19 Dec 2019 12:19:34 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB01867E47;
 Thu, 19 Dec 2019 12:19:31 +0000 (UTC)
Date: Thu, 19 Dec 2019 13:19:28 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2] iotests: Add more "skip_if_unsupported" statements to
 the python tests
Message-ID: <20191219121928.GH5230@linux.fritz.box>
References: <20191218144349.19354-1-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191218144349.19354-1-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: jnm0HGmsNS6jROB153rqDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.12.2019 um 15:43 hat Thomas Huth geschrieben:
> The python code already contains a possibility to skip tests if the
> corresponding driver is not available in the qemu binary - use it
> in more spots to avoid that the tests are failing if the driver has
> been disabled.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Thanks to Max' "iotests: Allow skipping test cases" patch (see
>      commit 6be012252018249d3a), this patch has been greatly simplified
>      by only marking the setUp functions instead of all functions from
>      a class.

Ah, nice. I didn't know this worked on setup() functions.

> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
> index f3766f2a81..a585554c61 100755
> --- a/tests/qemu-iotests/030
> +++ b/tests/qemu-iotests/030
> @@ -530,6 +530,7 @@ class TestQuorum(iotests.QMPTestCase):
>      children =3D []
>      backing =3D []
> =20
> +    @iotests.skip_if_unsupported(['quorum'])
>      def setUp(self):
>          opts =3D ['driver=3Dquorum', 'vote-threshold=3D2']

test_stream_quorum(), which is the only test case in this class, already
contains a check:

    if not iotests.supports_quorum():
        return

We should probably remove this check because it's dead code now.

> diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
> index 762ad1ebcb..74f62c3c4a 100755
> --- a/tests/qemu-iotests/040
> +++ b/tests/qemu-iotests/040
> @@ -106,6 +106,7 @@ class TestSingleDrive(ImageCommitTestCase):
>          self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xab 0 =
524288', backing_img).find("verification failed"))
>          self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xef 52=
4288 524288', backing_img).find("verification failed"))
> =20
> +    @iotests.skip_if_unsupported(['throttle'])
>      def test_commit_with_filter_and_quit(self):
>          result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group'=
, id=3D'tg')
>          self.assert_qmp(result, 'return', {})
> @@ -125,6 +126,7 @@ class TestSingleDrive(ImageCommitTestCase):
>          self.has_quit =3D True
> =20
>      # Same as above, but this time we add the filter after starting the =
job
> +    @iotests.skip_if_unsupported(['throttle'])
>      def test_commit_plus_filter_and_quit(self):
>          result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group'=
, id=3D'tg')
>          self.assert_qmp(result, 'return', {})
> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> index 8568426311..ef95fba656 100755
> --- a/tests/qemu-iotests/041
> +++ b/tests/qemu-iotests/041
> @@ -871,6 +871,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
>      image_len =3D 1 * 1024 * 1024 # MB
>      IMAGES =3D [ quorum_img1, quorum_img2, quorum_img3 ]
> =20
> +    @iotests.skip_if_unsupported(['quorum'])
>      def setUp(self):
>          self.vm =3D iotests.VM()

This is the same case as above, all test functions already have checks
that are dead code now.

> diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
> index e66a23c5f0..36d7ca6ded 100644
> --- a/tests/qemu-iotests/245
> +++ b/tests/qemu-iotests/245
> @@ -478,6 +478,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
>      # This test verifies that we can't change the children of a block
>      # device during a reopen operation in a way that would create
>      # cycles in the node graph
> +    @iotests.skip_if_unsupported(['blkverify'])
>      def test_graph_cycles(self):
>          opts =3D []
> =20
> @@ -534,6 +535,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
>          self.assert_qmp(result, 'return', {})
> =20
>      # Misc reopen tests with different block drivers
> +    @iotests.skip_if_unsupported(['quorum'])
>      def test_misc_drivers(self):
>          ####################
>          ###### quorum ######

This test case uses more than just quorum: blkdebug, null-co, throttle.
I think we assume that blkdebug and null-co are always available, but
you added tests for throttle in 040.

Maybe the test should actually be split into multiple parts so that if
one driver is missing, not all of them are skipped.

Kevin


