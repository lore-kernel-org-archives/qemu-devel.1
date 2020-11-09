Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E56C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:18:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B93520684
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 10:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuB93xWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B93520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc4Fl-0003uv-HW
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 05:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kc4F3-000357-0q
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 05:17:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kc4Ez-0005mL-SA
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 05:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604917057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LdZLCn8RAXvjiI16aCakvWUH/XK43pWrEL44H/VYv7Q=;
 b=UuB93xWvnbqfU+lkGEtj8Subih+SSsE+B37LtqWjThblQnEYw2f8wbaTtz0wrWu0JBtgXX
 kAE0yaayCBdpAa717w9MpPaWI4eC7aCHEpfaM45ARmAFKnKK2zvA8kBWcN7pga5aQD5v94
 aHSZfkacBP801kZr9htXNpAwowYaHho=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-l6LJ7ppVODSmm-UNyjXDOg-1; Mon, 09 Nov 2020 05:17:32 -0500
X-MC-Unique: l6LJ7ppVODSmm-UNyjXDOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AE961009E2C;
 Mon,  9 Nov 2020 10:17:31 +0000 (UTC)
Received: from localhost (ovpn-114-110.ams2.redhat.com [10.36.114.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF2C460DA0;
 Mon,  9 Nov 2020 10:17:30 +0000 (UTC)
Date: Mon, 9 Nov 2020 10:17:29 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Harshavardhan Unnibhavi <harshavardhan.unnibhavi@gmail.com>
Subject: Re: Qemu first time contribution
Message-ID: <20201109101729.GD783516@stefanha-x1.localdomain>
References: <CA+8xkr4ABLeYam6EPBdMKkX=HB3gik079zxUyo1TF91sCXmoQg@mail.gmail.com>
 <e84575ae-4eee-ca5a-e4ca-9b1660a8799d@redhat.com>
 <CA+8xkr4t4s8=dCp6MjcH59y_6KPO0a7-pNi0-A-8Ft14kP6F2Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CA+8xkr4t4s8=dCp6MjcH59y_6KPO0a7-pNi0-A-8Ft14kP6F2Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J5MfuwkIyy7RmF4Q"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 08, 2020 at 12:21:33PM +0000, Harshavardhan Unnibhavi wrote:
> Thank you for the reply! Yes, I understand that gsoc is over for 2020,
> and projects for 2021 will come up next year. I was thinking of
> contributing outside of gsoc(for which I won't be eligible anyways for
> next year). Anyway, I will work on some of the bite sized tasks, and
> get back to you for some other concrete project ideas that require
> somebody to work on, in qemu.

Hi Harsha,
Here is an idea you could explore:

The Linux AIO API was extended to support fsync(2)/fdatasync(2) in the
following commit from 2018:

  commit a3c0d439e4d92411c2b4b21a526a4de720d0806b
  Author: Christoph Hellwig <hch@lst.de>
  Date:   Tue Mar 27 19:18:57 2018 +0200

      aio: implement IOCB_CMD_FSYNC and IOCB_CMD_FDSYNC

QEMU's Linux AIO code does not take advantage of this feature yet.
Instead it invokes the traditional fdatasync(2) system call from a
thread pool because it assumes the Linux AIO API doesn't support the
operation. The function where this happens is
block/file-posix.c:raw_co_flush_to_disk().

The goal is to implement IO_CMD_FDSYNC support in block/linux-aio.c
using io_prep_fdsync() and update
block/file-posix.c:raw_co_flush_to_disk() to use this when the feature
is available. See <libaio.h> for the Linux AIO library API.

Keep in mind that old host kernels may not support IO_CMD_FDSYNC. In
that case QEMU should continue to use the thread pool.

Taking advantage of the Linux AIO API means QEMU will spawn fewer
worker threads and disk flush performance may improve. You can benchmark
performance using the fio(1) tool. Configure it with ioengine=pvsync2
rw=randwrite direct=1 fdatasync=1 bs=4k to measure the peformance of 4
KB writes followed by fdatasync. For more information about disk I/O
benchmarking, including example fio jobs, see:
https://blog.vmsplice.net/2017/11/common-disk-benchmarking-mistakes.html

Stefan

--J5MfuwkIyy7RmF4Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+pFzkACgkQnKSrs4Gr
c8i7aQf+PHT604AimvnlaKSOrbj9pbl+0nrNQIqm8RW50NdfeEGDjRD/YGttadKe
mRr51bsqyk8W9XGDna8xwk1RmVmw1jWN2fxjss9EX3T4pSL7jM93DwBn1o2TaRRq
DtUde0piL5aJwb60vJtNiBqUli0zmW+49t3pupVRZLTfUAgrOgfLP0xasTokRorP
K6vmggfaen3vuZcJ0JqqP+qcyH6t7Ei5MVxknEybQx8OKeOf2bIrdZd3pL763t2M
ippVXmuwlPBNYtbfzQ/qURdtMoTUgJ+jgbPJ6tSV+OBDkDwQemp1QkWlseg5E+7T
gokXtDfYv9smdPblcPcqbElWVdJYzA==
=taNh
-----END PGP SIGNATURE-----

--J5MfuwkIyy7RmF4Q--


