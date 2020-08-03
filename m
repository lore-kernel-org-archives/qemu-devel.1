Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A785BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3991420738
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Knk0dtWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3991420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2gYf-0006St-5B
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 15:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k2gXi-0005x0-40
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:54:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58224
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <nsoffer@redhat.com>)
 id 1k2gXe-0006Vw-UY
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596484477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SaTU3E01rL5VAMJJ2RjT9pPbWgLntGcnUG2WBVtMJhk=;
 b=Knk0dtWBD9kEUF5DFd9FpN6yPJJinFGPGgnusBqzbeAmXsvUYU46JDkMiF1+HLZPwF3N+I
 YqRcQNtJvCgre47hSj6YhvymbYkTdtOulNYPN7RaTbs0JFAftb6jPcsV+aHU4j8WbHxDjr
 xV2WjAHmdW8cR4rk60g7BdX5/DA0jus=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-5BnBlHZXOJ-7uV6Z-R9C5g-1; Mon, 03 Aug 2020 15:54:32 -0400
X-MC-Unique: 5BnBlHZXOJ-7uV6Z-R9C5g-1
Received: by mail-ot1-f70.google.com with SMTP id b11so11235534otl.17
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 12:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SaTU3E01rL5VAMJJ2RjT9pPbWgLntGcnUG2WBVtMJhk=;
 b=fnz7JGKCLQ4ITDZ7xup0DzZ/AYH4ytxkzNIwEdDXjuQW7ajwUKBxL/YdBkJ7iLqPZS
 pyA7HcWBV1/NlIejyscR60w3rnH7aM+LxR1jdDvpXNr2yGRZ26pcJ4CUUSvXODUKPrE7
 jV4p7qoRbS5ZEdcwsppTh+y4vOnLbHJ7X0naZ+s8Wg3SdOOu7JsZ553lgp3CO1i2S8D5
 8VgDtVUcNK2TDK6Gjrj75VPOxmBjEsyM84TYhWSKQu2qOXEdW9sAiN/gd73/ynf0Y0nQ
 GEYmHoAH81b3ZQpDgApAUpMn8J7SXIr8KSywzsOBOueGuwRSIqtSq1/uJtAiskVYcABm
 otBg==
X-Gm-Message-State: AOAM531gp/GSvHlRgb0VUZhN1zsEjy8LDOxjn+xBHJbXkyFJ5IsGSBfY
 z6wPJbU5QhyAw+4LkP/ZhCUS2bP1ay6n/Twqng9Jt5QeI1t49GjgJz2nmw/hUVqVqJc74Ef7F3Z
 vc2o09NoOK2qI/Wzlig52rdT/oGL262k=
X-Received: by 2002:a9d:4c86:: with SMTP id m6mr14404871otf.315.1596484471530; 
 Mon, 03 Aug 2020 12:54:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEpoY6+8d1to3jl+m6mwr5Z8A/JTT59xmme2rFkgkGTPcStdzX0BEJASFPMmULgNTwrOIFHWYQrC60GLGjWB8=
X-Received: by 2002:a9d:4c86:: with SMTP id m6mr14404849otf.315.1596484471134; 
 Mon, 03 Aug 2020 12:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200729185024.121766-1-abologna@redhat.com>
 <87ime52wxd.fsf@dusky.pond.sub.org>
 <20200730093732.GB3477223@redhat.com> <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <20200730132446.GL3477223@redhat.com> <875za33ku1.fsf@dusky.pond.sub.org>
 <20200731150738.GB3660103@redhat.com>
 <2cf1a431-9d2c-8ad6-446e-f10b36219764@redhat.com>
 <87d048i1m2.fsf@dusky.pond.sub.org>
 <83bbe0b0-c5e0-e3b7-5ba1-5946098370d5@redhat.com>
 <87ft94klyl.fsf@dusky.pond.sub.org>
 <490a0786-73f3-411e-4dfe-8c2ae90de251@redhat.com>
 <17a92222-2627-4961-b57e-1f1f5c86e14a@redhat.com>
 <e186e3b5-4aef-42c0-6957-2e5ae430686c@redhat.com>
 <6514f2e2-4694-6790-7663-f8a8f6a91e5a@redhat.com>
In-Reply-To: <6514f2e2-4694-6790-7663-f8a8f6a91e5a@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Mon, 3 Aug 2020 22:54:14 +0300
Message-ID: <CAMRbyytzHwfEV2=bxhn3zVR3rUKK9DB0V1CCGgub=CfN0pH7jw@mail.gmail.com>
Subject: Re: cleanups with long-term benefits (was Re: [PATCH] schemas: Add
 vim modeline)
To: John Snow <jsnow@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=nsoffer@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 13:51:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 3, 2020 at 9:19 PM John Snow <jsnow@redhat.com> wrote:
>
> On 8/3/20 2:16 PM, Paolo Bonzini wrote:
> > On 03/08/20 20:10, John Snow wrote:
> >> Heresy:
> >>
> >> Docstrings could become part of the data format so they can be parsed,
> >> analyzed and validated. Parsers largely treat comments like non-semantic
> >> information and discard it. Round-trip parsers that preserve comments in
> >> any language are extremely rare.
> >>
> >> If the docstrings are relevant to the generator and aren't discardable,
> >> they should be fully-fledged data members.
> >>
> >> In a prototype I had for a YAML format, I just promoted docstrings
> >> directly to fields, so I could allow clients to query help text for
> >> individual commands.
> >
> > This would be actually a good idea, but somebody has to write the code.
> >   Each field's docstring should be attached to the field, however---no
> > parsing needed only looking at the tree.  Take a look at what Nir posted:
> >
> >> Here is the patch adding schema convertor from qemu "json" format to
> >> standard yaml:
> >> https://github.com/oVirt/vdsm/commit/e57b69e72987c0929b20306c454835b52b5eb7ee
> >>
> >> The current version of the new yaml based schema:
> >> https://github.com/oVirt/vdsm/blob/master/lib/vdsm/api/vdsm-api.yml
> >
> >
> >      VmDiskDevice: &VmDiskDevice
> >          added: '3.1'
> >          description: Properties of a VM disk device.
> >          name: VmDiskDevice
> >          properties:
> >          -   description: Indicates if writes are prohibited for the
> >                  device
> >              name: readonly
> >              type: boolean
> >
> >          -   description: The size of the disk (in bytes)
> >              name: apparentsize
> >              type: uint
> >
> > etc.
> >
> > Paolo
> >
>
> I was working on a small prototype that used something that looked like
> this; the "*opt" format was traded for "?opt", but otherwise:
>
>
> struct:
>    name: AudiodevPerDirectionOptions
>    doc: >
>      General audio backend options that are used for both
>      playback and recording.
>    since: '4.0'
>    members:
>
>      ?mixing-engine:

This optimizes for writing instead of reading.

    optional: true

Would be nicer to read, but more important is all the tools parsing
this schema in multiple languages that will have code like:

    def is_optional(node):
        return node.name.startswith("?")

Instead of :

   if node.optional:
       ...

Or maybe better:

    if node.required:

Because it seems that more nodes are optional, so focusing on the required
items will make the schema shorter and more clear.

>        type: bool
>        default: 'true'
>        since: '4.2'
>        doc: |
>          Use QEMU's mixing engine to mix all streams inside QEMU and
>          convert audio formats when not supported by the backend.

Using | is nicer than >-. Not sure what is the difference. In vdsm we don't use
anything and I think it causes trouble when indenting text.

>          When set to off, fixed-settings must be also off.
>
>      ?fixed-settings:
>        type: bool
>        default: 'true'

Why is the default a string and not the actual type?

>        doc: >-
>          Use fixed settings for host input/output.
>          When off, frequency, channels and format must not be specified.
>
>      ?frequency:
>        type: bool
>        default: '44100'
>        doc: >-
>          frequency to use when using fixed settings.
>
>      ?channels:
>        type: 'uint32'
>        default: 2

Here you use the real type, and this is nicer.

>        doc: >-
>          Number of channels when using fixed settings.
>
>      ?voices:
>        type: 'uint32'
>        default: 1
>        doc: "Number of voices to use."
>
>      ?format:
>        type: 'AudioFormat'
>        default: 's16'
>        doc: "Sample format to use when using fixed settings."
>
>      ?buffer-length:
>        type: 'uint32'
>        doc: 'The buffer length, in microseconds.'
>
>    features:
>      my-cool-feature:
>        since: '6.0'
>        doc: 'This is, no doubt, an extremely cool feature.'
>
>      my-bad-feature:
>        doc: 'This is a very bad feature. I am sorry for making it.'
>        since: '1.0'
>        deprecated: '5.9'

Good example :-)

>
>


