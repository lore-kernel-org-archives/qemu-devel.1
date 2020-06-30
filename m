Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AE2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF86B20768
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1CI08NTe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF86B20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqJf6-0008PR-0D
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 13:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1jqJe9-0007Tc-9i; Tue, 30 Jun 2020 13:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbusch@kernel.org>)
 id 1jqJe6-0001l6-Dh; Tue, 30 Jun 2020 13:02:12 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CEE4A2074D;
 Tue, 30 Jun 2020 17:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593536527;
 bh=xwgkxZBtzgQM6lPEr0s1o3fXd6QCPw4+NC1PZUR6Nbc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1CI08NTenmPwGCY2v4uK0Uans0+MJWg0J7Upsqy0oVCL5kOSQ6XdHqMh9E2ixrq+D
 tAedO3LhYjUlt+//o74iINYkuFbqu4C+I5HL7r6wuzR9Chn7UHf//uITpxST/J0a+Y
 zmg++SnqO44s4GNZxIzTZHfv4sLyqvPWut/hj2p8=
Date: Tue, 30 Jun 2020 10:02:05 -0700
From: Keith Busch <kbusch@kernel.org>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH v2 05/18] hw/block/nvme: Introduce the Namespace Types
 definitions
Message-ID: <20200630170205.GC1987534@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200617213415.22417-1-dmitry.fomichev@wdc.com>
 <20200617213415.22417-6-dmitry.fomichev@wdc.com>
 <CAKmqyKO-O5kVkb-mKmBeCCtmaS8uR+0oau=5FfS_gYrXXX0nHA@mail.gmail.com>
 <20200630100214.GA548602@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630100214.GA548602@localhost.localdomain>
Received-SPF: pass client-ip=198.145.29.99; envelope-from=kbusch@kernel.org;
 helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 11:42:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -80
X-Spam_score: -8.1
X-Spam_bar: --------
X-Spam_report: (-8.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Qemu-block <qemu-block@nongnu.org>, Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Maxim Levitsky <mlevitsky@redhat.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 30, 2020 at 10:02:15AM +0000, Niklas Cassel wrote:
> On Mon, Jun 29, 2020 at 07:12:47PM -0700, Alistair Francis wrote:
> > On Wed, Jun 17, 2020 at 2:47 PM Dmitry Fomichev <dmitry.fomichev@wdc.com> wrote:
> > > +    uint16_t    ctrlid;
> > 
> > Shouldn't this be CNTID?
> 
> From the NVMe spec:
> https://nvmexpress.org/wp-content/uploads/NVM-Express-1_4-2019.06.10-Ratified.pdf
> 
> Figure 241:
> Controller  Identifier  (CNTID)
> 
> So you are correct, this is the official abbreviation.
> 
> I guess that I tried wanted to keep it in sync with Linux:
> https://github.com/torvalds/linux/blob/master/include/linux/nvme.h#L974
> 
> Which uses ctrlid.
> 
> 
> Looking further at the NVMe spec:
> In Figure 247 (Identify Controller Data Structure) they use other names
> for fields:
> 
> Controller  ID  (CNTLID)
> Controller Attributes (CTRATT)
> 
> I can understand if they want to have unique names for fields, but it
> seems like they have trouble deciding how to abbreviate controller :)
> 
> Personally I think that ctrlid is more obvious that we are talking about
> a controller and not a count. But I'm fine regardless.

They shouldn't have shortened controller to "CNT". For those of us that
can't help but pronounce these as words, that is a vulgarity in English.

