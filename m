Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC052C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 08:25:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD50E20637
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 08:25:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD50E20637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icPy1-0006zG-Tj
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 03:25:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1icPmp-0004fG-Av
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1icPmU-0006Gq-5H
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:13:24 -0500
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:37639)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1icPmT-00069a-LO
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 03:13:05 -0500
Received: from player779.ha.ovh.net (unknown [10.108.1.170])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 165FF722CF
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 09:12:58 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player779.ha.ovh.net (Postfix) with ESMTPSA id 1C60ACC40C09;
 Wed,  4 Dec 2019 08:12:55 +0000 (UTC)
Date: Wed, 4 Dec 2019 09:12:53 +0100
From: Greg Kurz <groug@kaod.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] travis.yml: Drop libcap-dev
Message-ID: <20191204091253.221cacbc@bahia.w3ibm.bluemix.net>
In-Reply-To: <69a9224c-4686-cd09-1a89-81954af6f902@redhat.com>
References: <157544579267.3537077.17459176619888583836.stgit@bahia.lan>
 <69a9224c-4686-cd09-1a89-81954af6f902@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7676948515854129458
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudejkedguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.52.203
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
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Dec 2019 09:07:42 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 04/12/2019 09.01, Greg Kurz wrote:
> > Commit b1553ab12fe0 converted virtfs-proxy-helper to using libcap-ng. There
> > aren't any users of libcap anymore. No need to install libcap-dev.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > 
> > Yet another follow-up to Paolo's patch to use libcap-ng instead of libcap.
> > Like with the docker and the gitlab CI patches, if I get an ack from Alex
> > I'll gladly merge this in the 9p tree and send a PR as soon as 5.0 dev
> > begins. I'll make sure the SHA1 for Paolo's patch remains the same.
> 
> I hope you don't have to rebase! Otherwise simply say "One of the
> previous changes ..." or so in the commit message instead.
> 

I don't expect to rebase, hence the SHA1.

> >  .travis.yml |    1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/.travis.yml b/.travis.yml
> > index 445b0646c18a..6cb8af6fa599 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -26,7 +26,6 @@ addons:
> >        - libaio-dev
> >        - libattr1-dev
> >        - libbrlapi-dev
> > -      - libcap-dev
> >        - libcap-ng-dev
> >        - libgcc-4.8-dev
> >        - libgnutls28-dev
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 

Thanks.

