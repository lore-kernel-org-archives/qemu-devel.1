Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473D2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 05:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AEF12067D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 05:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NV1Llw0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEF12067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2pah-0001QA-Cy
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 01:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2pZx-0000p8-3P
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 01:33:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20362
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2pZv-0005GS-9C
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 01:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596519214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fsHW8pRM8h3zkL3Z3ee0yJDJaaqk1Vf9LTFRmRmpER8=;
 b=NV1Llw0lPsgrjqoRBk0Y8yIQQsxT42BChN9vgU7WyQqJGTZW6GsSaRce1VgIKqIk2dSCx2
 YIKb5TXzTxfxC1fPCwD2C225W4uc3Db5TcGpXXMfMwHas0Ag0ROZF3GGiUkpptM8p3BdAk
 04qbQdcB0anEnYHjVmmNahay+v3xsSo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-p9ZTWt04P8-yexplctjBFQ-1; Tue, 04 Aug 2020 01:33:31 -0400
X-MC-Unique: p9ZTWt04P8-yexplctjBFQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 675AC18C63CB
 for <qemu-devel@nongnu.org>; Tue,  4 Aug 2020 05:33:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1332C5D9F7;
 Tue,  4 Aug 2020 05:33:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 805071132FD2; Tue,  4 Aug 2020 07:33:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: qapi-schema esotera
References: <5bfa3895-304d-8372-c0db-fda4c1a1ba59@redhat.com>
 <dc0a16e2-365f-a9e6-03df-b70f97dd7407@redhat.com>
 <64792de9-6719-3987-a66b-aed8cca61572@redhat.com>
Date: Tue, 04 Aug 2020 07:33:28 +0200
In-Reply-To: <64792de9-6719-3987-a66b-aed8cca61572@redhat.com> (John Snow's
 message of "Mon, 3 Aug 2020 13:51:10 -0400")
Message-ID: <875z9zgel3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 8/3/20 1:25 PM, Eric Blake wrote:
>> On 8/3/20 11:49 AM, John Snow wrote:
>>> UNION is split into two primary forms:
>>>
>>> 1. Simple (No discriminator nor base)
>>> 2. Flat (Discriminator and base)
>>>
>>> In expr.py, I notice that we modify the perceived type of the
>>> 'type' expression based on the two union forms.
>>>
>>> 1a. Simple unions allow Array[T]
>>> 1b. Flat unions disallow Array[T]
>>
>> Rather, branches in a simple unions are syntactic sugar for a
>> wrapper struct that contains a single member 'data'; because of that
>> extra nesting, the type of that single member is unconstrained.=C2=A0 In
>> flat unionw, the type MUST be a QAPI struct, because its members
>> will be used inline; as currently coded, this prevents the use of an
>> intrinsic type ('int', 'str') or an array type.
>>
>
> I meant syntactically here, to be clear. I'm looking at expr.py -- if
> there are deeper constraints on the semantics of the information
> provided, that happens later.
>
> Specifically, check_union's use of check_type() changes depending on
> the form of the union. One allows a string, the other allows a List of
> strings, provided the list is precisely one element long.
>
>> If you need to use an array type in a flat union, you can't do:
>>
>> { 'union' ...
>>  =C2=A0 'data': { 'foo': [ 'MyBranch' ] } }
>>
>> but you can provide a wrapper type yourself:
>>
>> { 'struct': 'MyBranch', 'data': { 'array': [ 'MyType' ] } }
>> { 'union' ...
>>  =C2=A0 'data': { 'foo': 'MyBranch' } }
>>
>>>
>>> =C2=A0From the docs:
>>>
>>> Syntax:
>>> =C2=A0=C2=A0=C2=A0=C2=A0 UNION =3D { 'union': STRING,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 'data': BRANCHES,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 '*if': COND,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 '*features': FEATURES }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | { 'union=
': STRING,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 'data': BRANCHES,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 'base': ( MEMBERS | STRING ),
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 'discriminator': STRING,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 '*if': COND,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 '*features': FEATURES }
>>> =C2=A0=C2=A0=C2=A0=C2=A0 BRANCHES =3D { BRANCH, ... }
>>> =C2=A0=C2=A0=C2=A0=C2=A0 BRANCH =3D STRING : TYPE-REF
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | ST=
RING : { 'type': TYPE-REF, '*if': COND }
>>>
>>> Both arms use the same "BRANCHES" grammar production, which both
>>> use TYPE-REF.
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 TYPE-REF =3D STRING | ARRAY-TYPE
>>> =C2=A0=C2=A0=C2=A0=C2=A0 ARRAY-TYPE =3D [ STRING ]
>>>
>>> Implying that List[T] should be allowed for both productions.
>>> Can I ask for a ruling from the judges?
>>
>> As you found, the docs are a bit misleading; the semantic constraint
>> on flat union branches being a struct (because they will be inlined)
>> prevents the use of type-refs that are valid in simple unions (where
>> those simple types will be wrapped in an implicit struct).=C2=A0 A patch
>> to improve the docs would be a reasonable idea.
>>
>
> Yes. I was working on a YAML prototype and I am trying to follow the
> existing parser as closely as possible. In some cases, this highlights
> differences between the grammar as advertised and what the parser
> actually does.

Please report all such differences, so we can fix them.

> If we are to keep the current state of things, splitting UNION into
> two separate productions might be nice.

It *is* two productions, joined with |.

The work unions really, really need is:

* Eliminate the simple union sugar.

* Make flat unions less cumbersome to write.  I'd like to fuse struct
  and union into a single object type, like introspect.json already
  does.

The former is a matter of massaging the schema and simplifying code.
The latter requires actual thought.  No big deal, just takes time, and
time is always in short supply.


