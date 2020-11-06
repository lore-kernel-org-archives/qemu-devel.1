Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07DDC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16212087E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKpgtE4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16212087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kayKN-00051V-UD
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 04:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kayJB-0004Qd-Gj
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 04:45:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kayJ9-0001W5-3j
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 04:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604655921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q+YBrll4rGG+yr/UKsg8zc6phmRdhc+n4NdhtMgbKMA=;
 b=bKpgtE4fYqe6hs+3fXNv1CmEWyQWd8dXU8f/4FBh1FPJoxI4mYKUaUhVMJzgkphAk2qdVY
 XouoQhn7XI8+8ZxvtvCeXRLSIzxVMKDjPhBHZX7BiOr4LbQfvi/Ls+k9ZZw16B0wfghmUo
 4B/mVEP31CpLMYxUsa2nlTN0AHlCI80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-5tATaai_NmKzuOYk--26Tg-1; Fri, 06 Nov 2020 04:45:19 -0500
X-MC-Unique: 5tATaai_NmKzuOYk--26Tg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D67064158;
 Fri,  6 Nov 2020 09:45:18 +0000 (UTC)
Received: from merkur.fritz.box (ovpn-114-116.ams2.redhat.com [10.36.114.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 304E31002C2A;
 Fri,  6 Nov 2020 09:45:13 +0000 (UTC)
Date: Fri, 6 Nov 2020 10:45:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v2 00/44] Make qdev static property API usable by any QOM
 type
Message-ID: <20201106094511.GA23864@merkur.fritz.box>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104160021.2342108-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 02:41:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 04.11.2020 um 16:59 hat Eduardo Habkost geschrieben:
> This series refactor the qdev property code so the static
> property system can be used by any QOM type.  As an example, at
> the end of the series some properties in TYPE_MACHINE are
> converted to static properties to demonstrate the new API.
> 
> Changes v1 -> v2
> ----------------
> 
> * Rename functions and source files to call the new feature
>   "field property" instead of "static property"
> 
> * Change the API signature from an array-based interface similar
>   to device_class_set_props() to a object_property_add()-like
>   interface.
> 
>   This means instead of doing this:
> 
>     object_class_property_add_static_props(oc, my_array_of_props);
> 
>   properties are registered like this:
> 
>     object_class_property_add_field(oc, "property-name"
>                                     PROP_XXX(MyState, my_field),
>                                     prop_allow_set_always);
> 
>   where PROP_XXX is a PROP_* macro like PROP_STRING, PROP_BOOL,
>   etc.

In comparison, I really like the resulting code from the array based
interface in v1 better.

I think it's mostly for two reasons: First, the array is much more
compact and easier to read. And maybe even more importantly, you know
it's static data and only static data. The function based interface can
be mixed with other code or the parameter list can contain calls to
other functions with side effects, so there are a lot more opportunities
for surprises.

What I didn't like about the v1 interface is that there is still a
separate object_class_property_set_description() for each property, but
I think that could have been fixed by moving the description to the
definitions in the array, too.

On Fri, Oct 30, 2020 at 06:10:34PM +0100, Paolo Bonzini wrote:
> On 29/10/20 23:02, Eduardo Habkost wrote:
> > +static Property machine_props[] = {
> > +    DEFINE_PROP_STRING("kernel", MachineState, kernel_filename),
> > +    DEFINE_PROP_STRING("initrd", MachineState, initrd_filename),
> > +    DEFINE_PROP_STRING("append", MachineState, kernel_cmdline),
> > +    DEFINE_PROP_STRING("dtb", MachineState, dtb),
> > +    DEFINE_PROP_STRING("dumpdtb", MachineState, dumpdtb),
> > +    DEFINE_PROP_STRING("dt-compatible", MachineState, dt_compatible),
> > +    DEFINE_PROP_STRING("firmware", MachineState, firmware),
> > +    DEFINE_PROP_STRING("memory-backend", MachineState, ram_memdev_id),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
>
> While I think generalizing the _code_ for static properties is obviously
> a good idea, I am not sure about generalizing the interface for adding them.
>
> The reason is that we already have a place for adding properties in
> class_init, and having a second makes things "less local", so to speak.

As long as you have the function call to apply the properites array in
.class_init, it should be obvious enough what you're doing.

Of course, I think we should refrain from mixing both styles in a single
object, but generally speaking the array feels so much better that I
don't think we should reject it just because QOM only had a different
interface so far (and the property array is preexisting in qdev, too, so
we already have differences between objects - in fact, the majority of
objects is probably qdev today).

Kevin


