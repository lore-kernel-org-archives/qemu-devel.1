Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A99BC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04D04218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EgxtK0Zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04D04218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihV7M-0001Cm-37
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ihV6h-0000gh-Ib
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ihV6f-00082x-0l
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:54:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23600
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ihV6e-0007zV-SK
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576659295;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R4QZHTMmY7LzRLO66++JExS0enFqMhafPVlEyAgcRe4=;
 b=EgxtK0ZnxL/KjQ6HQgJZ8LjtdQqyUy/3Ij6JH5K7+uzs8Ijk8MP+fkr+4Xz8Hua7i3MkCS
 koYPXn5tHOCQR8Col0yKlZcZ8ikmqzq3CdLB0jcfuLHtAUXDwY0S5Qxw21k+yZz43PcS3z
 Yt86aiEayrm5SeA73nnLRFKSLGL2JFQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-7LCsnQoHMniTX7-D14po3w-1; Wed, 18 Dec 2019 03:54:52 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71F2D800D48;
 Wed, 18 Dec 2019 08:54:51 +0000 (UTC)
Received: from redhat.com (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB16D5D9E2;
 Wed, 18 Dec 2019 08:54:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PULL 00/62] Misc patches for 2019-12-16
In-Reply-To: <20191217112236.GA2826@work-vm> (David Alan Gilbert's message of
 "Tue, 17 Dec 2019 11:22:36 +0000")
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_kFsxDKY-ktQ5E4gHxpkQq0Go38DPevKxgf3pTimRxeg@mail.gmail.com>
 <20191217112236.GA2826@work-vm>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Wed, 18 Dec 2019 09:54:48 +0100
Message-ID: <877e2u6mjr.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 7LCsnQoHMniTX7-D14po3w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>> (and others similar)
>>=20
>> and in the migration-test:
>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>> QTEST_QEMU_BINARY=3Di386-softmmu/qemu-system-i386
>> QTEST_QEMU_IMG=3Dqemu-img tests/migration-test -m=3Dquick -k --tap <
>> /dev/null | ./scripts/tap-driver.pl --test-name=3D"migration-test"
>> PASS 1 migration-test /i386/migration/deprecated
>> /home/petmay01/linaro/qemu-for-merges/tests/migration-test.c:689:15:
>> runtime error: load of value 255, which is not a valid value for type
>> 'bool'
>> /home/petmay01/linaro/qemu-for-merges/tests/migration-test.c:690:16:
>> runtime error: null pointer passed as argument 1, which is declared to
>> never be null
>> /usr/include/unistd.h:828:48: note: nonnull attribute specified here
>
> That's a use-after-free from Juan's 'migration-test: Use a struct for
> test_migrate_start parameters';  it's calling migrate_start_destroy and
> then checks args->use_shmem.

Hi

New series with the fix posted upstream.

Paolo, should I did the pull requset, or will you do it?

Thanks, Juan.

PD.  Just curious, how should I launch clang to give me that error?


