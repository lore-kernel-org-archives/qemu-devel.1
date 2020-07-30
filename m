Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6DEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:52:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E0220829
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MakCIikZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E0220829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k176b-0002KE-50
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 07:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k1760-0001oi-C3
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 07:51:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52697
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k175x-0000Ye-EE
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 07:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596109891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReJQ/vS/w4bC8U7HYAisGvde+/fEa31MuFNFVdxMWkU=;
 b=MakCIikZkJBti6JjGb9/7Ue/cd7Yqrdg24zNjsBRy/t/ziIaZAl1OtmfBCPwOLkzON4d0U
 MEhbDAVAhPFhGdTkgV06/YyJzFyJYyla22wJC6RlTqiKVy4eDL7nFOrb72IVPKlhGUYWFg
 P3P5qowUeM7VAKemzAwCL09NCwnf4ds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-2SgyzoZNOMCX4G6ebvTi_g-1; Thu, 30 Jul 2020 07:51:27 -0400
X-MC-Unique: 2SgyzoZNOMCX4G6ebvTi_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F2BB19200DD;
 Thu, 30 Jul 2020 11:51:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D3E28A191;
 Thu, 30 Jul 2020 11:51:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 18D621132FD2; Thu, 30 Jul 2020 13:51:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] schemas: Add vim modeline
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
 <20200730093732.GB3477223@redhat.com>
Date: Thu, 30 Jul 2020 13:51:10 +0200
In-Reply-To: <20200730093732.GB3477223@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Thu, 30 Jul 2020 10:37:32 +0100")
Message-ID: <87k0ylz0ep.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 03:59:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Jul 30, 2020 at 11:07:26AM +0200, Markus Armbruster wrote:
>> Andrea Bolognani <abologna@redhat.com> writes:
>>=20
>> > The various schemas included in QEMU use a JSON-based format which
>> > is, however, strictly speaking not valid JSON.
>> >
>> > As a consequence, when vim tries to apply syntax highlight rules
>> > for JSON (as guessed from the file name), the result is an unreadable
>> > mess which mostly consist of red markers pointing out supposed errors
>> > in, well, pretty much everything.
>> >
>> > Using Python syntax highlighting produces much better results, and
>> > in fact these files already start with specially-formatted comments
>> > that instruct Emacs to process them as if they were Python files.
>> >
>> > This commit adds the equivalent special comments for vim.
>> >
>> > Signed-off-by: Andrea Bolognani <abologna@redhat.com>
>
> Given that we already have emacs mode-lines, I see no reason to
> not also have vim mode-lines, so regardless of the deeper discussion
> I think this is patch is fine to merge in the short term
>
>   Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
>> Naming QAPI schema files .json even though their contents isn't was a
>> mistake.  Correcting it would be a pain.  If we correct it, then the
>> sooner the better.
>>=20
>> Renaming them to .py gives decent editor support out of the box.  Their
>> contents isn't quite Python, though: true vs. True, false vs. False.  Do
>> we care?  Only a few dozen occurences; they could be adjusted.
>>=20
>> Renaming them to .qapi would perhaps be less confusing, for the price of
>> "out of the box".
>
> IMHO, the critical rule is that if you a pick a particular file extension
> associated with an existing language, you absolutely MUST BE compliant
> with that language.

Can't argue with that :)

> We fail at compliance with both JSON and Python because we're actually
> using our own DSL (domain specific language).
>
> IOW if we're going to stick with our current file format, then we should
> be naming them .qapi. We can still use an editor mode line if we want to
> claim we're approximately equiv to another language, but we can't be
> surprised if editors get upset.
>
>
> The bigger question is whether having our own DSL is justified ?
>
> I'm *really* sceptical that it is.

To be precise: our own DSL *syntax*.  Semantics is a separate question
to be skeptical about.

> We can't use JSON because it lacks comments. So we invented our own
> psuedo-JSON parser that supported comments, and used ' instead of "
> for some reason. We also needed to be able to parse a sequence of
> multiple JSON documents in one file. We should have just picked a=20
> different language because JSON clearly didn't do what we eneeded.

JSON is a exceptionally poor choice for a DSL, or even a configuration
language.

Correcting our mistake involves a flag day and a re-learn.  We need to
weigh costs against benefits.

The QAPI schema language has two layers:

* JSON, with a lexical and a syntactical sub-layer (both in parser.py)

* QAPI, with a context-free and a context-dependend sub-layer (in
  expr.py and schema.py, respectively)

Replacing the JSON layer is possible as long as the replacement is
sufficiently expressive (not a tall order).

> You suggest naming them .py. If we do that, we must declare that they
> are literally Python code

Agree.

>                               modify them so that we can load the=20
> files straight into the python intepretor as code, and not parse=20
> them as data. I feel unhappy about treating data as code though.

Stress on *can* load.  Doesn't mean we should.

Ancient prior art: Lisp programs routinely use s-expressions as
configuration file syntax.  They don't load them as code, they read them
as data.

With Python, it's ast.parse(), I think.

> While JSON doesn't do what we need, its second-cousin YAML is a more
> flexible format. Taking one example
>
> ---
> ##
> # @ImageInfoSpecificQCow2:
> #
> # @compat: compatibility level
> #
> # ...snip...
> #
> # Since: 1.7
> ##
> struct: ImageInfoSpecificQCow2
> data:
>   compat: str
>   "*data-file": str
>   "*data-file-raw": bool
>   "*lazy-refcounts": bool
>   "*corrupt": bool
>   refcount-bits: int
>   "*encrypt": ImageInfoSpecificQCow2Encryption
>   "*bitmaps":
>     - Qcow2BitmapInfo
>   compression-type: Qcow2CompressionType
>
>
> Then we could use a regular off the shelf YAML parser in python.
>
> The uglyiness with quotes is due to the use of "*". Slightly less ugly
> if we simply declare that quotes are always used, even where they're
> not strictly required.

StrictYAML insists on quotes.

I hate having to quote identifiers.  There's a reason we don't write

    'int'
    'main'('int', 'argc', 'char' *'argv'[])
    {
        'printf'("hello world\n");
        return 0;
    }

> struct: ImageInfoSpecificQCow2
> data:
>   "compat": "str"
>   "*data-file": "str"
>   "*data-file-raw": "bool"
>   "*lazy-refcounts": "bool"
>   "*corrupt": "bool"
>   "refcount-bits": "int"
>   "*encrypt": "ImageInfoSpecificQCow2Encryption"
>   "*bitmaps":
>     - "Qcow2BitmapInfo"
>   "compression-type": "Qcow2CompressionType"
>
> With the use of "---" to denote the start of document, we have no trouble=
=20
> parsing our files which would actually be a concatenation of multiple=20
> documents. The python YAML library provides the easy yaml.load_all()
> method.

Required reading on YAML:
https://www.arp242.net/yaml-config.html

Some of the criticism there doesn't matter for our use case.


