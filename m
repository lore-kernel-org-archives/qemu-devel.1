Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645FCC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:57:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E0CD20659
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOfEl3IT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0CD20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXsaR-0006B1-Ci
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 14:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iXsYn-0005IB-7p
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iXsYl-0004D5-4U
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:56:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37102
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iXsYk-00048u-4w
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574366169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=94QXiH8zPblUylH/j9TrUSbgGfk9Ae2OwMxlvpHNbuk=;
 b=UOfEl3ITnI7HZFjr7NLOlYw4526PaSIcE2JhrXp+t50rjz65P2Gd1UEHE7iWoPw9Ik6QYd
 bR4nid7s6BG3oMauuCZY0YJyOOMRJo0kcBnOxmi1TWXCIx11n1k7Qu5EJ0GozNayKhZwbP
 bi69/B+TCs0Fzl+oKiOBtYE3bSQljME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-ezSRfB2_Ob2kCsOfzUwNUg-1; Thu, 21 Nov 2019 14:56:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2D72804917;
 Thu, 21 Nov 2019 19:56:05 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 701B460556;
 Thu, 21 Nov 2019 19:56:05 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH v4 03/14] qapi: Introduce default values for
 struct members
To: Markus Armbruster <armbru@redhat.com>
References: <20190624173935.25747-1-mreitz@redhat.com>
 <20190624173935.25747-4-mreitz@redhat.com>
 <87eey1b73y.fsf@dusky.pond.sub.org>
 <0214e73e-062e-a9c8-16c9-e99354c07277@redhat.com>
 <871ru1811o.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <817914b7-79d7-a2c9-142b-0a040b1da7ff@redhat.com>
Date: Thu, 21 Nov 2019 13:56:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <871ru1811o.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ezSRfB2_Ob2kCsOfzUwNUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/21/19 1:46 PM, Markus Armbruster wrote:

>>> The '*' is redundant in this form.
>>>
>>> Can anyone think of reasons for keeping it anyway?  Against?
>>
>> Is there ever a reason to allow an optional member but without a
>> 'default' value?  Or can we just blindly state that if 'default' is
>> not present, that is the same as 'default':0/'default':null?
>>
>> Or, applying your statement further,
>>
>> 'data': { '*a':'int', '*b':'str' }
>>
>> is shorthand for:
>>
>> 'data': { 'a': { 'type':'int', 'default':0 },
>>            'b': { 'type':'str', 'default':null } }
>=20
> You propose to default 'default' to a type-specific value.
>=20
> I don't think that's a good idea.

...


> When an absent member behaves just like it was present with a certain
> value DFLT, we want to be able to say in the schema 'default': DFLT.
>=20
> But the schema language also needs to let us say "absent member behaves
> unlike any value".
>=20
> If we define 'default' to default to a value, then that value must have
> this special meaning.
>=20
> Where that value is also a valid value, the schema language cannot
> express "absent member behaves like it was present with that value".
>=20
> I think this makes 0 a poor default value for 'default': "behaves like
> member was present with value 0" is fairly common, I think.
>=20
> Defaulting 'default' to null regardless of member type could work.
>=20
> null is a valid value of the 'null' type and of alternate types with a
> member of type 'null'.  For optional members of such types, the schema
> language then can't express ""absent member behaves like it was present
> with value null".  I think the need to say that is much less common than
> the needs to say "like value 0".
>=20
> Checking...  *sigh*: there are a few optional members that can take null
> values, e.g. MigrateSetParameters member @tls-creds.  I read its doc
> comment twice, and I have to admit I can't make heads or tails of it.
> Can't say for sure whether absent behaves like null, or some other
> value, or unlike any value.
>=20
> QAPI/QMP introspection already specifies null to have exactly this
> special meaning.

Maybe that means we need '*name':'t' to expand into something longer, maybe
  'name':{'type':'t', 'optional':true}
which in  turn would be synonymous with your idea of ALL types accepting=20
a default of null:
  'name':{'type':'t', 'optional':true, 'default':null}

At any rate, your counterpoint is taken - whatever we pick, we'll want=20
to make sure that introspection can expose semantics, and whether we can=20
make '*' redundant with some other form of longhand in the qapi language=20
is in part determined by whether we also reflect that through=20
introspection.  If that means that keeping '*' in the longhand form of=20
optional members (whether or not those members have a default value),=20
then so be it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


