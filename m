Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7F1C04AA7
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 06:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B254620862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 06:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B254620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60599 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQnnB-0005UR-VX
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 02:53:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQnir-0001qi-F5
	for qemu-devel@nongnu.org; Wed, 15 May 2019 02:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hQnUe-00020b-6p
	for qemu-devel@nongnu.org; Wed, 15 May 2019 02:34:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hQnUd-0001tC-U0
	for qemu-devel@nongnu.org; Wed, 15 May 2019 02:34:24 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 479D2307D978;
	Wed, 15 May 2019 06:34:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AC11A608AB;
	Wed, 15 May 2019 06:34:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 304C411385E4; Wed, 15 May 2019 08:34:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jason Wang <jasowang@redhat.com>
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-2-armbru@redhat.com>
	<2679829b-cc1d-83ce-9949-2b80d970ddec@redhat.com>
	<875zqe7b10.fsf@dusky.pond.sub.org>
	<CAFEAcA-vqnucYKuV3QKf4wBsfuXMZiC1kqrnaVcA+BEaud__Bw@mail.gmail.com>
	<877eat6xgm.fsf@dusky.pond.sub.org>
	<e562c5f5-9d01-59b0-5a4c-d040fa8b8962@redhat.com>
Date: Wed, 15 May 2019 08:34:17 +0200
In-Reply-To: <e562c5f5-9d01-59b0-5a4c-d040fa8b8962@redhat.com> (Jason Wang's
	message of "Wed, 15 May 2019 12:04:43 +0800")
Message-ID: <87lfz88bva.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Wed, 15 May 2019 06:34:22 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jason Wang <jasowang@redhat.com> writes:

> On 2019/5/14 =E4=B8=8B=E5=8D=888:18, Markus Armbruster wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> On Mon, 13 May 2019 at 14:21, Markus Armbruster <armbru@redhat.com> wro=
te:
>>>> Perhaps I should do it just for this file while I touch it anyway.  The
>>>> question to ask: should parse_acl_file() obey the locale for whitespace
>>>> recognition?
>>> I vote for "no".
>>>
>>> Q: do we document the format of the ACL file anywhere ?
>> Support for it was added in commit bdef79a2994, v1.1.  Just code, no
>> documentation.
>>
>> Grepping for qemu-bridge-helper finds just qemu-options.hx.  Contains
>> -help output and some .texi that goes into qemu-doc and the manual page.
>> None of it mentions how qemu-bridge-helper is run, or the ACL file
>> feature, let alone what its format might be.
>>
>> I'm afraid all we have is the commit message.  Which doesn't really
>> define the file format, it merely gives a bunch of examples.
>>
>> As far as I can tell, qemu-bridge-helper is for use with -netdev tap and
>> -netdev bridge.
>>
>> Both variations of -netdev call net_bridge_run_helper() to run the
>> helper.  First argument is -netdev parameter "helper", default usually
>> "$prefix/libexec/qemu-bridge-helper".  Second argument is parameter
>> "br", default "br0".
>>
>> If @helper contains space or tab, net_bridge_run_helper() guesses its a
>> full command, else it guesses its the name of the executable.  Bad
>> magic.
>>
>> If it guesses name of executable, it execv()s this executable with
>> arguments "--use-vnet", "--fd=3DFD", "--br=3D@bridge".
>>
>> If it guesses full command, it appends "--use-vnet --fd=3DFD", where FD =
is
>> the helper's half of the socketpair used to connect QEMU and the helper.
>> It further appends "--br=3D@bridge", unless @helper contains "--br=3D".
>> More bad magic.
>>
>> It executes the resulting string with sh -c.  Magic cherry on top.
>>
>> When the helper fails, netdev creation fails.
>>
>> The helper we ship with QEMU unconditionally tries to read
>> "$prefix/etc/bridge.conf".  Fatal error if this file doesn't exist.
>> Errors in this file are fatal.  Errors in files it includes are not
>> fatal; instead, the remainder of the erroneous file is ignored.
>> *Boggle*
>>
>> As far as I can tell, libvirt runs qemu-bridge-helper itself (Paolo's
>> commit 2d80fbb14df).  Makes sense, because running QEMU with the
>> necessary privileges would be unwise, and so would be letting it execute
>> setuid helpers.  Also bypasses the bad magic in QEMU's
>> net_bridge_run_helper().
>
>
> I don't notice this before. Is this only for the convenience of
> development? I guess libvirt should have native support like adding
> port to bridge/OVS without the help any external command or script.

Commit 2d80fbb14df hints at the reason:

    <source type=3D'bridge'> uses a helper application to do the necessary
    TUN/TAP setup to use an existing network bridge, thus letting
    unprivileged users use TUN/TAP interfaces.
    ~~~~~~~~~~~~~~~~~~

The code confirms:

    /* qemuInterfaceBridgeConnect:
     * @def: the definition of the VM
     * @driver: qemu driver data
     * @net: pointer to the VM's interface description
     * @tapfd: array of file descriptor return value for the new device
     * @tapfdsize: number of file descriptors in @tapfd
     *
---> * Called *only* called if actualType is VIR_DOMAIN_NET_TYPE_NETWORK or
---> * VIR_DOMAIN_NET_TYPE_BRIDGE (i.e. if the connection is made with a tap
     * device connecting to a bridge device)
     */
    int
    qemuInterfaceBridgeConnect(virDomainDefPtr def,
                               virQEMUDriverPtr driver,
                               virDomainNetDefPtr net,
                               int *tapfd,
                               size_t *tapfdSize)
    {
        [...]
--->    if (virQEMUDriverIsPrivileged(driver)) {
            [...]
        } else {
            if (qemuCreateInBridgePortWithHelper(cfg, brname,
                                                 &net->ifname,
                                                 tapfd, tap_create_flags) <=
 0) {
                virDomainAuditNetDevice(def, net, tunpath, false);
                goto cleanup;
            }
            [...]
        }
        [...]
    }

>> qemu-bridge-helper should have a manual page, and its handling of errors
>> in ACL include files needs work.  There's probably more; I just glanced
>> at it.  I'm not volunteering, though.  It lacks a maintainer.  Should we
>> add it to Jason's "Network device backends"?
>
>
> Yes.
>
>> -netdev's helper parameter is seriously underdocumented.  Document or
>> deprecate?
>
>
> I believe management should only use fd parameter of TAP. If we have
> other, it should be a duplication. So I suggest to deprecate the
> bridge helper and -netdev bridge.

Objections, anyone?

