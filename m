Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6E0CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 07:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A2F2084C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 07:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A2F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNBXY-00047A-6m
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 03:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44909)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iNBWA-0003W8-6j
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 03:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iNBW7-0002YU-AO
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 03:57:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32920)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iNBW7-0002XC-1X
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 03:57:15 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 080E1369AC
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 07:57:13 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id 62so8443771plb.12
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 00:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=nB4NWBURjG9ByWN7k0QFBAQHGM4V5bbnZqEoQkn0PRQ=;
 b=DtCDNwNvIx+FnMtQqWGIwnLPvtUidyhxl8QzDbLmGPQp6kM0Rdv0coPhP+7kGLBMSp
 cJl8kF6Dgar0gOBW36nYxgUAIqr5heywAOzDriWzj6Br7sGfkqMO2Cw/OnLvZtoATAn4
 C1472qJOhiJm6ZVEJ8jF7WYUMfrvdm2D4O2WMw+L9Gb4V/gEku6RDFpPBCNRuPcS80ff
 9UOrO5AcdKZHdI6E40kAalHQaaF9sJ/etew2q90VRoR9uD7KGgc6WJL6VaMDFdZn0uCx
 27q8Osy8NSvGBngjgb8uMZCAjqjFxOKV6xs6r9pQzgEMVlpXuJNV5+M/D59tR6e1/aze
 NNKQ==
X-Gm-Message-State: APjAAAWKMMfh840/vJqa47UwXS0viR1r2tcmSAj2DnKrakwNRdDi7VEd
 VCB2Fwc/NUTJheICkTX95sdqE0nNAq77kcIueFAKagIgkTP1RVM5VrHXUW5cc+PAlnUB+A3mzmg
 iCW2Yvip7LPrub50=
X-Received: by 2002:a17:902:1:: with SMTP id 1mr7647400pla.338.1571817432511; 
 Wed, 23 Oct 2019 00:57:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxeolfTa78QB6KmKhSOwnfbnK2w5UcfS56/ry2pGq8YEVuhwhGgE43oyb4GhmTTLmnwy1TxUQ==
X-Received: by 2002:a17:902:1:: with SMTP id 1mr7647377pla.338.1571817432216; 
 Wed, 23 Oct 2019 00:57:12 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id q42sm28440466pja.16.2019.10.23.00.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 00:57:11 -0700 (PDT)
Date: Wed, 23 Oct 2019 15:57:01 +0800
From: Peter Xu <peterx@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH v2 0/4] apic: Fix migration breakage of >255 vcpus
Message-ID: <20191023075701.GA18443@xz-x1>
References: <20191016022933.7276-1-peterx@redhat.com>
 <20191016144001.GE4084@habkost.net> <20191019034153.GB9478@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191019034153.GB9478@xz-x1>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, QEMU Block List <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Oct 19, 2019 at 11:41:53AM +0800, Peter Xu wrote:
> On Wed, Oct 16, 2019 at 11:40:01AM -0300, Eduardo Habkost wrote:
> > On Wed, Oct 16, 2019 at 10:29:29AM +0800, Peter Xu wrote:
> > > v2:
> > > - use uint32_t rather than int64_t [Juan]
> > > - one more patch (patch 4) to check dup SaveStateEntry [Dave]
> > > - one more patch to define a macro (patch 1) to simplify patch 2
> > > 
> > > Please review, thanks.
> > 
> > I wonder how hard it is to write a simple test case to reproduce
> > the original bug.  We can extend tests/migration-test.c or
> > tests/acceptance/migration.py.  If using -device with explicit
> > apic-id, we probably don't even need to create >255 VCPUs.
> 
> I can give it a shot next week. :)

When trying this, I probably noticed a block layer issue: q35 seems to
have problem on booting from a very small block device (like 512B,
which is the image size that currently used for migration-test.c).
For example, this cmdline can boot successfully into the test image:

$qemu -M pc -m 200m -accel kvm -nographic \
      -drive file=$image,id=drive0,index=0,format=raw \
      -device ide-hd,drive=drive0

While this cannot:

$qemu -M q35 -m 200m -accel kvm -nographic \
      -drive file=$image,id=drive0,index=0,format=raw \
      -device ide-hd,drive=drive0

With error (BIOS debug messages on):

Booting from Hard Disk..invalid basic_access:143:
   a=00000201  b=00000000  c=00000001  d=00000080 ds=0000 es=07c0 ss=d980
  si=00000000 di=00000000 bp=00000000 sp=0000fd8e cs=f000 ip=cb81  f=0202
invalid basic_access:144:
   a=00000201  b=00000000  c=00000001  d=00000080 ds=0000 es=07c0 ss=d980
  si=00000000 di=00000000 bp=00000000 sp=0000fd8e cs=f000 ip=cb81  f=0202
.
Boot failed: could not read the boot disenter handle_18:
  NULL
k

This corresponds to this SeaBIOS check error:

static void noinline
basic_access(struct bregs *regs, struct drive_s *drive_fl, u16 command)
{
    ...
    // sanity check on cyl heads, sec
    if (cylinder >= nlc || head >= nlh || sector > nls) {
        warn_invalid(regs);
        disk_ret(regs, DISK_RET_EPARAM);
        return;
    }
    ...
}

And... below cmdline will work even for q35 (as suggested by Fam when
we talked offline):

$qemu -M q35 -m 200m -accel kvm -nographic \
      -drive file=$image,id=drive0,index=0,format=raw \
      -device ide-hd,drive=drive0,secs=1,cyls=1,heads=1

I think for migration test we can workaround like above, but I'm also
curious whether this is a real bug somewhere because I don't see a
reason for q35 to refuse to boot on a one-sector image.

Thanks,

-- 
Peter Xu

