Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37121C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0981A205ED
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0981A205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iblSs-0002Fl-7d
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 08:10:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iblQK-0000xg-Fd
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iblQJ-0003PK-56
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:07:32 -0500
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:44856)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iblQI-0003Op-V2
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:07:31 -0500
Received: from player716.ha.ovh.net (unknown [10.108.35.128])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 8FA5114BF82
 for <qemu-devel@nongnu.org>; Mon,  2 Dec 2019 14:07:28 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player716.ha.ovh.net (Postfix) with ESMTPSA id 0B0C1CBB0105;
 Mon,  2 Dec 2019 13:07:20 +0000 (UTC)
Date: Mon, 2 Dec 2019 14:07:19 +0100
From: Greg Kurz <groug@kaod.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] docker: remove libcap development packages
Message-ID: <20191202140719.05204718@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191202114958.606de16f@bahia.w3ibm.bluemix.net>
References: <20191129150801.26654-1-pbonzini@redhat.com>
 <20191202114958.606de16f@bahia.w3ibm.bluemix.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 905223527624841678
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudejhedgheduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejfedtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeduiedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.63.100
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
Cc: Fam Zheng <fam@euphon.net>, berrange@redhat.com,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Dec 2019 11:49:58 +0100
Greg Kurz <groug@kaod.org> wrote:

> On Fri, 29 Nov 2019 16:08:01 +0100
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > Libcap was dropped from virtio-9p, so remove it from the dockerfiles as well.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> 
> Similarly to what was discussed in these threads:
> 
> 20191129111632.22840-2-pbonzini@redhat.com
> 
> 20191129142126.32967-1-dgilbert@redhat.com
> 
> I'm ok to take this one in my tree as well if I get an ack from Alex
> or Fam.
> 

Oops, I didn't realize my mail client still had Fam's previous address...

> >  tests/docker/dockerfiles/fedora.docker     | 1 -
> >  tests/docker/dockerfiles/ubuntu.docker     | 1 -
> >  tests/docker/dockerfiles/ubuntu1804.docker | 1 -
> >  3 files changed, 3 deletions(-)
> > 
> > diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> > index 4ddc7dd112..47732fc5d5 100644
> > --- a/tests/docker/dockerfiles/fedora.docker
> > +++ b/tests/docker/dockerfiles/fedora.docker
> > @@ -25,7 +25,6 @@ ENV PACKAGES \
> >      libasan \
> >      libattr-devel \
> >      libblockdev-mpath-devel \
> > -    libcap-devel \
> >      libcap-ng-devel \
> >      libcurl-devel \
> >      libfdt-devel \
> > diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/dockerfiles/ubuntu.docker
> > index f486492224..ecea155646 100644
> > --- a/tests/docker/dockerfiles/ubuntu.docker
> > +++ b/tests/docker/dockerfiles/ubuntu.docker
> > @@ -23,7 +23,6 @@ ENV PACKAGES flex bison \
> >      libbrlapi-dev \
> >      libbz2-dev \
> >      libcacard-dev \
> > -    libcap-dev \
> >      libcap-ng-dev \
> >      libcurl4-gnutls-dev \
> >      libdrm-dev \
> > diff --git a/tests/docker/dockerfiles/ubuntu1804.docker b/tests/docker/dockerfiles/ubuntu1804.docker
> > index 3cc4f492c4..32a607471a 100644
> > --- a/tests/docker/dockerfiles/ubuntu1804.docker
> > +++ b/tests/docker/dockerfiles/ubuntu1804.docker
> > @@ -12,7 +12,6 @@ ENV PACKAGES flex bison \
> >      libbrlapi-dev \
> >      libbz2-dev \
> >      libcacard-dev \
> > -    libcap-dev \
> >      libcap-ng-dev \
> >      libcurl4-gnutls-dev \
> >      libdrm-dev \
> 
> 


