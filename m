Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8ECC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:04:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612C922305
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612C922305
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQIe-0006lj-GB
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 14:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33768)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hvQI5-00061T-VW
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hvQI4-0006wa-VK
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:04:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hvQI4-0006u3-Pn
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:04:00 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E8668316D8C3;
 Wed,  7 Aug 2019 18:03:59 +0000 (UTC)
Received: from localhost (ovpn-116-50.ams2.redhat.com [10.36.116.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB21310016E8;
 Wed,  7 Aug 2019 18:03:55 +0000 (UTC)
Date: Wed, 7 Aug 2019 19:03:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: virtio-fs@redhat.com, qemu-devel@nongnu.org
Message-ID: <20190807180355.GA22758@stefanha-x1.localdomain>
References: <20190801165409.20121-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20190801165409.20121-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 07 Aug 2019 18:04:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/4] virtiofsd: multithreading preparation
 part 3
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
Cc: Liu Bo <bo.liu@linux.alibaba.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2019 at 05:54:05PM +0100, Stefan Hajnoczi wrote:
> Performance
> -----------
> Please try these patches out and share your results.

Here are the performance numbers:

  Threadpool | iodepth | iodepth
     size    |    1    |   64
  -----------+---------+--------
  None       |   4451  |  4876
  1          |   4360  |  4858
  64         |   4359  | 33,266

A graph is available here:
https://vmsplice.net/~stefan/virtiofsd-threadpool-performance.png

Summary:

 * iodepth=64 performance is increased by 6.8 times.
 * iodepth=1 performance degrades by 2%.
 * DAX is bottlenecked by QEMU's single-threaded
   VHOST_USER_SLAVE_FS_MAP/UNMAP handler.

Threadpool size "none" is virtiofsd commit 813a824b707 ("virtiofsd: use
fuse_lowlevel_is_virtio() in fuse_session_destroy()") without any of the
multithreading preparation patches.  I benchmarked this to check whether
the patches introduce a regression for iodepth=1.  They do, but it's
only around 2%.

I also ran with DAX but found there was not much difference between
iodepth=1 and iodepth=64.  This might be because the host mmap(2)
syscall becomes the bottleneck and a serialization point.  QEMU only
processes one VHOST_USER_SLAVE_FS_MAP/UNMAP at a time.  If we want to
accelerate DAX it may be necessary to parallelize mmap, assuming the
host kernel can do them in parallel on a single file.  This performance
optimization is future work and not directly related to this patch
series.

The following fio job was run with cache=none and no DAX:

  [global]
  runtime=60
  ramp_time=30
  filename=/var/tmp/fio.dat
  direct=1
  rw=randread
  bs=4k
  size=4G
  ioengine=libaio
  iodepth=1

  [read]

Guest configuration:
1 vCPU
4 GB RAM
Linux 5.1 (vivek-aug-06-2019)

Host configuration:
Intel(R) Core(TM) i7-5600U CPU @ 2.60GHz (2 cores x 2 threads)
8 GB RAM
Linux 5.1.20-300.fc30.x86_64
XFS + dm-thin + dm-crypt
Toshiba THNSFJ256GDNU (256 GB SATA SSD)

Stefan

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1LEmwACgkQnKSrs4Gr
c8gLjQf/UBAHjyJ/mHomkCbE3SaeaZIwfXNA9Zm278DVu9a2vAOhjZ1shtV5b21g
yDlesefwzFb9u/McYTwf1hbUiYweSy2bNqaRFb9ZsI4EWxqDJRirpTGlioWESzjy
kdQ3Gh9PRwgdgfXZMBUN01ut07dQKEDSTzlBISHkS5GT56to9NbzprHZh+bwy8NG
9UenaGzcvEwTxGxEjSekF/UkGwXVnsBOE4Do1MsBK5WJf+T919kUW5043yz1HUyB
7YfoTtKMo+cyUJaQcyGOOXCs2vhoAVqY/KUYM92RH31shnwbBZK5nAa9wVACGcu2
fslfzmFxRovmbI6U+QjZrfs+lgQGCg==
=swFN
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--

