Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111C8C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 05:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D945320644
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 05:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D945320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58121 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSapN-0002oV-2G
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 01:27:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hSaoe-0002XM-1X
	for qemu-devel@nongnu.org; Mon, 20 May 2019 01:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hSaod-0003If-79
	for qemu-devel@nongnu.org; Mon, 20 May 2019 01:26:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hSaod-0003Gj-1u
	for qemu-devel@nongnu.org; Mon, 20 May 2019 01:26:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 505493086262;
	Mon, 20 May 2019 05:26:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2A27E1001938;
	Mon, 20 May 2019 05:26:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 6B13B1751C; Mon, 20 May 2019 07:26:15 +0200 (CEST)
Date: Mon, 20 May 2019 07:26:15 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Message-ID: <20190520052615.ty2bpmxdoajjqvk6@sirius.home.kraxel.org>
References: <20190510104633.9428-1-kraxel@redhat.com>
	<20190510104633.9428-11-kraxel@redhat.com>
	<40966599-9a55-8078-bc49-e2597ce5d498@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <40966599-9a55-8078-bc49-e2597ce5d498@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Mon, 20 May 2019 05:26:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 10/13] tests/vm: freebsd autoinstall,
 using serial console
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 19, 2019 at 12:55:09AM +0200, Philippe Mathieu-Daud=E9 wrote:
> Hi Gerd,
>=20
> On 5/10/19 12:46 PM, Gerd Hoffmann wrote:
> > Instead of fetching the prebuilt image from patchew download the inst=
all
> > iso and prepare the image locally.  Install to disk, using the serial
> > console.  Create qemu user, configure ssh login.  Install packages
> > needed for qemu builds.
>=20
> I'm impressed how charmly this works :)
>=20
> 3 comments so far.
>=20
> 1/ We could record (in tests/vm/freebsd header?) roughly how many local
> storage will be used (or display in 'make vm-help'?). FYI this image
> takes ~3.1GiB.

vm-help would be more useful I think.

> 2/ "Autoboot in 9 seconds, hit [Enter] to boot or any other key to stop=
"

Probably tweakable via loader.conf, I'll check.

> 3/ I am a bit annoyed it overwrote my previous
> ~/.cache/qemu-vm/images/freebsd.img VM. Not sure what's the best hash t=
o
> use, maybe "git log -n 1 --pretty=3Dformat:%H -- tests/vm/freebsd"?
> (Similarly for other images).

Then use ~/.cache/qemu-vm/images/freebsd-${hash}.img ?

Which will fill ~/.cache/qemu-vm/images with stale images over time,
which isn't great either ...

Or do you have something else in mind?

cheers,
  Gerd


