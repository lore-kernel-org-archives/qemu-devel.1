Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFD9C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16F62084F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16F62084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34789 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQr8R-0004qO-Ta
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 06:27:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQr7C-0004Aa-So
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hQr7B-0006eS-FE
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:26:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hQr7B-0006dC-6a
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:26:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 186DF30018E9;
	Wed, 15 May 2019 10:26:23 +0000 (UTC)
Received: from redhat.com (ovpn-112-65.ams2.redhat.com [10.36.112.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D3B85D9C0;
	Wed, 15 May 2019 10:26:18 +0000 (UTC)
Date: Wed, 15 May 2019 11:26:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190515102615.GB4751@redhat.com>
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-2-armbru@redhat.com>
	<2679829b-cc1d-83ce-9949-2b80d970ddec@redhat.com>
	<875zqe7b10.fsf@dusky.pond.sub.org>
	<CAFEAcA-vqnucYKuV3QKf4wBsfuXMZiC1kqrnaVcA+BEaud__Bw@mail.gmail.com>
	<877eat6xgm.fsf@dusky.pond.sub.org>
	<e562c5f5-9d01-59b0-5a4c-d040fa8b8962@redhat.com>
	<87lfz88bva.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lfz88bva.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 15 May 2019 10:26:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-bridge-helper: Fix misuse of
 isspace()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 08:34:17AM +0200, Markus Armbruster wrote:
> Jason Wang <jasowang@redhat.com> writes:
>=20
> > On 2019/5/14 =E4=B8=8B=E5=8D=888:18, Markus Armbruster wrote:
> >> Peter Maydell <peter.maydell@linaro.org> writes:
> >>
> >>> On Mon, 13 May 2019 at 14:21, Markus Armbruster <armbru@redhat.com>=
 wrote:
> >>>> Perhaps I should do it just for this file while I touch it anyway.=
  The
> >>>> question to ask: should parse_acl_file() obey the locale for white=
space
> >>>> recognition?
> >>> I vote for "no".
> >>>
> >>> Q: do we document the format of the ACL file anywhere ?
> >> Support for it was added in commit bdef79a2994, v1.1.  Just code, no
> >> documentation.
> >>
> >> Grepping for qemu-bridge-helper finds just qemu-options.hx.  Contain=
s
> >> -help output and some .texi that goes into qemu-doc and the manual p=
age.
> >> None of it mentions how qemu-bridge-helper is run, or the ACL file
> >> feature, let alone what its format might be.
> >>
> >> I'm afraid all we have is the commit message.  Which doesn't really
> >> define the file format, it merely gives a bunch of examples.
> >>
> >> As far as I can tell, qemu-bridge-helper is for use with -netdev tap=
 and
> >> -netdev bridge.
> >>
> >> Both variations of -netdev call net_bridge_run_helper() to run the
> >> helper.  First argument is -netdev parameter "helper", default usual=
ly
> >> "$prefix/libexec/qemu-bridge-helper".  Second argument is parameter
> >> "br", default "br0".
> >>
> >> If @helper contains space or tab, net_bridge_run_helper() guesses it=
s a
> >> full command, else it guesses its the name of the executable.  Bad
> >> magic.
> >>
> >> If it guesses name of executable, it execv()s this executable with
> >> arguments "--use-vnet", "--fd=3DFD", "--br=3D@bridge".
> >>
> >> If it guesses full command, it appends "--use-vnet --fd=3DFD", where=
 FD is
> >> the helper's half of the socketpair used to connect QEMU and the hel=
per.
> >> It further appends "--br=3D@bridge", unless @helper contains "--br=3D=
".
> >> More bad magic.
> >>
> >> It executes the resulting string with sh -c.  Magic cherry on top.
> >>
> >> When the helper fails, netdev creation fails.
> >>
> >> The helper we ship with QEMU unconditionally tries to read
> >> "$prefix/etc/bridge.conf".  Fatal error if this file doesn't exist.
> >> Errors in this file are fatal.  Errors in files it includes are not
> >> fatal; instead, the remainder of the erroneous file is ignored.
> >> *Boggle*
> >>
> >> As far as I can tell, libvirt runs qemu-bridge-helper itself (Paolo'=
s
> >> commit 2d80fbb14df).  Makes sense, because running QEMU with the
> >> necessary privileges would be unwise, and so would be letting it exe=
cute
> >> setuid helpers.  Also bypasses the bad magic in QEMU's
> >> net_bridge_run_helper().
> >
> >
> > I don't notice this before. Is this only for the convenience of
> > development? I guess libvirt should have native support like adding
> > port to bridge/OVS without the help any external command or script.
>=20
> Commit 2d80fbb14df hints at the reason:
>=20
>     <source type=3D'bridge'> uses a helper application to do the necess=
ary
>     TUN/TAP setup to use an existing network bridge, thus letting
>     unprivileged users use TUN/TAP interfaces.
>     ~~~~~~~~~~~~~~~~~~
>=20
> The code confirms:
>=20
>     /* qemuInterfaceBridgeConnect:
>      * @def: the definition of the VM
>      * @driver: qemu driver data
>      * @net: pointer to the VM's interface description
>      * @tapfd: array of file descriptor return value for the new device
>      * @tapfdsize: number of file descriptors in @tapfd
>      *
> ---> * Called *only* called if actualType is VIR_DOMAIN_NET_TYPE_NETWOR=
K or
> ---> * VIR_DOMAIN_NET_TYPE_BRIDGE (i.e. if the connection is made with =
a tap
>      * device connecting to a bridge device)
>      */
>     int
>     qemuInterfaceBridgeConnect(virDomainDefPtr def,
>                                virQEMUDriverPtr driver,
>                                virDomainNetDefPtr net,
>                                int *tapfd,
>                                size_t *tapfdSize)
>     {
>         [...]
> --->    if (virQEMUDriverIsPrivileged(driver)) {
>             [...]
>         } else {
>             if (qemuCreateInBridgePortWithHelper(cfg, brname,
>                                                  &net->ifname,
>                                                  tapfd, tap_create_flag=
s) < 0) {
>                 virDomainAuditNetDevice(def, net, tunpath, false);
>                 goto cleanup;
>             }
>             [...]
>         }
>         [...]
>     }
>=20
> >> qemu-bridge-helper should have a manual page, and its handling of er=
rors
> >> in ACL include files needs work.  There's probably more; I just glan=
ced
> >> at it.  I'm not volunteering, though.  It lacks a maintainer.  Shoul=
d we
> >> add it to Jason's "Network device backends"?
> >
> >
> > Yes.
> >
> >> -netdev's helper parameter is seriously underdocumented.  Document o=
r
> >> deprecate?
> >
> >
> > I believe management should only use fd parameter of TAP. If we have
> > other, it should be a duplication. So I suggest to deprecate the
> > bridge helper and -netdev bridge.
>=20
> Objections, anyone?

Libvirt runs the qemu bridge helper command directly, and we have
applications using this functionality.

I'd like libvirt to be able to avoid use of the QEMU bridge helper and
instead have unprivileged libvirt talk to privileged libvirtd to open a
TAP fd on its behalf. If we ever get that done, then libvirt would not
need the qemu bridge helper command anymore.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

