Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A83C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E56221ED
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L16nb1+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E56221ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGgas-0002pN-Cm
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 06:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGgaA-0002OA-9V
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 06:47:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26543
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGga8-00035S-Fz
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 06:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599821223;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJgnqXlYM1vI+NXJ7IH/8t1QKqck5Q9rsixPNLnIXyE=;
 b=L16nb1+OccwoqahBqphPALsClsKbPHqLLgj6gbq/NlGyJogSfkFt2igtqJjuB4OWXPvNlh
 XdOyi2+/xFmbWWqfuVACfR1cUBSF1GuebVbJkmmqZ1wsUaV3c2Wm91OUxbim30y81gmg+j
 QwMPI+eboEzRq8cnalh69FrgKM3tPmU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-WoTPb_xCOPKg_1_uLDZiLQ-1; Fri, 11 Sep 2020 06:46:53 -0400
X-MC-Unique: WoTPb_xCOPKg_1_uLDZiLQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23962801AC4;
 Fri, 11 Sep 2020 10:46:52 +0000 (UTC)
Received: from redhat.com (ovpn-113-229.ams2.redhat.com [10.36.113.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 954D81A914;
 Fri, 11 Sep 2020 10:46:44 +0000 (UTC)
Date: Fri, 11 Sep 2020 11:46:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
Message-ID: <20200911104642.GE1203593@redhat.com>
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200910174850.716104-1-marcandre.lureau@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:28:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: slp@redhat.com, stefanha@gmail.com, qemu-devel@nongnu.org,
 armbru@redhat.com, pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 09:48:50PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> Among the QEMU developers, there is a desire to use Rust. (see previous
> thread from Stefan "Why QEMU should move from C to Rust", the rust-vmm
> related projects and other experiments).
> 
> Thanks to our QAPI type system and the associate code generator, it is
> relatively straightforward to create Rust bindings for the generated C
> types (also called sys/ffi binding) and functions. (rust-bindgen could
> probably do a similar job, but it would probably bring other issues).
> This provides an important internal API already.
> 
> Slightly more complicated is to expose a Rust API for those, and provide
> convenient conversions C<->Rust. Taking inspiration from glib-rs
> binding, I implemented a simplified version of the FromGlib/ToGlib
> traits, with simpler ownership model, sufficient for QAPI needs.
> 
> The usage is relatively simple:
> 
> - from_qemu_none(ptr: *const sys::P) -> T
>   Return a Rust type T for a const ffi pointer P.
> 
> - from_qemu_full(ptr: *mut sys::P) -> T
>   Return a Rust type T for a ffi pointer P, taking ownership.
> 
> - T::to_qemu_none() -> Stash<P>
>   Returns a borrowed ffi pointer P (using a Stash to destroy "glue"
>   storage data, if any).
> 
> - T::to_qemu_full() -> P
>   Returns a ffi pointer P. (P resources are leaked/passed to C/ffi)
> 
> With those traits, it's relatively easy to implement the QMP callbacks.
> With enough interest, we could eventually start rewriting QGA in
> Rust, as it is a simple service. See qga/qmp.rs for some examples.
> We could also try to tackle qemu itself.
> 
> Finally, given that the QAPI types are easy to serialize, it was simple
> to use "serde" on them, and provide a D-Bus interface for QMP with zbus.
> (a similar approach could probably be taken for other protocols, that
> could be dynamically loaded... anyone like protobuf better?)
> 
> This PoC modifies qemu-ga to provide the interface on the session bus:
> $ qga/qemu-ga -m unix-listen -p /tmp/qga.sock -t /tmp -v
> $ busctl --user introspect org.qemu.qga /org/qemu/qga org.qemu.QgaQapi
> ...
> $ busctl --user call org.qemu.qga /org/qemu/qga org.qemu.QgaQapi
> GuestSetVcpus aa\{sv\} 1 2 logical-id x 0 online b 1
> ...
> 
> Note: the generated code doesn't work with the qemu schema, there is a
> couple of fixme/todo left.
> 
> Shameful pain point: meson & cargo don't play nicely together.

Do we actually need/want it to be in the same monolithic repo
as qemu, as opposed to a qemu-qapi-rust repo ?

Trying to weld together different build systems is never that
attractive. The language specific build systems generally are
much simpler if they're self contained. From a distro POV it
can be better if the language bindings are self contained, as
you don't neccessarily want to build the language binding in
the same environment as the main app. For example with modules
in Fedora or RHEL, there can be multiple parallel versions of
a language runtime, and thus language bindings would be built
separately from QEMU.

IIUC, you're generating stuff from the QEMU schemas. One way
we can deal with this is to actually install the QEMU schemas
into /usr/share. Distros would have an "qemu-devel" package
that provided the schemas and the QAPI base tools which
can then be used by separate bindings.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


