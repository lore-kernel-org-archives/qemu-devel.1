Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7009C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BE320781
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 15:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPb5pwdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BE320781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2ciQ-0004MQ-Ou
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 11:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2chr-0003ot-MR
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 11:48:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34032
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2chp-0008Tu-BZ
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 11:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596469731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bpu7VVRy6Yht5APBWZdJUTgcWt01v1YLw8FSA7hu/pk=;
 b=iPb5pwdrtNRUgUombKMyigJA/5kQO8S7fF/iadZatL3fLb4uHsIzXRG+OqqrdqLTzJCKdj
 miee18Hoi238TnF0RFdAgKWYTNkdBs+FFHNLJDO2WNUdTzYKTHwG6XXdzlKKVglYVCwGp6
 KAurfMqgz+cXECTfHD6cyRVWl2Tw9qw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-EstMKDWnOmCk9u8bzBjOOg-1; Mon, 03 Aug 2020 11:48:49 -0400
X-MC-Unique: EstMKDWnOmCk9u8bzBjOOg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D911C79ECD;
 Mon,  3 Aug 2020 15:48:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ADB8110027A6;
 Mon,  3 Aug 2020 15:48:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3D4641132FD2; Mon,  3 Aug 2020 17:48:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] schemas: Add vim modeline
References: <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org>
 <20200731150738.GB3660103@redhat.com>
 <03bb7822-20a0-2945-6c86-1d5f1b2a01d9@redhat.com>
 <20200731154429.GD3660103@redhat.com>
 <21cda868-85d3-77db-31d8-0248a5029318@redhat.com>
 <20200803113655.GI3670709@redhat.com>
 <fcc9056d-4d72-5bdb-bd21-2bf6213f5a55@redhat.com>
 <20200803122304.GJ3670709@redhat.com>
Date: Mon, 03 Aug 2020 17:48:35 +0200
In-Reply-To: <20200803122304.GJ3670709@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Mon, 3 Aug 2020 13:23:04 +0100")
Message-ID: <875z9zivcc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:37:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Aug 03, 2020 at 02:16:19PM +0200, Paolo Bonzini wrote:
>> On 03/08/20 13:36, Daniel P. Berrang=C3=A9 wrote:
>> >>> Given that QEMU needs to pass
>> >>> uint64 values, JSON was simply the wrong choice of format for QMP.
>> >
>> > I wasn't refering to RFC7159. The problem of undefined integer precisi=
on
>> > with JSON came up right at the very start when QMP was first designed =
and
>> > implemented, and has come up again periodically ever since then. libvi=
rt
>> > needed to do workarounds right at the start in 2009, in order to fully
>> > handle signed/unsigned 64-bit integers with QMP.
>>=20
>> I assume the workaround you refer to is to store the number as a string
>> and converting it lazily to either an integer or a floating-point type
>> in whoever uses the JSON API.  It may not be pretty but probably it
>> would have been the same for any text-based, schema-less protocol.  For
>> example, it didn't require writing your own parser.
>
> Yes, we get the raw values as a string, but not all parsers for C
> allow you to do this.  We'd really love to move off YAJL for JSON
> parsing, but the most viable alternatives don't have a way to let
> you get the string before they parse it as an integer and report
> errors.

You know, if I had to write a *general purpose* parser for a language
that obviously supports numbers of arbitrary precision (but permits
implementations to support less), then I'd try *hard* to stay as general
as practical.  At the very least, provide a way to retrieve number
tokens as strings, so the decision to limit precision devolves to the
client.  Also, GMP exists.

The fact that "most viable alternatives" to YAJL are unable to support
uint64_t tempts me to condemn the whole lot as toys :)

I suspect the simplicity of JSON not only lowers the barrier for toys,
but also dampens the demand for general purpose non-toys.  Writing and
maintaining yet another JSON parser is quite possibly easier than
getting one of the toys fixed up properly.

[...]


