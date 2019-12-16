Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13B0C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA116206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WspmnDS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA116206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igsbG-0002Zq-Qp
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1igsZm-0001RL-8e
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1igsZg-0007hz-Sb
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:46:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40867
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1igsZf-0007fy-56
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576511177;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FKjxxMWe2oEP6McR3cJxnmCRa7Cw3Oi3ll0C35i9LtI=;
 b=WspmnDS+xkhcaOwv6JfE6saomL7RdJBpbwEK4U+e+uoSBXJNynKpQrrMlnMyg24Xcpyxhv
 QdyuQqxi18WX8nFdcuH+QQZL/ZjkXOXyfcoS9VfG4opU7nyVStmUTgOFMHgRPx/MbFeSAJ
 BaTPatOi99cnzp/l9mSMIFwh0cbLigE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-jCBf9y_uPpeGdsZegtcWfw-1; Mon, 16 Dec 2019 10:46:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F7458024E4
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 15:46:14 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9F81620A1;
 Mon, 16 Dec 2019 15:46:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 00/10] Migration Arguments cleanup
In-Reply-To: <89264106-87af-4fcb-607a-82ad7b56750d@redhat.com> (Paolo
 Bonzini's message of "Mon, 16 Dec 2019 15:01:18 +0100")
References: <20191212222033.1026-1-quintela@redhat.com>
 <89264106-87af-4fcb-607a-82ad7b56750d@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Mon, 16 Dec 2019 16:46:11 +0100
Message-ID: <87o8w86zp8.fsf@trasno.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: jCBf9y_uPpeGdsZegtcWfw-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 12/12/19 23:20, Juan Quintela wrote:
>> Hi
>>=20
>> This series simplify test_migrate_start() in two ways:
>> - simplify the command line creation, so everything that is common betwe=
en
>>   architectures don't have to be repeated (DRY).
>>   Note that this bit remove lines of code.
>> - test_migrate_start() has two bools and two strings as arguments, it is=
 very
>>   difficult to remmeber which is which and meaning.  And it is even wors=
e to
>>   add new parameters.  Just pass them through one struct.
>>=20
>> Please, review.
>>=20
>> Juan Quintela (10):
>>   migration-test: Create cmd_soure and cmd_target
>>   migration-test: Move hide_stderr to common commandline
>>   migration-test: Move -machine to common commandline
>>   migration-test: Move memory size to common commandline
>>   migration-test: Move shmem handling to common commandline
>>   migration-test: Move -name handling to common commandline
>>   migration-test: Move -serial handling to common commandline
>>   migration-test: Move -incomming handling to common commandline
>>   migration-test: Rename cmd_src/dst to arch_source/arch_target
>>   migration-test: Use a struct for test_migrate_start parameters
>>=20
>>  tests/migration-test.c | 265 +++++++++++++++++++++++------------------
>>  1 file changed, 147 insertions(+), 118 deletions(-)
>>=20
>
> I have picked up this series and rebased the -accel changes on top.

Thanks.

about the accel and the machine type, .... it feel so weird that we only
need to add a machine type for aarch64.

Later, Juan.


