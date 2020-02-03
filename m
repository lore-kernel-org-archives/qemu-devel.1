Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23D6C35249
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2B7521775
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WEjI5E+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B7521775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyebM-0000IB-UQ
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 11:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iyea0-00075b-Cc
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iyeZy-000680-1y
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:28:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29856
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iyeZx-00066v-UB
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580747285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GA55x0fjvV7vPI718+tO3D63guIP7Bk72KBM8Xtjy0M=;
 b=WEjI5E+RRL9Fb2pVU19uaSVgWpClIjlkO94b1/HEEhcAHo3R8XzVknwWDlOHDFRvBjXxDl
 ejp4SQXBNoKFDvE2xnl5rr/xJ7ItKYFtW5kX+x+OdLej5PWlGjhSFLIJS7OBQDAQCfA8XG
 OQTC3aSYpIEj07iux0GWCiR1h0WPYc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-kx51HDpkM4ubBk-paBs2AA-1; Mon, 03 Feb 2020 11:27:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D75CE800D41;
 Mon,  3 Feb 2020 16:27:43 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3A2B811F8;
 Mon,  3 Feb 2020 16:27:40 +0000 (UTC)
Subject: Re: Does Libvirt's json parser support single quoted string in qmp
 json string?
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <ADDDD4B8-45AD-4D79-9332-06F2A50B26CE@sina.com>
 <9bac386b-5a90-3c10-b63b-d45a2e8c2d58@redhat.com>
 <20200203101352.GB1922177@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1f285f58-7a8f-0656-4f0a-8acfe56bad43@redhat.com>
Date: Mon, 3 Feb 2020 10:27:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203101352.GB1922177@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: kx51HDpkM4ubBk-paBs2AA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: libvirt-users@redhat.com, Peter Luo <d8514@sina.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[adding Markus]

On 2/3/20 4:13 AM, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Jan 31, 2020 at 06:44:42AM -0600, Eric Blake wrote:
>> On 1/31/20 4:38 AM, Peter Luo wrote:
>>
>>> error: internal error: cannot parse json {"execute": "block-commit", "a=
rguments": { "device": "drive-virtio-disk2", "job-id": "job100", "base":'js=
on:{"encrypt.key-secret":"vol-38973xjl.secret","driver":"qcow2","file":{"dr=
iver":"file","filename":"/pitrix/data/container/vol-38973xjl.img"}}', "top"=
: "/pitrix/data/container/vol-38973xjl_ss-2tw7v0mm.img"}}: lexical error: i=
nvalid char in json text.
>>>
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 , "job-id": "j=
ob100", "base":'json:{"encrypt.key-secret":"vo
>>>
>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (right here) ------^
>>>
>>
>> qemu's QMP language has an extension where it accepts 'string' in additi=
on
>> to the JSON "string".  But it uses a hand-rolled parser, so it can do
>> whatever it wants.
>=20
> Can we deprecate & remove this extension in QEMU ?

We could start a deprecation clock, if desired, but I don't know how=20
many external users would be impacted (at least qemu's testsuite heavily=20
relies on the extension of single quotes).

Are there any third-party libraries that parse JSON5?=20
https://json5.org/ documents that one of the nice features of JSON5 is=20
that single quotes work out of the box.  Right now, even though qemu=20
does NOT parse the same thing as pure JSON (which is=20
https://datatracker.ietf.org/doc/rfc8259/), it does appear to parse a=20
subset of JSON5, where the additional features of JSON5 (such as=20
allowing a trailing comma, escaped newlines within strings, allowing=20
bareword key:"value" syntax, a larger set of accepted numeric values,=20
allowing comments) don't seem that onerous.

>=20
> If we're going to call QMP protocol JSON, then IMHO QEMU should follow
> the JSON spec as closely as possible, without extensions.

As it is, qemu explicitly does NOT parse all valid JSON - it rejects=20
non-ASCII bytes (whether as UTF-8 or as \u escape sequences) in strings.=20
  So the fact that it already extensions in some places and limitations=20
in others is a burden for clients to be aware of.

>=20
> On the flip side, if we're going to support extensions like single quotin=
g,
> then we should make it clear to applications that this is not really JSON
> and that they need to provide an impl that is 100% matching QEMU's dialec=
t.
> This effectively means they need just import a copy of QEMU's code.
>=20
> Regards,
> Daniel
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


