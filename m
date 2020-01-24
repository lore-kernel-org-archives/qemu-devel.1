Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC8AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:44:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 173862070A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 12:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuU7+dny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173862070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuyJp-0001dP-97
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 07:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iuyJE-0001B5-OR
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:43:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iuyJC-0006KC-Hh
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:43:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26022
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iuyJC-0006Iq-8Y
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 07:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579869813;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+/kTGMTNptPaYkqkmSyRcDcTUY2yrWXo5yWx5CKGzUY=;
 b=EuU7+dnyCx1eKnUgoje/qQK6Y78v2KN5Q4hMK5PlTiBzfQ+0HWCqW7p15OndQyTJLolasu
 58889jRtubjEKCfvYJG/bfPu9LTqeyE2K/9c/R1X+7622Fy5hkoLjsrWF8LIcFfn9+p8KN
 yZfKpYSx+OlqyZQiwZAtIy5GgArMg8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-6Vwjh7lGMg-7MdUEdIZmgQ-1; Fri, 24 Jan 2020 07:43:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBDAD1005510;
 Fri, 24 Jan 2020 12:43:27 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A45D867E2;
 Fri, 24 Jan 2020 12:43:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH 0/3] migration: add sztd compression
In-Reply-To: <20190226131535.30361-1-dplotnikov@virtuozzo.com> (Denis
 Plotnikov's message of "Tue, 26 Feb 2019 16:15:32 +0300")
References: <20190226131535.30361-1-dplotnikov@virtuozzo.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Fri, 24 Jan 2020 13:43:23 +0100
Message-ID: <87o8ut3tzo.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 6Vwjh7lGMg-7MdUEdIZmgQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: quintela@redhat.com
Cc: den@virtuozzo.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Denis Plotnikov <dplotnikov@virtuozzo.com> wrote:
> zstd date compression algorithm shows better performance on data compress=
ion.
> It might be useful to employ the algorithm in VM migration to reduce CPU =
usage.
> A user will be able to choose between those algorithms, therefor compress=
-type
> migration parameter is added.
>
> Here are some results of performance comparison zstd vs gzip:

Please, could you comment on the series:

[PATCH v3 00/21] Multifd Migration Compression

That series integrated zstd/zlib compression on top of multifd,
advantages over "old" compression code are:
- We don't have to copy data back and forth
- The unit of compression is 512KB instead of 4kb
- We "conserve" the compression state between packets (this is specially
  interesting for zstd, that uses dictionaries)

> host: i7-4790 8xCPU @ 3.60GHz, 16G RAM
> migration to the same host
> VM: 2xVCPU, 8G RAM total
> 5G RAM used, memory populated with postgreqsl data
> produced by pgbench performance benchmark
>
>
> Threads: 1 compress =E2=80=93 1 decompress
>
> zstd provides slightly less compression ratio with almost the same
> CPU usage but copes with RAM  compression roghly 2 times faster
>
> compression type              zlib       |      zstd
> ---------------------------------------------------------
> compression level          1       5     |   1       5
> compression ratio          6.92    7.05  |   6.69    6.89
> cpu idle, %                82      83    |   86      80
> time, sec                  49      71    |   26      31
> time diff to zlib, sec                      -25     -41
>
>
> Threads: 8 compress =E2=80=93 2 decompress
>
> zstd provides the same migration time with less cpu consumption
>
> compression type         none  |        gzip(zlib)    |          zstd
> -------------------------------------------------------------------------=
-----
> compression level        -     |  1      5       9    |   1       5      =
 15
> compression ratio        -     |  6.94   6.99    7.14 |   6.64    6.89   =
 6.93
> time, sec                154   |  22     23      27   |   23      23     =
 25
> cpu idle, %              99    |  45     30      12   |   70      52     =
 23
> cpu idle diff to zlib          |                      |  -25%    -22%    =
-11%

I don't have handy results, but it looked for me like you:
- zstd has a way better latency than zlib (i.e. the packet cames sooner)
- And it compress much better

On the migration test (best possible case for a compressor, as we are
writting just one byte of each page, and we write the same value in all
pages):

- zlib: compress 512KB -> 2500 bytes
- zstd: compess 512KB -> 52 bytes (yeap, I tested several times, it
  looked too small)

See that I posted another patch to "delete" the old compression code.
Why?
- I have been unable to modify migration-test to test it and work
  reliablely (only way was to allow a really huge downtime)
- Even with slow networking (1Gigabit) I got really mixed results,
  because as it is so slow, the guest continue dirtying memory, and in
  my tests it was never a winner

Thanks, Juan.


