Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4337C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:41:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767E1206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 16:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767E1206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIF1H-0004P6-B4
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 12:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52984)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iI3L8-0004SJ-PO
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 00:12:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iI3L6-00075A-5d
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 00:12:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iI3L5-00074u-Ti
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 00:12:40 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 54EB79B28C
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 04:12:38 +0000 (UTC)
Received: by mail-pg1-f197.google.com with SMTP id r24so741183pgj.17
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 21:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=ZPrpLWbOiPgMepprMvnvxPnkY4AxeJFeGRMKug+Qn2I=;
 b=NuXYv7UKRE+fG2kE8VQe2imWbTTsFe6qv88IpTqLtWOhBO3uU+WeH7ub31q1pxIAC6
 utbCW/fSbf3yfrmjFNFfnNsTO2PIEcRjvs5v2sKMbdtteclRqefrDSW6ZcpzIen34ssa
 6niKxZHmm5IKySYRcxqzrjNoz9BslSpZ87uYXaxZKZbszfXpZqCtb8akLwYckEeaFN7b
 dGeD8UF2j7gdHcs4HE+tNrP+f2KMGNgwyk8Jm+ZyAnE64atQjFyBKz5NM3bwh1llv3Za
 zMSN5hg//BIWePhWSu3DghDAfBwjJdzEMS+HJ/pw3CCYcFY39ul5USga6HoioilWhVgl
 hKyw==
X-Gm-Message-State: APjAAAXqF3V4mSkFCthhQQxj5J4imFlPlTi2kISUaVQRGtl4/qV2yVGo
 7+CurJfwI8jJEgo1jwPMD4TWNuOBaJ1x1Xx0pS7v/6l3WgnuhLn6evrgOJiBMk2UiFYzOcnZ5X/
 wI7hnJw5YXrE1Yt8=
X-Received: by 2002:a63:f250:: with SMTP id d16mr2119291pgk.165.1570594357534; 
 Tue, 08 Oct 2019 21:12:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxduM62s2FHP4wGxuC3bf0C6bpFPxwH5UdQeG+D8w5X5QOafwSRHYTvK/szekl63bDeqFp+eQ==
X-Received: by 2002:a63:f250:: with SMTP id d16mr2119259pgk.165.1570594357115; 
 Tue, 08 Oct 2019 21:12:37 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b22sm631800pfo.85.2019.10.08.21.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 21:12:36 -0700 (PDT)
Date: Wed, 9 Oct 2019 12:12:25 +0800
From: Peter Xu <peterx@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 3/3] migration/postcopy: handle POSTCOPY_INCOMING_RUNNING
 corner case properly
Message-ID: <20191009041225.GF10750@xz-x1>
References: <20191001100122.17730-1-richardw.yang@linux.intel.com>
 <20191001100122.17730-4-richardw.yang@linux.intel.com>
 <20191008164046.GF3441@work-vm> <20191009010204.GC26203@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191009010204.GC26203@richard>
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 09, 2019 at 09:02:04AM +0800, Wei Yang wrote:
> On Tue, Oct 08, 2019 at 05:40:46PM +0100, Dr. David Alan Gilbert wrote:
> >* Wei Yang (richardw.yang@linux.intel.com) wrote:
> >> Currently, we set PostcopyState blindly to RUNNING, even we found the
> >> previous state is not LISTENING. This will lead to a corner case.
> >> 
> >> First let's look at the code flow:
> >> 
> >> qemu_loadvm_state_main()
> >>     ret = loadvm_process_command()
> >>         loadvm_postcopy_handle_run()
> >>             return -1;
> >>     if (ret < 0) {
> >>         if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING)
> >>             ...
> >>     }
> >> 
> >> From above snippet, the corner case is loadvm_postcopy_handle_run()
> >> always sets state to RUNNING. And then it checks the previous state. If
> >> the previous state is not LISTENING, it will return -1. But at this
> >> moment, PostcopyState is already been set to RUNNING.
> >> 
> >> Then ret is checked in qemu_loadvm_state_main(), when it is -1
> >> PostcopyState is checked. Current logic would pause postcopy and retry
> >> if PostcopyState is RUNNING. This is not what we expect, because
> >> postcopy is not active yet.
> >> 
> >> This patch makes sure state is set to RUNNING only previous state is
> >> LISTENING by introducing an old_state parameter in postcopy_state_set().
> >> New state only would be set when current state equals to old_state.
> >> 
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >
> >OK, it's a shame to use a pointer there, but it works.
> 
> You mean second parameter of postcopy_state_set()?
> 
> I don't have a better idea. Or we introduce a new state
> POSTCOPY_INCOMING_NOCHECK. Do you feel better with this?

Maybe simply fix loadvm_postcopy_handle_run() to set the state after
the POSTCOPY_INCOMING_LISTENING check?

> 
> >Note, something else; using '-1' as the return value and checking for it
> >is something we do a lot; but in this case it's an example of an error
> >we could never recover from so it never makes sense to try and recover.
> >We should probably look at different types of error.

It is true that we might hang on some real errors, but IMHO it might
be no where better to quit QEMU if we're in postcopy...

(What I'm thinking in mind here is that sometimes even if postcopy
 failed we might still have a chance to recover a full VM by dumping
 both src/dst of the during-postcopy VM instances and manually merge
 them by black magic, in very extreme cases)

Regards,

-- 
Peter Xu

