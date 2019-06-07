Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E3FC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6E120868
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6E120868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51134 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZK7j-00054q-4q
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33525)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hZIgN-0004kg-Vc
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hZIgM-0001ut-Os
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:29:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37546)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hZIgM-0001tp-HA
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 13:29:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4BFEB308FF30;
 Fri,  7 Jun 2019 17:29:28 +0000 (UTC)
Received: from redhat.com (ovpn-112-33.ams2.redhat.com [10.36.112.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A03E468D6B;
 Fri,  7 Jun 2019 17:29:18 +0000 (UTC)
Date: Fri, 7 Jun 2019 18:29:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cleber Rosa <crosa@redhat.com>
Message-ID: <20190607172915.GN28838@redhat.com>
References: <20190607152223.9467-1-crosa@redhat.com>
 <20190607152223.9467-8-crosa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190607152223.9467-8-crosa@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 07 Jun 2019 17:29:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 7/8] VNC Acceptance test: check protocol
 version
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 07, 2019 at 11:22:22AM -0400, Cleber Rosa wrote:
> This goes a bit further than the other tests, and does a basic (read
> only) interaction with the VNC protocol.
> 
> This is not a enough to perform a handshake, but enough to make sure
> that the socket is somewhat operational and that the expected initial
> step of the handshake is performed by the server and that the version
> matches.

The GTK-VNC project provides a low level library libgvnc that can
be used to talk the RFB protocol in a fairly fine grained manner.
This is built using GObject, so is accessible from Python thanks
to GObject Introspection.

We could use libgvnc for exercising the VNC server instead of writing
custom RFB code. For your simple test just sending/receiving the
version it won't save much, but if we ever want to test TLS or
SASL integration, it would save alot of work dealing wth the auth
handshake and subsequent encryption needs.

The main limitation it would have is that it would only work well
for sending "well formed" RFB protocol messages. If we ever want to
send intentionally evil/bad RFB data to check QEMU's VNC server
security hardening it would be harder.

As the maintainer of GTK-VNC though, I would be open to adding more
APIs to the low level gvnc library to facilitate QEMU's testing
needs if we want.

> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/vnc.py | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
> index d32ae46685..b000446d7c 100644
> --- a/tests/acceptance/vnc.py
> +++ b/tests/acceptance/vnc.py
> @@ -11,6 +11,7 @@
>  import os
>  import tempfile
>  import shutil
> +import socket
>  
>  from avocado_qemu import Test
>  
> @@ -71,5 +72,16 @@ class VncUnixSocket(Test):
>                                              arg='new_password')
>          self.assertEqual(set_password_response['return'], {})
>  
> +    def test_protocol_version(self):
> +        self.vm.add_args('-nodefaults', '-S',
> +                         '-vnc', 'unix:%s' % self.socket_path)
> +        self.vm.launch()
> +        self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
> +        client = socket.socket(socket.AF_UNIX)
> +        client.connect(self.socket_path)
> +        expected = b'RFB 003.008'
> +        actual = client.recv(len(expected))
> +        self.assertEqual(expected, actual, "Wrong protocol version")
> +
>      def tearDown(self):
>          shutil.rmtree(self.socket_dir)
> -- 
> 2.21.0
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

