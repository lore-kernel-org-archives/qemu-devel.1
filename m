Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2819EC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1B8720B1F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1B8720B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36573 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTnyE-0000Py-QN
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:41:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hTnwN-0007j9-9o
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:39:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hTnwM-00013p-6S
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:39:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hTnwM-0000vN-0E
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:39:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id 15so5822387wmg.5
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 06:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=/0G1uf9n3CmYHtuItIDb2r96upOg87e78uEEoYqlPjk=;
	b=oQ0dsVk7DZYoIoUuwPM706hsxeVdOAzl9wRZ+rBfKL5HoAoGcl7oij14hEelVUDMt8
	lkH15y3oJQupQlABcf/63DOdswFf/rdGLkzqhaWvmu+c/t/Rq/oNJ0p+Lyx0h/bbGcoT
	Rp3Pqwn4Q5hJw3o/h7Yq6Uyf4ltSGDk3+/4pe1fEjtxJHVR9MXm3i5N3d+U1pg7gZaya
	zQe8iKSDCP+taAmX5L131K76/YJ+EMvUQWlAjMfJ658Hb42rjRt/HywaJIbTDZbvkiC3
	vq+6e2tZb2evNYTPXsm+wrcEK/8S8RgCZegQ4+AQxsGYSEI52BNhOvllVzZNweRN+4/o
	bdlQ==
X-Gm-Message-State: APjAAAVSUXPzBgQ4O06f0uY1MBf6Hxq25O+hdUMZDJ6TS1qvAesWWMRJ
	W101j3skWHmUCpM2FmucBBd6CA==
X-Google-Smtp-Source: APXvYqw6wu3Hn3KeqLEXHS/cEN2me6BpFjjb1J4lcI2acTZCXO4UYp1Ux8NQi4q85mVVdniWb3/Xug==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr12405523wmc.130.1558618759458; 
	Thu, 23 May 2019 06:39:19 -0700 (PDT)
Received: from steredhat (host253-229-dynamic.248-95-r.retail.telecomitalia.it.
	[95.248.229.253]) by smtp.gmail.com with ESMTPSA id
	88sm64479849wrc.33.2019.05.23.06.39.18
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 23 May 2019 06:39:19 -0700 (PDT)
Date: Thu, 23 May 2019 15:39:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190523133911.ddd6475zkfox6mij@steredhat>
References: <20190427113625.46594-1-sgarzare@redhat.com>
	<877eb2hiwk.fsf@dusky.pond.sub.org>
	<20190507083615.as7shlq7fwjgwz54@steredhat>
	<8736lp5fxg.fsf@dusky.pond.sub.org>
	<CAGxU2F6r0hKy_Egwf=xfMkFH-3bxL8Yjz3z6GTT0QTrkYoHCDQ@mail.gmail.com>
	<87woiijw2a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87woiijw2a.fsf@dusky.pond.sub.org>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] Use of PreallocMode in block drivers
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
Cc: qemu devel list <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 22, 2019 at 06:25:17PM +0200, Markus Armbruster wrote:
> Stefano Garzarella <sgarzare@redhat.com> writes:
> 
> > On Wed, May 8, 2019 at 1:44 PM Markus Armbruster <armbru@redhat.com> wrote:
> >>
> >> Stefano Garzarella <sgarzare@redhat.com> writes:
> >>
> >> > On Tue, May 07, 2019 at 08:34:51AM +0200, Markus Armbruster wrote:
> [...]
> >> >> Let me review support in drivers:
> >> >>
> >> >> * file (file-win32.c)
> >> >> * iscsi
> >> >> * nfs
> >> >> * qed
> >> >> * ssh
> >> >>
> >> >>   - Reject all but PREALLOC_MODE_OFF
> >> >>
> >> >> * copy-on-read
> >> >> * luks (crypto.c)
> >> >> * raw
> >> >>
> >> >>   - Pass through only
> >> >>
> >> >> * file host_cdrom host_device (file-posix.c)
> >> >>
> >> >>   - Reject all but PREALLOC_MODE_OFF when shrinking and for non-regular
> >> >>     files
> >> >>   - Reject PREALLOC_MODE_FALLOC unless CONFIG_POSIX_FALLOCATE
> >> >>   - Reject PREALLOC_MODE_METADATA
> >> >>
> >> >> * gluster
> >> >>
> >> >>   - Reject all but PREALLOC_MODE_OFF when shrinking
> >> >>   - Reject PREALLOC_MODE_FALLOC unless CONFIG_GLUSTERFS_FALLOCATE
> >> >>   - Reject PREALLOC_MODE_FULL unless CONFIG_GLUSTERFS_ZEROFILL
> >> >>   - Reject PREALLOC_MODE_METADATA
> >> >>
> >> >> * qcow2
> >> >>
> >> >>   - Reject all but PREALLOC_MODE_OFF when shrinking and with a backing
> >> >>     file
> >> >>
> >> >> * rbd with this patch
> >> >>
> >> >>   - Reject all but PREALLOC_MODE_OFF when shrinking
> >> >>   - Reject PREALLOC_MODE_METADATA and PREALLOC_MODE_FALLOC
> >> >>
> >> >> * sheepdog
> >> >>
> >> >>   - Reject PREALLOC_MODE_METADATA and PREALLOC_MODE_FALLOC
> >> >>   - Doesn't support shrinking
> >> >>
> >> >> * vdi
> >> >>
> >> >>   - Reject PREALLOC_MODE_FALLOC and PREALLOC_MODE_FULL
> >> >>   - Doesn't support shrinking
> >> >>
> >> >> * blkdebug
> >> >> * blklogwrites
> >> >> * blkverify
> >> >> * bochs
> >> >> * cloop
> >> >> * dmg
> >> >> * ftp
> >> >> * ftps
> >> >> * http
> >> >> * https
> >> >> * luks
> >> >> * nbd
> >> >> * null-aio
> >> >> * null-co
> >> >> * nvme
> >> >> * parallels
> >> >> * qcow
> >> >> * quorum
> >> >> * replication
> >> >> * throttle
> >> >> * vhdx
> >> >> * vmdk
> >> >> * vpc
> >> >> * vvfat
> >> >> * vxhs
> >> >>
> >> >>   - These appear not to use PreallocMode: they don't implement
> >> >>     .bdrv_co_truncate(), and either don't implement .bdrv_co_create() or
> >> >>     implement it without a prealloc parameter.
> >> >>
> >> >> Looks good to me.
> >> >>
> >> >
> >> > Thanks for the analysis!
> [...]
> >> > If you agree, I can check and update the documentation of all drivers following
> >> > your analysis.
> >>
> >> Yes, please!
> >
> >
> > Hi Markus,
> > I'm finally updating the documentation of preallocation modes
> > supported by block drivers and protocols in qapi/block-core.json.
> > As sheepdog and vdi I'm adding the supported values for each driver or
> > protocol that supports 'preallocation' parameter during the creation,
> > I'm also updating the '.help' in the QemuOptsList.
> >
> > My doubt is: where is better to put the documentation about
> > preallocation modes supported during the resize? (e.g. some drivers
> > support only PREALLOC_MODE_OFF when shrinking)
> 
> As far as I can tell, no driver supports anything but PREALLOC_MODE_OFF
> when shrinking.  Suggest to ignore the shrinking case for now when
> documenting.
> 

Okay, I'll ignore it for now.

> I'm not sure I fully answered your question.  Don't hesitate to ask for
> more advice.

Yes, your answer is what I was looking for :)

Thanks,
Stefano

