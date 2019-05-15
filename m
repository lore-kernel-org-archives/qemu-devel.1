Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8BCC04E87
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 14:59:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83572206BF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 14:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83572206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38235 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQvN9-0002bE-R6
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 10:59:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQvLE-0001HS-OS
	for qemu-devel@nongnu.org; Wed, 15 May 2019 10:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQvIW-00006i-4U
	for qemu-devel@nongnu.org; Wed, 15 May 2019 10:54:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQvIP-0008Li-55
	for qemu-devel@nongnu.org; Wed, 15 May 2019 10:54:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4621D300DA33;
	Wed, 15 May 2019 14:54:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D9B1919C7C;
	Wed, 15 May 2019 14:54:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 5C94911385E4; Wed, 15 May 2019 16:54:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-2-armbru@redhat.com>
	<2679829b-cc1d-83ce-9949-2b80d970ddec@redhat.com>
	<875zqe7b10.fsf@dusky.pond.sub.org>
	<CAFEAcA-vqnucYKuV3QKf4wBsfuXMZiC1kqrnaVcA+BEaud__Bw@mail.gmail.com>
	<877eat6xgm.fsf@dusky.pond.sub.org>
	<e562c5f5-9d01-59b0-5a4c-d040fa8b8962@redhat.com>
	<87lfz88bva.fsf@dusky.pond.sub.org> <20190515102615.GB4751@redhat.com>
Date: Wed, 15 May 2019 16:54:04 +0200
In-Reply-To: <20190515102615.GB4751@redhat.com> ("Daniel P. =?utf-8?Q?Berr?=
	=?utf-8?Q?ang=C3=A9=22's?=
	message of "Wed, 15 May 2019 11:26:15 +0100")
Message-ID: <87a7fn6a5v.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Wed, 15 May 2019 14:54:10 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, May 15, 2019 at 08:34:17AM +0200, Markus Armbruster wrote:
>> Jason Wang <jasowang@redhat.com> writes:
>>=20
>> > On 2019/5/14 =E4=B8=8B=E5=8D=888:18, Markus Armbruster wrote:
>> >> Peter Maydell <peter.maydell@linaro.org> writes:
>> >>
>> >>> On Mon, 13 May 2019 at 14:21, Markus Armbruster <armbru@redhat.com> =
wrote:
>> >>>> Perhaps I should do it just for this file while I touch it anyway. =
 The
>> >>>> question to ask: should parse_acl_file() obey the locale for whites=
pace
>> >>>> recognition?
>> >>> I vote for "no".
>> >>>
>> >>> Q: do we document the format of the ACL file anywhere ?
>> >> Support for it was added in commit bdef79a2994, v1.1.  Just code, no
>> >> documentation.
>> >>
>> >> Grepping for qemu-bridge-helper finds just qemu-options.hx.  Contains
>> >> -help output and some .texi that goes into qemu-doc and the manual pa=
ge.
>> >> None of it mentions how qemu-bridge-helper is run, or the ACL file
>> >> feature, let alone what its format might be.
>> >>
>> >> I'm afraid all we have is the commit message.  Which doesn't really
>> >> define the file format, it merely gives a bunch of examples.
>> >>
>> >> As far as I can tell, qemu-bridge-helper is for use with -netdev tap =
and
>> >> -netdev bridge.
>> >>
>> >> Both variations of -netdev call net_bridge_run_helper() to run the
>> >> helper.  First argument is -netdev parameter "helper", default usually
>> >> "$prefix/libexec/qemu-bridge-helper".  Second argument is parameter
>> >> "br", default "br0".
>> >>
>> >> If @helper contains space or tab, net_bridge_run_helper() guesses its=
 a
>> >> full command, else it guesses its the name of the executable.  Bad
>> >> magic.
>> >>
>> >> If it guesses name of executable, it execv()s this executable with
>> >> arguments "--use-vnet", "--fd=3DFD", "--br=3D@bridge".
>> >>
>> >> If it guesses full command, it appends "--use-vnet --fd=3DFD", where =
FD is
>> >> the helper's half of the socketpair used to connect QEMU and the help=
er.
>> >> It further appends "--br=3D@bridge", unless @helper contains "--br=3D=
".
>> >> More bad magic.
>> >>
>> >> It executes the resulting string with sh -c.  Magic cherry on top.
>> >>
>> >> When the helper fails, netdev creation fails.
>> >>
>> >> The helper we ship with QEMU unconditionally tries to read
>> >> "$prefix/etc/bridge.conf".  Fatal error if this file doesn't exist.
>> >> Errors in this file are fatal.  Errors in files it includes are not
>> >> fatal; instead, the remainder of the erroneous file is ignored.
>> >> *Boggle*
>> >>
>> >> As far as I can tell, libvirt runs qemu-bridge-helper itself (Paolo's
>> >> commit 2d80fbb14df).  Makes sense, because running QEMU with the
>> >> necessary privileges would be unwise, and so would be letting it exec=
ute
>> >> setuid helpers.  Also bypasses the bad magic in QEMU's
>> >> net_bridge_run_helper().
>> >
>> >
>> > I don't notice this before. Is this only for the convenience of
>> > development? I guess libvirt should have native support like adding
>> > port to bridge/OVS without the help any external command or script.
>>=20
>> Commit 2d80fbb14df hints at the reason:
>>=20
>>     <source type=3D'bridge'> uses a helper application to do the necessa=
ry
>>     TUN/TAP setup to use an existing network bridge, thus letting
>>     unprivileged users use TUN/TAP interfaces.
>>     ~~~~~~~~~~~~~~~~~~
>>=20
>> The code confirms:
>>=20
>>     /* qemuInterfaceBridgeConnect:
>>      * @def: the definition of the VM
>>      * @driver: qemu driver data
>>      * @net: pointer to the VM's interface description
>>      * @tapfd: array of file descriptor return value for the new device
>>      * @tapfdsize: number of file descriptors in @tapfd
>>      *
>> ---> * Called *only* called if actualType is VIR_DOMAIN_NET_TYPE_NETWORK=
 or
>> ---> * VIR_DOMAIN_NET_TYPE_BRIDGE (i.e. if the connection is made with a=
 tap
>>      * device connecting to a bridge device)
>>      */
>>     int
>>     qemuInterfaceBridgeConnect(virDomainDefPtr def,
>>                                virQEMUDriverPtr driver,
>>                                virDomainNetDefPtr net,
>>                                int *tapfd,
>>                                size_t *tapfdSize)
>>     {
>>         [...]
>> --->    if (virQEMUDriverIsPrivileged(driver)) {
>>             [...]
>>         } else {
>>             if (qemuCreateInBridgePortWithHelper(cfg, brname,
>>                                                  &net->ifname,
>>                                                  tapfd, tap_create_flags=
) < 0) {
>>                 virDomainAuditNetDevice(def, net, tunpath, false);
>>                 goto cleanup;
>>             }
>>             [...]
>>         }
>>         [...]
>>     }
>>=20
>> >> qemu-bridge-helper should have a manual page, and its handling of err=
ors
>> >> in ACL include files needs work.  There's probably more; I just glanc=
ed
>> >> at it.  I'm not volunteering, though.  It lacks a maintainer.  Should=
 we
>> >> add it to Jason's "Network device backends"?
>> >
>> >
>> > Yes.
>> >
>> >> -netdev's helper parameter is seriously underdocumented.  Document or
>> >> deprecate?
>> >
>> >
>> > I believe management should only use fd parameter of TAP. If we have
>> > other, it should be a duplication. So I suggest to deprecate the
>> > bridge helper and -netdev bridge.
>>=20
>> Objections, anyone?
>
> Libvirt runs the qemu bridge helper command directly, and we have
> applications using this functionality.

Specifically, when libvirt lacks the privileges to set up a TAP fd, it
farms out the job to setuid qemu-bridge-helper.  Correct?

> I'd like libvirt to be able to avoid use of the QEMU bridge helper and
> instead have unprivileged libvirt talk to privileged libvirtd to open a
> TAP fd on its behalf. If we ever get that done, then libvirt would not
> need the qemu bridge helper command anymore.

We don't want to deprecate qemu-bridge-helper while libvirt has a
sensible use for it.

We can still deprecate -netdev tap parameter "helper" and -netdev bridge
entirely.

Once they're gone, qemu-bridge-helper wull have no user within QEMU.  We
could discuss moving it to libvirt then, but I doubt it'll be worth the
trouble.

