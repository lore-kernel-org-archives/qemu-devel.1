Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A1EC433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D48921883
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 09:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8m7iHHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D48921883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1QwK-0000Tb-NB
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 05:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k1QvE-0007vy-EU
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 05:01:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27629
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k1QvC-0000V8-3r
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 05:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596186104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=do7hlnBBRk792pSIX1UDPJVJZayUn1eDM3kjoaKSFLk=;
 b=f8m7iHHWFC/l2DyZZOfROdVMv1hLjWfws1xptPLeUP9yUMmzgqaUk3L0fMiR8p/G1ubhS8
 XLhywO8gCJXeTdMgxhzSf21rY30bk9ZY1ATULYriWJ9QPOoMmWOPGVSAVgJqlm9HPgDqaP
 UMU5c2rJLISUTqmEvT2H839lJ5buczc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-m17BVaB6NryruBpO-0Vacg-1; Fri, 31 Jul 2020 05:01:42 -0400
X-MC-Unique: m17BVaB6NryruBpO-0Vacg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C990803822;
 Fri, 31 Jul 2020 09:01:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B317F10013C4;
 Fri, 31 Jul 2020 09:01:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F3531132FD2; Fri, 31 Jul 2020 11:01:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] schemas: Add vim modeline
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
 <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <d3625b38-7f07-ea8b-42c3-1d462d18018f@redhat.com>
 <20200731071513.GA4707@linux.fritz.box>
Date: Fri, 31 Jul 2020 11:01:39 +0200
In-Reply-To: <20200731071513.GA4707@linux.fritz.box> (Kevin Wolf's message of
 "Fri, 31 Jul 2020 09:15:13 +0200")
Message-ID: <875za4t5vw.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 04:33:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 30.07.2020 um 17:11 hat Eric Blake geschrieben:
>> > JSON is a exceptionally poor choice for a DSL, or even a configuration
>> > language.
>> > 
>> > Correcting our mistake involves a flag day and a re-learn.  We need to
>> > weigh costs against benefits.
>> > 
>> > The QAPI schema language has two layers:
>> > 
>> > * JSON, with a lexical and a syntactical sub-layer (both in parser.py)

An incompatible dialect of JSON with a doc comment language, actually.

The need to keep doc generation working could complicate replacing the
lower layer.

>> > 
>> > * QAPI, with a context-free and a context-dependend sub-layer (in
>> >    expr.py and schema.py, respectively)
>> > 
>> > Replacing the JSON layer is possible as long as the replacement is
>> > sufficiently expressive (not a tall order).
>> 
>> I'm open to the idea, if we want to attempt it, and agree with the
>> assessment that it is not a tall order.

Careful, "not a tall order" is meant to apply to the "sufficiently
expressive" requirement for a replacemnt syntax.

On actually replacing the lower layer, I wrote "we need to weigh costs
against benefits."

> I'm not so sure about that. I mean, it certainly sounds doable if need
> be, but getting better syntax highlighting by default in some editors
> feels like a pretty weak reason to switch out the complete schema
> language.
>
> At first I was going to say "but if you don't have anything else to do
> with your time...", but it's actually not only your time, but the time
> of everyone who has development branches or downstream repositories and
> will suffer rather nasty merge conflicts. So this will likely end up
> having a non-negligible cost.

Yup.

> So is there more to it or are we really considering doing this just
> because editors can tell more easily what to do with a different syntax?

If memory serves, the following arguments have been raised:

1. A chance to improve ergonomics for developers

   Pain points include

   - Confusion

     It claims to be JSON, but it's not.

   - Need to learn another syntax

     Sunk cost for old hands, but it's a valid point all the same.

   - Poor tool support

     JSON tools don't work.  Python tools do, but you may have to work
     around the issue of true, false.

   - Excessive quoting

   - Verbosity

     When all you have is KEY: VALUE, defining things with multiple
     properties becomes verbose like

         'status': { 'type': 'DirtyBitmapStatus',
                     'features': [ 'deprecated' ] }

     We need syntactic sugar to keep vebosity in check for the most
     common cases.  More complexity.

   - No trailing comma in arrays and objects

   - No way to split long strings for legibility

   - The doc comment language is poorly specified

   - Parse error reporting could be better (JSON part) / could hardly be
     worse (doc comment part)

2. Not having to maintain our own code for the lower layer

   I consider this argument quite weak.  parser.py has some 400 SLOC.
   Writing and rewriting it is sunk cost.  Keeping it working has been
   cheap.  Keeping the glue for some off-the-shelf parser working isn't
   free, either.  No big savings to be had here, sorry.

   Almost half of parser.c is about doc comments, and it's the hairier
   part by far.  Peter has patches to drag the doc comment language
   closer to rST.  I don't remember whether they shrink parser.py.

3. Make the schema more easily consumable by other programs

   Use of a "standard" syntax instead of our funky dialect of JSON means
   other programs can use an off-the-shelf parser instead of using or
   reimplementing parser.py.

   Valid point for programs that parse the lower layer, and no more, say
   for basic syntax highlighting.

   Pretty much irrelevant for programs that need to go beyond the lower
   layer.  Parsing the lower layer is the easy part.  The code dealing
   with the upper layer is much larger (expr.py and schema.py), and it
   actually changes as we add features to the schema language.
   Duplicating it would be a Bad Idea.  Reuse the existing frontend
   instead.


