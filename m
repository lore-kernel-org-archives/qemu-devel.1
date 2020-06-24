Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D39C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76B120738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 13:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1qdfIIZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76B120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo5Tk-00041m-FT
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 09:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1jo5SL-00021c-D8
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:28:49 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231]:42797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1jo5SJ-0002lr-PJ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 09:28:49 -0400
Received: by mail-lj1-x231.google.com with SMTP id y11so2524544ljm.9
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=nUrO1UmohK9ah4PTXz60cWnuU3BQE5TYlbAsoayD3rs=;
 b=j1qdfIIZ/q1NnGEj8rl1xpFjrLO16wTKUdJwWNBQqs/KEhL2zgL4G9Wuctl4moJ8L8
 p4QD4qRv+Jxfb3+f3s7wl4Zd3HVNUHUfLz5v/chtPrx2T9XWvEXr6GmUGONf8WQLq4BW
 6m+SjU0Ndjxhap5GK2lRLh4Uq574Av38crJK56x1R/5NmS/M3wZfhD0jPcgUB5YDesge
 1PUPooOkLnVqkckEFq6tB7UrB+I4SGRviggewzrNWeK1onAWEH1IUxSRhwJIqMhRGmLK
 HmIn7mwpJ6+6YvbNXqsbNTDDBBKInK+XtlISN/Tt0BzD4Z4K5VNdaI5FTtQ6H4aTej4k
 4f0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=nUrO1UmohK9ah4PTXz60cWnuU3BQE5TYlbAsoayD3rs=;
 b=gjkN2lwbsCYaeIp80qlr5rOJqUAx77zTDwzKEfUDk7T3j3AJd/X0C2bHY126LTI98Y
 /PARa/1i8HDINI1NrwCCCXTNK+bEVr2Quxfmnqt8WdItbpctZuCy+YeL0Kc0ezkwAPfS
 GR/tz2XOcMFjsiV3BcmRyxmET8UQnVNLsNDts18LyAnj+px3uL/Bq4Uip6kc/Ko3/L5K
 YgmyQyO5d+jZ9fgQDEb8MmGqus/FtHhEEDGXAlzJQ8M/2D2JNAYPRPoERNwjDx/lXvxx
 Ud7iJOAufEKXBrFntqc8VzqFRAKrGuf6DBW9U/rv6GoWY4PUmHNpUdipIWHmxt9olLY3
 NZAQ==
X-Gm-Message-State: AOAM532jVEoaGKIGwYfGgCz2XWl9es3LT9pYqHXEcDJ+qBYIooGwSA5d
 1tRN3YlRXu5CHjb16SHV/zjizD4043v4Rqhzs/eeVlVx
X-Google-Smtp-Source: ABdhPJx7vdw407d2wlLmqmq7qPN+YgmYyWzZLeZti3qgdfxdqAyoP7/KyEKrMYgsteU0k3JGc7eosC0VKWXGiyAxTcE=
X-Received: by 2002:a2e:9a59:: with SMTP id k25mr14877859ljj.114.1593005325745; 
 Wed, 24 Jun 2020 06:28:45 -0700 (PDT)
MIME-Version: 1.0
From: Jason Andryuk <jandryuk@gmail.com>
Date: Wed, 24 Jun 2020 09:28:34 -0400
Message-ID: <CAKf6xptNySqXOHAZJiiBq=h99GBQcS8Cbzmpyqzy-ucxX8Od2Q@mail.gmail.com>
Subject: Migration vmdesc and xen-save-devices-state
To: QEMU <qemu-devel@nongnu.org>, xen-devel <xen-devel@lists.xenproject.org>, 
 zhang.zhanghailiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=jandryuk@gmail.com; helo=mail-lj1-x231.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

At some point, QEMU changed to add a json VM description (vmdesc)
after the migration data.  The vmdesc is not needed to restore the
migration data, but qemu_loadvm_state() will read and discard the
vmdesc to clear the stream when should_send_vmdesc() is true.

xen-save-devices-state generates its migration data without a vmdesc.
xen-load-devices-state in turn calls qemu_loadvm_state() which tries
to load vmdesc since should_send_vmdesc is true for xen.  When
restoring from a file, this is fine since it'll return EOF, print
"Expected vmdescription section, but got 0" and end the restore
successfully.

Linux stubdoms load their migration data over a console, so they don't
hit the EOF and end up waiting.  There does seem to be a timeout
though and restore continues after a delay, but we'd like to eliminate
the delay.

Two options to address this are to either:
1) set suppress_vmdesc for the Xen machines to bypass the
should_send_vmdesc() check.
or
2) just send the vmdesc data.

Since vmdesc is just discarded, maybe #1 should be followed.

If going with #2, qemu_save_device_state() needs to generate the
vmdesc data.  Looking at qemu_save_device_state() and
qemu_savevm_state_complete_precopy_non_iterable(), they are both very
similar and could seemingly be merged.  qmp_xen_save_devices_state()
could even leverage the bdrv_inactivate_all() call in
qemu_savevm_state_complete_precopy_non_iterable().

The would make qemu_save_device_state a little more heavywight, which
could impact COLO.  I'm not sure how performance sensitive the COLO
code is, and I haven't measured anything.

Does anyone have thoughts or opinions on the subject?

Thanks,
Jason

