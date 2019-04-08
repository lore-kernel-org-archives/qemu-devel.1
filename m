Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06B8C10F14
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 22:35:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86D10213F2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 22:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fH2cxdjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D10213F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59963 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDcru-0004uf-H8
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 18:35:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1hDcqz-0004Ru-0a
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 18:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1hDcqx-0005FP-Ql
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 18:35:00 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>)
	id 1hDcqu-00054z-Kd; Mon, 08 Apr 2019 18:34:56 -0400
Received: by mail-ot1-x341.google.com with SMTP id e80so13766134ote.5;
	Mon, 08 Apr 2019 15:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
	:cc:references:message-id:user-agent:subject:date;
	bh=x7wXYYZc1cEXDL1nwHNxB7Gy60QdFbpjWW3W3jEI060=;
	b=fH2cxdjZJ+A1QLI7+cKUVzXWLGXk3zcoEkIM4Ub3vRM+g6URzO9q5HfWD9Oj3zFs8f
	7J8TVA2OytrPbIY2vqN2iyuXYquUEysIEJBhU7h39f+ZnZJ5IPKfkonMa0pdPpJ/DKw9
	OhKKvf9H7d3100B5AXC1hrsbasW8R8ZxoA+3aHEIuWM5af/bD/YMvw354jrh/a73hGVb
	z/KcM9Tm1i71sZEF30BB4pt131SyCkZWlywkVUrdssKGoxXUsIRu83275vbyCA5OEVhi
	sSgI6eZj46qskFjAu6fKZccxfAuPl+S9pbNOkVGeRb3W6h8nlhioFP9Q9pPm0F6f4azg
	NfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
	:from:in-reply-to:cc:references:message-id:user-agent:subject:date;
	bh=x7wXYYZc1cEXDL1nwHNxB7Gy60QdFbpjWW3W3jEI060=;
	b=rZ3eZ6+9m+8DkJ9wVWmHMyvVqSBGtK4Q4UUWOkPZVrIekULwVImPa915QrP6pomVG6
	6K4RO24d2J+3Xji4CpjGWONn5vX2FvJQE7cU0lmO8pRbsSrf6kg49dPSqvXZs4gVQdjv
	M7sl1SyRRpgiS6b1lJzoX5C4ks2dTdGilF2iddvHqD7laWotvcq4vyIetdJjguOTA7XP
	adKUpt1BeKjUnlQ2iJj9+XzM8z+VgUhTGzqUVz11AYNQpMldD5IyW9MyIKgg7btFAnnh
	uLsTJrKWhsy4m6t+fMr4OBJHqZ6OAFgT0/kDGJXylJIY88u+kNd7+FeNxvV7WmmMoJcA
	/leA==
X-Gm-Message-State: APjAAAXCTUkL/ZgD8YV3CsYKpHiURs5v7fmy6m/UEJY1+/tcTdSrC4fd
	+8U1MCfEtm53ax/pr1+QdzA=
X-Google-Smtp-Source: APXvYqzO5wq7QxZXzIedO8TMjlyngQLgjbaJ8YcTiwgqmjpQsmQKjTWxDmC7AfQLfKV7cp3kAbIwUw==
X-Received: by 2002:a05:6830:15:: with SMTP id
	c21mr20368191otp.182.1554762895185; 
	Mon, 08 Apr 2019 15:34:55 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
	[76.251.165.188]) by smtp.gmail.com with ESMTPSA id
	m21sm12886125otj.48.2019.04.08.15.34.53
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 08 Apr 2019 15:34:53 -0700 (PDT)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190408183156.1f71c21d@bahia.lan>
References: <20190327204102.20925-1-maxiwell@linux.ibm.com>
	<20190328142151.7b0e00dd@bahia.lab.toulouse-stg.fr.ibm.com>
	<20190328183923.lcd3p6fpy4qvvxoo@maxibm>
	<20190329132951.451d4ef0@bahia.lan>
	<20190408042149.GH16627@umbus.fritz.box>
	<20190408183156.1f71c21d@bahia.lan>
Message-ID: <155476288881.5793.5351161802797300445@sif>
User-Agent: alot/0.7
Date: Mon, 08 Apr 2019 17:34:48 -0500
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v7 0/2] spapr-rtas: add ibm,
 get-vpd RTAS interface
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	"Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408223448.TuhQnRe1Z4LfS_KR9Efl7tEVKmr5U2fhqv86k6NgTfI@z>

Quoting Greg Kurz (2019-04-08 11:31:56)
> On Mon, 8 Apr 2019 14:21:50 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
> =

> > On Fri, Mar 29, 2019 at 01:29:51PM +0100, Greg Kurz wrote:
> > > On Thu, 28 Mar 2019 15:39:45 -0300
> > > "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
> > >   =

> > > > Hi,
> > > > =

> > > > On Thu, Mar 28, 2019 at 02:21:51PM +0100, Greg Kurz wrote:  =

> > > > > On Wed, 27 Mar 2019 17:41:00 -0300
> > > > > "Maxiwell S. Garcia" <maxiwell@linux.ibm.com> wrote:
> > > > >     =

> > > > > > Here are two patches to add a handler for ibm,get-vpd RTAS call=
s.
> > > > > > This RTAS exposes host information in case of set QEMU options
> > > > > > 'host-serial' and 'host-model' as 'passthrough'.
> > > > > > =

> > > > > > The patch 1 creates helper functions to get valid 'host-serial'
> > > > > > and 'host-model' parameters, guided by QEMU command line. These
> > > > > > parameters are useful to build the guest device tree and to ret=
urn
> > > > > > get-vpd RTAS calls. The patch 2 adds the ibm,get-vpd itself.
> > > > > > =

> > > > > > Update v7:
> > > > > > * rtas_get_vpd_fields as a static array in spapr machine state
> > > > > > =

> > > > > > Maxiwell S. Garcia (2):
> > > > > >   spapr: helper functions to get valid host fields
> > > > > >   spapr-rtas: add ibm,get-vpd RTAS interface
> > > > > > =

> > > > > >  hw/ppc/spapr.c         | 48 +++++++++++----------
> > > > > >  hw/ppc/spapr_rtas.c    | 96 ++++++++++++++++++++++++++++++++++=
++++++++
> > > > > >  include/hw/ppc/spapr.h | 14 +++++-
> > > > > >  3 files changed, 135 insertions(+), 23 deletions(-)
> > > > > >     =

> > > > > =

> > > > > Hi Maxiwell,
> > > > > =

> > > > > David sent a patch to rework how the host data is exposed to the =
guest.
> > > > > Especially, the special casing of the "none" and "passthrough" st=
rings
> > > > > is no more... I'm afraid you'll have to rework your patches accor=
dingly:
> > > > > code+changelog in patch 1 and at least changelog in patch 2.
> > > > > =

> > > > > Cheers,    =

> > > > =

> > > > IIUC, the 'ibm,get-vpd' RTAS should return information about the
> > > > platform/cabinet. Thus, it's not necessary to add new nodes in the =
guest
> > > > device tree to export information like that.  =

> > > =

> > > I agree that these "host-model" and "host-serial" props, which aren't
> > > described anywhere and not used by either the linux kernel or the
> > > powerpc-utils, look like a QEMU-specific poor man's version of VPD.
> > > =

> > > Not quite sure why they were even created since this is the purpose
> > > of "system-id" and "model" as explained in PAPR, and supposedly
> > > exposed in /proc/ppc64/lparcfg according to the LPARCFG(5) manual
> > > page:  =

> > =

> > Yeah, I'm not sure why they were created either.  I rather suspect
> > nothing much is using them, and I'd kind of like to just kill them.
> > But Daniel Berrange (and maybe others) are paranoid about this
> > breaking things.
> > =

> =

> Speaking of that. The "host-model"/"host-serial" fix is associated to a
> CVE which affects QEMU versions currently shipped by downstream vendors.
> Isn't a good enough reason to break things in existing unsecure setups ?
> Should we add this patch to Mike's patch round-up for stable 3.0.1 (and
> therefore break something that used to _work_ with 3.0.0) ?

Just for confirm: is the suggestion to backport 27461d69a? IIUC the fix
would involve utilizing new command-line options to override the default
"passthrough" mode for host-model/host-serial.

If so, I think an argument could be made, but I generally try to avoid
anything relying on new command-line options since they're unlikely to be
utilized unless the distro/vendor are likely to have specific plans to use
them and implement the appropriate changes elsewhere in their stack to do
so (e.g.  stuff like Spectre mitigations). And, worst case, downstreams
would still have the option of backporting the QEMU fixes as part of the
overall CVE fix, so I'd probably opt to leave this one to the downstreams
to consider.

