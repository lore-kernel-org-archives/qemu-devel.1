Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E6FC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 20:07:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B13320835
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 20:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B13320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHZII-0005Ai-PD
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 16:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36325)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iHZHb-0004eZ-Tl
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 16:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iHZHa-0005vS-S9
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 16:07:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41052)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iHZHY-0005tZ-Im; Mon, 07 Oct 2019 16:07:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CD43630842B5;
 Mon,  7 Oct 2019 20:06:59 +0000 (UTC)
Received: from [10.3.116.162] (ovpn-116-162.phx2.redhat.com [10.3.116.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AD885B69A;
 Mon,  7 Oct 2019 20:06:55 +0000 (UTC)
Subject: Re: [PATCH 1/2] tests: Make iotest 223 easier to edit
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20190924143522.22902-1-eblake@redhat.com>
 <20190924143522.22902-2-eblake@redhat.com>
 <7aea45cd-bada-4e90-9ee9-1bac19e3c7df@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <40b49be4-950c-a71d-1803-af0b0b8d9eb5@redhat.com>
Date: Mon, 7 Oct 2019 15:06:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <7aea45cd-bada-4e90-9ee9-1bac19e3c7df@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 07 Oct 2019 20:06:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: nsoffer@redhat.com, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/19 7:05 AM, Max Reitz wrote:
> On 24.09.19 16:35, Eric Blake wrote:
>> Log the QMP input to qemu, not just the QMP output.
>=20
> Why not just add this functionality to _send_qemu_cmd directly?  (Like
> silent already does for replies, although it=E2=80=99s inverted.)

Interesting idea.  I'll give it a shot (it may have a larger effect on=20
more .out files, but that's probably a good thing).

>=20
> (Although I=E2=80=99m not quite sold on the indentation for commands, b=
ecause
> (1) we don=E2=80=99t do that in other tests, (2) I=E2=80=99d prefer som=
e prefix like
> ->/<-, and (3) there is generally no need because commands start with
> =E2=80=9Cexecute=E2=80=9D and replies start with =E2=80=9Creturn=E2=80=9D=
, =E2=80=9Cerror=E2=80=9D, or =E2=80=9Cevent=E2=80=9D, so they
> already have clear prefixes to distinguish the two classes.)

I don't mind avoiding indentation; as you say, direction can be inferred=20
by contents.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

