Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8558C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 15:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E352084E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 15:06:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E352084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38400 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQvUY-0007ee-W9
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 11:06:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hQvM9-0002A5-UC
	for qemu-devel@nongnu.org; Wed, 15 May 2019 10:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hQvM8-0003HE-O0
	for qemu-devel@nongnu.org; Wed, 15 May 2019 10:58:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hQvL2-0001yF-F6; Wed, 15 May 2019 10:57:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B14289C36;
	Wed, 15 May 2019 14:56:32 +0000 (UTC)
Received: from localhost (ovpn-117-238.ams2.redhat.com [10.36.117.238])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8AD7A60BE5;
	Wed, 15 May 2019 14:56:31 +0000 (UTC)
Date: Wed, 15 May 2019 15:56:30 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190515145630.GH29507@stefanha-x1.localdomain>
References: <68cc5bbc-ed6f-e001-e376-ccd986683b88@redhat.com>
	<f1dfe2c3-2d61-e477-ac3d-37ad26d9236d@redhat.com>
	<61685a48-b84e-c379-7193-f456e82635ba@redhat.com>
	<67a38513-89af-7f54-2fc8-05b5777983ca@redhat.com>
	<22933e94-18da-257c-7931-da511bc5a602@redhat.com>
	<20f1aecc-02b4-781c-9ada-7ac6c73892a3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2oox5VnwalALFvA7"
Content-Disposition: inline
In-Reply-To: <20f1aecc-02b4-781c-9ada-7ac6c73892a3@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 15 May 2019 14:56:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Failing QEMU iotest 175
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Qemu-block <qemu-block@nongnu.org>, Nir Soffer <nirsof@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2oox5VnwalALFvA7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2019 at 12:44:56PM -0500, Eric Blake wrote:
> On 5/4/19 1:51 AM, Thomas Huth wrote:
>=20
> >> Hmm, it's passing for me on ext4, but that probably means we have
> >> different configuration parameters. I'm not sure how to easily show wh=
at
> >> parameters a particular ext4 partition uses to compare the differences
> >> between your setup and mine (mine is tuned to whatever defaults Fedora=
's
> >> installer chose on my behalf), so maybe someone else can chime in.
> >=20
> > $ sudo tune2fs -l /dev/mapper/Home
> > tune2fs 1.42.9 (28-Dec-2013)
> > Filesystem volume name:   <none>
> > Last mounted on:          /home
> > Filesystem magic number:  0xEF53
> > Filesystem revision #:    1 (dynamic)
> > Filesystem features:      has_journal ext_attr dir_index filetype
> > needs_recovery meta_bg extent 64bit flex_bg sparse_super large_file
> > huge_file uninit_bg dir_nlink extra_isize
> > Filesystem flags:         signed_directory_hash
> > Default mount options:    user_xattr acl
> > Filesystem state:         clean
> > Errors behavior:          Continue
> > Filesystem OS type:       Linux
> > Inode count:              36700160
> > Block count:              146800640
> > Reserved block count:     5873663
> > Free blocks:              56266267
> > Free inodes:              35403275
> > First block:              1
> > Block size:               1024
> > Fragment size:            1024
> > Group descriptor size:    64
> > Blocks per group:         8192
> > Fragments per group:      8192
> > Inodes per group:         2048
> > Inode blocks per group:   256
> > First meta block group:   258
> > Flex block group size:    16
> > Filesystem created:       Thu Apr 19 18:34:33 2018
> > Last mount time:          Sat May  4 08:20:36 2019
> > Last write time:          Sat May  4 08:20:36 2019
> > Mount count:              224
> > Maximum mount count:      -1
> > Last checked:             Thu Apr 19 18:34:33 2018
> > Check interval:           0 (<none>)
> > Lifetime writes:          1826 GB
> > Reserved blocks uid:      0 (user root)
> > Reserved blocks gid:      0 (group root)
> > First inode:              11
> > Inode size:	          128
> > Journal inode:            8
> > First orphan inode:       11076944
> > Default directory hash:   half_md4
> > Directory Hash Seed:      08e1be04-c3a3-4c37-a059-cf54af5c4bc0
> > Journal backup:           inode blocks
> >=20
>=20
> # tune2fs -l /dev/mapper/fedora-home
> tune2fs 1.44.6 (5-Mar-2019)
> Filesystem volume name:   home
> Last mounted on:          /home
> Filesystem UUID:          3ef45c0b-b2a0-43da-a1d3-c4f726097eda
> Filesystem magic number:  0xEF53
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      has_journal ext_attr resize_inode dir_index
> filetype needs_recovery extent 64bit flex_bg sparse_super large_file
> huge_file dir_nlink extra_isize metadata_csum
> Filesystem flags:         signed_directory_hash
> Default mount options:    user_xattr acl
> Filesystem state:         clean
> Errors behavior:          Continue
> Filesystem OS type:       Linux
> Inode count:              13107200
> Block count:              52428800
> Reserved block count:     2621440
> Free blocks:              27184765
> Free inodes:              12049129
> First block:              0
> Block size:               4096
> Fragment size:            4096
> Group descriptor size:    64
> Reserved GDT blocks:      1024
> Blocks per group:         32768
> Fragments per group:      32768
> Inodes per group:         8192
> Inode blocks per group:   512
> Flex block group size:    16
> Filesystem created:       Thu Dec  6 16:17:23 2018
> Last mount time:          Wed Apr  3 10:19:05 2019
> Last write time:          Wed Apr  3 10:19:05 2019
> Mount count:              12
> Maximum mount count:      -1
> Last checked:             Thu Dec  6 16:17:23 2018
> Check interval:           0 (<none>)
> Lifetime writes:          1962 GB
> Reserved blocks uid:      0 (user root)
> Reserved blocks gid:      0 (group root)
> First inode:              11
> Inode size:	          256
> Required extra isize:     32
> Desired extra isize:      32
> Journal inode:            8
> First orphan inode:       5248434
> Default directory hash:   half_md4
> Directory Hash Seed:      d1bbea0e-dd2e-4df7-b7f0-f7300c524cc9
> Journal backup:           inode blocks
> Checksum type:            crc32c
> Checksum:                 0x3a8a8676
>=20
> I'm definitely seeing some differences in the two configs (such as your
> block size of 1k vs. mine at 4k), but not sure which are the most
> important, nor how to easily recreate a setup that matches yours.

Yes, previously when we had similar issues it was the block size that
caused the difference.  It's worth trying it out with a test file system
on a loop device.

Stefan

--2oox5VnwalALFvA7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzcKJ4ACgkQnKSrs4Gr
c8jrPgf7B7lu3T8LfS6j/jA7v2GQvriP3wIvYBjRYl8whQSwWxVNQCQAvb8aVLW3
PD9RjHoDDlInROaURUVsk3qgEN34CgH0VKJQ2nDfb/WWN6KNOwDUEVBA1Qwnr/x2
4cZ4D2SRvUFmcBZgw9w4CqfRlvk6CNoMihGksweLaXWGGt682GOE8tVw+RgTdbDc
vlcE1rcIDrWamvXOrlnC8Wv0Dwx76f28LfuJYF+XspkcAKf2dh+FC1tkclXD9iTm
aTQT3cmYXNS9LuYrPEZKAdauPo848BEhVVj20hqtSQhhB7jdKTRhyNmjmW/chklx
+9oEbHpbnlfamLQlW8lBITwPvBByiQ==
=uccx
-----END PGP SIGNATURE-----

--2oox5VnwalALFvA7--

