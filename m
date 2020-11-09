Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2BFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CDDF2068D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 15:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y2CrOZRg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CDDF2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc90h-0005h9-2B
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 10:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kc8z9-0004qd-JJ
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 10:21:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56485)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kc8z7-0002KV-Ns
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 10:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604935292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BJq3QX0+hxUogI0SOayImhXTwuU5HoIwKtzS3k0vXOo=;
 b=Y2CrOZRgIL7zH0m7wBuhNfgvLgj574Ds5rkestqwzBFiBXmss/n8nmGDvYU/hFYnoRfmcG
 6DeEH8ENIum4jytButC07yYkE74mpTtQDpgVJWXHRYHGzjDcZjxou+iMDSFAVI3prtG3Vv
 xgAiOs4bbKEuZQFPsQFb5L9B5tZPlLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-ecnfwUAqO62OzOfA7n99OA-1; Mon, 09 Nov 2020 10:21:31 -0500
X-MC-Unique: ecnfwUAqO62OzOfA7n99OA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F4251019627;
 Mon,  9 Nov 2020 15:21:30 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB85E5C5B0;
 Mon,  9 Nov 2020 15:21:26 +0000 (UTC)
Date: Mon, 9 Nov 2020 10:21:25 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 00/44] Make qdev static property API usable by any QOM
 type
Message-ID: <20201109152125.GZ5733@habkost.net>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
 <20201106094511.GA23864@merkur.fritz.box>
 <20201106155013.GX5733@habkost.net>
 <20201106211034.GY5733@habkost.net>
 <ca99fc61-6cdd-117d-343e-8141e385522e@redhat.com>
 <20201109113404.GA24970@merkur.fritz.box>
 <3b711053-e67a-86fb-59e7-c06948dd8928@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3b711053-e67a-86fb-59e7-c06948dd8928@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 01:25:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Nov 09, 2020 at 03:15:26PM +0100, Paolo Bonzini wrote:
> On 09/11/20 12:34, Kevin Wolf wrote:
> > > If all properties were like this, it would be okay.  But the API in v2 is
> > > the one that is most consistent with QOM in general. Here is how this change
> > > would be a loss in term of consistency:
> > > 
> > > - you have the field properties split in two (with the property itself in
> > > one place and the allow-set function in a different place), and also you'd
> > > have some properties listed as array and some as function calls.
> > 
> > Why would you have properties defined as function calls for the same
> > object that uses the array?
> 
> Because some properties would not be field properties, for example.  For
> example, any non-scalar property would need to invoke visit_SomeQapiStruct
> manually and would not be a field property.

Nothing prevents us from describing those properties inside the
same property array.

> 
> > I'm not entirely sure what you mean with allow-set. The only things I
> > can find are related to link properties, specifically the check()
> > callback of object_class_property_add_link(). If it's this, what would
> > be the problem with just adding it to DEFINE_PROP_LINK instead of
> > using a separate function call to define link properties?
> 
> Eduardo's series is adding allow-set functions to field properties as well.
> If it's be specified in the function call to
> object_class_add_field_properties, you'd have part of the property described
> in the array and part in the object_class_add_field_properties.
> 
> > > - we would have different ways to handle device field properties (with
> > > dc->props) compared to object properties.
> > 
> > You mean dynamic per-object properties, i.e. not class properties?
> 
> No, I mean that device properties would be handled as
> 
>    dc->props = foo;

More precisely, it is
  device_class_set_props(dc, foo);

which is supposed to become a one-line wrapper to
object_class_add_field_properties().

> 
> while object properties would be handled as
> 
>    object_class_add_field_properties(oc, foo, prop_allow_set_always);
> 
> There would be two different preferred ways to do field properties in qdev
> vs. non-qdev.

They should become exactly the same method, just with a different
allow_set function.

(There's also the possibility we let the class provide a default
allow_set function, and both would become 100% the same)

> 
> > I think having different ways for different things (class vs. object) is
> > better than having different ways for the same things (class in qdev vs.
> > class in non-qdev).
> 
> Right, but qdev's DEFINE_PROP_STRING would be easy to change to something
> like
> 
> - DEFINE_PROP_STRING("name", ...),
> + device_class_add_field_property(dc, "name", PROP_STRING(...));

I'm not worried about this direction of conversion (which is
easy).  I'm worried about the function call => QAPI schema
conversion.  Function calls are too flexible and requires parsing
and executing C code.  Requiring all property descriptions to be
evaluated at compilation time is an intentional feature of the
new API.

> 
> > > The choice to describe class properties as function calls was made in 2016
> > > (commit 16bf7f522a, "qom: Allow properties to be registered against
> > > classes", 2016-01-18); so far I don't see that it has been misused.
> > 
> > This was the obvious incremental step forward at the time because you
> > just had to replace one function call with another function call. The
> > commit message doesn't explain that not using data was a conscious
> > decision. I think it would probably have been out of scope then.
> > 
> > > Also, I don't think it's any easier to write an introspection code generator
> > > with DEFINE_PROP_*.  You would still have to parse the class init function
> > > to find the reference to the array (and likewise the TypeInfo struct to find
> > > the class init function).
> > 
> > I don't think we should parse any C code. In my opinion, both
> > introspection and the array should eventually be generated by the QAPI
> > generator from the schema.
> 
> That'd be a good plan, and I'd add generating the property description from
> the doc comment.  (Though there's still the issue of how to add non-field
> properties to the introspection.  Those would be harder to move to the QAPI
> generator).
> 
> But at that point the array vs. function call would not change anything (if
> anything the function call would be a tiny bit better), so that's another
> reason to stay with the API that Eduardo has in v2.

I don't agree the function call is a tiny bit better.  In the
best case, I find it a tiny bit worse.

-- 
Eduardo


