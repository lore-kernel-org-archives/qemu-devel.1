Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B949DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8172020738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 11:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THF+ShGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8172020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2YbN-0004Cq-JQ
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 07:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2YaV-0003CC-NO
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:25:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21125
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2YaS-0005jE-TQ
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 07:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596453899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eCndamxCg5Er1Eqf1yYE2PkaSpc9LohO2q6jxr6CIh4=;
 b=THF+ShGtlimU9s+HgoPTfl3SPx7nwM4rgprhO2vMd647mq+dVi0ueGBHxZpCDyOu+Kap2b
 7bz+ypVzePLNm/+NvwGk01epJw6pa8JuWDZG4dIDJT2xMcG1bT8eUrzq0T6W8xgAvwyJlV
 KvN4+DcYmPYpzwQvYezVeDC58knk8TE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-1NKJt8_nNlGwkwP7tKpmag-1; Mon, 03 Aug 2020 07:24:56 -0400
X-MC-Unique: 1NKJt8_nNlGwkwP7tKpmag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA836106B242;
 Mon,  3 Aug 2020 11:24:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8DB217150;
 Mon,  3 Aug 2020 11:24:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5DA0A1132FD2; Mon,  3 Aug 2020 13:24:44 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] schemas: Add vim modeline
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
 <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org>
 <20200731150738.GB3660103@redhat.com>
 <03bb7822-20a0-2945-6c86-1d5f1b2a01d9@redhat.com>
 <20200731154429.GD3660103@redhat.com>
 <21cda868-85d3-77db-31d8-0248a5029318@redhat.com>
Date: Mon, 03 Aug 2020 13:24:44 +0200
In-Reply-To: <21cda868-85d3-77db-31d8-0248a5029318@redhat.com> (Paolo
 Bonzini's message of "Mon, 3 Aug 2020 10:41:22 +0200")
Message-ID: <87k0ygkm4j.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:56:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 31/07/20 17:44, Daniel P. Berrang=C3=A9 wrote:
>> I'd consider the runtime protocol separately. In terms of what's on the
>> wire, we use genuine JSON format. The runtime problem is simply that JSO=
N
>> standard is useless when it comes to integers, leaving behaviour undefin=
ed
>> in the standard if you exceed 53 bits of precision. So there's no way to
>> reliably parse unsigned 64-bit integers. Given that QEMU needs to pass
>> uint64 values, JSON was simply the wrong choice of format for QMP.
>
> JSON's 53-bit precision was not part of RFC4627, which was the JSON
> specification in 2010.  They say hindsight is 20/20, but referring to
> RFC7159 which would come 4 years later is rewriting history, not hindsigh=
t.

RFC 4627's original sin:

    4.  Parsers
    [...]
    An implementation may set limits on the size of texts that it
    accepts.  An implementation may set limits on the maximum depth of
    nesting.  An implementation may set limits on the range of numbers.
    An implementation may set limits on the length and character contents
    of strings.

Giving license to set limits is not a sin, absence of minimal limits is.

Became an actual problem only when many implementations followed the
early JavaScript implementation(s), which had inherited JavaScript's
quick-and-dirty approach to numerical towers: double should be enough
for anybody.

>> There's a 3rd aspect which is our source code that deals with JSON, wher=
e
>> we defined some JSON extensions to make it easier for C code to construc=
t
>> JSON documents for sending over the wire. Back when we did this, it was =
a
>> reasonably good idea as no obvious alternative existed for this problem.
>> Today, I would just suggest using GLib's  GVariant feature, which solves
>> the same problem for GLib's DBus APIs.
>
> Many years ago actually I tried replacing QObject with GVariant.  I'm
> pretty sure the code for that experiment is lost but it took me just a
> couple days so it could be redone.  The only issue was that QObjects are
> mutable so some instances of QString had to be replaced with GString.
>
> (A small part of it was merged as commit
> 9bada8971173345ceb37ed1a47b00a01a4dd48cf for unrelated reasons).
>
>> It is a shame we didn't just use DBus back in the day as that's a well
>> specified, simple protocol that would have done everything we needed,
>> including the ability to actually represent integers reliably. We
>> would be able to trivially talk to QEMU from any programming language,
>> and use common DBus code-generator tools instead of writing code
>> generators ourselves.
>
> Not really, DBus doesn't provide the extensibility that we get from
> optional arguments in commands and optional fields in structs.

Enables compatible evolution of interfaces, which has been a massive win
for us.

>                                                                 Again,
> we may discuss the QMP protocol itself,

We can discuss everything, but please not everything in the same thread.
This one is / tries to be about the QAPI schema language.

>                                         but JSON *was chosen for a reason=
*.

In our field, dissing prior technical choices without making an effort
to understand the tradeoffs that led to them is an ancient tradition :)


