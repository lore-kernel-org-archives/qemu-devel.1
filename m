Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F97C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 13:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9DFF2133D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 13:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RAvcoUiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DFF2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49152 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEZzO-0005CY-1f
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 09:43:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEZxX-0004Ma-1i
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hEZxW-0001dR-3T
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 09:41:42 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:40170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>)
	id 1hEZxV-0001cO-E5; Thu, 11 Apr 2019 09:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; 
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
	bh=rn4EdDI3YXllij23C3NWAb+LwEISd2TiDiT3U+arVI0=; 
	b=RAvcoUiMRO/RJ5xpbEYRJ5zscqC+umtpyvb0eKlSwmFX+TjcXySCOyxvheIsFktRWucbThRoFNepAcaDCwy8g35xyChLkDMmb7c2LX5TrCbi2wXRjNlSn2flr+1072/hYcGah8EpLpmTp4g8OqLashaa4UPTIUU2d8uhFlgY7TdXjStJbnmBuGCdd9GYQcHe/tO8+5bn+8t1eVKbw9Lf//m0OHJPiprSNIwzGMpgRwqjPO0raWDebZbN2cXPwvrb6JOh1xI/mdHCkA1EiKruBu72qmD63KRLN4DLpmb/n0HnMnYYccTRG9KFzgNs9YF2t1sGSHsuM6WFS2Nu5s7omw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine.igalia.com with esmtps 
	(Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
	id 1hEZxS-0003S9-VI; Thu, 11 Apr 2019 15:41:39 +0200
Received: from berto by mail.igalia.com with local (Exim)
	id 1hEZxS-0002Ei-Sf; Thu, 11 Apr 2019 15:41:38 +0200
From: Alberto Garcia <berto@igalia.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
In-Reply-To: <1df28c23-7efe-310d-2955-432b9a4bb1ad@redhat.com>
References: <cover.1551895813.git.berto@igalia.com>
	<e25b416f8646a476017f21a8484a05931b0e3f5a.1551895814.git.berto@igalia.com>
	<1df28c23-7efe-310d-2955-432b9a4bb1ad@redhat.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
	(i586-pc-linux-gnu)
Date: Thu, 11 Apr 2019 15:41:38 +0200
Message-ID: <w515zrkveul.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
	timestamps) [generic] [fuzzy]
X-Received-From: 91.117.99.155
Subject: Re: [Qemu-devel] [PATCH v2 13/13] qemu-iotests: Test the
 x-blockdev-reopen QMP command
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411134138.ta4Hl8TuRe0JWerHan32GnKoYjKqZIvxRSI4PJ_cx0M@z>

On Wed 10 Apr 2019 07:03:50 PM CEST, Max Reitz wrote:
>> +        # hd0 has no backing file: we can omit the 'backing' option
>> +        self.reopen(opts)
>
> [...]
>
>> +        # Detach hd2 from hd0.
>> +        self.reopen(opts, {'backing': None})
>> +        self.reopen(opts, {}, "backing is missing for 'hd0'")
>
> I don=E2=80=99t understand the second test.  hd0 has no default backing f=
ile
> and it currently has no backing child attached to it.  Why would this
> call fail now?

I think there's a bug.

Calling x-blockdev-reopen without 'backing' should only fail if

 a) the image has a backing file attached to it.
    In this case it doesn't: we just detached it in the previous line.

 b) there's a default backing file written on the image header.
    In this case there isn't (hd0 is created without one in setUp()).

So it should not fail. I think the bug is that the test for condition
(b) in bdrv_reopen_prepare() that returns "backing is missing..." is
using backing_file but it should use (correct me if I'm wrong)
auto_backing_file.

Changing that and replacing the test line with self.reopen(opts) fixes
it for me.

Not directly related to this, but should bdrv_backing_detach() also
clear backing_file ?

Berto


