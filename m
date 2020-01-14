Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242EBC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B3724673
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7zibmtb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B3724673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irKKU-00047m-LS
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 06:25:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51952)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1irKHE-0008Lb-Dp
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1irKHA-0005HV-PM
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:22:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48982
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1irKH9-0005H4-Kh
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579000942;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=95rfsn43b8vdT617lWevePZoP33VYujDwqJf7PGBIeE=;
 b=D7zibmtbdx2UkLXeRZkYjsNBfJ+Pll6swNoWIPSVDKm03F64qCgU5G34yzy/o8ldb/YLhJ
 Ik6HgttUjKG6NJ0jF9O3jHqg10phHERLnwa+BhW/NOpPHB2z1PeT3YRMhzgW7MA1Ny5BnB
 Cz5naGBkR3G54Gowjoze6fwWHspD6Qg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-CyDF3rQBN6ue5S9zSccwig-1; Tue, 14 Jan 2020 06:22:20 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E03B51800D48;
 Tue, 14 Jan 2020 11:22:18 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 638815DA76;
 Tue, 14 Jan 2020 11:22:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/29] Migration pull patches (second try)
In-Reply-To: <CAFEAcA-7aLrp4n9gtD=0MzmMDpzNyJCUpOmY2XPxNOun5MKeGA@mail.gmail.com>
 (Peter Maydell's message of "Tue, 14 Jan 2020 11:15:03 +0000")
References: <20200114092606.1761-1-quintela@redhat.com>
 <CAFEAcA-7aLrp4n9gtD=0MzmMDpzNyJCUpOmY2XPxNOun5MKeGA@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 14 Jan 2020 12:22:10 +0100
Message-ID: <875zhewae5.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: CyDF3rQBN6ue5S9zSccwig-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Thomas Huth <thuth@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On Tue, 14 Jan 2020 at 09:26, Juan Quintela <quintela@redhat.com> wrote:
>>
>> The following changes since commit 3c8a6575985b1652b45bfa670b5e1907d642c=
fa0:
>>
>>   Merge remote-tracking branch
>> 'remotes/kraxel/tags/usb-20200113-pull-request' into staging
>> (2020-01-13 14:19:57 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://github.com/juanquintela/qemu.git tags/migration-pull-pull-requ=
est
>>
>> for you to fetch changes up to 4eafab585c091050b5ae63130f46fe46ac919c3a:
>>
>>   migration: Support QLIST migration (2020-01-14 10:17:12 +0100)
>>
>> ----------------------------------------------------------------
>> Migration pull request
>> - updated QList patch
>> - initialize local msg variable
>>
>> ----------------------------------------------------------------
>
> Still fails on hosts where ram_addr_t is 32 bits.
> Looks like you still haven't got the fix for the problem
> Dan pointed out where multifd_save_setup() is using the
> wrong type when it calculates p->packetlen to allocate the
> data structure.

Ouch.  Then there is "yet" another different problem. I fixed the one
that daniel pointed.

Working there.


