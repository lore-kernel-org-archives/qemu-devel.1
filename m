Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2038CC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D008C206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkgmPgBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D008C206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxgM-00051Z-WA
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jVxfQ-000499-JH
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:31:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28651
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jVxfO-0003pX-QS
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588685482;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axTnztTbw/NA/38fFaUgFTnxmrSTWZtbWdnftiUCGpQ=;
 b=FkgmPgBekm5DBoadKzcIxFTNv7Wq4d/E/za5439vzYUvKRmCE2df539Xok486hMyLPVe5j
 2VrCF/2+5c8bASi61KTu7EvTCQQPbRQAtL0oqJap0sh1nQrWI4+MaA0w5RSkDGPC8URZqd
 A91W2gV09AMeuuuCAPBZ2IpyzUsToyo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-bbugI3Y5PASywQ5uASxJxA-1; Tue, 05 May 2020 09:31:20 -0400
X-MC-Unique: bbugI3Y5PASywQ5uASxJxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AED38015CB;
 Tue,  5 May 2020 13:31:19 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61FFB5C1D3;
 Tue,  5 May 2020 13:31:13 +0000 (UTC)
Date: Tue, 5 May 2020 14:31:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/4] Add support for SafeStack
Message-ID: <20200505133111.GM764268@redhat.com>
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
 <51f28cf2-0f34-508f-96f8-02c02b3c8a85@redhat.com>
MIME-Version: 1.0
In-Reply-To: <51f28cf2-0f34-508f-96f8-02c02b3c8a85@redhat.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Tobin Feldman-Fitzthum <tobin@ibm.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniele Buono <dbuono@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 05, 2020 at 03:15:18PM +0200, Philippe Mathieu-Daud=C3=A9 wrote=
:
> +Alex & Daniel who keep track on CI stuff.
>=20
> On 4/29/20 9:44 PM, Daniele Buono wrote:
> > LLVM supports SafeStack instrumentation to protect against stack buffer
> > overflows, since version 3.7
> >=20
> >  From https://clang.llvm.org/docs/SafeStack.html:
> > "It works by separating the program stack into two distinct regions: th=
e
> > safe stack and the unsafe stack. The safe stack stores return addresses=
,
> > register spills, and local variables that are always accessed in a safe
> > way, while the unsafe stack stores everything else. This separation
> > ensures that buffer overflows on the unsafe stack cannot be used to
> > overwrite anything on the safe stack."
> >=20
> > Unfortunately, the use of two stack regions does not cope well with
> > QEMU's coroutines. The second stack region is not properly set up with
> > both ucontext and sigaltstack, so multiple coroutines end up sharing th=
e
> > same memory area for the unsafe stack, causing undefined behaviors at
> > runtime (and most iochecks to fail).
> >=20
> > This patch series fixes the implementation of the ucontext backend and
> > make sure that sigaltstack is never used if the compiler is applying
> > the SafeStack instrumentation. It also adds a configure flag to enable
> > SafeStack, and enables iotests when SafeStack is used.
> >=20
> > This is an RFC mainly because of the low-level use of the SafeStack
> > runtime.
> > When running swapcontext(), we have to manually set the unsafe stack
> > pointer to the new area allocated for the coroutine. LLVM does not allo=
w
> > this by using builtin, so we have to use implementation details that ma=
y
> > change in the future.
> > This patch has been tested briefly ( make check on an x86 system ) with
> > clang v3.9, v4.0, v5.0, v6.0
> > Heavier testing, with make check-acceptance has been performed with
> > clang v7.0
>=20
> I noticed building using SafeStack is slower, and running with it is even
> sloooower. It makes sense to have this integrated if we use it regularly.=
 Do
> you have plan for this? Using public CI doesn't seem reasonable.

The runtime behaviour is rather odd, given the docs they provide:

"The performance overhead of the SafeStack instrumentation is
 less than 0.1% on average across a variety of benchmarks=20
 This is mainly because most small functions do not have any
 variables that require the unsafe stack and, hence, do not=20
 need unsafe stack frames to be created. The cost of creating=20
 unsafe stack frames for large functions is amortized by the=20
 cost of executing the function.

  In some cases, SafeStack actually improves the performance"

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


