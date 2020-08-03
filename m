Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1C6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27CC8206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 07:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gW0fqZba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27CC8206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2UuO-0000pD-UJ
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 03:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2UtX-0000Ky-MA
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 03:28:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54116
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2UtV-0005ko-2S
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 03:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596439704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4X4Bd22jjViqVhM3Nz9wLcuFN7+oimeGR03nrXxz5kE=;
 b=gW0fqZbanwiBoLjlii+t5B+ScBwTnAC5BSqsd2juNX9xjCkyIvjsiuh2rdxkVvD7cznwEC
 SasCAU6rBwbGE9l6kceHFr0PtK8bsIWZf+YZQLkFvRjthtsQant1MjlfYZo8RBkMS/otrE
 5dnFePfP+VNbgrOIH978x/UAqlnJK0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-EwnmU30UMkqt7XmoE1dwvw-1; Mon, 03 Aug 2020 03:28:22 -0400
X-MC-Unique: EwnmU30UMkqt7XmoE1dwvw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AB871800D42;
 Mon,  3 Aug 2020 07:28:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1324087E26;
 Mon,  3 Aug 2020 07:28:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9324F1132FD2; Mon,  3 Aug 2020 09:28:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
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
Date: Mon, 03 Aug 2020 09:28:09 +0200
In-Reply-To: <20200731154429.GD3660103@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Fri, 31 Jul 2020 16:44:29 +0100")
Message-ID: <87r1soi3xy.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Juan Quintela <quintela@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
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

> On Fri, Jul 31, 2020 at 11:26:28AM -0400, John Snow wrote:
>> > The long answer is that as a general philosophy I'm in favour of agres=
sively
>> > eliminating anything that is custom to a project and isn't offering an
>> > compelling benefit over a functionally equivalent, commonly used / sta=
ndard
>> > solution.
>> >=20
>>=20
>> I agree as violently as I know how. The purpose of this is not for us, i=
t's
>> for the ecosystem.
>>=20
>> I saw the critique that we still use JSON-ish for the runtime QMP protoc=
ol,
>> and moving the QAPI IDL to a standard wouldn't remove all instances of a
>> custom format from our tree.
>
> I'd consider the runtime protocol separately. In terms of what's on the
> wire, we use genuine JSON format.

Yes.

Fine print: QMP accepts (but does not emit) minor extensions[*].  RFC
8592 actually permits this: "A JSON parser MAY accept non-JSON forms or
extensions."  This is due to lazy implementation, not due to an actual
need.  We could deprecate and remove.

>                                   The Runtime problem is simply that JSON
> standard is useless when it comes to integers, leaving behaviour undefine=
d
> in the standard if you exceed 53 bits of precision. So there's no way to
> reliably parse unsigned 64-bit integers. Given that QEMU needs to pass
> uint64 values, JSON was simply the wrong choice of format for QMP.

To be precise: "An implementation may set limits on the range and
precision of numbers."  Not quite undefined behavior.  Useless all the
same.  There are more interoperability pitfalls due to JSON's
notoriously useless minimal requirements.  Range of numbers is the most
relevant one, because so many implementations set useless numeric
limits, and there is no good way to work around the issue.

> There's a 3rd aspect which is our source code that deals with JSON, where
> we defined some JSON extensions to make it easier for C code to construct
> JSON documents for sending over the wire.

Example: qmp_error_response() uses the interpolation extension to safely
insert values into a JSON syntax tree.

    rsp =3D qdict_from_jsonf_nofail("{ 'error': { 'class': %s, 'desc': %s }=
 }",
                                  QapiErrorClass_str(error_get_class(err)),
                                  error_get_pretty(err));

Two extensions, actually:

1. Interpolation: tokens starting with % get replaced by the
   corresponding variable argument converted to a QObject.

2. Single-quoted strings to avoid leaning toothpick syndrome.

Without interpolation, we'd have to construct the tree by hand, like
this:

    error =3D qdict_new();
    qdict_put_str(error, "class", QapiErrorClass_str(error_get_class(err)),
    qdict_put_str(error, "desc", error_get_pretty(err));
    rsp =3D qdict_new();
    qdict_put(rsp, error);

Much harder to read even for such a simple example.

>                                           Back when we did this, it was a
> reasonably good idea as no obvious alternative existed for this problem.
> Today, I would just suggest using GLib's  GVariant feature, which solves
> the same problem for GLib's DBus APIs.
>
> It is a shame we didn't just use DBus back in the day as that's a well
> specified, simple protocol that would have done everything we needed,
> including the ability to actually represent integers reliably. We
> would be able to trivially talk to QEMU from any programming language,
> and use common DBus code-generator tools instead of writing code
> generators ourselves.

Water under the bridge.

[...]

[*] Single-quoted strings and \' in strings.


