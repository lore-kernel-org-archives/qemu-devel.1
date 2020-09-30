Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D560C4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2B102076E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 13:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcPDQnkN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B102076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNbwy-0000IS-TF
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 09:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNbw6-0007si-R2
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:14:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNbw4-0003BF-LL
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 09:14:22 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601471659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4TccTHfaLf8QXZ7cHaQ24ir5GkVtE9UhjL3TUbKVseU=;
 b=BcPDQnkNJ1frwUFBFCJ47Zbyoz56DArfcH+3sBxTPyabOh8pWwZuz1XQj5MLNirVMtVvP2
 TbDjT2NCIa2riTV/eh4M6fX111kDT2kDrUyX1Ef9Bnjc/SYowp/wIWPqEyVbDZk40yZPSk
 zd/4i9GrOw+r3R1I66UxHjfG8lHIyKY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-BmGeB6F_PjaX9okqxbVLAw-1; Wed, 30 Sep 2020 09:14:16 -0400
X-MC-Unique: BmGeB6F_PjaX9okqxbVLAw-1
Received: by mail-wm1-f71.google.com with SMTP id r83so609595wma.8
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 06:14:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4TccTHfaLf8QXZ7cHaQ24ir5GkVtE9UhjL3TUbKVseU=;
 b=fE+9rX+W15sScvGYRnr7jmP2Sj4qv51gcSzjmuKdvLNesIEZTGLEdtuCFdnlaSV2BN
 vdyvpZadZ5VQbxMkgXBXLdlndhJ5NbE6bJS5cPWK09kLn39fAHKtPUq4l+gI+Z23minP
 m/tyMzWJv/8mNer/ZZVFsuIbZeYXdocsiFWRnFq4UqOnxkho1iVor9z9dUjWsqI1iLKy
 y0PZuyKNhdVyaMbGLrz75HWLckoFnNCRK1qKqglW+++VdH6wBrep+XKWMHtUfNk14nm2
 ylZMWmA1UsVHPSqVjZMxYbE6Vy/qBs7fVEfjuMTR4QGO38D4YLnT4rLKETMRCNcF9CTQ
 ZTxg==
X-Gm-Message-State: AOAM533jnDGmUqKkzSCVcarVckQ/lGoJzoGoIMJF2otcZwpBFK4CTfwB
 JaDSBu87LRb8W8/Nk7zJaww1tQuwU3LUaFpl7QOohPb6RhPhv/MykmaCnOEm0/Hlz5wWaHZBYF5
 v3/uHzBrHHmFDiuA=
X-Received: by 2002:a1c:4e02:: with SMTP id g2mr2886443wmh.3.1601471655556;
 Wed, 30 Sep 2020 06:14:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKru4LhI4cCumkgFTcwlHx/IjO5u2CuS3AabZkZcoDnQnryQBZRfsywIcOD/gXoBls0DGfMw==
X-Received: by 2002:a1c:4e02:: with SMTP id g2mr2886413wmh.3.1601471655239;
 Wed, 30 Sep 2020 06:14:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:75e3:aaa7:77d6:f4e4?
 ([2001:b07:6468:f312:75e3:aaa7:77d6:f4e4])
 by smtp.gmail.com with ESMTPSA id r14sm2924013wrn.56.2020.09.30.06.14.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 06:14:14 -0700 (PDT)
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
 <87mu1j8p7p.fsf@dusky.pond.sub.org>
 <CAMxuvayvRfjUMYDiB5fm5QBD76kfD8-G1wTEucQTBbZUtnwXrA@mail.gmail.com>
 <874knpluez.fsf@dusky.pond.sub.org>
 <CAJ+F1CLCT3RpZF8JDYayqkKxFu76vy+q6GUjofZV3JF_YDvxng@mail.gmail.com>
 <9d6215d4-d0cd-67e4-3048-77127194f7e8@redhat.com>
 <CAJ+F1CLowpdHaJ58Vt7GYukAYvYAfuEJvnuw_ZM5kO_4=gh9XA@mail.gmail.com>
 <8c1783d1-70f4-d751-3d5d-83459cb1db45@redhat.com>
 <CAJ+F1CJgEe3++UHDfT3iOGyu+r1tM4A_9jRXoKC0P-k-Mhq29w@mail.gmail.com>
 <fb20f8e4-6bc9-3518-a983-86fad1915e49@redhat.com>
 <CAJ+F1C+p-JLj_epZfLiag7CdJGfZUkFNOmzPTsjCkW=QQ07_3g@mail.gmail.com>
 <87r1qjhg5w.fsf@dusky.pond.sub.org>
 <CAJ+F1CJD2hNLxbGijxA_Dc=JpGjFm3cc-_3PVpPj8088SLXVJQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <64b791d7-05d1-5ae6-5721-9a86b73baeba@redhat.com>
Date: Wed, 30 Sep 2020 15:14:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJD2hNLxbGijxA_Dc=JpGjFm3cc-_3PVpPj8088SLXVJQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: John Snow <jsnow@redhat.com>, "Hajnoczi, Stefan" <stefanha@gmail.com>,
 "P. Berrange, Daniel" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Sergio Lopez Pascual <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/09/20 09:51, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Sep 30, 2020 at 11:34 AM Markus Armbruster <armbru@redhat.com
> <mailto:armbru@redhat.com>> wrote:
> 
>     Marc-André Lureau <marcandre.lureau@gmail.com
>     <mailto:marcandre.lureau@gmail.com>> writes:
> 
>     > Hi
>     >
>     > On Tue, Sep 29, 2020 at 3:01 PM Paolo Bonzini <pbonzini@redhat.com
>     <mailto:pbonzini@redhat.com>> wrote:
>     [...]
>     >> Marc-André, we are totally in agreement about that!  The problem
>     is that
>     >> you have already decided what the solution looks like, and that's
>     what
>     >> I'm not sure about because your solution also implies completely
>     >> revisiting the schema.
>     >>
>     >
>     > Did I? Which schema change are you (or I) implying? Versioning the
>     > interface? It's necessary at the client level, unless everything is
>     > dynamic, after introspection, which makes automated static bindings
>     > impractical.
> 
>     I disagree with "necessary".
> 
>     A client can use a specific version of QMP, and still talk to a server
>     with a different version, because we designed that capability into QMP.
> 
>  "A client can use a specific version of QMP" == versioning on the
> client side

No: "a client can use code generated for a specific version of QMP" does
not imply versioning on the client side.  It does imply that, before
using *certain* features, the client must verify that they are
implemented in the server.

>     1. Opaque dictionaries are far from the only way to do keyword arguments
>     in a language that lacks them.
> 
> Oh one can always be creative. The point is trying to stay idiomatic in
> the target language.

And builders in Rust, or keyword arguments in Python, are perfectly
idiomatic.

> Or a badly designed QMP command.
> Or a badly designed QMP command ?

Great.  Do you have ideas around how to design good QMP commands?  It
doesn't have to be patches for code, just documentation.

>     > varlink does non-optional members and versioning the same way I propose
>     > here, for what I could tell. Although they use JSON, and have similar
>     > transport "benefits", this basic rule allow them to have very decent
>     > automated binding in various languages, without resorting to
>     unorthodox
>     > solutions, ex:
>     >
>     https://github.com/varlink/rust/blob/master/examples/example/src/main.rs
> 
>     Paolo pointed out successful protocols that make tradeoffs similar to
>     QMP to support the idea that these tradeoffs can make sense and are
>     workable.
> 
>     Pointing out other, dissimilar protocols is not a convincing
>     counter-argument :)
> 
> It's relevant. Did you study varlink a bit? It's so close to QMP, you
> will find it hard to point out real dissimilarities.

I played a bit with varlink, and it seems to me that varlink does
actually support QMP-/OpenAPI-like extensibility.  Missing nullable
fields are treated as null, and on the client side it generally does not
give an error if it receives unknown fields (just like QMP). [1]  Also
just like QMP there are limits to the server's liberality, for example
sending extra fields to the server is an error.

In fact I could have skipped the experiments and read the Varlink
documentation: :)

  Varlink interfaces do not have a version number, they only have a
  feature set described in detail by the interface definition, which is
  part of the wire protocol.

  If your interface has users, you should not break the interface, only
  extend it, never remove or incompatibly change things which might be
  already in use.

  [...]

  Varlink does not use positional parameters or fixed-size objects in
  its interface definition or on the wire, all parameters are identified
  by their name and can be extended later.

  Extending existing structures should be done via optional fields
  (nullable type, maybe). The result of the methods, when passed
  parameters without the optional fields should be the same as in older
  versions. Method parameters can be extended the same way. The expected
  behavior for omitted fields/parameters should be documented. Removing
  fields, types, errors or methods are not backward compatible and
  should be avoided.

which is pretty much what QMP does.  So even though some users of
varlink might have chosen to rein themselves in on the extensibility
allowed by Varlink, that's a self-imposed limitation.  It may be due to
the desire to interoperate with varlink language bindings that use
positional parameters, but that's again a limitation of the bindings and
not the protocol.

So I don't see varlink as a reason to change the existing practice for
QMP, more as a second example of someone else doing the same as QMP.

Again, I'm not saying that DBus's choice with respect to versioning and
backwards/forwards-compatibility is _wrong_.  I do not like Protobuf's
numbered fields for that matter either, but it's not wrong either.  I am
saying that the choices in QMP are one of many different tradeoffs, and
that there's no point in saying that they get in the way of writing
language bindings or even just in the way of writing good/idiomatic
language bindings, because they don't.

Paolo




[1] Try this:

$ git clone git://github.com/bonzini/python
$ git checkout nullable-ping
$ python3 -m varlink.tests.test_orgexamplemore --varlink="unix:/tmp/test" &

And then:

$ varlink info unix:/tmp/test org.example.more
...
method Ping(ping: ?string) -> (pong: ?string)
...
$ python -m varlink.cli call unix:/tmp/test/org.example.more.Ping '{}'
{
  "pang": "xxx",
  "pong": null
}

You can see that the argument was implicitly treated as null, and there
were no complaints about the extra returned field.

I didn't try returning extra fields with the Rust bindings, but I did
try optional arguments and they work fine.  A "recent" client with
optional argument can talk to an "old" server with non-optional
argument, and it will only fail if the client actually takes advantage
of the newer interface.  As long as the argument is there, everything
works just fine.


