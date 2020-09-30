Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796ECC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C3892076E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 12:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOXsW/Aq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3892076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNb2W-0000hd-7O
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 08:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kNb15-00089S-Gt; Wed, 30 Sep 2020 08:15:27 -0400
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:39662)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kNb13-0007Tn-OE; Wed, 30 Sep 2020 08:15:27 -0400
Received: by mail-lf1-x143.google.com with SMTP id q8so1857914lfb.6;
 Wed, 30 Sep 2020 05:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=qbZSVSU17WV55dOskSAdoTUJcp8hLjwx5Q8wWgC5cPM=;
 b=fOXsW/AqW48b33lgFHVjub2d0CFXvv7ULHfSYF58BPGxd49SA0Q0No+SGKT1GjZJc5
 n/U6OfToJyKDTUTxDgeowrriBvfrmpqV08iKS5hKU5M1HdBn4RSTrDfLmS+pL6PuO2xd
 iKImjB5FHtAbWGhdLFLfJiShXCutpzWvDcF7j2l4fqDpUsQn2oi6UjHc+dtk1be8cCd1
 J/k+fA+wlHPB16GOcHfeuFFTncZmguumo2QoCnUYX5WzHmYoBzA3uJr8ewqlWree4bQY
 HbkOa0p/tVrPi4gCIyMQS2GHAxnul+ycjeGoDtHzqyTkPjDag8jCk94lGx6sxLosbZIM
 A2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=qbZSVSU17WV55dOskSAdoTUJcp8hLjwx5Q8wWgC5cPM=;
 b=gEG9V1Cjhm1Fc1s9N5+2Ih/eJmOudSEkUtu+GR1lHviRFSfMAtfcw9MoneFvH4uo/k
 AOS7tiIDku4pOnNsI+HXN3JRVNmaS0Vj9MyHdSCVVEXnz2eq3mqYq1eLvXkXLrdfrATV
 LfFpAIWEC40npEiSW4StQeT9ns3QU/g43XR4qVct7HMGBVb7vbNfnWhZrfAOiOsXiGlF
 Rd8d1IPf/ZIkO8TtZPL9lDoCjXnVX9rqqD8xeOyDCl3X99V4e63PUDV6usJfosDpX1jy
 5xM7jkCqGph5zpw1Q+K4aI5OiOnrXkadC65uogf+T/2MmwZdSQ8wQgY0MzgmKWAv39q4
 maeA==
X-Gm-Message-State: AOAM532vryW8EMy3Zit8tPvaMF4QK9cU6ykdIxk1UmV3bdW4qpCJp/p1
 /GCZHKa5IJWPhLKD7VNY8Gk=
X-Google-Smtp-Source: ABdhPJzjJaYWixBqC11ZKbbrmrQVAoWMWpQxCn0IFMYHFEv54xS/U2vU8FgFHj2BRdzxk0/7P4X14A==
X-Received: by 2002:a19:e4c:: with SMTP id 73mr884357lfo.286.1601468122542;
 Wed, 30 Sep 2020 05:15:22 -0700 (PDT)
Received: from [192.168.167.128] (37-145-186-126.broadband.corbina.ru.
 [37.145.186.126])
 by smtp.gmail.com with ESMTPSA id m204sm170105lfd.307.2020.09.30.05.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 05:15:22 -0700 (PDT)
Message-ID: <db5d1fc04bdb15da6c9ecf65402a784aab856ede.camel@gmail.com>
Subject: Re: [PATCH] job: delete job_{lock,unlock} functions and replace
 them with lock guard
From: Elena Afanasova <eafanasova@gmail.com>
To: John Snow <jsnow@redhat.com>
Date: Wed, 30 Sep 2020 05:15:07 -0700
In-Reply-To: <b055221b-c436-1ff3-b986-5a522178fde8@redhat.com>
References: <20200929134214.4103-1-eafanasova@gmail.com>
 <b055221b-c436-1ff3-b986-5a522178fde8@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::143;
 envelope-from=eafanasova@gmail.com; helo=mail-lf1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-09-29 at 14:04 -0400, John Snow wrote:
> On 9/29/20 9:42 AM, Elena Afanasova wrote:
> > Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
> 
> Hi, can I have a commit message here, please?
> 
> > ---
> >   job.c | 46 +++++++++++++++++-----------------------------
> >   1 file changed, 17 insertions(+), 29 deletions(-)
> > 
> > diff --git a/job.c b/job.c
> > index 8fecf38960..89ceb53434 100644
> > --- a/job.c
> > +++ b/job.c
> > @@ -79,16 +79,6 @@ struct JobTxn {
> >    * job_enter. */
> >   static QemuMutex job_mutex;
> >   
> > -static void job_lock(void)
> > -{
> > -    qemu_mutex_lock(&job_mutex);
> > -}
> > -
> > -static void job_unlock(void)
> > -{
> > -    qemu_mutex_unlock(&job_mutex);
> > -}
> > -
> >   static void __attribute__((__constructor__)) job_init(void)
> >   {
> >       qemu_mutex_init(&job_mutex);
> > @@ -437,21 +427,19 @@ void job_enter_cond(Job *job, bool(*fn)(Job
> > *job))
> >           return;
> >       }
> >   
> > -    job_lock();
> > -    if (job->busy) {
> > -        job_unlock();
> > -        return;
> > -    }
> > +    WITH_QEMU_LOCK_GUARD(&job_mutex) {
> > +        if (job->busy) {
> > +            return;
> > +        }
> >   
> > -    if (fn && !fn(job)) {
> > -        job_unlock();
> > -        return;
> > -    }
> > +        if (fn && !fn(job)) {
> > +            return;
> > +        }
> >   
> > -    assert(!job->deferred_to_main_loop);
> > -    timer_del(&job->sleep_timer);
> > -    job->busy = true;
> > -    job_unlock();
> > +        assert(!job->deferred_to_main_loop);
> > +        timer_del(&job->sleep_timer);
> > +        job->busy = true;
> > +    }
> >       aio_co_enter(job->aio_context, job->co);
> >   }
> >   
> > @@ -468,13 +456,13 @@ void job_enter(Job *job)
> >    * called explicitly. */
> >   static void coroutine_fn job_do_yield(Job *job, uint64_t ns)
> >   {
> > -    job_lock();
> > -    if (ns != -1) {
> > -        timer_mod(&job->sleep_timer, ns);
> > +    WITH_QEMU_LOCK_GUARD(&job_mutex) {
> > +        if (ns != -1) {
> > +            timer_mod(&job->sleep_timer, ns);
> > +        }
> > +        job->busy = false;
> > +        job_event_idle(job);
> 
> Is this new macro safe to use in a coroutine context?

Hi, I suppose it's safe. It would be nice to get some more opinions
here.

> >       }
> > -    job->busy = false;
> > -    job_event_idle(job);
> > -    job_unlock();
> >       qemu_coroutine_yield();
> >   
> >       /* Set by job_enter_cond() before re-entering the
> > coroutine.  */
> > 
> 
> I haven't looked into WITH_QEMU_LOCK_GUARD before, I assume it's new.
> If 
> it works like I think it does, this change seems good.
> 
> (I'm assuming it works like a Python context manager and it drops
> the 
> lock when it leaves the scope of the macro using GCC/Clang language 
> extensions.)
> 


