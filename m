Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC10C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 09:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB081206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 09:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FisYIX4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB081206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihsUJ-0007Y9-V3
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 04:52:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ihsTh-0006gp-0Q
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 04:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ihsTd-0007yx-Lp
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 04:52:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54897
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ihsTd-0007tJ-CM
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 04:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576749132;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pgmS/kN1YzmVsEiG8rSyDHONHXymsnIUDqvPYjpzLp4=;
 b=FisYIX4gtECoKQSWJG51UAVx4x+DbZfwyTcnUe8gOjG5d2OlV6ZkpyIZC5qaHDtg7qlgMd
 HOCG564vApM9pyD9pbi2G0+XkWcwLB7ECvSQbEe+xhJraDN2nDWMPutEGQ6RnaDzRTgmE2
 POoj8NpapjSTPekGNserj6OJHust2Wg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-6Hw4nI0xMeSd-p8dobrZFg-1; Thu, 19 Dec 2019 04:52:10 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33A381883524;
 Thu, 19 Dec 2019 09:52:09 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3F0863B92;
 Thu, 19 Dec 2019 09:52:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 00/62] Misc patches for 2019-12-16
In-Reply-To: <63ea9d45-cf98-661a-8788-fbe0c17e9566@redhat.com> (Paolo
 Bonzini's message of "Wed, 18 Dec 2019 12:53:00 +0100")
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_kFsxDKY-ktQ5E4gHxpkQq0Go38DPevKxgf3pTimRxeg@mail.gmail.com>
 <20191217112236.GA2826@work-vm> <877e2u6mjr.fsf@trasno.org>
 <63ea9d45-cf98-661a-8788-fbe0c17e9566@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 19 Dec 2019 10:52:06 +0100
Message-ID: <87sglg1w3d.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 6Hw4nI0xMeSd-p8dobrZFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 18/12/19 09:54, Juan Quintela wrote:
>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>>>> (and others similar)
>>>>
>>>> and in the migration-test:
>>>> MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
>>>> QTEST_QEMU_BINARY=3Di386-softmmu/qemu-system-i386
>>>> QTEST_QEMU_IMG=3Dqemu-img tests/migration-test -m=3Dquick -k --tap <
>>>> /dev/null | ./scripts/tap-driver.pl --test-name=3D"migration-test"
>>>> PASS 1 migration-test /i386/migration/deprecated
>>>> /home/petmay01/linaro/qemu-for-merges/tests/migration-test.c:689:15:
>>>> runtime error: load of value 255, which is not a valid value for type
>>>> 'bool'
>>>> /home/petmay01/linaro/qemu-for-merges/tests/migration-test.c:690:16:
>>>> runtime error: null pointer passed as argument 1, which is declared to
>>>> never be null
>>>> /usr/include/unistd.h:828:48: note: nonnull attribute specified here
>>>
>>> That's a use-after-free from Juan's 'migration-test: Use a struct for
>>> test_migrate_start parameters';  it's calling migrate_start_destroy and
>>> then checks args->use_shmem.
>>=20
>> Hi
>>=20
>> New series with the fix posted upstream.
>>=20
>> Paolo, should I did the pull requset, or will you do it?
>
> I can do it.

Thanks

>> PD.  Just curious, how should I launch clang to give me that error?
>
> "make docker-test-debug@fedora".

Double thanks.

Later, Juan.


