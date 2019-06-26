Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C99DC48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 13:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02B44214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 13:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B44214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg8SS-0002g3-7R
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 09:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48067)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1hg8RC-0001y0-WF
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 09:58:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1hg8RC-0001bb-1G
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 09:58:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1hg8R9-0001YT-ME; Wed, 26 Jun 2019 09:58:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E34E02F8BF0;
 Wed, 26 Jun 2019 13:58:10 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 085A51001B04;
 Wed, 26 Jun 2019 13:58:08 +0000 (UTC)
Date: Wed, 26 Jun 2019 15:58:06 +0200
From: Andrew Jones <drjones@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Message-ID: <20190626135806.l6mna6swbdncbb2a@kamzik.brq.redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
 <20190621163422.6127-6-drjones@redhat.com>
 <3c24d706-4ee5-336d-8f74-adae672c450d@redhat.com>
 <20190626132846.lj62nu4orn3nhnug@kamzik.brq.redhat.com>
 <4c96ac11-1195-81d5-79d9-ee3d5e92210e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c96ac11-1195-81d5-79d9-ee3d5e92210e@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 26 Jun 2019 13:58:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 05/14] target/arm/helper: zcr: Add build
 bug next to value range assumption
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, armbru@redhat.com, qemu-arm@nongnu.org,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 26, 2019 at 03:40:11PM +0200, Auger Eric wrote:
> Hi,
> 
> On 6/26/19 3:28 PM, Andrew Jones wrote:
> > On Wed, Jun 26, 2019 at 12:01:10PM +0200, Auger Eric wrote:
> >> Hi Drew,
> >>
> >> On 6/21/19 6:34 PM, Andrew Jones wrote:
> >>> Suggested-by: Dave Martin <Dave.Martin@arm.com>
> >>> Signed-off-by: Andrew Jones <drjones@redhat.com>
> >>> ---
> >>>  target/arm/helper.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/target/arm/helper.c b/target/arm/helper.c
> >>> index df4276f5f6ca..edba94004e0b 100644
> >>> --- a/target/arm/helper.c
> >>> +++ b/target/arm/helper.c
> >>> @@ -5319,6 +5319,7 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
> >>>      int new_len;
> >>>  
> >>>      /* Bits other than [3:0] are RAZ/WI.  */
> >>> +    QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
> >> Can you document in the commit message why this check is critical?
> > 
> > Sure. I can copy+paste the email subject into the commit message :-)
> Well that's not what I asked for. Are you enforcing an architectural
> maximum of 2048 bits or is the limitation due to some data structs in
> the existing code, ... For a non expert reviewer as I am it is not
> totally obvious.

How's this for the commit message

    The current implementation of ZCR_ELx matches the architecture, only
    implementing the lower four bits, with the rest RAZ/WI. This puts
    a strict limit on ARM_MAX_VQ of 16. Make sure we don't let ARM_MAX_VQ
    grow without a corresponding update here.

Thanks,
drew

> 
> Thanks
> 
> Eric
> > 
> > drew
> > 
> >>
> >> Thanks
> >>
> >> Eric
> >>>      raw_write(env, ri, value & 0xf);
> >>>  
> >>>      /*
> >>>
> >>

