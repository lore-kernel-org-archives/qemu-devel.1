Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA0BC3815B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 16:54:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00602084D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 16:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="xWWYISO4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00602084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMaRL-0006nA-31
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 12:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dan.j.williams@intel.com>) id 1jMaKX-0001TE-6V
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dan.j.williams@intel.com>) id 1jMaKT-0002to-LY
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:47:02 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:46877)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
 id 1jMaKT-0002p5-AF
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 12:47:01 -0400
Received: by mail-ed1-x542.google.com with SMTP id dk4so531282edb.13
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 09:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n9FEAdpDjPYMRFdoFbysT5eMJJ0P5dsamPqoNfI9cHc=;
 b=xWWYISO4wCuDtwghfIKXyIZbt5X+zk/OJUkDIqk+11TZUo0BTr9wX7A9K3iNjf0UNj
 czkrFtn7sLDvaKFPcq8AW8ZXupCLLEyeI85yqAAGZ8TAgjKkoTWrLpDJ8YKbaFtY6ux3
 IPtPfT+RAzC2DSBnCdKSt6ifMuPmnYpwK9H0k/vtH2xNK94fHCDVPnB/tIjcuIvzbtWR
 hDE9FdOZRdJwY2nn6DmCh21Ush0DDjbeXUxrG6VR9CWI+NFGoE151zb6rP+akJl617PR
 g2CwSTj+YgGPZNOGcirG6os/HyjqtGcq8gPoniJppdHzsKxecU8Dd9+2xJAaQTKiGQ+y
 CxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n9FEAdpDjPYMRFdoFbysT5eMJJ0P5dsamPqoNfI9cHc=;
 b=lRRuetAr1K3m6Rkdv2xITR9nPkCaUfcd0CXG0zOucWmii8EmijSS+tnQ88fwWTQrCM
 HXPueuYypoyLmqm71iGTaLXtL9J/B74tJ0No2C5hu9QTMkpARx/2UMyVxT6EZ540J00x
 TSwleeG0Ej9vv1B80f5JwB/8bW5vsrN5TY1WhIdg0P/BPZ7Y9FIAvrSnqTkHouxqDQj7
 jFZGhtCOUig51NX1o1vBQAdl+b4XTAgbtVoMxjTxALe03MuB4m75MhlUSxVWt8A4L+q+
 Rg+l7TW0CQI98CoqbLEzA7MSUiEzKNa4S3+IcTnZ/M2XS1ab3X/PKgfVhFGujQTgdtU1
 rSLw==
X-Gm-Message-State: AGi0PubEFd3J5fthOtf8gXZacm1M9wZRSvfmg4jfXRB7ADUnQPzvXp7Q
 xLc1WKPXBEfrMaOQP54M6Qbs948RswX//F39KTg8LA==
X-Google-Smtp-Source: APiQypLY8N2jehAYP9EJOPRFBqg+kkPwk6+KE2ZHCfYNpDNKnd+d7NRCFFLzYCjOh4t3ziked9t9WqOeQtaC+HPVI5s=
X-Received: by 2002:a17:906:6987:: with SMTP id
 i7mr12437981ejr.12.1586450805184; 
 Thu, 09 Apr 2020 09:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200401031314.11592-1-jingqi.liu@intel.com>
 <c906a3ae-c9d2-5802-5988-3c1d0302109b@oracle.com>
 <CAPcyv4igr9-DJx2ehoHj7sXk5g5GmgmivCqM3VpmJV7J4QM+kA@mail.gmail.com>
 <3873cb30-608c-6a27-c19f-f6446898796f@oracle.com>
 <9959e648-94f6-3be3-2271-3d2b855e7e48@intel.com>
 <6c12c748-6ee6-7132-f54b-bf0f90ae84c2@oracle.com>
 <2e2ba0c4-88ed-dc37-c642-a1cc7ae98f05@intel.com>
In-Reply-To: <2e2ba0c4-88ed-dc37-c642-a1cc7ae98f05@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 9 Apr 2020 09:46:33 -0700
Message-ID: <CAPcyv4hpA1Lc8+-3sDLBkG=sqMXbcxwQzNHYEcJevu8NypQcFQ@mail.gmail.com>
Subject: Re: [PATCH] exec: fetch the alignment of Linux devdax pmem character
 device nodes
To: "Liu, Jingqi" <jingqi.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 9, 2020 at 7:33 AM Liu, Jingqi <jingqi.liu@intel.com> wrote:
>
> On 4/8/2020 5:42 PM, Joao Martins wrote:
> > On 4/8/20 3:25 AM, Liu, Jingqi wrote:
> >> On 4/8/2020 2:28 AM, Joao Martins wrote:
> >>> On 4/7/20 5:55 PM, Dan Williams wrote:
> >>>> On Tue, Apr 7, 2020 at 4:01 AM Joao Martins <joao.m.martins@oracle.com> wrote:
> >>>>> Perhaps, you meant instead:
> >>>>>
> >>>>>           /sys/dev/char/%d:%d/align
> >>>>>
> >>>> Hmm, are you sure that's working?
> >>> It is, except that I made the slight mistake of testing with a bunch of wip
> >>> patches on top which one of them actually adds the 'align' to child dax device.
> >>>
> >>> Argh, my apologies - and thanks for noticing.
> >>>
> >>>> I expect the alignment to be found
> >>>> in the region device:
> >>>>
> >>>> /sys/class/dax:
> >>>> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus1/region1/dax1.1/dax1.0
> >>>> $(readlink -f /sys/dev/char/253\:263)/../align
> >>>> $(readlink -f /sys/dev/char/253\:263)/device/align
> >>>>
> >>>>
> >>>> /sys/bus/dax:
> >>>> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus1/region1/dax1.0/dax1.0
> >>>> $(readlink -f /sys/dev/char/253\:265)/../align
> >>>> $(readlink -f /sys/dev/char/253\:265)/device/align <-- No such file
> >>>>
> >>>> The use of the /sys/dev/char/%d:%d/device is only supported by the
> >>>> deprecated /sys/class/dax.
> >> Hi Dan,
> >>
> >> Thanks for your comments.
> >>
> >> Seems it is a mistake.
> >>
> >> It should be: $(readlink -f /sys/dev/char/253\:263)/../../align
> >>
> > Hmm, perhaps you have an extra '../' in the path? This works for me:
> >
> > # ls $(readlink -f /sys/dev/char/252\:0/../align)
> > /sys/devices/platform/e820_pmem/ndbus0/region0/dax0.0/dax0.0/../align
> > # cat $(readlink -f /sys/dev/char/252\:0)/../align
> > 2097152
> > # cat /sys/dev/char/252\:0/../align
> > 2097152
>
> Hi Joao,
>
> Hmm, I need to have an extra '../' in the path. The details are as follows:
>
> # ll /dev/dax2.0
> crw------- 1 root root 251, 5 Mar 20 13:35 /dev/dax2.0
> # uname -r
> 5.6.0-rc1-00044-gb19e8c684703
> # readlink -f /sys/dev/char/251\:5/
> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/region2/dax2.1/dax/dax2.0
> # ls $(readlink -f /sys/dev/char/251\:5)/../align
> ls: cannot access
> '/sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/region2/dax2.1/dax/dax2.0/../align':
> No such file or directory
> # ls $(readlink -f /sys/dev/char/251\:5)/../dax_region/align
> ls: cannot access
> '/sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/region2/dax2.1/dax/dax2.0/../dax_region/align':
> No such file or directory
> # ls $(readlink -f /sys/dev/char/251\:5)/../../align
> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/region2/dax2.1/dax/dax2.0/../../align
> # ls $(readlink -f /sys/dev/char/251\:5)/../../dax_region/align
> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/region2/dax2.1/dax/dax2.0/../../dax_region/align
> # lsmod|grep pmem
> dax_pmem_compat        16384  0
> device_dax             20480  1 dax_pmem_compat
> dax_pmem_core          16384  1 dax_pmem_compat
> # lsmod|grep dax
> dax_pmem_compat        16384  0
> device_dax             20480  1 dax_pmem_compat
> dax_pmem_core          16384  1 dax_pmem_compat
>
> Seems some configurations are different ?
>
> Can you share your info as above ? Thanks.

Alternatively maybe you can use libdaxctl that automatically handles
the ABI differences between compat-dax-class and dax-bus layouts? I
didn't recommend it before because I was not sure about qemu's policy
about taking on new library dependencies, but with libdaxctl you could
do something like (untested):

path = g_strdup_printf("/sys/dev/char/%d:%d", major(st.st_rdev),
minor(st.st_rdev));
rpath = realpath(path, NULL);
daxctl_region_foreach(ctx, region)
    if (strstr(daxctl_region_get_path(region), rpath)) {
        align = daxctl_region_get_align(region);
        break;
    }

