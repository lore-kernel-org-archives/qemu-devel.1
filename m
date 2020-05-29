Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B191FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:19:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77F25207D4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 11:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hlwk1OaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F25207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jed3H-0000OH-G6
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 07:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jed2O-0007zj-82
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:18:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52271
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jed2M-00067C-P1
 for qemu-devel@nongnu.org; Fri, 29 May 2020 07:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590751133;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYiSMjIofNB15qWzwWiArouHiwdmYBQj6661003ktIs=;
 b=Hlwk1OaQymPUNIXUxlp+DqDA+u+/wFlc4dTThZAx3etu6WKFXzadeaYXYND9v6/k3IdlMc
 FKuVm35F9AC5UJa4Y1cK8mZ9agbFXt+R1kaxfE8UUczBc9r4ZNOpLvG7F7VL2YKDnj1t6H
 hcjccA1xGgLhDIHCTUkJxI6VHLec6+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-IE5wJrDZPi2d1tCHbEXS2g-1; Fri, 29 May 2020 07:18:48 -0400
X-MC-Unique: IE5wJrDZPi2d1tCHbEXS2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88877461
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 11:18:47 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.15])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41DD36298C;
 Fri, 29 May 2020 11:18:43 +0000 (UTC)
Date: Fri, 29 May 2020 12:18:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH v7 4/5] crypto: Add tls-cipher-suites object
Message-ID: <20200529111840.GE2755532@redhat.com>
References: <20200528173141.17495-1-philmd@redhat.com>
 <20200528173141.17495-5-philmd@redhat.com>
 <81c61004-cccc-2ece-91a7-de96012a8ebf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <81c61004-cccc-2ece-91a7-de96012a8ebf@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:34:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 29, 2020 at 01:09:22PM +0200, Laszlo Ersek wrote:
> On 05/28/20 19:31, Philippe Mathieu-Daudé wrote:
> (2) We need an actual commit message for this patch. How about the
> following -- I have liberally stolen and edited comments that Daniel
> made earlier in the Red Hat Bugzilla:
> 
> ---v--- ---v--- ---v--- ---v---
> On the host OS, various aspects of TLS operation are configurable. In
> particular it is possible for the sysadmin to control the TLS
> cipher/protocol algorithms that applications are permitted to use.
> 
> * Any given crypto library has a built-in default priority list defined by
>   the distro maintainer of the libary package (or by upstream).
> 
> * The "crypto-policies" RPM (or equivalent host OS package) provides a
>   config file such as "/etc/crypto-policies/config", where the sysadmin
>   can set a high level (library-independent) policy.
> 
>   The "update-crypto-policies --set" command (or equivalent) is used to
>   translate the global policy to individual library representations,
>   producing files such as "/etc/crypto-policies/back-ends/*.config". The
>   generated files, if present, are loaded by the various crypto libraries
>   to override their own built-in defaults.
> 
>   For example, the GNUTLS library may read
>   "/etc/crypto-policies/back-ends/gnutls.config".
> 
> * A management application (or the QEMU user) may overide the system-wide
>   crypto-policies config via their own config, if they need to diverge
>   from the former.
> 
> Thus the priority order is "QEMU user config" > "crypto-policies system
> config" > "library built-in config".
> 
> Introduce the "tls-cipher-suites" object for exposing the ordered list of
> permitted TLS cipher suites from the host side to the firmware, via
> fw_cfg. The list is represented as an array of IANA_TLS_CIPHER objects.
> The firmware uses the IANA_TLS_CIPHER array for configuring guest-side
> TLS, for example in UEFI HTTPS Boot.
> 
> The priority at which the host-side policy is retrieved is given by the
> "priority" property of the new object type. For example,
> "priority=@SYSTEM" may be used to refer to
> "/etc/crypto-policies/back-ends/gnutls.config" (given that QEMU uses
> GNUTLS).
> ---^--- ---^--- ---^--- ---^---
> 
> (3) I think I have now at least formed an idea about where we should
> document -fw_cfg / "gen_id" in the *manual*.
> 
> The various -object types are already documented extensively; namely in
> section "Generic object creation". Thus, I think we should document
> "tls-cipher-suites" there -- near the already existent "-object tls-*"
> ones.
> 
> I suggest including a manual update to that effect. I think we can mostly
> copy the suggested commit message into the manual as well.
> 
> And then, we can include the new "-fw_cfg" command line option (with
> "gen_id") *right there*. Consequently, we won't need to modify the
> existent "-fw_cfg" documentation bits (about "file" and "string") under
> section "Debug/Expert options".
> 
> Dan: please comment!

I don't really have anything else to say. More docs == better

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


