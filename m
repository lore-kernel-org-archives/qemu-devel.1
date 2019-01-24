Received: from eggs.gnu.org ([209.51.188.92]:40173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmhNJ-0004m4-5y
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:57:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gmhNI-0005Pz-Cj
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:57:05 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gmhNH-0005Ou-JF
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 10:57:04 -0500
Received: by mail-wr1-x431.google.com with SMTP id 96so7056615wrb.2
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 07:57:03 -0800 (PST)
References: <20181209193749.12277-1-cota@braap.org>
	<20181209193749.12277-7-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181209193749.12277-7-cota@braap.org>
Date: Thu, 24 Jan 2019 15:57:00 +0000
Message-ID: <87munqyroz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 06/38] plugin: add core code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>


Emilio G. Cota <cota@braap.org> writes:

> Some design requirements/goals:

Also this commit breaks bisect-ability:


  15:56:23 [alex@zen:~/l/q/qemu.git] (0138e1a5=E2=80=A6)|BISECTING 2 + head=
 -n 3 config.log
  # QEMU configure log Thu Jan 24 15:19:36 GMT 2019
  # Configured with: './configure' '--disable-tools' '--disable-docs' '--py=
thon=3D/usr/bin/python3'
  #
  15:56:35 [alex@zen:~/l/q/qemu.git] (0138e1a5=E2=80=A6)|BISECTING + make
          CHK version_gen.h
    CC      qapi/qapi-visit-core.o
  In file included from /home/alex/lsrc/qemu/qemu.git/include/qom/cpu.h:33:=
0,
                   from ./trace/control-internal.h:13,
                   from ./trace/control.h:270,
                   from qapi/trace.h:7,
                   from qapi/qapi-visit-core.c:21:
  /home/alex/lsrc/qemu/qemu.git/include/qemu/plugin.h:38:49: error: =E2=80=
=98qemu_plugin_list=E2=80=99 defined as wrong kind of tag
                                            struct qemu_plugin_list *head)
                                                   ^~~~~~~~~~~~~~~~
  /home/alex/lsrc/qemu/qemu.git/include/qemu/plugin.h:38:49: error: =E2=80=
=98struct qemu_plugin_list=E2=80=99 declared inside parameter list will not=
 be visible outside of this definition or
  declaration [-Werror]
  /home/alex/lsrc/qemu/qemu.git/include/qemu/plugin.h:44:48: error: =E2=80=
=98qemu_plugin_list=E2=80=99 defined as wrong kind of tag
   static inline int qemu_plugin_load_list(struct qemu_plugin_list *head)
                                                  ^~~~~~~~~~~~~~~~
  /home/alex/lsrc/qemu/qemu.git/include/qemu/plugin.h:44:48: error: =E2=80=
=98struct qemu_plugin_list=E2=80=99 declared inside parameter list will not=
 be visible outside of this definition or
  declaration [-Werror]
  cc1: all warnings being treated as errors
  /home/alex/lsrc/qemu/qemu.git/rules.mak:69: recipe for target 'qapi/qapi-=
visit-core.o' failed
  make: *** [qapi/qapi-visit-core.o] Error 1

--
Alex Benn=C3=A9e
