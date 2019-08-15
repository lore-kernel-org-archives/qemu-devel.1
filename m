Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983CEC433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB2B2084F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 02:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="iQlTmDzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB2B2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy5wy-00068H-KL
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 22:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dan.j.williams@intel.com>) id 1hy5YH-0006pL-SD
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:31:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dan.j.williams@intel.com>) id 1hy5YG-0001am-2l
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:31:45 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45281)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
 id 1hy5YF-0001YO-Nw
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 22:31:44 -0400
Received: by mail-oi1-x242.google.com with SMTP id m206so140872oib.12
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 19:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B2lj9TI2ju3aKcKqVFXMxJLQUpRxkW4aE8XDzhT4ks4=;
 b=iQlTmDzS0QbLzv+WLXrJC7xQMtTODNq1NUiI8x/AEUbra8oWCw64hWDrzF67obR7NP
 nf/vVKVmuMbNAZNNodp0cFa68RqtTCbAMEdsXrhPOilsdmVHjp6J6uABfcMRo5VO+C68
 IGi2MoJo3UQgoDweBqOJkQE984O0OMCst4OA3zkZIal/9gWobKhy2W/ytu8Ib8Usv+VM
 tzaa2fsCUOc2Qg0boo2HxMvi7W9i8tXcnGHokoE4uaxegf0QsiOWlG84rrNpfD4kxMJo
 pwiAD76JVrD2x4KoL+6q7B17GvlC4ZApMAuDUVjH6PI8ZVOlFWUxXVJwmJVfvc9swart
 zwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B2lj9TI2ju3aKcKqVFXMxJLQUpRxkW4aE8XDzhT4ks4=;
 b=iGklpKZ+BjGJyGM5xWN6Z8cnVy0eIJRyGE/mFUHvOcaSqj+/kWslW8+G9cv9VtK9mU
 v3FoiD+plPdbDupfbzkYMfI7ME6x07AYMCAt1XW/ejI6IqNXwXyOEvfEx0FjWH+KkK4w
 LTex1H/6q5tavsqyrJ6JL+ctH89ZH/FJVZUllKfw28eKeR19B/ocrTR7DUW4pfykx1ib
 r7I8EGcVXFLIJ9J766nDuvpAcVJgWyNP2hbfnj/vjhH6T3o0KhTbo7JLnynwYoBt6A9L
 V3dwslk7odYHqtIaiy4oYWvBAxSoHloP4DOLJiMOK6+ojI3FmT8RYKOaGNBZRKSDjydY
 mi9w==
X-Gm-Message-State: APjAAAVGYyDgUB84OMJgO8fpxaRFI6OEZGmhzWc4Rrd6hC+j/uJ025dE
 ZvLp2hUWQVQRaC6rUk9cYegjG5b26GihjE0pCLceKA==
X-Google-Smtp-Source: APXvYqztuSC6WeGdWiypX+yocYxtxxiDg8kvsXaabfD1n+jx9YNeCFsMij0kUt2t+5aUKADGNZdHTnbrLuiSSaKX5uQ=
X-Received: by 2002:a05:6808:914:: with SMTP id
 w20mr111418oih.73.1565836299530; 
 Wed, 14 Aug 2019 19:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190809065731.9097-1-tao3.xu@intel.com>
 <20190809065731.9097-6-tao3.xu@intel.com>
 <20190813170027.0617b129@redhat.com>
 <CAPcyv4j=wBtBcscJBtrMNDDz=d6+HYYDF=4QLU69d0EPMkTTqg@mail.gmail.com>
 <a73f7c81-0363-c10f-8ae1-9344abc55449@intel.com>
 <CAPcyv4jCuy6zvM8NcacXhvpUBUyp_BYMcEtBuA_ck3AhkyGNsQ@mail.gmail.com>
 <789df028-9dd9-884a-2493-aecc9a646e63@intel.com>
In-Reply-To: <789df028-9dd9-884a-2493-aecc9a646e63@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 14 Aug 2019 19:31:27 -0700
Message-ID: <CAPcyv4h-WmFPSsPMfPz5AALm=MyxGzyU5Ju0iSKsxORVh1wV7Q@mail.gmail.com>
To: Tao Xu <tao3.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v9 05/11] numa: Extend CLI to provide
 initiator information for numa nodes
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Liu, Jingqi" <jingqi.liu@intel.com>,
 "Du, Fan" <fan.du@intel.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "daniel@linux.ibm.com" <daniel@linux.ibm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 14, 2019 at 6:57 PM Tao Xu <tao3.xu@intel.com> wrote:
>
> On 8/15/2019 5:29 AM, Dan Williams wrote:
> > On Tue, Aug 13, 2019 at 10:14 PM Tao Xu <tao3.xu@intel.com> wrote:
> >>
> >> On 8/14/2019 10:39 AM, Dan Williams wrote:
> >>> On Tue, Aug 13, 2019 at 8:00 AM Igor Mammedov <imammedo@redhat.com> wrote:
> >>>>
> >>>> On Fri,  9 Aug 2019 14:57:25 +0800
> >>>> Tao <tao3.xu@intel.com> wrote:
> >>>>
> >>>>> From: Tao Xu <tao3.xu@intel.com>
> >>>>>
> [...]
> >>>>> +    for (i = 0; i < machine->numa_state->num_nodes; i++) {
> >>>>> +        if (numa_info[i].initiator_valid &&
> >>>>> +            !numa_info[numa_info[i].initiator].has_cpu) {
> >>>>                             ^^^^^^^^^^^^^^^^^^^^^^ possible out of bounds read, see bellow
> >>>>
> >>>>> +            error_report("The initiator-id %"PRIu16 " of NUMA node %d"
> >>>>> +                         " does not exist.", numa_info[i].initiator, i);
> >>>>> +            error_printf("\n");
> >>>>> +
> >>>>> +            exit(1);
> >>>>> +        }
> >>>> it takes care only about nodes that have cpus or memory-only ones that have
> >>>> initiator explicitly provided on CLI. And leaves possibility to have
> >>>> memory-only nodes without initiator mixed with nodes that have initiator.
> >>>> Is it valid to have mixed configuration?
> >>>> Should we forbid it?
> >>>
> >>> The spec talks about the "Proximity Domain for the Attached Initiator"
> >>> field only being valid if the memory controller for the memory can be
> >>> identified by an initiator id in the SRAT. So I expect the only way to
> >>> define a memory proximity domain without this local initiator is to
> >>> allow specifying a node-id that does not have an entry in the SRAT.
> >>>
> >> Hi Dan,
> >>
> >> So there may be a situation for the Attached Initiator field is not
> >> valid? If true, I would allow user to input Initiator invalid.
> >
> > Yes it's something the OS needs to consider because the platform may
> > not be able to meet the constraint that a single initiator is
> > associated with the memory controller for a given memory target. In
> > retrospect it would have been nice if the spec reserved 0xffffffff for
> > this purpose, but it seems "not in SRAT" is the only way to identify
> > memory that is not attached to any single initiator.
> >
> But As far as I konw, QEMU can't emulate a NUMA node "not in SRAT". I am
> wondering if it is effective only set Initiator invalid?

You don't need to emulate a NUMA node not in SRAT. Just put a number
in this HMAT entry larger than the largest proximity domain number
found in the SRAT.
>

