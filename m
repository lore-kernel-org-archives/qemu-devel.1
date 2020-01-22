Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0B8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3ED121734
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgCp5Ejv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3ED121734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGj1-0003kL-OX
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:11:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iuGi2-00033d-4q
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:10:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iuGi1-0008Ss-58
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:10:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50596
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iuGi1-0008S3-13
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579702215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QDC32YjQqL2dXaVDdnT21uI/ufauCJEY3exCwKR4FQk=;
 b=bgCp5Ejv5mLSEZu/dXZrZuJeCfPnCMhe8dZF3Hvhp7fLxz//K2xANL2qnmXQdf8xtSkUgq
 ef8ob/Wp9NLNxRtNsk46enwqV65V3bI+z/Pa78kP8OktFZT2L1j1s7f450K2hVva8HK+3X
 eXQpFJhZSvb7vIHhvr95YYJmAYlnTcw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-DSTlVHMzM7eOCIzkBbwaNA-1; Wed, 22 Jan 2020 09:10:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADE4C18AAFA5;
 Wed, 22 Jan 2020 14:10:10 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-127.ams2.redhat.com
 [10.36.116.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA91B5DA84;
 Wed, 22 Jan 2020 14:10:09 +0000 (UTC)
Subject: Re: Maintainers, please add Message-Id: when merging patches
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@gmail.com>
References: <CAJSP0QX22cYJvnpb+zDDXLaYg0yY4CV3Jn5QY+ExxJyFcmQ3Gw@mail.gmail.com>
 <87v9p3znas.fsf@linaro.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9ac75d71-731d-a9d8-4ba6-f394077c4d96@redhat.com>
Date: Wed, 22 Jan 2020 15:10:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87v9p3znas.fsf@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: DSTlVHMzM7eOCIzkBbwaNA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/22/20 13:30, Alex Benn=C3=A9e wrote:
>=20
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>=20
>> Around 66% of qemu.git commits since v4.1.0 include a Message-Id: tag.  =
Hooray!
>>
>> Message-Id: references the patch email that a commit was merged from.
>> This information is helpful to anyone wishing to refer back to email
>> discussions and patch series.
>=20
> So I guess the ones that don't are maintainer originated patches unless
> you actively rebuild your trees from a posted series?

I *think* this should not be a huge problem process wise:

Assuming that a maintainer does not include their own patches in a PULL
request for Peter until the same patches receive R-b/A-b/T-b feedback
from other list subscribers, the maintainer will want to rebase the
patches at least once anyway, in order to pick up those lines.

And, in the process, the maintainer might as well add in their own
Message-Id's from the list.

... I realize though, that could be more burden in practice than just
running git-am against the same (known) base commit... One could always
run git-range-diff in the end, to compare the "re-pick" versus the
original local branch.

Thanks
Laszlo


