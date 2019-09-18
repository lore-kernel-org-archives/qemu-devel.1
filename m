Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C85C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 00:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28D94206C2
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 00:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D94206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iANf6-0004RR-8p
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 20:17:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iANeA-0003zc-AS
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 20:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iANe7-0001Rx-Pt
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 20:16:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39584)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iANe7-0001Q1-GJ
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 20:16:35 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5551581F11
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 00:16:33 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id z4so3611594pfn.0
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 17:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=5N0+hUSCAu9hul42mvoG1kRE/emotgRwM2NXikwk1n4=;
 b=aHC1hpQBr9HbyARkAStnZvXjiqxUuYxaSR4cCD7svFd4gEz1oOpXOXJ02zLeerU59u
 g+wUXJSPiExIQdyqWAkDjK+lP8idzeYw6jvnwZPxNoYN0kJEM9PrRwUd8Yfnv71L+r9n
 uLQsrndPcBVTipJYBy0u58UlJxRTf2pyL4SoYWPUCwd3pbtI5ApFWf9ITH3fhcXEehoB
 kibDTWDyP4niyhyT5xMBZZzcG2ll6486Ggfforlz2sDJwxjK2q3dycl5kObnUyfM9qJz
 CV4KUyt2x5XXWs5qbT2JBxL9yOjOKNwx6fEgUqpZmzjM72M6guX0wWL65H+YuCeMObNK
 Oaow==
X-Gm-Message-State: APjAAAUT+g2Xw0sUAFrQeWgBo4Rn9hiHK1D+IvmrHIX7sGv2qXGzKccU
 0ASpb8jWpzCKoXmY8oIMfk3ADzkhG935JyJZ9ACGlpYgEk6Zj70SoOSG1fjvf39fXavtDGhYHwA
 Y4jmh/pqsDhXSae8=
X-Received: by 2002:a63:fe42:: with SMTP id x2mr1446003pgj.80.1568765792742;
 Tue, 17 Sep 2019 17:16:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz14pyBiqsbkgZklpdHcilxoUEmBGLJij5uoBMIP6Uma4/44LBHw3LyYqtG32pEHHutAS7Hpg==
X-Received: by 2002:a63:fe42:: with SMTP id x2mr1445986pgj.80.1568765792327;
 Tue, 17 Sep 2019 17:16:32 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 132sm5748249pgg.52.2019.09.17.17.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 17:16:31 -0700 (PDT)
Date: Wed, 18 Sep 2019 08:16:21 +0800
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190918001621.GH30562@xz-x1>
References: <20190916132347.30676-1-imammedo@redhat.com>
 <20190916132347.30676-3-imammedo@redhat.com>
 <20190917084442.GE30562@xz-x1> <20190917154212.1fab537f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190917154212.1fab537f@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 2/2] s390: do not call
 memory_region_allocate_system_memory() multiple times
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 17, 2019 at 03:42:12PM +0200, Igor Mammedov wrote:
> On Tue, 17 Sep 2019 16:44:42 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Mon, Sep 16, 2019 at 09:23:47AM -0400, Igor Mammedov wrote:
> > > PS:
> > > I don't have access to a suitable system to test it.  
> > 
> > Hmm I feel like it would be good to have series like this to be at
> > least smoke tested somehow...
> > 
> > How about manually setup a very small max memslot size and test it on
> > x86?  IMHO we'd test with both KVMState.manual_dirty_log_protect to be
> > on & off to make sure to cover the log_clear() code path.  And of
> > course to trigger those paths we probably need migrations, but I
> > believe local migrations would be enough.
> 
> I did smoke test it (Fedora boot loop) [*] on s390 host with hacked
> 1G max section. I guess I could hack x86 and do the same for x86 guest.
> Anyways, suggestions how to test it better are welcome.
> 
> *) I don't have much faith in tests we have though as it didn't
>    explode with broken v5 in my case. Hence CCing ones who is more
>    familiar with migration parts.
> 
>    I used 2 memslot split config at 1Gb with offline migration like this:
> 
>    $ qemu-system-s390x -M s390-ccw-virtio -m 2048 -cpu max -smp 2 -M accel=kvm  \
>         --nographic --hda fedora.qcow2 -serial unix:/tmp/s,server,nowait \
>         -monitor stdio 
>      (monitor) stop
>      (monitor) migrate "exec: cat > savefile
>      (monitor) q
>    $ qemu-system-s390x -M s390-ccw-virtio -m 2048 -cpu max -smp 2 -M accel=kvm  \
>         --nographic --hda fedora.qcow2 -serial unix:/tmp/s,server,nowait \
>         -incoming "exec: cat savefile"

Yeah this looks good already. A better one could be (AFAICS):

  1) as mentioned, enable KVMState.manual_dirty_log_protect to test
     the log_clear path by offering a host kernel new enough (Linux
     5.2+), then it'll be on by default.  Otherwise the default is
     off.  We can enable some trace points to make sure those code
     paths are triggered if uncertain like trace_kvm_clear_dirty_log.

  2) more aggresive dirtying. This can be done by:

    - run a mem dirty workload inside.  I normally use [1] on my own
      ("mig_mon mm_dirty 1024 500" will dirty mem upon 1024MB with
      500MB/s dirty rate), but any tool would work

    - turn down migration bandwidth using "migrate_set_speed" so the
      migration even harder to converge, then dirty bit path is
      tortured more.  Otherwise local full-speed migration normally
      completes super fast due to pure mem moves.

Though if with 2) above I'd suggest to use unix sockets or tcp
otherwise the dumped file could be super big (hopefully not eating all
the laptop disk!).

[1] https://github.com/xzpeter/clibs/blob/master/bsd/mig_mon/mig_mon.c

Regards,

-- 
Peter Xu

