Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B76C34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 05:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E902208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 05:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XihMw+RX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E902208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Hq4-0008O7-Lj
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 00:24:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j4HpG-0007vc-44
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 00:23:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j4HpD-0005PK-Sf
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 00:23:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30429
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j4HpD-0005Nk-NJ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 00:23:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582089786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=adupBomnbk1lKkqUKhZ3JZoMimIYL+RHEQ82dC7OlCk=;
 b=XihMw+RXK+msOLBH2ASf9fFok3FM6cy45BCzJ+DU9hxlE8/ms+QD0Pijt/kpQbR3A2uk4r
 vLUIUCXuIU955YRTJTy+LmmbUSuCKoSyQJ4+JxEld9bZaMBc69oFM4SJzjw6xdoCEpSM3S
 La5v/QZlZ6qhsT5lYc8RVnQrLsV54YU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-3OtvymAtOZq3gBfgluP1IQ-1; Wed, 19 Feb 2020 00:23:00 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 181F2100550E;
 Wed, 19 Feb 2020 05:22:59 +0000 (UTC)
Received: from [10.72.13.212] (ovpn-13-212.pek2.redhat.com [10.72.13.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 990185C10D;
 Wed, 19 Feb 2020 05:22:57 +0000 (UTC)
Subject: Re: QEMU Sockets Networking Backend Multicast Networking Fix
To: Faisal Al-Humaimidi <falhumai96@gmail.com>
References: <CAMx8kb2aJ2OOHx6GG9qmXOoSXdQrzQ9+fsK=JR7pM-bJA4QOzg@mail.gmail.com>
 <87mu9knnhn.fsf@dusky.pond.sub.org>
 <968ea798-aedc-7bb3-e2ed-ee8fe9c0aeab@redhat.com>
 <CAMx8kb2jHAGngXuR_WmGtpP0mtQUkWxMWmP7TD=nbMnnKCY_wA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8685d929-91a1-4e6e-7b39-5ee682fcb365@redhat.com>
Date: Wed, 19 Feb 2020 13:22:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAMx8kb2jHAGngXuR_WmGtpP0mtQUkWxMWmP7TD=nbMnnKCY_wA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3OtvymAtOZq3gBfgluP1IQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/2/17 =E4=B8=8B=E5=8D=886:05, Faisal Al-Humaimidi wrote:
> Hello Jason,
>
> But, the local address is not meant to be added to the group, rather=20
> we listen to it, hence we bind to the local address. The multicast=20
> group is a higher layer that would be requested to join to by the=20
> listening host. Here's a similar example in multicasting that=20
> demonstrates this idea in Python:=20
> https://pymotw.com/2/socket/multicast.html.


Well, I think it kinds of violates the multicast overlay here. It allows=20
to receive any other traffic (unitcast) that may be received for the=20
port which is not what we want here.

Thanks


>
>
> Regards,
> Faisal Al-Humaimidi
>
> On Mon., Feb. 17, 2020, 1:54 a.m. Jason Wang, <jasowang@redhat.com=20
> <mailto:jasowang@redhat.com>> wrote:
>
>
>     On 2020/2/15 =E4=B8=8B=E5=8D=886:39, Markus Armbruster wrote:
>     > Jason, please have a look.
>     >
>     > Faisal Al-Humaimidi <falhumai96@gmail.com
>     <mailto:falhumai96@gmail.com>> writes:
>     >
>     >> Hello QEMU developers,
>     >>
>     >> I have noticed a bug in the `mcast` option of the `socket`
>     networking
>     >> backend, where I simply cannot join a multicast group (tested
>     in Windows 10
>     >> with QEMU 4.2.0 release). I have found a fix to the problem.
>     The problem
>     >> was mainly due to the fact that QEMU was binding to the
>     multicast address,
>     >> and not the local address or the default INADDR_ANY (0.0.0.0)
>     if no local
>     >> address is used.
>     >>
>     >> Here's the patch text (as well as attached with this email),
>     that outlines
>     >> my fix:
>     >>
>     >> ```
>     >> diff -uarN qemu-4.2.0.original/net/socket.c
>     qemu-4.2.0.modified/net/socket.c
>     >> --- qemu-4.2.0.original/net/socket.c 2019-12-12
>     10:20:48.000000000 -0800
>     >> +++ qemu-4.2.0.modified/net/socket.c 2020-02-14
>     10:30:16.395973453 -0800
>     >> @@ -253,6 +253,15 @@
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     >>
>     >> +=C2=A0 =C2=A0 /* Preserve the multicast address, and bind to a
>     non-multicast group
>     >> (e.g. a
>     >> +=C2=A0 =C2=A0 =C2=A0* local address).
>     >> +=C2=A0 =C2=A0 =C2=A0*/
>     >> +=C2=A0 =C2=A0 struct in_addr group_addr =3D mcastaddr->sin_addr;
>     >> +=C2=A0 =C2=A0 if (localaddr) {
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mcastaddr->sin_addr =3D *localaddr;
>     >> +=C2=A0 =C2=A0 } else {
>     >> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mcastaddr->sin_addr.s_addr =3D htonl(=
INADDR_ANY);
>     >> +=C2=A0 =C2=A0 }
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D bind(fd, (struct sockaddr *)mcas=
taddr,
>     sizeof(*mcastaddr));
>
>
>     This looks wrong, AFAIK the local address should be added through
>     IP_ADD_MEMBERSHIP which is already handled in this function I believe=
.
>
>     Thanks
>
>
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret < 0) {
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_errno(errp, err=
no, "can't bind ip=3D%s to
>     socket",
>     >> @@ -260,7 +269,10 @@
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     >>
>     >> -=C2=A0 =C2=A0 /* Add host to multicast group */
>     >> +=C2=A0 =C2=A0 /* Restore the multicast address. */
>     >> +=C2=A0 =C2=A0 mcastaddr->sin_addr =3D group_addr;
>     >> +
>     >> +=C2=A0 =C2=A0 /* Add host to multicast group. */
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0imr.imr_multiaddr =3D mcastaddr->sin_add=
r;
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0if (localaddr) {
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0imr.imr_interface =3D *loc=
aladdr;
>     >> @@ -277,7 +289,7 @@
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     >>
>     >> -=C2=A0 =C2=A0 /* Force mcast msgs to loopback (eg. several QEMUs =
in same
>     host */
>     >> +=C2=A0 =C2=A0 /* Force mcast msgs to loopback (eg. several QEMUs =
in same
>     host). */
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0loop =3D 1;
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D qemu_setsockopt(fd, IPPROTO_IP, =
IP_MULTICAST_LOOP,
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&loop, sizeof(loop));
>     >> @@ -287,7 +299,7 @@
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0}
>     >>
>     >> -=C2=A0 =C2=A0 /* If a bind address is given, only send packets fr=
om that
>     address */
>     >> +=C2=A0 =C2=A0 /* If a bind address is given, only send packets fr=
om that
>     address. */
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0if (localaddr !=3D NULL) {
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D qemu_setsockopt(fd=
, IPPROTO_IP, IP_MULTICAST_IF,
>     >>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0localaddr, sizeof(*loca=
laddr));
>     >> ```
>     >>
>     >> Regards,
>     >> Faisal Al-Humaimidi
>     >
>


