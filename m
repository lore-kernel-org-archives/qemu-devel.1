Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F1FC04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 21:43:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC16206BF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 21:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC16206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34345 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNlNz-0004YU-Km
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 17:42:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hNlN5-0004Bs-3M
	for qemu-devel@nongnu.org; Mon, 06 May 2019 17:42:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hNlN4-0001Tp-2l
	for qemu-devel@nongnu.org; Mon, 06 May 2019 17:42:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>)
	id 1hNlN1-0001RM-Qa; Mon, 06 May 2019 17:41:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F6DD81E0D;
	Mon,  6 May 2019 21:41:59 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9CEFA5DA99;
	Mon,  6 May 2019 21:41:56 +0000 (UTC)
Date: Mon, 6 May 2019 18:41:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190506214155.GI28722@habkost.net>
References: <20190312234541.2887-1-philmd@redhat.com>
	<d5d84efd-ef8c-4e0d-d48a-6996d91832e7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d5d84efd-ef8c-4e0d-d48a-6996d91832e7@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Mon, 06 May 2019 21:41:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Acceptance Tests: Test the
 Raspberry Pi 2 board
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>,
	Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 04, 2019 at 01:52:51PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 3/13/19 12:45 AM, Philippe Mathieu-Daud=E9 wrote:
> > Add the raspi2 to the list of boards tested by the
> > boot_linux_console Avocado test.
> >=20
> > Based on "Acceptance Tests: target architecture support" v5:
> > https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg04111.html
> > Based-on: <20190312171824.5134-1-crosa@redhat.com>
> >=20
> > Philippe Mathieu-Daud=E9 (2):
> >   BootLinuxConsoleTest: Let extract_from_deb handle various compressi=
ons
> >   Boot Linux Console Test: add a test for the Raspberry Pi 2
> >=20
> >  tests/acceptance/boot_linux_console.py | 34 ++++++++++++++++++++++++=
--
> >  1 file changed, 32 insertions(+), 2 deletions(-)
>=20
> I was hoping this series would be included in "Acceptance Tests: target
> architecture support" by Eduardo (removing the 'print' debug line) but =
I
> just realized I forgot to Cc him :S

Problem solved: queued on python-next (after removing the print
statement from patch 2/2).  :)

--=20
Eduardo

