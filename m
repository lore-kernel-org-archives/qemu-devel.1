Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F54C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C76B20674
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IU5Uq+Uy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C76B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXoL7-0006RT-85
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 10:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iXoKD-0005jQ-Fi
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:24:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iXoKC-0006Jq-Bh
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:24:53 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20443
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iXoKC-0006JK-8h
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574349891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vrjEfNCKpbvP2mud/gtTxbxJ6NETRNI2/clN66e647Y=;
 b=IU5Uq+UyxRUm2bK1lJ50SLcg8XYMx4CgMZvfoRzp5Mw6CWIcUfRq7awRVDPH6KRUAlUdjB
 uwPCbrm0cDIb3dSkvwid96T3OsZaL4wRObipOg4PFrnGB7ky1lRlQ0Ct0kWDoOsSs9kjxp
 QC5b4Br/61DiAYNafpOsh9hewd/mVeI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-HeDLBC_bOaCDbhegg8PWbQ-1; Thu, 21 Nov 2019 10:24:47 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B55D8024C0;
 Thu, 21 Nov 2019 15:24:46 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 735AC44FA8;
 Thu, 21 Nov 2019 15:24:45 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH v4 03/14] qapi: Introduce default values for
 struct members
To: Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
References: <20190624173935.25747-1-mreitz@redhat.com>
 <20190624173935.25747-4-mreitz@redhat.com>
 <87eey1b73y.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0214e73e-062e-a9c8-16c9-e99354c07277@redhat.com>
Date: Thu, 21 Nov 2019 09:24:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87eey1b73y.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: HeDLBC_bOaCDbhegg8PWbQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/21/19 9:07 AM, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> With this change, it is possible to give default values for struct
>> members, as follows:
>>
>>    What you had to do so far:
>>
>>      # @member: Some description, defaults to 42.
>>      { 'struct': 'Foo',
>>        'data': { '*member': 'int' } }
>>
>>    What you can do now:
>>
>>      { 'struct': 'Foo',
>>        'data': { '*member': { 'type': 'int', 'default': 42 } }
>=20
> The '*' is redundant in this form.
>=20
> Can anyone think of reasons for keeping it anyway?  Against?

Is there ever a reason to allow an optional member but without a=20
'default' value?  Or can we just blindly state that if 'default' is not=20
present, that is the same as 'default':0/'default':null?

Or, applying your statement further,

'data': { '*a':'int', '*b':'str' }

is shorthand for:

'data': { 'a': { 'type':'int', 'default':0 },
           'b': { 'type':'str', 'default':null } }

So I could live with permitting '*' only in the shorthand form, and=20
declaring that it is incompatible with longhand form because the=20
existence of a 'default' key in longhand form is evidence that the=20
member is therefore optional.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


