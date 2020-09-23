Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7964EC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D512820C09
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J61K3Etg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D512820C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL30Q-0007Nn-DQ
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 07:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kL2z4-0006sA-89
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:30:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kL2z1-0005ux-4D
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600860645;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k23k4SXD775v0ONdnrfYjSiVNESSfLi2q514/euwNTY=;
 b=J61K3EtgqpR/1i/WHeM5W7OrbVFVYvBE/QMdc3uXZ8axFY8Yymguj1Tcq6wxFLhNZFgVCC
 F/ZX/Vqy6nAIL0QRBnsM9A7MaibfR5+8aBrIWCK4W978gG6ejuWO/R8LfQOz4NRwvkkClG
 DJYEXEX0mg9h6IzaH8hqbZc+zu3FhT8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-zyUt8LigPTSLwUMdKUexUg-1; Wed, 23 Sep 2020 07:30:38 -0400
X-MC-Unique: zyUt8LigPTSLwUMdKUexUg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20EFC10BBEC8;
 Wed, 23 Sep 2020 11:30:37 +0000 (UTC)
Received: from redhat.com (ovpn-114-73.ams2.redhat.com [10.36.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E7D9810021AA;
 Wed, 23 Sep 2020 11:30:31 +0000 (UTC)
Date: Wed, 23 Sep 2020 12:30:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] Add execute bit back to scripts/tracetool.py
Message-ID: <20200923113029.GQ2053606@redhat.com>
References: <20200923103620.1980151-1-anthony.perard@citrix.com>
 <8cbf1d90-849a-5046-d6f0-756000decaef@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8cbf1d90-849a-5046-d6f0-756000decaef@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Anthony PERARD <anthony.perard@citrix.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 23, 2020 at 01:14:57PM +0200, Paolo Bonzini wrote:
> On 23/09/20 12:36, Anthony PERARD wrote:
> > Commit a81df1b68b65 ("libqemuutil, qapi, trace: convert to meson")
> > removed it without explanation and it is useful to be able to run a
> > script without having to figure out which interpreter to use.
> > 
> > Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> > ---
> >  scripts/tracetool.py | 0
> >  1 file changed, 0 insertions(+), 0 deletions(-)
> >  mode change 100644 => 100755 scripts/tracetool.py
> > 
> > diff --git a/scripts/tracetool.py b/scripts/tracetool.py
> > old mode 100644
> > new mode 100755
> > 
> 
> The explanation is in docs/devel/build-system.rst
> 
> Support scripts
> ---------------
> 
> Meson has a special convention for invoking Python scripts: if their
> first line is `#! /usr/bin/env python3` and the file is *not* executable,
> find_program() arranges to invoke the script under the same Python
> interpreter that was used to invoke Meson.  This is the most common
> and preferred way to invoke support scripts from Meson build files,
> because it automatically uses the value of configure's --python= option.
> 
> In case the script is not written in Python, use a `#! /usr/bin/env ...`
> line and make the script executable.
> 
> Scripts written in Python, where it is desirable to make the script
> executable (for example for test scripts that developers may want to
> invoke from the command line, such as tests/qapi-schema/test-qapi.py),
> should be invoked through the `python` variable in meson.build. For
> example::
> 
>   test('QAPI schema regression tests', python,
>        args: files('test-qapi.py'),
>        env: test_env, suite: ['qapi-schema', 'qapi-frontend'])
> 
> This is needed to obey the --python= option passed to the configure
> script, which may point to something other than the first python3
> binary on the path.

The top level meson.build sets


  tracetool = [
    python, files('scripts/tracetool.py'),
     '--backend=' + config_host['TRACE_BACKENDS']
  ]

So looks like we're correctly honouring the configured --python
binary, and thus setting the executable bit will not cause any
problems with meson.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


