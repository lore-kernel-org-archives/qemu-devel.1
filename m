Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B5BC2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 19:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5C9F21BE5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 19:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NC3WkSu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5C9F21BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPAHY-00042o-S7
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 15:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jPAFk-00032L-4u
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 15:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jPAFh-0004IV-H4
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 15:32:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39726
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jPAFh-0004Hv-9r
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 15:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587065564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JQ6PS+BTNSgiNl7S4KnFH2rCSZUvSubdjkM5iRIh0c8=;
 b=NC3WkSu0oORu1Wxyo95qskoDLjiVzoH+a1DSJxA3x5dFAZHyTm8GLsa4ZXcm303EgeMd0h
 WA6dAakxyiMxG0mXstgGh/if7+rEz57FOAcQcjrWzrMpQ/SJfJjd5+w636KMD/vwmJNzCI
 aqusv+8oI7z0UKUxRrLEv6IY6XM7Aqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-XGWPkyjRN_e_uC6603HbbQ-1; Thu, 16 Apr 2020 15:32:30 -0400
X-MC-Unique: XGWPkyjRN_e_uC6603HbbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D03771005510;
 Thu, 16 Apr 2020 19:31:59 +0000 (UTC)
Received: from [10.3.115.59] (ovpn-115-59.phx2.redhat.com [10.3.115.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9B9418A85;
 Thu, 16 Apr 2020 19:31:58 +0000 (UTC)
Subject: Re: [PATCH 0/3] qemu-img: Add convert --bitmaps
To: Nir Soffer <nsoffer@redhat.com>
References: <20200416145115.699033-1-eblake@redhat.com>
 <CAMRbyyv5=AsFLsaaWg9hEWo4NgR=OMzLgvG5=spcHXmNJGebUA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1999cf08-44f5-ffd4-9fbd-2c46b82f5921@redhat.com>
Date: Thu, 16 Apr 2020 14:31:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAMRbyyv5=AsFLsaaWg9hEWo4NgR=OMzLgvG5=spcHXmNJGebUA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Benny Zlotnik <bzlotnik@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Eyal Shenitzky <eshenitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(adding Markus for a CLI question, look for [*])

On 4/16/20 1:20 PM, Nir Soffer wrote:
> On Thu, Apr 16, 2020 at 5:51 PM Eric Blake <eblake@redhat.com> wrote:
>>
>> Without this series, the process for copying one qcow2 image to
>> another including all of its bitmaps involves running qemu and doing
>> the copying by hand with a series of QMP commands.  This makes the
>> process a bit more convenient.
> 
> This seems good for copying an image chain from one storage to another,
> but I think we need a similar --bitmaps option to qemu-img measure to make
> this really useful.
> 
> Here is example use case showing how qemu-img measure is related:
> 
> Source chain:
> /dev/vg1/base
> /dev/vg1/top
> 
> Destination chain:
> /dev/vg2/base
> /dev/vg2/top
> 
> We create empty lvs with the same name on destination storage (/dev/vg2).
> 
> We measure the base lv using qemu-img measure for creating the target lv:
> 
>      qemu-img measure -f qcow2 -O qcow2 /dev/vg1/base
>      lvcreate -L required_size /dev/vg2/base
>      qemu-img create -f qcow2 /dev/vg2/base 10g
> 
> For the top lv we use the current size of the source lv - I think we
> should measure it instead but
> I'm not sure if qemu-img measure supports measuring a single image in a chain
> (maybe -o backing_file?).

qemu-measure --image-opts should be able to measure a single image by 
specifying image opts that purposefully treat the image as standalone 
rather than with its normal backing file included.  Let's see if I can 
whip up an example:

$ qemu-img create -f qcow2 img.base 100M
Formatting 'img.base', fmt=qcow2 size=104857600 cluster_size=65536 
lazy_refcounts=off refcount_bits=16
$ qemu-io -f qcow2 -c 'w 0 25m' img.base
wrote 26214400/26214400 bytes at offset 0
25 MiB, 1 ops; 00.24 sec (103.405 MiB/sec and 4.1362 ops/sec)
$ qemu-img create -f qcow2 -F qcow2 -b img.base img.top
Formatting 'img.top', fmt=qcow2 size=104857600 backing_file=img.base 
backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
$ qemu-io -f qcow2 -c 'w 25m 25m' img.top
wrote 26214400/26214400 bytes at offset 26214400
25 MiB, 1 ops; 00.24 sec (103.116 MiB/sec and 4.1247 ops/sec)
$ qemu-img measure -f qcow2 -O qcow2 img.base
required size: 26542080
fully allocated size: 105185280
required size: 52756480
fully allocated size: 105185280

Okay, I can reproduce what you are seeing - measuring the top image 
defaults to measuring the full allocation of the entire chain, rather 
than the allocation of just the top image.  And now with --image-opts to 
the rescue:

$ qemu-img measure --image-opts -O qcow2 
driver=qcow2,backing=,file.driver=file,file.filename=img.top
qemu-img: warning: Use of "backing": "" is deprecated; use "backing": 
null instead
required size: 26542080
fully allocated size: 105185280

There you go - by forcing qemu to treat the overlay image as though it 
had no backing, you can then measure that image in isolation.

(*) Hmm - that warning about backing="" being deprecated is annoying, 
but I don't know any other way to use dotted command line syntax and 
still express that we want a QMP null.  I tried to see if I could inject 
an alternative backing driver, such as null-co, but was met with errors:

$ ./qemu-img measure --image-opts -O qcow2 
driver=qcow2,backing.driver=null-co,file.driver=file,file.filename=img.top
qemu-img: Could not open 
'driver=qcow2,backing.driver=null-co,file.driver=file,file.filename=img.top': 
Could not open backing file: The only allowed filename for this driver 
is 'null-co://'
$ ./qemu-img measure --image-opts -O qcow2 
driver=qcow2,backing.driver=null-co,backing.file=null-co://,file.driver=file,file.filename=img.top
qemu-img: Could not open 
'driver=qcow2,backing.driver=null-co,backing.file=null-co://,file.driver=file,file.filename=img.top': 
Could not open backing file: The only allowed filename for this driver 
is 'null-co://'
$ ./qemu-img measure --image-opts -O qcow2 
driver=qcow2,backing.driver=null-co,backing.file.filename=null-co://,file.driver=file,file.filename=img.top
qemu-img: Could not open 
'driver=qcow2,backing.driver=null-co,backing.file.filename=null-co://,file.driver=file,file.filename=img.top': 
Could not open backing file: Block protocol 'null-co' doesn't support 
the option 'file.filename'

We don't want to support "" in the QMP syntax forever, but if the CLI 
syntax has to handle the empty string specially in order to get null 
passed to the QMP code, then so be it.

I also tried, but failed, to use JSON syntax.  I don't know why we 
haven't wired up --image-opts to use JSON syntax yet.

$ qemu-img measure --image-opts -O qcow2 '{"driver":"qcow2", "backing":null,
   "file":{"driver":"file", "filename":"img.top"}}'
qemu-img: Could not open '{"driver":"qcow2", "backing":null,
   "file":{"driver":"file", "filename":"img.top"}}': Cannot find 
device={"driver":"qcow2" nor node_name={"driver":"qcow2"

I guess there's always the pseudo-json protocol:

$ qemu-img measure -O qcow2 'json:{"driver":"qcow2", "backing":null,
   "file":{"driver":"file", "filename":"img.top"}}'
required size: 26542080
fully allocated size: 105185280


> 
>      lvcreate -L current_size /dev/vg2/top
>      qemu-img create -f qcow2 -b /dev/vg2/base -F qcow2 /dev/vg2/top 10g
> 
> And then convert the lvs one by one:
> 
>      qemu-img convert -f qcow2 -O qcow2 -n --bitmaps /dev/vg1/base /dev/vg2/base
>      qemu-img convert -f qcow2 -O qcow2 -n --bitmaps -B /dev/vg2/base
> /dev/vg1/top /dev/vg2/top
> 
> The first copy may fail with ENOSPC since qemu-img measure of the base
> does not consider the
> bitmaps in the required size.

Yes, that's a good argument for adding 'qemu-img measure --bitmaps'.  In 
the meantime...

> 
> So I think we need to add a similar --bitmaps option to qemu-img
> measure, hopefully reusing the
> same code to find and estimate the size of the bitmaps.
> 
> Maybe we can estimate the size using qemu-img info --bitmaps,

...you are correct, this works today.  Well, 'qemu-img info --bitmaps' 
doesn't exist, but 'qemu-img info' does output the number of bitmaps, as 
well as their granularity, and if you also assume that each bitmap is 
sized to match the virtual image size, you can compute the estimated 
space occupied by those bitmaps.

> but I
> think the right way to
> do this is in qemu-img measure.

Yes, even though we have existing multi-step code, being able to do it 
in a single step is justification for the improvement (although you may 
still end up having to code the multi-step mode yourself if you can't 
guarantee new-enough qemu-img - the addition of 'qemu-img measure 
--bitmaps' won't land until at least 4 months from now with qemu 5.1). 
Not to mention that the estimation computation (image size / granularity 
rounded up to the next cluster size, summed over all bitmaps) is hairy 
enough that it shouldn't have to be reimplemented by multiple layers of 
software.

> 
> We have also another use case when we collapsed an image chain to single image:
> 
> Source chain:
> /dev/vg1/base
> /dev/vg1/top
> 
> Destination:
> /dev/vg2/collapsed
> 
> In this case we measure the size of the entire chain (/dev/vg1/base <-
> /dev/vg1/top) and create
> /dev/vg2/collapsed in the correct size, and then we convert the chain using:
> 
>     qemu-img convert /dev/vg1/top /dev/vg2/collapsed

When I submitted my v1 patch, I had only tested with a single source 
image to a single destination.  But now that you mention flattening, 
it's easy enough for me to test of what happens (tl;dr: my patch only 
looks at bitmaps in the active layer of the source):

$ qemu-img create -f qcow2 img.base 100M
Formatting 'img.base', fmt=qcow2 size=104857600 cluster_size=65536 
lazy_refcounts=off refcount_bits=16
$ qemu-img create -f qcow2 -F qcow2 -b img.base img.top
Formatting 'img.top', fmt=qcow2 size=104857600 backing_file=img.base 
backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
$ qemu-kvm --nographic --nodefaults --qmp stdio
{'execute':'qmp_capabilities'}
{'execute':'blockdev-add','arguments':{'driver':'qcow2',
  'node-name':'base','file':{'driver':'file','filename':'img.base'}}}
{'execute':'blockdev-add','arguments':{'driver':'qcow2',
  'node-name':'top','file':{'driver':'file','filename':'img.top'},
  'backing':'base'}}
{'execute':'block-dirty-bitmap-add','arguments':{'node':'base',
  'name':'b1','persistent':true}}
{'execute':'block-dirty-bitmap-add','arguments':{'node':'base',
  'name':'b2','persistent':true}}
{'execute':'block-dirty-bitmap-add','arguments':{'node':'top',
  'name':'b2','persistent':true}}
{'execute':'block-dirty-bitmap-add','arguments':{'node':'top',
  'name':'b3','persistent':true}}
{'execute':'quit'}
$ qemu-img convert -f qcow2 -O qcow2 --bitmaps img.top img.flat
$ qemu-img info img.flat
image: img.flat
file format: qcow2
virtual size: 100 MiB (104857600 bytes)
disk size: 208 KiB
cluster_size: 65536
Format specific information:
     compat: 1.1
     lazy refcounts: false
     bitmaps:
         [0]:
             flags:
                 [0]: auto
             name: b3
             granularity: 65536
         [1]:
             flags:
                 [0]: auto
             name: b2
             granularity: 65536
     refcount bits: 16
     corrupt: false

It only copied the bitmaps from the active layer, not all bitmaps from 
all layers.  If we want more complicated handling (such as whether to 
pull in bitmaps deeper in the backing chain, rename bitmaps, policies on 
merging duplicated bitmap names across nodes vs. failure, etc), we 
really should be designing 'qemu-img bitmap' that gives full 
command-line control over all sorts of bitmap operations, rather than 
trying to further overload 'qemu-img convert'.

> 
> Currently we use this for exporting images, for example when creating
> templates, or as a simple
> backup. In this case we don't need to copy the bitmaps in the target
> image - this is a new image
> not used by any VM. Copying the bitmaps may also be non-trivial since
> we may have the bitmaps
> with the same names in several layers (e.g. result of live snapshot).
> 
> So I think using --bitmaps should be disabled when doing this kind of
> convert. We can handle this
> on our side easily, but I think this should fail or log a warning on
> qemu-img, or require merging of
> bitmaps with same names during the copy. I did not check if you
> already handle this.

My patch only copies top-most bitmaps.  If you are using qemu-img 
convert to flatten a chain, we'll need something else to control what to 
do with bitmaps across that chain.

> 
> Finally we also have a use case when we copy the chain as is to new or
> same storage, but
> we create a new vm. In this case I don't think the backup history
> makes sense for the new
> vm, so we don't need to copy the bitmaps.
> 
> I will review the rest of the patches next week and can maybe give
> this some testing.
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


