Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CF6CA9EA0
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 01:09:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6349207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 01:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BR7zDRK8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6349207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN595-0002To-17
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 21:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iN587-0001wE-QX
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 21:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iN586-0004P9-1h
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 21:08:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24566
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iN585-0004Ox-V6
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 21:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571792881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Us/RNeJtwntly8baA+TeoSclqp7ev8xCh3nlG8vd7H4=;
 b=BR7zDRK8lm6IIyfmTCRfL2hsFiJbCQ+988u89NZlM2625CbUGEqYWOhNtfLtTdsSE72XpL
 Rb+Q1dX3j8CMhfxFxDSYorFuNlR+gKvkM5Ij0WcX7NVCsnvM46ymR2gVnI/JaaD5KqmjFA
 0RS/1TzPZ+tEpA1T8fK+6UjipWgUln4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-k8fnbmiVMxWpw9TRaQBvfw-1; Tue, 22 Oct 2019 21:07:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30D8080183E;
 Wed, 23 Oct 2019 01:07:55 +0000 (UTC)
Received: from [10.3.117.0] (ovpn-117-0.phx2.redhat.com [10.3.117.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0743C5D6B2;
 Wed, 23 Oct 2019 01:07:51 +0000 (UTC)
Subject: Re: [GIT PULL for qemu-pseries] pseries: Update SLOF firmware image
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20191022040945.35730-1-aik@ozlabs.ru>
 <1c3c1b36-a355-9ebb-9c68-8ae1af268fff@redhat.com>
 <89175bc7-87d0-8b77-595e-2a610a9d3b30@ozlabs.ru>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <106a1e2a-3ee1-50c1-c80d-3d8d7d693acf@redhat.com>
Date: Tue, 22 Oct 2019 20:07:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <89175bc7-87d0-8b77-595e-2a610a9d3b30@ozlabs.ru>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: k8fnbmiVMxWpw9TRaQBvfw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/19 7:04 PM, Alexey Kardashevskiy wrote:

>> Looking at commit 8e59d05f71ae which update the SLOF submodule,
>> in your future updates can you include the git shortlog in the
>> commit description?
>=20
>=20
> I guess I can do that.
>=20
> Is there an easy way to combine
>=20
> git -C roms/SLOF shortlog qemu-slof-20190911..qemu-slof-20191022
> git commit
> ?
>=20

git -C roms/SLOF shortlog qemu-slof-20190911..qemu-slof-20191022 \
   | git commit -F -


You can get something similar with less typing as:

git sumodule summary | git commit -F -


> After
> export MYDIFF=3D$(git -C roms/SLOF shortlog qemu-slof-20190911..qemu-slof=
-20191022)
> $MYDIFF looses formatting (drops \r) so it is no good for a commit log.

Potentially insufficient quoting there.

POSIX says that:

export foo=3D$(printf 'a  b')

can result in either of the following scenarios:

both 'foo' and 'b' are exported, foo with the value 'a', b with its=20
existing value (if any, otherwise empty); bash uses this behavior [in=20
POSIX terms, bash treats arguments after 'export' in an assignment context]

just 'foo' is exported, with value 'a  b'; dash uses this behavior

If you want to guarantee the latter (that is, that the shell does not=20
split on whitespace or perform globbing), you have to either split it=20
into two commands (so that your unquoted use of $() is guaranteed to=20
occur in assignment context, without worrying whether 'export'=20
introduces those contexts):

export foo
foo=3D$(...)

or use quoting:

export foo=3D"$(...)"

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


