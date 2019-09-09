Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9430BC4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 18:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FDE42089F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 18:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rku79bmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FDE42089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7OcM-0004j9-GO
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 14:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <junio@pobox.com>) id 1i7Obk-0004KX-4k
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 14:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <junio@pobox.com>) id 1i7Obj-0006Mb-1E
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 14:41:48 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51915)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <junio@pobox.com>) id 1i7Obi-0006KU-Jr
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 14:41:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
 by pb-smtp21.pobox.com (Postfix) with ESMTP id 2F06C92EBA;
 Mon,  9 Sep 2019 14:41:44 -0400 (EDT) (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
 :subject:references:date:in-reply-to:message-id:mime-version
 :content-type; s=sasl; bh=eGoqGbkXpH+RlUFjrqlrGn1HdPI=; b=Rku79b
 mf123UWHnerKJRPeaBf9UPMNurVOrW9XLOjlNee3WatswBqmsSjeU7zG5TlkWHi8
 o26XqOJSujBCdH/LJ7WOuz8zfLzjpxHg2Bu3KHJfg7pjN4IcXqNxmWfOTkWy1xWb
 ABtZ0VVHK9S32V1LDAz8aN5i8IVdXIWWuIyJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
 :subject:references:date:in-reply-to:message-id:mime-version
 :content-type; q=dns; s=sasl; b=JOmhdzv1gI0Q/241xsvek5VyRmAK7iZZ
 gZzsN/s3WHDOY25H7ti7Bx40MBb9a7xxk8A5qS0nKTIekICT2X+bVHzbtgyQgod7
 P//t+11Uq8QAnuFLGpig2npBFE48LKeTWJ6VGxcR7vjB1hV1xLOsXWtC/LmKDgn7
 PgCsUujHnbM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
 by pb-smtp21.pobox.com (Postfix) with ESMTP id 2832192EB9;
 Mon,  9 Sep 2019 14:41:44 -0400 (EDT) (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3C7A292EB5;
 Mon,  9 Sep 2019 14:41:41 -0400 (EDT) (envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Blake <eblake@redhat.com>
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <46fe6c73-961f-d72a-77de-88491b6f223c@redhat.com>
 <4642438.ai5u8AxThJ@silver> <1897173.eDCz7oYxVq@silver>
 <305577c2-709a-b632-4056-6582771176ac@redhat.com>
Date: Mon, 09 Sep 2019 11:41:39 -0700
In-Reply-To: <305577c2-709a-b632-4056-6582771176ac@redhat.com> (Eric Blake's
 message of "Mon, 9 Sep 2019 09:05:45 -0500")
Message-ID: <xmqqd0g9jorg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76DE39FE-D331-11E9-A20F-8D86F504CC47-77302942!pb-smtp21.pobox.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 173.228.157.53
Subject: Re: [Qemu-devel] [PATCH v6 0/4] 9p: Fix file ID collisions
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
Cc: berrange@redhat.com, stefanha@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, dgilbert@redhat.com, antonios.motakis@huawei.com,
 git@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eric Blake <eblake@redhat.com> writes:

> How hard would it be to improve 'git format-patch'/'git send-email' to
> have an option to ALWAYS output a From: line in the body, even when the
> sender is the author, for the case of a mailing list that munges the
> mail headers due to DMARC/DKIM reasons?

I'd say that it shouldn't be so hard to implement than realizing
what ahd why it is needed, designing what the end-user interaction
would be (i.e.  command line options?  configuration variables?
should it be per send-email destination?) and stating all of the
above clearly in the documentation and the proposed commit log
message.

The reason you are asking is...?  Am I smelling a volunteer?

