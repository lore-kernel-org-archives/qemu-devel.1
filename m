Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4991C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:10:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2FB205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 13:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RemdxnV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D2FB205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixW4G-00020n-L3
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 08:10:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48911)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ixW2L-0007tn-Di
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:08:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ixW2J-0003X5-5o
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:08:40 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23297
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ixW2I-0003UZ-Td
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 08:08:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580476118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WD9XJunk4udcum0FdR8WtrQEOzr5FIDs1fs2L9kD3J4=;
 b=RemdxnV9HfMp4H9dOzDxjaU4B5++J6+jQLA9EOs8xQlEMkZlXb+ePTU7+S6Zy8xzgVz1Gf
 jP+3VW+x+N9L/3/bRTpaVbo5fZZzM1LP898odddB3WEKYMg7Gvej32C3EL1Ruj2KHRWsES
 0PRTb3VVaDRfqCYLvKrFqgyc5N7bagg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-eCJVtjFjMkym4CYwHou0jA-1; Fri, 31 Jan 2020 08:08:34 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4337E8C8E05
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 13:08:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-40.gru2.redhat.com
 [10.97.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 090668885B;
 Fri, 31 Jan 2020 13:08:28 +0000 (UTC)
Subject: Re: [PATCH 0/5] python/qemu: qmp: Fix, delint and improvements
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191227134101.244496-1-wainersm@redhat.com>
 <fe3ffe05-c620-7770-2752-3d2c4973da03@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <a729dffa-2c74-8cfe-123c-8d5fe47f9cb5@redhat.com>
Date: Fri, 31 Jan 2020 11:08:27 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <fe3ffe05-c620-7770-2752-3d2c4973da03@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: eCJVtjFjMkym4CYwHou0jA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/30/20 8:41 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/27/19 2:40 PM, Wainer dos Santos Moschetta wrote:
>> I started fixing an issue on exception handling which in some places
>> currently use the deprecated (in Python 3.3) `socket.error`. Then I
>> ended up delinting the module code and making some improvements.
>>
>> Git:
>> - Tree: https://github.com/wainersm/qemu
>> - Branch: python_qmp_sockets_error
>>
>> CI:
>> - Travis (FAIL): https://travis-ci.org/wainersm/qemu/builds/629772066
>> =C2=A0=C2=A0 Failure not related with this series. Even QEMU master bran=
ch is
>> =C2=A0=C2=A0 failing to build when `--without-default-devices --disable-=
user`.
>>
>> Wainer dos Santos Moschetta (5):
>> =C2=A0=C2=A0 python/qemu: qmp: Replace socket.error with OSError
>> =C2=A0=C2=A0 python/qemu: Delint the qmp module
>> =C2=A0=C2=A0 python/qemu: qmp: Make accept()'s timeout configurable
>> =C2=A0=C2=A0 python/qemu: qmp: Make QEMUMonitorProtocol a context manage=
r
>> =C2=A0=C2=A0 python/qemu: qmp: Remove unnused attributes
>>
>> =C2=A0 python/qemu/qmp.py | 91 +++++++++++++++++++++++++++++++++--------=
-----
>> =C2=A0 1 file changed, 65 insertions(+), 26 deletions(-)
>>
>
> Thanks, applied patches 1, 2 and 5 to my python-next tree:
> https://gitlab.com/philmd/qemu/commits/python-next
>
>

Great, I was going to ask you that. Patches 3 and 4 are likely to need a=20
respin.

Thanks Philippe!



