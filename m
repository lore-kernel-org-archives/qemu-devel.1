Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12585CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8AF2064A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE8AF2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLSLa-0004zz-W6
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iLSKj-0004MR-Ij
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iLSKi-0004HQ-HC
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:30:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16219)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iLSKg-0004FD-6g; Fri, 18 Oct 2019 09:30:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4FD77A3CD81;
 Fri, 18 Oct 2019 13:30:17 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A943D5D9CA;
 Fri, 18 Oct 2019 13:30:16 +0000 (UTC)
Subject: Re: [PATCH v2 01/23] iotests: Introduce $SOCK_DIR
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191017133155.5327-1-mreitz@redhat.com>
 <20191017133155.5327-2-mreitz@redhat.com>
 <b8251992-a52b-f605-e45e-edf381394130@redhat.com>
 <1ea69391-fa2b-bb19-ce34-f47036f1a064@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cb686253-f14f-1d0a-69a3-f1b310914a9d@redhat.com>
Date: Fri, 18 Oct 2019 08:30:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1ea69391-fa2b-bb19-ce34-f47036f1a064@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 18 Oct 2019 13:30:17 +0000 (UTC)
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/18/19 4:03 AM, Max Reitz wrote:

>>>  =C2=A0 -if [ ! -e "$TEST_DIR" ]; then
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mkdir "$TEST_DIR"
>>> +tmp_sock_dir=3Dfalse
>>> +if [ -z "$SOCK_DIR" ]; then
>>> +=C2=A0=C2=A0=C2=A0 SOCK_DIR=3D$(mktemp -d)
>>> +=C2=A0=C2=A0=C2=A0 tmp_sock_dir=3Dtrue
>>>  =C2=A0 fi
>>> +mkdir -p "$SOCK_DIR" || _init_error 'Failed to create SOCK_DIR'
>>
>> Thinking about this again: if the user passed in a name, we probably
>> want to use it no matter whether the directory already exists (mkdir -=
p
>> makes sense: either the directory did not exist, or the user is in
>> charge of passing us a directory that they already secured).=C2=A0 But=
 if we
>> generate our own name in a world-writable location in /tmp, using mkdi=
r
>> -p means someone else can race us to the creation of the directory, an=
d
>> potentially populate it in a way to cause us a security hole while we
>> execute our tests.
>=20
> I don=E2=80=99t quite see how this is a security hole.  mktemp -d creat=
es the
> directory, so noone can race us.

Aha - I confused 'mktemp -u' (necessary for creating a socket name) and=20
'mktemp -d' (for directories).  With that confusion cleared up, yes, the=20
directory is safely created (or else the burden is on the caller), so:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

