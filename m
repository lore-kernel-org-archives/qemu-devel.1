Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9520CC5ACC4
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 02:36:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B3424656
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 02:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwAI+m2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B3424656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4bhO-00049g-Dq
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 21:36:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laine@redhat.com>) id 1j4bgm-0003kI-DE
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 21:35:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laine@redhat.com>) id 1j4bgk-0004MF-2K
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 21:35:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29760
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laine@redhat.com>) id 1j4bgj-0004IB-UX
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 21:35:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582166138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ssSNVnJMLsw0ZQgl0RKPIWnKYH3WyRdAwiv66/J/tyU=;
 b=FwAI+m2VvnapOKkgUs1Czneb6JAS/EiuI7T1Hp2Rz4XXyHbUKw7jHW50oV5dkUKYqn0pYi
 PjyVY9DUvmrfGha06w88pxkgiahOfGySHNDWCX8AP+CGj7ne9EJtAzNPZuJU3pEI9gskeq
 CFbfZqNlwCj5map1nSeTw/zUGUYL3rQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-TUwb9gl9N0mH_1KOlPkHBw-1; Wed, 19 Feb 2020 21:35:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FA9218A6EC0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2020 02:35:31 +0000 (UTC)
Received: from [10.10.125.146] (ovpn-125-146.rdu2.redhat.com [10.10.125.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DD0028AC5B;
 Thu, 20 Feb 2020 02:35:22 +0000 (UTC)
Subject: Re: [PATCH v2] pcie_root_port: Add enable_hotplug option
To: qemu-devel@nongnu.org
References: <20200219145540.648365-1-jusual@redhat.com>
From: Laine Stump <laine@redhat.com>
Message-ID: <0bf5b8fd-5ea7-b285-823e-54bb6482970c@redhat.com>
Date: Wed, 19 Feb 2020 21:35:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219145540.648365-1-jusual@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: TUwb9gl9N0mH_1KOlPkHBw-1
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
Cc: =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Julia Suvorova <jusual@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/19/20 9:55 AM, Julia Suvorova wrote:
> Make hot-plug/hot-unplug on PCIe Root Ports optional to allow libvirt
> manage it and restrict unplug for the whole machine. This is going to
> prevent user-initiated unplug in guests (Windows mostly).
> Hotplug is enabled by default.
> Usage:
>      -device pcie-root-port,enable-hotplug=3Dfalse,...
>=20
> If you want to disable hot-unplug on some downstream ports of one
> switch, disable hot-unplug on PCIe Root Port connected to the upstream
> port as well as on the selected downstream ports.
>=20
> Discussion related:
>      https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg00530.html
>=20
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
> v1: https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg04868.html
>=20
> v2:
>      * change name of the option to 'enable-hotplug' [Laine]


Heh... I didn't actually expect you to do that just for me :-)=20
(especially since I guess nobody else was bothered by "disable"). But=20
now that you did, I look at it and realize that the "enable-" part is=20
redundant, ie. just "hotplug=3Don|off|true|false" is plenty descriptive=20
(since it's implied that it's being enabled).

But I've already created too much of a tempest over such a tiny detail,=20
and kind of wish I'd just kept quiet instead...

I'll try to test this with libvirt in the next day or two.


>      * change order of enabling capability bits [Igor]
>      * enable HPS bit [Igor]
>      * add option to xio3130_downstream [J=C3=A1n]
>=20


