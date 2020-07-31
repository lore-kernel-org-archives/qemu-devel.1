Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF31AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 12:56:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1F52087C
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 12:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QPbabUG7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1F52087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1UaR-00016I-2e
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 08:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k1UZn-0000ad-69
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 08:55:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33639
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k1UZj-00045Y-12
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 08:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596200149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VbV8d5L7PB8rKT6CdqMjhFqSBLOM0d/VpPvouWLvXjQ=;
 b=QPbabUG7+rskvhFA6bIa22p441IPV71KF8kb8NmM7lzL9wir2tciENgUZnLL/Ic+wMpc5y
 R4FTn6EYhEtZLzLBSM0HhoFXEAOU3OmhteiRfWS34HJLOHieAr+H8i9bHtINRg6uEyTD/x
 PztpMSW1R+pZ8cUmVkBF0334QP78LcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-4vyRVeIAN0CqOI_mEexeBA-1; Fri, 31 Jul 2020 08:55:46 -0400
X-MC-Unique: 4vyRVeIAN0CqOI_mEexeBA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F95159;
 Fri, 31 Jul 2020 12:55:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CC295D9F1;
 Fri, 31 Jul 2020 12:55:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AD6551132FD2; Fri, 31 Jul 2020 14:55:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] schemas: Add vim modeline
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
 <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <20200730132446.GL3477223@redhat.com>
Date: Fri, 31 Jul 2020 14:55:34 +0200
In-Reply-To: <20200730132446.GL3477223@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Thu, 30 Jul 2020 14:24:46 +0100")
Message-ID: <875za33ku1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 08:55:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Jul 30, 2020 at 01:51:10PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> >                               modify them so that we can load the=20
>> > files straight into the python intepretor as code, and not parse=20
>> > them as data. I feel unhappy about treating data as code though.
>>=20
>> Stress on *can* load.  Doesn't mean we should.
>>=20
>> Ancient prior art: Lisp programs routinely use s-expressions as
>> configuration file syntax.  They don't load them as code, they read them
>> as data.
>>=20
>> With Python, it's ast.parse(), I think.
>
> Yes, that could work
>
>
>> > struct: ImageInfoSpecificQCow2
>> > data:
>> >   compat: str
>> >   "*data-file": str
>> >   "*data-file-raw": bool
>> >   "*lazy-refcounts": bool
>> >   "*corrupt": bool
>> >   refcount-bits: int
>> >   "*encrypt": ImageInfoSpecificQCow2Encryption
>> >   "*bitmaps":
>> >     - Qcow2BitmapInfo
>> >   compression-type: Qcow2CompressionType
>> >
>> >
>> > Then we could use a regular off the shelf YAML parser in python.
>> >
>> > The uglyiness with quotes is due to the use of "*". Slightly less ugly
>> > if we simply declare that quotes are always used, even where they're
>> > not strictly required.
>>=20
>> StrictYAML insists on quotes.
>
> I wouldn't suggest StrictYAML, just normal YAML is what pretty much
> everyone uses.
>
> If we came up with a different way to mark a field as optional
> instead of using the magic "*" then we wouldn't need to quote
> anything

Nope.

Stupid test script:

    $ cat test-yaml.py
    #!/usr/bin/python3

    import sys, yaml

    data =3D yaml.load(sys.stdin, Loader=3Dyaml.CLoader)
    print(data)

Example taken from block.json:

    $ ./test-yaml.py <<EOF
    enum: FloppyDriveType
    data:
    - 144
    - 288
    - 120
    - none
    - auto
    EOF
    {'enum': 'FloppyDriveType', 'data': [144, 288, 120, 'none', 'auto']}

The upper layer will choke on this:

    qapi/block.yaml: In enum 'FloppyDriveType':
    qapi/block.yaml:61: 'data' member requires a string name

You could propose to provide "wouldn't need to quote anything" by
silently converting numbers back to strings.  I got two issues with
that.

1. What's the point in switching to an off-the-shelf parser to replace
less than 400 SLOC if I then have to write non-trivial glue code to make
the syntax less surprising?

2. Let me trot out the tired Norway problem again.  Say we QAPIfy -k so
that its argument is an enum, for nice introspection.  Something like

    $ ./test-yaml.py <<EOF
    enum: Keymap
    data:
    - ar
    - cz
    - de
    - de-ch
    - en-gb
    - en-us
    - no
    - pt
    - pt-br
    EOF
    {'enum': 'Keymap', 'data': ['ar', 'cz', 'de', 'de-ch', 'en-gb', 'en-us'=
, False, 'pt', 'pt-br']}

To which of the eleven ways to say False in YAML should we convert?

YAML and the schema language are fundamentally at odds here: they fight
over types.  YAML lets the value determine the type regardless of
context.  But in the schema, the context determines the type.

>> I hate having to quote identifiers.  There's a reason we don't write
>>=20
>>     'int'
>>     'main'('int', 'argc', 'char' *'argv'[])
>>     {
>>         'printf'("hello world\n");
>>         return 0;
>>     }
>>=20
>> > struct: ImageInfoSpecificQCow2
>> > data:
>> >   "compat": "str"
>> >   "*data-file": "str"
>> >   "*data-file-raw": "bool"
>> >   "*lazy-refcounts": "bool"
>> >   "*corrupt": "bool"
>> >   "refcount-bits": "int"
>> >   "*encrypt": "ImageInfoSpecificQCow2Encryption"
>> >   "*bitmaps":
>> >     - "Qcow2BitmapInfo"
>> >   "compression-type": "Qcow2CompressionType"
>> >
>> > With the use of "---" to denote the start of document, we have no trou=
ble=20
>> > parsing our files which would actually be a concatenation of multiple=
=20
>> > documents. The python YAML library provides the easy yaml.load_all()
>> > method.
>>=20
>> Required reading on YAML:
>> https://www.arp242.net/yaml-config.html
>
> I don't think this is especially helpful to our evaluation. You can write
> such blog posts about pretty much any thing if you want to pick holes in =
a
> proposal. Certainly there's plenty of awful stuff you can write about
> JSON, and Python.

Picking holes in a proposal is precisely what we need to do before we
act on it and rebase our QAPI schema DSL.  That's expensive and painful,
so we better don't screw it up *again*.

Here's my superficial five minute assessment of the essay's main points
for our use case:

* Insecure by default

  Valid criticism of existing YAML tools, but hardly relevant for us,
  because 1. "don't do that then", and 2. the QAPI schema is trusted
  input.

* Can be hard to edit, especially for large files

  Valid when you use YAML to describe data.  We would use it as an IDL,
  though.  If parts of the interface description get too deeply nested
  or too long for comfort, we better provide means to rearrange it in
  more pleasant ways.  However, if our new base language got
  uncomfortable earlier than the old one, and the existing means to
  rearrange prove to weak (they are pretty weak), then we'd create
  additional work.

  I'm cautiously optimistic that YAML would do okay here.

* It=E2=80=99s pretty complex

  If you go "we'll use only a simple subset", then I go "define the
  subset, and tell me how to enforce the subset.  I have no interest in
  teaching contributors one by one which of the nine ways to write a
  multiline string to avoid, or which of the eleven ways to say False to
  use.

* Surprising behavior

  See "fight over types" above.

* It=E2=80=99s not portable

  Probably irrelevant, because feeding the schema to another YAML parser
  is so unlikely to be useful.

>> Some of the criticism there doesn't matter for our use case.
>
> Yeah, what matters is whether it can do the job we need in a way that is
> better than what we have today, and whether there are any further options
> to consider that might be viable alternatives.

Would it improve things enough to be worth the switching pain?


