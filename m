Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A177CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:43:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3DC42082C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 16:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3DC42082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVLB-00008I-0f
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 12:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iLVK7-0007m2-7P
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iLVK6-0005lD-4U
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:41:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39922)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iLVK5-0005jX-Gx
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 12:41:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B5B4AC049E12;
 Fri, 18 Oct 2019 16:41:52 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9C713DB4;
 Fri, 18 Oct 2019 16:41:44 +0000 (UTC)
Date: Fri, 18 Oct 2019 13:41:43 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Samuel Thibault <samuel.thibault@gnu.org>
Subject: Re: Python 2 and test/vm/netbsd
Message-ID: <20191018164143.GP4084@habkost.net>
References: <20191016030021.GD4084@habkost.net>
 <a83d518a-6e39-0017-203d-2ee3d61935ca@redhat.com>
 <20191016224124.GF4084@habkost.net>
 <20191017220541.GJ4084@habkost.net>
 <20191017225548.GL4084@habkost.net>
 <20191018104439.c2tojlvi2c5zzesi@sirius.home.kraxel.org>
 <20191018142940.GN4084@habkost.net>
 <a0c2df74-360b-79de-132e-f4d5be5bfc12@redhat.com>
 <20191018160019.he52tpvjqolzgswg@function>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5uO961YFyoDlzFnP"
Content-Disposition: inline
In-Reply-To: <20191018160019.he52tpvjqolzgswg@function>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 18 Oct 2019 16:41:52 +0000 (UTC)
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, John Snow <jsnow@redhat.com>,
 Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5uO961YFyoDlzFnP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2019 at 06:00:19PM +0200, Samuel Thibault wrote:
> Philippe Mathieu-Daud=E9, le ven. 18 oct. 2019 16:58:00 +0200, a ecrit:
> > On 10/18/19 4:29 PM, Eduardo Habkost wrote:
> > > On Fri, Oct 18, 2019 at 12:44:39PM +0200, Gerd Hoffmann wrote:
> > > >    Hi,
> > > >=20
> > > > > > Running with V=3D1, I see packages being downloaded at reason=
able speeds, but
> > > > > > there's a huge interval (of various minutes) between each pac=
kage download.
> > > > >=20
> > > > > I've found the cause for the slowness I'm seeing: for each file
> > > > > being downloaded, the guest spents at least 75 seconds trying t=
o
> > > > > connect to the IPv6 address of ftp.NetBSD.org, before trying
> > > > > IPv4.
> > > >=20
> > > > Ah, that nicely explains why it worked just fine for me.  First, =
I have
> > > > a local proxy configured so the installer isn't going to connect =
to
> > > > ftp.NetBSD.org directly.  Second I have IPv6 connectivity.
> > > >=20
> > > > > I don't know if this is a NetBSD bug, or a slirp bug.
> > > >=20
> > > > Both I'd say ...
> > > >=20
> > > > First, by default slirp should not send IPv6 router announcements
> > > > to the user network if the host has no IPv6 connectivity.
> > > >=20
> > > > Second, the recommended way to connect is to try ipv4 and ipv6 in
> > > > parallel, then use whatever connects first.  Web browsers typical=
ly
> > > > do it that way.  wget and curl don't do that though, they try one
> > > > address after the other, and I guess this is where the delay come=
s
> > > > from ...
> > >=20
> > > In addition to that, the connect() error should be generating a
> > > ICMP6_UNREACH message, and I'd expect the NetBSD guest to notice
> > > it instead of waiting for timeout.
> >=20
> > Is this missing in SLiRP?
>=20
> It was implemented at the time of introduction of IPv6 in SLIRP. Perhap=
s
> NetBSD has a slightly different behavior which makes the implementation
> fail to notice the error.

If anybody is interested in investigating it, a network traffic
dump generated by `-object filter-dump` is attached.

--=20
Eduardo

--5uO961YFyoDlzFnP
Content-Type: application/gzip
Content-Disposition: attachment; filename="dump.pcap.gz"
Content-Transfer-Encoding: base64

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
bpl2wediFHZ/Aje85bc5HQAA

--5uO961YFyoDlzFnP--

