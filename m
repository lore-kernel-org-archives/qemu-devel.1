Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AEEC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 18:11:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D59C920661
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 18:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hJgt2XQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59C920661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icCeH-0007uV-31
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 13:11:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icBa6-0008EO-9q
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:03:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icBZt-0004Im-Hy
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 12:03:11 -0500
Received: from mail-eopbgr60116.outbound.protection.outlook.com
 ([40.107.6.116]:38662 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icBZr-0003ty-Pe; Tue, 03 Dec 2019 12:03:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgaxa85AT/86xZAcCsGlrAJdmS6gtPGJ8y+/7Kwv7KGOgO8ogI5w+W2vHTvhEfKxv7DEHnBUE9ZZy5zTgtgecJQziSH4K/X3k76+Goa2QPqYup1q8aybSu3i9jcCp5O2ZIlZIji8Tt2pSOqu44annS4BRVVzSDBeJBRHENGGW3gSrwHjC7xqWViAJbjHQwTCbde4hihxIGxtp/eFJ94UOd6pxFe5tCz59a4Ylb4WtXZHdHbVLPYeSbmE2dfOLirf8vxqs8V9pv0g02AmepbJ2gEWZDMrsSlrb3Vf683EeuC2uQgYXeq9iS9N95uOHbiXVzv2Aw716J5yig2AHpRK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LazU0iaXw5zBKzwK2w1ehNom7IySwn6IiVrrsLw3yI=;
 b=aad2pbtaub7ApYr1fwCWW6aGLgBF+JH8adC84ZeG9SuOkkX/Hq7Wz6ij9N2cq54wrHkWqd0OTNJnynVzz3K2mWPCD5/2Y4Bvvlmkr3Fk+72ss9/b2D7Q4foM0jBf56CEijFAJGnVolSSB4cx8bFiAluJCIDPHfb2vaJof1Be0jU3ipKnXKAHnfHtM+FemB598kwbI6RCVtYaUytzeMlFBW7tQebhi/lE3xTutL63zNM+uplCIZuNvOwvybvmwXEG6DZvwZeyl2ovzk47PBumVRsoPRnOpPx0WSFwCJYOcvncDCsAdaLT6L6Wr1WyEQdz5ElveOXfgEIl4pqBG5B9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LazU0iaXw5zBKzwK2w1ehNom7IySwn6IiVrrsLw3yI=;
 b=hJgt2XQm2yylCxkgoahN0C+zD9Q4ZsVBf4a06y7pBZIm6X+yz2ImP906HmiRVIOO+Jy1nI3HSeYv/YrPkhooqlaAjg6w5xaHGpizzmwFd8dj+8ZpLhPUHkhGuzR0z6gVZSL7tTgQPefmlccepu43Bxt+dR7MFK2GCRjOOrltrpo=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB4214.eurprd08.prod.outlook.com (20.178.91.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Tue, 3 Dec 2019 17:03:03 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 17:03:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH for-5.0 v2 23/23] iotests: Mirror must not attempt to
 create loops
Thread-Topic: [PATCH for-5.0 v2 23/23] iotests: Mirror must not attempt to
 create loops
Thread-Index: AQHVmKmTAXGMHbLuAEi2qLzV429TFqeoxbaA
Date: Tue, 3 Dec 2019 17:03:02 +0000
Message-ID: <9b6585e2-031a-ded9-1de2-cb697b8261d3@virtuozzo.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-24-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-24-mreitz@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::36)
 To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191203200301054
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94285b69-0e41-4d92-f867-08d77812a873
x-ms-traffictypediagnostic: AM6PR08MB4214:
x-microsoft-antispam-prvs: <AM6PR08MB42145F408493148BB5CA6C3DC1420@AM6PR08MB4214.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(39840400004)(376002)(136003)(346002)(366004)(189003)(199004)(66476007)(2616005)(81166006)(36756003)(478600001)(14454004)(229853002)(11346002)(81156014)(31686004)(26005)(54906003)(110136005)(66946007)(3846002)(8936002)(31696002)(6116002)(446003)(6486002)(8676002)(66446008)(64756008)(2906002)(5660300002)(66556008)(5024004)(102836004)(186003)(6436002)(4326008)(386003)(25786009)(6506007)(14444005)(256004)(2501003)(71190400001)(99286004)(71200400001)(76176011)(316002)(305945005)(6512007)(86362001)(6246003)(52116002)(7736002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB4214;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1vfQ/2EkTXFvCIM9Jy/Jo72i5RnZgDDa9XkV1FXhB1Y6jHXU3nYFeUDZ3R/ljVNjGP5pmPuMOd9IDv+UcKStO/VS1KFhbxBsHNdL/2i6bJ31L84ETDCzpJYP34Boaysrff4o4XXLlDCo41EI8kLJImRwPPRSMxr7hzafhQemyc8ifK7cjjgm3evfOd7dVSs/5O+1MO04OwR2k1bZrcgSiYvM8LzaJifPnXswhwLrSbXH+N//Z/Y2rMN1Z37c3MeUHEacK1AmABEgHyDOTShsdm+yw0U4OX49zkqdnNq/VzgAbX1QUDxt8wmy8LFPZqvYT2Sl2fjXVWSAoQTMGBEhiCcSN4owPvOfJJFvNkbZxy9fWSyp8DMhkBj2l+wQYMBI+L239M8QWdcLFxdx2IpVzBtbQujPJ2P5u8NWf6M2YIqSMPQDaxQx+8aK37FyC15R
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <1D6CC1576F93CE4D82AFBCB6C2FF4F68@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94285b69-0e41-4d92-f867-08d77812a873
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 17:03:02.8840 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: upSq1FJdBec78p6H52BSexeKFEEeX9RYyQ9deTuWB++JLm5dYPR3alNqG7XDJj+M1UrEfnVyY4zmb/U0n58G8x8z3piS8gWNNgowz0dre0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4214
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.116
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

11.11.2019 19:02, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/041     | 235 +++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/041.out |   4 +-
>   2 files changed, 237 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> index 9a00cf6f7b..0e43bb699d 100755
> --- a/tests/qemu-iotests/041
> +++ b/tests/qemu-iotests/041
> @@ -1246,6 +1246,241 @@ class TestReplaces(iotests.QMPTestCase):
>  =20
>           self.vm.assert_block_path('filter0', '/file', 'target')
>  =20
> +    """
> +    See what happens when the @sync/@replaces configuration dictates
> +    creating a loop.
> +    """
> +    @iotests.skip_if_unsupported(['throttle'])
> +    def test_loop(self):
> +        qemu_img('create', '-f', iotests.imgfmt, test_img, str(1 * 1024 =
* 1024))
> +
> +        # Dummy group so we can create a NOP filter
> +        result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group'=
, id=3D'tg0')
> +        self.assert_qmp(result, 'return', {})
> +
> +        result =3D self.vm.qmp('blockdev-add', **{
> +                                 'driver': 'throttle',
> +                                 'node-name': 'source',
> +                                 'throttle-group': 'tg0',
> +                                 'file': {
> +                                     'driver': iotests.imgfmt,
> +                                     'node-name': 'filtered',
> +                                     'file': {
> +                                         'driver': 'file',
> +                                         'filename': test_img
> +                                     }
> +                                 }
> +                             })
> +        self.assert_qmp(result, 'return', {})
> +
> +        # Block graph is now:
> +        #   source[throttle] --file--> filtered[imgfmt] --file--> ...
> +
> +        result =3D self.vm.qmp('drive-mirror', job_id=3D'mirror', device=
=3D'source',
> +                             target=3Dtarget_img, format=3Diotests.imgfm=
t,
> +                             node_name=3D'target', sync=3D'none',
> +                             replaces=3D'filtered')
> +
> +        """
> +        Block graph before mirror exits would be (ignoring mirror_top):
> +          source[throttle] --file--> filtered[imgfmt] --file--> ...
> +          target[imgfmt] --file--> ...
> +
> +        Then, because of sync=3Dnone and drive-mirror in absolute-paths =
mode,
> +        the source is attached to the target:
> +          source[throttle] --file--> filtered[imgfmt] --file--> ...
> +                 ^
> +              backing
> +                 |
> +            target[imgfmt] --file--> ...
> +
> +        Replacing filtered by target would yield:
> +          source[throttle] --file--> target[imgfmt] --file--> ...
> +                 ^                        |
> +                 +------- backing --------+
> +
> +        I.e., a loop.  bdrv_replace_node() detects this and simply
> +        does not let source's file link point to target.  However,
> +        that means that target cannot really replace source.
> +
> +        drive-mirror should detect this and not allow this case.
> +        """
> +
> +        self.assert_qmp(result, 'error/desc',
> +                        "Replacing 'filtered' by 'target' with this sync=
 " + \
> +                        "mode would result in a loop, because the former=
 " + \
> +                        "would be a child of the latter's backing file "=
 + \
> +                        "('source') after the mirror job")
> +
> +    """
> +    Test what happens when there would be no loop with the pre-mirror
> +    configuration, but something changes during the mirror job that asks
> +    for a loop to be created during completion.
> +    """
> +    @iotests.skip_if_unsupported(['copy-on-read', 'quorum'])
> +    def test_loop_during_mirror(self):
> +        qemu_img('create', '-f', iotests.imgfmt, test_img, str(1 * 1024 =
* 1024))
> +
> +        """
> +        In this test, we are going to mirror from a node that is a
> +        filter above some file "common-base".  The target is a quorum
> +        node (with just an unrelated null-co child).
> +
> +        We will ask the mirror job to replace common-base by the
> +        target upon completion.  That is a completely valid
> +        configuration so far.
> +
> +        However, while the job is running, we add common-base as an
> +        (indirect[1]) child to the target quorum node.  This way,
> +        completing the job as requested would yield a loop, because
> +        the target would be supposed to replace common-base -- which
> +        is its own (indirect) child.
> +
> +        [1] It needs to be an indirect child, because if it were a
> +        direct child, the mirror job would simply end by effectively
> +        injecting the target above common-base.  This is the same
> +        effect as when using sync=3Dnone: The target ends up above the
> +        source.
> +
> +        So only loops that have a length of more than one node are
> +        forbidden, which means common-base must be an indirect child
> +        of the target.
> +
> +        (Furthermore, we are going to use x-blockdev-change to add
> +        common-base as a child to the target.  This command only
> +        allows doing so for nodes that have no parent yet.
> +        common-base will have a parent already, though, namely the
> +        source node.  Therefore, this is another reason why we need at
> +        least one node above common-base, so this parent can become
> +        target's child during the mirror.)
> +        """
> +
> +        result =3D self.vm.qmp('blockdev-add', **{
> +                                 'driver': 'null-co',
> +                                 'node-name': 'common-base',
> +                                 'read-zeroes': True,
> +                                 'size': 1 * 1024 * 1024
> +                             })
> +        self.assert_qmp(result, 'return', {})
> +
> +        result =3D self.vm.qmp('blockdev-add', **{
> +                                 'driver': 'copy-on-read',
> +                                 'node-name': 'source',
> +                                 'file': 'common-base'
> +                             })
> +        self.assert_qmp(result, 'return', {})
> +
> +        """
> +        As explained above, we have to create a parent above
> +        common-base.
> +
> +        We cannot use any parent that would forward the RESIZE
> +        permission, because the job takes it on the target, but
> +        unshares it on the source: After the x-blockdev-change
> +        operation during the mirror job, this parent will be a child
> +        of the target, so common-base will be an (indirect) child of
> +        both the mirror's source and target.  Thus, the job would
> +        conflict with itself.
> +
> +        Therefore, we make common-base a backing child of a $imgfmt
> +        node.  Unfortunately, we cannot let the mirror job replace a
> +        node that acts as a backing child somewhere (because of an op
> +        blocker), so we put another raw node between the $imgfmt node
> +        and common-base.
> +        """
> +        result =3D self.vm.qmp('blockdev-add', **{
> +                                 'driver': iotests.imgfmt,
> +                                 'node-name': 'base-parent',
> +                                 'file': {
> +                                     'driver': 'file',
> +                                     'filename': test_img
> +                                 },
> +                                 'backing': {
> +                                     'driver': 'raw',
> +                                     'file': 'common-base'
> +                                 }
> +                             })

self.assert_qmp(result, 'return', {})

> +
> +        """
> +        Add a quorum node with a single child, we will add base-parent
> +        to prepare a loop later.
> +        (We do not care about this single child at all, but it is
> +        impossible to create a quorum node without any children.  We
> +        will ignore this child from now on.)
> +        """
> +        result =3D self.vm.qmp('blockdev-add', **{
> +                                 'driver': 'quorum',
> +                                 'node-name': 'target',
> +                                 'vote-threshold': 1,
> +                                 'children': [
> +                                     {
> +                                         'driver': 'null-co',
> +                                         'read-zeroes': True,
> +                                         'size': 1 * 1024 * 1024
> +                                     }
> +                                 ]
> +                             })
> +        self.assert_qmp(result, 'return', {})
> +
> +        """
> +        Current block graph:
> +
> +        base-parent[$imgfmt] --backing--> [raw]
> +                                            |
> +                                           file
> +                                            v
> +              source[COR] --file--> common-base[null-co]
> +
> +        target[quorum]
> +
> +
> +        The following blockdev-mirror asks for this graph post-mirror:
> +
> +        base-parent[$imgfmt] --backing--> [raw]
> +                                            |
> +                                           file
> +                                            v
> +                source[COR] --file--> target[quorum]
> +
> +        That would be a valid configuration without any loops.
> +        """
> +
> +        result =3D self.vm.qmp('blockdev-mirror', job_id=3D'mirror',
> +                             device=3D'source', target=3D'target', sync=
=3D'full',
> +                             replaces=3D'common-base')
> +        self.assert_qmp(result, 'return', {})
> +
> +        """
> +        However, now we will make base-parent a child of target.
> +        Before the mirror job completes, that is still completely
> +        valid:
> +
> +                                             source
> +                                               |
> +                                               v
> +        target -> base-parent -> [raw] -> common-base
> +        """
> +
> +        result =3D self.vm.qmp('x-blockdev-change',
> +                             parent=3D'target', node=3D'base-parent')
> +        self.assert_qmp(result, 'return', {})
> +
> +        """
> +        However, post-mirror, we thus ask for a loop:
> +
> +        source -> target (replaced common-base) -> base-parent
> +                                  ^                    |
> +                                  |                    v
> +                                  +----------------- [raw]
> +
> +        bdrv_replace_node() would not allow such a configuration, but
> +        we should not pretend we can create it, so the mirror job
> +        should fail during completion.
> +        """
> +
> +        self.complete_and_wait('mirror',
> +                               completion_error=3D'Operation not permitt=
ed')

Thanks for exhaustive comments!

> +
>   if __name__ =3D=3D '__main__':
>       iotests.main(supported_fmts=3D['qcow2', 'qed'],
>                    supported_protocols=3D['file'])
> diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
> index 877b76fd31..20a8158b99 100644
> --- a/tests/qemu-iotests/041.out
> +++ b/tests/qemu-iotests/041.out
> @@ -1,5 +1,5 @@
> -........................................................................=
......................
> +........................................................................=
........................
>   ----------------------------------------------------------------------
> -Ran 94 tests
> +Ran 96 tests
>  =20
>   OK
>=20


With forgotten assertion added:

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

--=20
Best regards,
Vladimir

