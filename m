Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5248C3A5A6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 00:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5CF206C2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 00:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5CF206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB785-0002v6-DM
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 20:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iB77I-0001zC-H5
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iB77F-0001dV-Ml
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:49:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43206)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1iB77F-0001dI-Eq
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 20:49:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0FC2D300DA2E;
 Fri, 20 Sep 2019 00:49:40 +0000 (UTC)
Received: from [10.18.17.38] (dhcp-17-38.bos.redhat.com [10.18.17.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C593A5D9CD;
 Fri, 20 Sep 2019 00:49:34 +0000 (UTC)
Subject: Re: [PATCH v3 13/22] libqtest: make qtest_bufwrite send "atomic"
To: "Oleinik, Alexander" <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-14-alxndr@bu.edu>
 <20190919103741.GO3606@stefanha-x1.localdomain>
 <da63050e-73b2-d9ac-112b-75b9a7caa54d@redhat.com>
 <b416ebcc5d9a0b09a0ad7ef78ba0cd19d13f9f2d.camel@bu.edu>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <def68290-2e7a-0c7e-c5e0-865a5feae36a@redhat.com>
Date: Thu, 19 Sep 2019 20:49:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <b416ebcc5d9a0b09a0ad7ef78ba0cd19d13f9f2d.camel@bu.edu>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 20 Sep 2019 00:49:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Thomas Huth <thuth@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/19/19 3:36 PM, Oleinik, Alexander wrote:
> On Thu, 2019-09-19 at 14:56 -0400, John Snow wrote:
>> >
>> > On 9/19/19 6:37 AM, Stefan Hajnoczi wrote:
>>> > > On Wed, Sep 18, 2019 at 11:19:40PM +0000, Oleinik, Alexander wrot=
e:
>>>> > > > When using qtest "in-process" communication, qtest_sendf direc=
tly
>>>> > > > calls
>>>> > > > a function in the server (qtest.c). Combining the contents of =
the
>>>> > > > subsequent socket_sends into the qtest_sendf, makes it so the
>>>> > > > server can
>>>> > > > immediately handle the command, without building a local buffe=
r
>>>> > > > and
>>>> > > > waiting for a newline.
>>>> > > >
>>>> > > > Signed-off-by: Alexander Oleinik <alxndr@bu.edu
>>>> <mailto:alxndr@bu.edu>>
>>>> > > > ---
>>>> > > > =A0tests/libqtest.c | 4 +---
>>>> > > > =A01 file changed, 1 insertion(+), 3 deletions(-)
>>>> > > >
>>>> > > > diff --git a/tests/libqtest.c b/tests/libqtest.c
>>>> > > > index 19feea9e17..d770462869 100644
>>>> > > > --- a/tests/libqtest.c
>>>> > > > +++ b/tests/libqtest.c
>>>> > > > @@ -1086,9 +1086,7 @@ void qtest_bufwrite(QTestState *s, uint6=
4_t
>>>> > > > addr, const void *data, size_t size)
>>>> > > > =A0=A0=A0=A0=A0gchar *bdata;
>>>> > > > =A0
>>>> > > > =A0=A0=A0=A0=A0bdata =3D g_base64_encode(data, size);
>>>> > > > -=A0=A0=A0=A0qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx ", a=
ddr, size);
>>>> > > > -=A0=A0=A0=A0socket_send(s->fd, bdata, strlen(bdata));
>>>> > > > -=A0=A0=A0=A0socket_send(s->fd, "\n", 1);
>>>> > > > +=A0=A0=A0=A0qtest_sendf(s, "b64write 0x%" PRIx64 " 0x%zx %s\n=
", addr,
>>>> > > > size, bdata);
>>>> > > > =A0=A0=A0=A0=A0qtest_rsp(s, 0);
>>>> > > > =A0=A0=A0=A0=A0g_free(bdata);
>>>> > > > =A0}
>>>> > > > --=A0
>>>> > > > 2.23.0
>>> > >
>>> > > Cc John Snow, who added the b64write command.
>>> > >
>>> > > The downside to doing this is that sprintf-formatting needs to be
>>> > > performed on the entire base64 buffer.=A0=A0This slows things dow=
n
>>> > > slightly
>>> > > and a larger temporary buffer needs to be allocated, but I'm not
>>> > > sure it
>>> > > matters.
>>> > >
>> >
>> > *struggles to remember*
>> >
>> > I guess I wanted something that had some space savings while
>> > maintaining
>> > some semblance of debuggability. This is almost certainly meant for
>> > AHCI
>> > tests where it's writing various patterns to large blocks of memory.
>> >
>> > I doubt I really measured the performance of it, but it seemed like
>> > the
>> > way to go for transferring medium amounts of data at the time via th=
e
>> > qtest protocol.
>> >
>> > Looks like I am the only user of it, still:
>> >
>> > tests/ahci-test.c:=A0=A0=A0=A0qtest_bufwrite(ahci->parent->qts, ptr,=
 tx,
>> > bufsize);
>> > tests/ahci-test.c:=A0=A0=A0=A0qtest_bufwrite(ahci->parent->qts, ptr,=
 tx,
>> > bufsize);
>> > tests/libqos/ahci.c:=A0=A0=A0=A0=A0=A0=A0=A0qtest_bufwrite(ahci->par=
ent->qts, ptr,
>> > buffer, bufsize);
>> >
>> > The buffers can be quite large, so you might be re-buffering a decen=
t
>> > amount of data from the sender now.
>> >
>> > 1, Are large transfers like this guaranteed to be atomic anyway? Wha=
t
>> > kind of socket is it? we're probably eclipsing frame and packet size=
s
>> > here.
>> >
>> > 2, I am not sure what being "atomic" affords us in terms of allowing
>> > the server to not wait for newlines, how does this change help?
>> >
>> > --js
>=20
> I'm modifying qtest to allow the server and client to co-exist within
> the same process (facilitating coverage-guided fuzzing). One of the
> modifications is making qtest_sendf directly call a function in
> qtest.c. All the other qtest commands are sent with a single
> qtest_sendf call, so the qtest.c function could immediately call
> qtest_process_command. This breaks if the command is sent with
> different qtest_send/socket_send calls, as in b64write.
>=20
> It should be simple to change qtest_server_inproc_recv (the qtest.c
> receiver) to wait for an "\n" prior to qtest_process_command, so I will
> probably do that and then normal(socket) qtest will keep the
> memory-reduction benefits of the non-"atomic" approach.
>=20

Before you spend the effort, just benchmark it if you can. I'd look at
the before and after of the AHCI tests with and without the pre-buffering=
.

> As a side note, would qtest_memwrite, also benefit from splitting up th=
e
> send command?
>=20
> =A0=A0=A0=A0for (i =3D 0; i < size; i++) {
> =A0=A0=A0=A0=A0=A0=A0=A0sprintf(&enc[i * 2], "%02x", ptr[i]);
> =A0=A0=A0=A0}
>=20
> =A0=A0=A0=A0qtest_sendf(s, "write 0x%" PRIx64 " 0x%zx 0x%s\n", addr, si=
ze, enc);
> =A0=A0=A0=A0qtest_rsp(s, 0);
> =A0=A0=A0=A0g_free(enc);

Depends on the users. I think at the time I wrote bufwrite it was using
obviously more data. Some of the memwrite users might be writing pretty
small things.

Looks like users are:

tests/ahci-test
tests/ide-test
tests/libqos/e1000e.c
tests/libqos/pci-pc.c
tests/libqos/pci-spapr.c
tests/megasas-test.c
tests/tpm-util.c
tests/virtio-9p-test.c

the libqos ones are used by other tests -- you can give it a skim and
come up with a small list of tests to benchmark and see if it makes any
actual difference.

--js

