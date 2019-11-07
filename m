Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E57CC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECFFA2077C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+yf1d2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFFA2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSl5d-0002Ws-K7
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1iSkna-00041D-Ex
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:38:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1iSknY-00060N-Bk
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:38:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32329
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1iSknY-000607-7s
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:38:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573144695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2f7F2x0H0eDnSuQOT1VmzLMbYwyX8MQmSBXxannVS0M=;
 b=b+yf1d2SSSsyd+fCe4xXsMh+Hg8aevA9XQ6uYJ4WGqHoQruVfY+Uk9pKJybqpDrKZAGpcm
 fi/RLrfU7Y9zhdxE15GuI+0yDDqRzMEhMokLuROi8koZQO7WyCzNZNwVAQlW2XbxGvwzAk
 ZrHajLnfdVht29FehHLzDrw9ZJ3nSHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-CgBYYzU-OMe3XNVWggcXRA-1; Thu, 07 Nov 2019 11:38:12 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F8E58017E0;
 Thu,  7 Nov 2019 16:38:11 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
 (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C25B60BEC;
 Thu,  7 Nov 2019 16:38:11 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com
 (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
 by colo-mx.corp.redhat.com (Postfix) with ESMTP id EEDEE4BB5C;
 Thu,  7 Nov 2019 16:38:10 +0000 (UTC)
Date: Thu, 7 Nov 2019 11:38:10 -0500 (EST)
From: Cleber Rosa <crosa@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <1209928652.10986630.1573144690743.JavaMail.zimbra@redhat.com>
In-Reply-To: <19097f6f-28a8-12ee-6761-da0f34735910@redhat.com>
References: <20191028181643.5143-12-laurent@vivier.eu>
 <20191029232320.12419-1-crosa@redhat.com>
 <19097f6f-28a8-12ee-6761-da0f34735910@redhat.com>
Subject: Re: [PATCH 0/2] Acceptance test: update kernel used on m68k/q800 test
MIME-Version: 1.0
X-Originating-IP: [10.10.123.183, 10.4.195.15]
Thread-Topic: Acceptance test: update kernel used on m68k/q800 test
Thread-Index: EJ/q+1dPLIzijX5ctIh08mRBEYUp+A==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: CgBYYzU-OMe3XNVWggcXRA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



----- Original Message -----
> From: "Eric Blake" <eblake@redhat.com>
> To: "Cleber Rosa" <crosa@redhat.com>, qemu-devel@nongnu.org
> Cc: "Peter Maydell" <peter.maydell@linaro.org>, "Eduardo Habkost" <ehabko=
st@redhat.com>, "Philippe Mathieu-Daud=C3=A9"
> <f4bug@amsat.org>, "Wainer dos Santos Moschetta" <wainersm@redhat.com>, "=
Laurent Vivier" <laurent@vivier.eu>,
> "Willian Rampazzo" <wrampazz@redhat.com>, "Philippe Mathieu-Daud=C3=A9" <=
philmd@redhat.com>
> Sent: Thursday, November 7, 2019 10:43:08 AM
> Subject: Re: [PATCH 0/2] Acceptance test: update kernel used on m68k/q800=
 test
>=20
> On 10/29/19 6:23 PM, Cleber Rosa wrote:
> > The boot_linux_console.py:BootLinuxConsole.test_m68k_q800 was very
> > recently merged, but between its last review and now, the Kernel
> > package used went missing.
> >=20
>=20
> meta-question: Why was this series posted in-reply-to the pull request,
> rather than as a new top-level thread? I nearly missed it because I
> don't expect to see unreviewed patches buried in threading like that.
> My workflow would have been to post the series in isolation, then
> manually reply to the pull request to mention the message-id of the
> related series proposed as a followup.
>=20

Hi Eric,

That was my attempt to signal that it was a fix to something which had *jus=
t*
being merged as part of that pull request (though now caused by it).

I basically did not know how to act properly, so I thank you for the workfl=
ow
suggestion.  I'll certainly follow it next time.

Thanks a lot!
- Cleber.

> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>=20


