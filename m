Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E97CA9EC9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 05:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC09220650
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 05:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC09220650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQPV8-0005At-Rg
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 01:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@pond.sub.org>) id 1iQPUK-0004j9-8Z
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 01:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@pond.sub.org>) id 1iQPUI-0003EU-Ok
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 01:28:44 -0400
Received: from oxygen.pond.sub.org ([2a01:4f8:13b:3ad0:1::3]:39086)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@pond.sub.org>) id 1iQPUG-0003Bj-Ki
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 01:28:40 -0400
Received: from blackfin.pond.sub.org
 (p200300D36F1EBC00DACB8AFFFEE0C842.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f1e:bc00:dacb:8aff:fee0:c842])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 1A13E3B8FE;
 Fri,  1 Nov 2019 06:28:34 +0100 (CET)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B5C0B11385C9; Fri,  1 Nov 2019 06:28:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH] fw_cfg: Allow reboot-timeout=-1 again
References: <20191025165706.177653-1-dgilbert@redhat.com>
 <87a79o4jjb.fsf@dusky.pond.sub.org> <20191028134700.GB2961@work-vm>
 <87lft3sqhf.fsf@dusky.pond.sub.org> <20191029125641.GC16329@work-vm>
 <CAHjf+S_KfDQeC_k997_PKSgP6v8LQgNh1HYt9JPRM-Ds+POADg@mail.gmail.com>
 <20191031133549.GC3128@work-vm>
Date: Fri, 01 Nov 2019 06:28:31 +0100
Message-ID: <87y2x0jhc0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:13b:3ad0:1::3
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
Cc: Karen Noel <knoel@redhat.com>, Jaroslav Suchanek <jsuchane@redhat.com>,
 lersek@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org,
 Han Han <hhan@redhat.com>, philmd@redhat.com, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Han Han (hhan@redhat.com) wrote:
>> However, another important question is: how can we avoid such undocumented
>> incompatibility appears again?
>
> The reboot-timeout one was accidental - it was a documented qemu
> feature; just no one noticed it when the input check was added.

Yes.  Mistakes happen.  Integration tests can catch them.  Perfection is
impossible there as well, though.

> Officially if we actually want to deprecate a feature we should actually
> follow qemu's deprecation guidelines.

Yes.

>> I can show another case caused by such incompatibile change:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1745868#c0
>> 
>> For the qemu devices, attributes, values, qmp cmds, qmp cmds arguments used
>> by libvirt, could we get a way to inform libvirt
>> that an incompatibile qemu change is coming, please update libvirt code
>> ASAP to adjust to that change?
>> Or another way that is more gently:  popping up the warning of depreciation
>> instead of  dropping it, and then drop it in the version
>> after next version.
>
> Yes that should happen;

No argument.  The question is how.  I'm working on making it easier to
do and easier to consume for QAPI interfaces, i.e. most of QMP.

>                          with deprecated devices it's easier than more
> subtle features like command line things;  I'm not sure how that gets
> introspected.  I thought libvirt already asked qemu for a list of
> devices, so I'm confused why libvirt didn't spot it before starting the
> VM in 1745868.

Command line isn't really introspectable (see my KVM Forum 2017 talk).

That said, the list of devices *is* introspectable with QMP:

    {"execute": "qom-list-types",
     "arguments": {"implements": "device", "abstract": false}}

I'm not sure what exactly goes wrong in RHBZ 1745868.

