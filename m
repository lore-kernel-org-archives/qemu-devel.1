Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BE1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 02:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F302D2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 02:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJrRcOqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F302D2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joHsk-00049j-6w
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 22:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1joHs8-0003jt-JV
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 22:44:16 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235]:38618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1joHs6-0001q8-Ub
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 22:44:16 -0400
Received: by mail-lj1-x235.google.com with SMTP id 9so4796550ljv.5
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 19:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ijxYOypE8JXmxPV7oqzpPRU34Arl5A/6UxXyzebkzTE=;
 b=aJrRcOqcB6m7AtN2HWtoifTfn5MvNxminS0EWt/BO2jobOhDpWEwVAh/U4We2yzNwi
 j8G1/OVA6ztA3TYFz6vw79ki0ePUwKugeodA+6ZC5m4TrhDif/lLjZv97BxEUlzKD/sw
 qYCYbTmHp/wWihFbMiPIHYRmUG8f+zJTNWl0GXQKm/DEh3FmT0F40a5jz8dPXFJ8hDnO
 D1k2Jln0hRIfu6HSRvUR+ci8Uoc5yAKuKgpdji+y83Jo3RuBX93j59VLcI30QvucAgje
 CRX4Yd3NAu/q9n2ILMvaPz/nS9rDTC5XLXhew4elue1ZfiuKKQwF0/ainIbLNu+WGMjY
 pCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ijxYOypE8JXmxPV7oqzpPRU34Arl5A/6UxXyzebkzTE=;
 b=JMSnphFerEPd1gTfz4/BNxgciAthPz2QP9o82FEWQDhzR/25X6/v721gSyq4MTp5RR
 E+EKDe7O9ySA6AGldq7w+vkpn2yJrbR5uvBekEg6myTFuq4oKRGLPneDQWox7k1455vN
 8QXe4/RINfYMJoB6kNfFsAFD3qKr0cDaVvfKXkfWBPfgMW+NXG90ZPyZy2z2UbQEvWd3
 mDnhmd+IZboEkR3691oYIOEMVY3lKVhn4nDtm5SB0nQpd14GInkmKelY8p1WfKSoYU34
 f1aMngh3nXxkUTZQ7Xdq++y7FRNZJXW/qACBPvjhT28fJZGVzoJq9UKMUpBJEghrllZW
 ak4Q==
X-Gm-Message-State: AOAM53319mmlo6yAxqWwDZko5aP39gX2oc8AAOcxISCXMqUuIGwIjEQt
 M6/Ti1SJw2G+qDKDYBBxop0AielGTKzbeKY2EHU=
X-Google-Smtp-Source: ABdhPJyuLSZ/XCaBa1ABWU/XsMuIcc8TqjQSUuD8XEgjbvwas8KZop8+H2BeD4OCm3fYLTHkJ/qjr/24fQvYc3CNdBg=
X-Received: by 2002:a2e:978b:: with SMTP id y11mr3907624lji.399.1593053053018; 
 Wed, 24 Jun 2020 19:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAKf6xptNySqXOHAZJiiBq=h99GBQcS8Cbzmpyqzy-ucxX8Od2Q@mail.gmail.com>
 <20200624175653.GA49433@work-vm>
In-Reply-To: <20200624175653.GA49433@work-vm>
From: Jason Andryuk <jandryuk@gmail.com>
Date: Wed, 24 Jun 2020 22:44:00 -0400
Message-ID: <CAKf6xpvtiOVSY8VWFi-bRAAsTGy0nVNZk0aO4HKshXAXQ9Kt5Q@mail.gmail.com>
Subject: Re: Migration vmdesc and xen-save-devices-state
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=jandryuk@gmail.com; helo=mail-lj1-x235.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: xen-devel <xen-devel@lists.xenproject.org>, QEMU <qemu-devel@nongnu.org>,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 1:57 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Jason Andryuk (jandryuk@gmail.com) wrote:
> > Hi,
> >
> > At some point, QEMU changed to add a json VM description (vmdesc)
> > after the migration data.  The vmdesc is not needed to restore the
> > migration data, but qemu_loadvm_state() will read and discard the
> > vmdesc to clear the stream when should_send_vmdesc() is true.
>
> About 5 years ago :-)

:)

> > xen-save-devices-state generates its migration data without a vmdesc.
> > xen-load-devices-state in turn calls qemu_loadvm_state() which tries
> > to load vmdesc since should_send_vmdesc is true for xen.  When
> > restoring from a file, this is fine since it'll return EOF, print
> > "Expected vmdescription section, but got 0" and end the restore
> > successfully.
> >
> > Linux stubdoms load their migration data over a console, so they don't
> > hit the EOF and end up waiting.  There does seem to be a timeout
> > though and restore continues after a delay, but we'd like to eliminate
> > the delay.
> >
> > Two options to address this are to either:
> > 1) set suppress_vmdesc for the Xen machines to bypass the
> > should_send_vmdesc() check.
> > or
> > 2) just send the vmdesc data.
> >
> > Since vmdesc is just discarded, maybe #1 should be followed.
>
> #1 does sound simple!
>
> > If going with #2, qemu_save_device_state() needs to generate the
> > vmdesc data.  Looking at qemu_save_device_state() and
> > qemu_savevm_state_complete_precopy_non_iterable(), they are both very
> > similar and could seemingly be merged.  qmp_xen_save_devices_state()
> > could even leverage the bdrv_inactivate_all() call in
> > qemu_savevm_state_complete_precopy_non_iterable().
> >
> > The would make qemu_save_device_state a little more heavywight, which
> > could impact COLO.  I'm not sure how performance sensitive the COLO
> > code is, and I haven't measured anything.
>
> COLO snapshots are potentially quite sensitive; although we've got a
> load of other things we could do with speeding up, we could do without
> making them noticably heavier.

qemu_savevm_state_complete_precopy_non_iterable() generates the vmdesc
json and just discards it if not needed.  How much overhead that adds
is the question.

Thanks,
Jason

