Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECA2C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:25:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7742220880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 10:25:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7742220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnKdz-0006Rn-Or
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 06:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46482)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hnKdn-00061m-1Q
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hnKdl-0000Gx-PK
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:24:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47858)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hnKdl-0000ED-HB
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 06:24:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9EFD3308A9E2;
 Tue, 16 Jul 2019 10:24:55 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99133600C4;
 Tue, 16 Jul 2019 10:24:47 +0000 (UTC)
Date: Tue, 16 Jul 2019 11:24:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190716102444.GE11261@redhat.com>
References: <20190713143311.17620-1-marcandre.lureau@redhat.com>
 <20190713143311.17620-6-marcandre.lureau@redhat.com>
 <2cbc75cf-887d-630d-f4e9-835d8ad135f1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2cbc75cf-887d-630d-f4e9-835d8ad135f1@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 16 Jul 2019 10:24:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 5/6] test-char: skip tcp tests if ipv4
 check failed
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
Cc: Fam Zheng <fam@euphon.net>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 15, 2019 at 06:45:28PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> On 7/13/19 4:33 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  tests/Makefile.include |  2 +-
> >  tests/test-char.c      | 17 +++++++++++++----
> >  2 files changed, 14 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index a983dd32da..2bddebaf4b 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -523,7 +523,7 @@ tests/check-qlit$(EXESUF): tests/check-qlit.o $(t=
est-util-obj-y)
> >  tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(te=
st-qom-obj-y)
> >  tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test=
-qom-obj-y)
> > =20
> > -tests/test-char$(EXESUF): tests/test-char.o $(test-util-obj-y) $(qte=
st-obj-y) $(test-io-obj-y) $(chardev-obj-y)
> > +tests/test-char$(EXESUF): tests/test-char.o $(test-util-obj-y) $(qte=
st-obj-y) $(test-io-obj-y) $(chardev-obj-y) tests/socket-helpers.o
> >  tests/test-coroutine$(EXESUF): tests/test-coroutine.o $(test-block-o=
bj-y)
> >  tests/test-aio$(EXESUF): tests/test-aio.o $(test-block-obj-y)
> >  tests/test-aio-multithread$(EXESUF): tests/test-aio-multithread.o $(=
test-block-obj-y)
> > diff --git a/tests/test-char.c b/tests/test-char.c
> > index f9440cdcfd..2dde620afc 100644
> > --- a/tests/test-char.c
> > +++ b/tests/test-char.c
> > @@ -15,6 +15,7 @@
> >  #include "io/channel-socket.h"
> >  #include "qapi/qobject-input-visitor.h"
> >  #include "qapi/qapi-visit-sockets.h"
> > +#include "socket-helpers.h"
> > =20
> >  static bool quit;
> > =20
> > @@ -1356,11 +1357,17 @@ static void char_hotswap_test(void)
> > =20
> >  int main(int argc, char **argv)
> >  {
> > +    bool has_ipv4, has_ipv6;
> > +
> >      qemu_init_main_loop(&error_abort);
> >      socket_init();
> > =20
> >      g_test_init(&argc, &argv, NULL);
> > =20
> > +    if (socket_check_protocol_support(&has_ipv4, &has_ipv6) < 0) {
> > +        return -1;
> > +    }
> > +
> >      module_call_init(MODULE_INIT_QOM);
> >      qemu_add_opts(&qemu_chardev_opts);
> > =20
> > @@ -1438,10 +1445,12 @@ int main(int argc, char **argv)
> >      g_test_add_data_func("/char/socket/client/wait-conn-fdpass/" # n=
ame, \
> >                           &client6 ##name, char_socket_client_test)
> > =20
> > -    SOCKET_SERVER_TEST(tcp, &tcpaddr);
> > -    SOCKET_CLIENT_TEST(tcp, &tcpaddr);
> > -    g_test_add_data_func("/char/socket/server/two-clients/tcp", &tcp=
addr,
> > -                         char_socket_server_two_clients_test);
> > +    if (has_ipv4) {
>=20
> Why not if(has_ipv4 || has_ipv6) ?

The 'tcpaddr' data is initialized with an IPv4 address only.

>=20
> > +        SOCKET_SERVER_TEST(tcp, &tcpaddr);
> > +        SOCKET_CLIENT_TEST(tcp, &tcpaddr);
> > +        g_test_add_data_func("/char/socket/server/two-clients/tcp", =
&tcpaddr,
> > +                             char_socket_server_two_clients_test);
> > +    }
> >  #ifndef WIN32
> >      SOCKET_SERVER_TEST(unix, &unixaddr);
> >      SOCKET_CLIENT_TEST(unix, &unixaddr);
> >=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

