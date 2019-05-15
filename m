Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FEAC04E84
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5D82084E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcWHLkTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5D82084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36493 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQt2i-0008Iy-D1
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 08:29:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hQt1E-0007Se-6O
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hQt1D-0006zX-4Q
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:28:24 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:41116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hQt1C-0006fi-N3
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:28:23 -0400
Received: by mail-ed1-x541.google.com with SMTP id m4so3830194edd.8
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 05:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=cbaLoTFydWQo72ytbfEQ1owVAhADDT3+OqWdRDyyzto=;
	b=YcWHLkTcgLPIdP+Cdv8qQu+VlQWfReXEgR9FgWSUp1TH1w06dx9ifp4azRv6kYSldW
	J5kpQNKzZmMWEHjaKjniZ3XHu30jtkJLHUEQOg1VFVwPwl+wsknX7SWTpu+M3h9BU57O
	82lwmGonehuRcIDILqjmIJT+9fwcOC9MNUXlQAwJJH/QlkSxuTRGDySysd6ZnuPhh0C5
	65PJoLedEr0lKRckEb5oA1WPDmsusrVONSir2QbhUi/mSu5u14Fyc/3WMSqX4hFBRkRo
	MiB9e3GLn1HAoZsCZPYXZbpJeN0KOgZCf35MkC0nIi1bIUj69lmLlyb/5ldVuFdCS9Za
	gkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=cbaLoTFydWQo72ytbfEQ1owVAhADDT3+OqWdRDyyzto=;
	b=nxdRoRGhcfiveodLskj2UtQfa1KI1joEGwDZLvm1nnc2Zb7Io/JuMNUGaoAwgfxnQc
	G21OApJq7OlHRYJFU+c0volILOHU303T53Kwc1ZLKFL7q5TYPReMHuc0f6Sp0Cew/AuD
	ZB925m+PzfU3Bp6Wxzg95TkU+DBZTShMEm8NvQnz2nRWwVZo4JyRkjwvthfjEF5ZIWQC
	Dc8rCow7t98QRmt4gBtn5qKIh1yR1k2Pq2F/z2+Y0qmuLibxQUd5abEMm0pqR2Yp1Efn
	mnTx62gFuEAOwfOGt+egEFrdwn4SLZROaUUB3fs+5ATecjoJt84y7yX63M0B/zKuSCIK
	JlPw==
X-Gm-Message-State: APjAAAWcgR6syGSdBF2E+CKMgDn4UVRl0zKXzsf5yPV/s7RoMG7MgqNk
	bWQzmER6bRUYq75EaHyLWXE=
X-Google-Smtp-Source: APXvYqz35Spzmnks6NyxjaV0PFvJRZwRZ7MMfZoteUQPZ/nvDpOnTUkE0nnz7/+95HIfpcdKiS2oRg==
X-Received: by 2002:a50:8903:: with SMTP id e3mr40298055ede.11.1557923299241; 
	Wed, 15 May 2019 05:28:19 -0700 (PDT)
Received: from localhost ([185.92.221.13])
	by smtp.gmail.com with ESMTPSA id w14sm441426ejv.58.2019.05.15.05.28.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 05:28:17 -0700 (PDT)
Date: Wed, 15 May 2019 12:28:17 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190515122817.of52yngzguy6xfwn@master>
References: <20190424004700.12766-1-richardw.yang@linux.intel.com>
	<20190424004700.12766-3-richardw.yang@linux.intel.com>
	<0eb5e5a5-593e-f4a2-7e2d-a9fed481ab6c@gmail.com>
	<20190426005133.GB25513@richard> <20190514151813.GL2753@work-vm>
	<20190515063827.GB11845@richard> <20190515070341.GA24741@richard>
	<20190515093837.GD2668@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515093837.GD2668@work-vm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH 2/4] migration/savevm: use
 migration_is_blocked to validate
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Cc: quintela@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>,
	Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 10:38:37AM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> On Wed, May 15, 2019 at 02:38:27PM +0800, Wei Yang wrote:
>> >On Tue, May 14, 2019 at 04:18:14PM +0100, Dr. David Alan Gilbert wrote:
>> >>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> >>> 
>> >>> Well, when you look into the source side of migration:
>> >>> 
>> >>> qmp_migrate
>> >>>   migrate_prepare
>> >>>     migration_is_blocked
>> >>> 
>> >>> This means if migration_is_blocked fails, the source will not start migration.
>> >>> And it is the same as save_snapshot.
>> >>> 
>> >>> From my understanding, when we load a vm, it should check the same
>> >>> requirement.
>> >>
>> >>I've been thinking about this, and I think I agree with Daniel on this.
>> >>The 'migration_blockers' list tells you that something about the
>> >>*current* state of a device means that it can't be migrated - e.g.
>> >>a 9pfs with a mounted filesystem can't be migrated.
>> >>
>> >>If we're about to reload the state from a snapshot, then the saved
>> >>snapshot's state must have been migratable, so that's OK.
>> >>
>> >
>> >The situation is on a vm with 'migration_blockers' still could reload from a
>> >snapshot.
>> >
>> >This sounds reasonable. Thanks :-)
>> >
>> 
>> Well, this is still a little strange. The means source vm and destination vm
>> could have different configuration. Is this common?
>
>It's not different configuration that I'm worried about here; but it's different runtime state.
>Items can get added/removed from migration_blockers dynamically
>depending on the behaviour of the guest; e.g. a device might only
>migratable in certain states.
>

I am not familiar with the usage of migration_blockers, just found one case
when we add a reason to it. -- vhost_dev_init().

Per my understanding, this is a device. We specify it in command line or use
hot-plug to add it. To me, guest may not alter the add/remove? Looks even we
have one such device, we still could load vm. This looks not bad, but we have
the different devices from source. 

BTW, migration works if source and destination have different devices?

As you mentioned, these is some case where guest could add/remove a reason to
migration_blockers.  This is what you concerned right?

Do we need to limit the usage of migration_blockers? Just use this in the case
you concerned?

>Dave
>
>
>> -- 
>> Wei Yang
>> Help you, Help me
>--
>Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Wei Yang
Help you, Help me

