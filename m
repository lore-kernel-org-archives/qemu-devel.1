Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BC6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02CBC20780
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDtyyjxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CBC20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxIc-00038K-2X
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqx8e-0003ek-Ti
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:12:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54682
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jqx8d-0002AW-9y
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593688338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s5TIhgGCNPC7GHZzpVoRDCbyoBVQC6a+bjl8clAXdFU=;
 b=BDtyyjxRIAFTOyMDlRlN312etMLixeFmq5FJixY2UF4a+NqFctYlPmdRPqqjODNtaP0OOM
 NUbe6rtUR+JE24ciBT0vRxMCFrYvrheH2+BqXJ3mR+Znr3MF5ZBSqZNyBR/bB9E/YSrNKL
 ncaNaz5vjlTfkK6gCr1d5r0uiehimA0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-XIf2Gav0PCuOS6Znex08aA-1; Thu, 02 Jul 2020 07:12:14 -0400
X-MC-Unique: XIf2Gav0PCuOS6Znex08aA-1
Received: by mail-wm1-f71.google.com with SMTP id t145so28333819wmt.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 04:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=s5TIhgGCNPC7GHZzpVoRDCbyoBVQC6a+bjl8clAXdFU=;
 b=JACtmhSm2VTvr0OunoIufYGIXI/sgj/HKlsQvM9fqOZWPgaBTBOcWOwzYCA9TTAfBH
 gMIEMbgEdFnuRBCJQJY6ljSGx7EHk5t2cFIt+k+2fdHjT7YiTxsyIAP/3TiF2+7LMPZ4
 i7WjzrTVTeMDIujf9J/7U68+KyRs8toJfPzUGT7hfRY1ZgMPfW5gEBOUzxoUyjeVjTB5
 Kz5MET+/dhHTCFscTuPoUl1rOMtvgkIIvHY1ZO+lNiABP0t4QmT0390kTjhGoxYUdh7m
 3r1ndUiHQ7iUHK/7DyzDK5z1eyOseS/jz910EV8Wfwvr16xdLJTyw/ecCP/2tnS4LQbN
 0TMQ==
X-Gm-Message-State: AOAM532PFhqehq//H5s2EEWpBEEAATNV1Ef7mS6MI8QqIiFiBRL6ByrD
 4vID+j62KDZQcV4197C1N5wENEgSAzO34JqDC5Mc2UCEIeT5MGeTv74VAIwwQa9/+ZjsrytBiFs
 Ibyx1I8nPRF1NeW0=
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr31091729wme.160.1593688333687; 
 Thu, 02 Jul 2020 04:12:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYeUS94uXEEC4n73jw1b5MBvXbDWZV3QSqL0g2Tv2AQOFnTZ/D9RKUFptRolAsfVFf2eB0GA==
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr31091684wme.160.1593688333283; 
 Thu, 02 Jul 2020 04:12:13 -0700 (PDT)
Received: from redhat.com ([93.157.82.4])
 by smtp.gmail.com with ESMTPSA id l132sm10561813wmf.6.2020.07.02.04.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 04:12:12 -0700 (PDT)
Date: Thu, 2 Jul 2020 07:12:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Subject: Re: [PATCH] acpi: Fix access to PM1 control and status registers
Message-ID: <20200702063310-mutt-send-email-mst@kernel.org>
References: <20200701110549.148522-1-anthony.perard@citrix.com>
 <20200701075914-mutt-send-email-mst@kernel.org>
 <20200701124836.GD2030@perard.uk.xensource.com>
MIME-Version: 1.0
In-Reply-To: <20200701124836.GD2030@perard.uk.xensource.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, pbonzini@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, "open list:PReP" <qemu-ppc@nongnu.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 01, 2020 at 01:48:36PM +0100, Anthony PERARD wrote:
> On Wed, Jul 01, 2020 at 08:01:55AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Jul 01, 2020 at 12:05:49PM +0100, Anthony PERARD wrote:
> > > The ACPI spec state that "Accesses to PM1 control registers are
> > > accessed through byte and word accesses." (In section 4.7.3.2.1 PM1
> > > Control Registers of my old spec copy rev 4.0a).
> > > 
> > > With commit 5d971f9e6725 ("memory: Revert "memory: accept mismatching
> > > sizes in memory_region_access_valid""), it wasn't possible anymore to
> > > access the pm1_cnt register by reading a single byte, and that is use
> > > by at least a Xen firmware called "hvmloader".
> > > 
> > > Also, take care of the PM1 Status Registers which also have "Accesses
> > > to the PM1 status registers are done through byte or word accesses"
> > > (In section 4.7.3.1.1 PM1 Status Registers).
> > > 
> > > Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> > 
> > 
> > Can't we set impl.min_access_size to convert byte accesses
> > to word accesses?
> 
> I actually tried, but when reading `addr` or `addr+1` I had the same
> value. So I guess `addr` wasn't taken into account.
> 
> I've checked again, with `.impl.min_access_size = 2`, the width that the
> function acpi_pm_cnt_read() get is 2, but addr isn't changed so the
> function is still supposed to shift the result (or the value to write)
> based on addr, I guess.

True address is misaligned.  I think memory core should just align it -
this is what devices seem to expect.
However result is shifted properly so just align addr and be done with
it.


In fact I have a couple more questions. Paolo - maybe you can answer some of these?



    if (!access_size_min) {
        access_size_min = 1;
    }
    if (!access_size_max) {
        access_size_max = 4;
    }

>>>>

So 8 byte accesses are split up unless one requests 8 bytes.
Undocumented right?  Why are we doing this?

>>>>


    /* FIXME: support unaligned access? */

>>>>

Shouldn't we document impl.unaligned is ignored right now?
Shouldn't we do something to make sure callbacks do not get
unaligned accesses they don't expect?


In fact, there are just 2 devices which set valid.unaligned but
not impl.unaligned:
    aspeed_smc_ops
    raven_io_ops


Is this intentional? Do these in fact expect memory core to
provide aligned addresses to the callbacks?
Given impl.unaligned is not implemented, can we drop it completely?
Cc a bunch of people who might know.

Can relevant maintainers please comment? Thanks a lot!

>>>>


    access_size = MAX(MIN(size, access_size_max), access_size_min);
    access_mask = MAKE_64BIT_MASK(0, access_size * 8);

>>>>


So with a 1 byte access at address 1, with impl.min_access_size = 2, we get:
    access_size = 2
    access_mask = 0xffff
    addr = 1



<<<<


    if (memory_region_big_endian(mr)) {
        for (i = 0; i < size; i += access_size) {
            r |= access_fn(mr, addr + i, value, access_size,
                        (size - access_size - i) * 8, access_mask, attrs);

>>>

now shift is -8.

<<<<


        }
    } else {
        for (i = 0; i < size; i += access_size) {
            r |= access_fn(mr, addr + i, value, access_size, i * 8,
                        access_mask, attrs);
        }
    }


<<<<

callback is invoked with addr 1 and size 2:

>>>>


    uint64_t tmp;

    tmp = mr->ops->read(mr->opaque, addr, size);
    if (mr->subpage) {
        trace_memory_region_subpage_read(get_cpu_index(), mr, addr, tmp, size);
    } else if (trace_event_get_state_backends(TRACE_MEMORY_REGION_OPS_READ)) {
        hwaddr abs_addr = memory_region_to_absolute_addr(mr, addr);
        trace_memory_region_ops_read(get_cpu_index(), mr, abs_addr, tmp, size);
    }
    memory_region_shift_read_access(value, shift, mask, tmp);
    return MEMTX_OK;

<<<<

let's assume callback returned 0xabcd

this is where we are shifting the return value:

>>>>


static inline void memory_region_shift_read_access(uint64_t *value,
                                                   signed shift,
                                                   uint64_t mask,
                                                   uint64_t tmp)
{
    if (shift >= 0) {
        *value |= (tmp & mask) << shift;
    } else {
        *value |= (tmp & mask) >> -shift;
    }
}


So we do 0xabcd & 0xffff >> 8, and we get 0xab.

>>>

How about aligning address for now? Paolo?

-->

memory: align to min access size

If impl.min_access_size > valid.min_access_size access callbacks
can get a misaligned access as size is increased.
They don't expect that, let's fix it in the memory core.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---


diff --git a/memory.c b/memory.c
index 9200b20130..ea489ce405 100644
--- a/memory.c
+++ b/memory.c
@@ -532,6 +532,7 @@ static MemTxResult access_with_adjusted_size(hwaddr addr,
     }
 
     /* FIXME: support unaligned access? */
+    addr &= ~(access_size_min - 1);
     access_size = MAX(MIN(size, access_size_max), access_size_min);
     access_mask = MAKE_64BIT_MASK(0, access_size * 8);
     if (memory_region_big_endian(mr)) {
> -- 
> Anthony PERARD


