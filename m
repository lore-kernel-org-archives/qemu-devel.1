Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2E4C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 04:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC02208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 04:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC02208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48230 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbdYM-0002Ao-Ea
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 00:11:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55568)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hbdXr-0001jf-O9
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 00:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hbdXq-0006YR-K2
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 00:10:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59666)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hbdSq-0001vt-A0; Fri, 14 Jun 2019 00:05:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62C5E356C4;
 Fri, 14 Jun 2019 04:04:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 31AC01B5B9;
 Fri, 14 Jun 2019 04:04:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9DBAA1138648; Fri, 14 Jun 2019 06:04:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
References: <b1e59713-c126-8f8f-7adf-aa6f23b86474@redhat.com>
Date: Fri, 14 Jun 2019 06:04:44 +0200
In-Reply-To: <b1e59713-c126-8f8f-7adf-aa6f23b86474@redhat.com> (Eric Blake's
 message of "Thu, 13 Jun 2019 10:53:27 -0500")
Message-ID: <87r27wke1v.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 14 Jun 2019 04:04:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] testsuite spurious failure due to leftover files
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
Cc: QEMU <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> iotests ./check -qcow2 failed for me today:
>
> 191      fail       [10:46:04] [10:46:13]   0s (last: 7s)    output
> mismatch (see 191.out.bad)
> --- /home/eblake/qemu/tests/qemu-iotests/191.out	2019-05-24
> 09:27:46.449348997 -0500
> +++ /home/eblake/qemu/tests/qemu-iotests/191.out.bad	2019-06-13
> 10:46:13.906004319 -0500
> @@ -8,6 +8,8 @@
>  Formatting 'TEST_DIR/t.IMGFMT.ovl2', fmt=IMGFMT size=67108864
> backing_file=TEST_DIR/t.IMGFMT.mid
>  wrote 65536/65536 bytes at offset 1048576
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +mkfifo: cannot create fifo
> '/home/eblake/qemu/tests/qemu-iotests/scratch/qmp-out-17782_0': File exists
> +mkfifo: cannot create fifo
> '/home/eblake/qemu/tests/qemu-iotests/scratch/qmp-in-17782_0': File exists
>  {
>      "return": {
>      }
>
> If someone wants a good project to take on - it would be nice to revive
> Jeff Cody's initial work on refactoring the iotests to operate with one
> directory per test, allowing things to be run in parallel, and allowing
> cleanup to be much easier (nuke the temp directories, rather than trying
> to track down which test left a possibly-colliding file name behind)

The non-iotests could use the same treatment.

Too big for <https://wiki.qemu.org/BiteSizedTasks>, I'm afraid.

