Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D02C04AAB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 16:47:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2B821726
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 16:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2B821726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40300 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOPig-0007Pe-Hp
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 12:47:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hOPh7-0006Bt-80
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hOPh5-0004TP-Vx
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:45:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36823)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1hOPh5-0004Kd-Es
	for qemu-devel@nongnu.org; Wed, 08 May 2019 12:45:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id o4so28108373wra.3
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 09:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=bZ+tu+/ICtwv8ZZyBrkHfYnbpxIC4jyGZUjz6/c59hQ=;
	b=lhtalKcqh8yt2AUJy7dIVjx+zGdmIfZC4deNrwAgiaxCDARRtJQVHhxzgbv9Jld/qC
	3SF1+Ew4UHErLpjVZ2fyuZwnox7TmeCQWkKSCVmNKOmTw5FeurvQ5j9PdZT1uCRp8T7G
	2jWMpV6VdU8blueHtBMu3WBfn/kbGbVMBLwbqJiMPhbwpFC9riyFxbgUi9P9QnhRUO90
	h9/tQoRdq1I9K8G4xUULgg0x4mvI5X0mQdjaKl+QzpC7sY51KymOno78MJw+l6sL7ews
	YR0gaWUKYOMAs1cOpHTL5wE17R13gIhTKpM00iWP3w1iLXonrwy6yKI8UwErczM3oP0/
	Cb/Q==
X-Gm-Message-State: APjAAAV//EGPsyBONf8o0CURcxLZTh6cf5OA0i6YPD+kojE9mr+gixXv
	Y+HnTuKn7KRDMswN3DvJdHaYkrcfqsobfK6W/jJ9aA==
X-Google-Smtp-Source: APXvYqwFpueOKgtPMSCxMJJrIdwa2UQIgIsGcoJSOZGkXRP5Gc4Qj1guQVnPeBudhasuTVPb0XfZYL3l0IQ5dt7KVIk=
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr3973920wrw.105.1557333915495; 
	Wed, 08 May 2019 09:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190507134521.31044-1-thuth@redhat.com>
	<CAFEAcA-j+wQXjPW+puxk=foi2T8O=MzXHtxdWJ6E5P7o89WQSg@mail.gmail.com>
	<c0cda8fc-cc68-eadd-0750-cc9eeca094a4@redhat.com>
	<b93b1eb4-d2ff-67cd-a293-5ceb4db9b957@redhat.com>
In-Reply-To: <b93b1eb4-d2ff-67cd-a293-5ceb4db9b957@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Wed, 8 May 2019 18:45:03 +0200
Message-ID: <CAP+75-XRZ22uhxfLF6uOpjDtKOf_EDC8uGgbu=DgYw-kcBSAGQ@mail.gmail.com>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PULL v2 00/28] Kconfig for Arm machines
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
Cc: qemu-arm <qemu-arm@nongnu.org>, John Snow <jsnow@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[clicked ctrl+enter too fast]

On Wed, May 8, 2019 at 6:43 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
> On 5/8/19 5:33 PM, Thomas Huth wrote:
> > On 08/05/2019 17.09, Peter Maydell wrote:
> >> On Tue, 7 May 2019 at 14:45, Thomas Huth <thuth@redhat.com> wrote:
> >>>
> >>>  Hi Peter,
> >>>
> >>> the following changes since commit a6ae23831b05a11880b40f7d58e332c45a=
6b04f7:
> >>>
> >>>   Merge remote-tracking branch 'remotes/ehabkost/tags/python-next-pul=
l-request' into staging (2019-05-03 15:26:09 +0100)
> >>>
> >>> are available in the Git repository at:
> >>>
> >>>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-05-07
> >>>
> >>> for you to fetch changes up to 69f879e9fefab9aaf24893fe4ce23e07756d70=
3c:
> >>>
> >>>   hw/arm: Remove hard-enablement of the remaining PCI devices (2019-0=
5-07 15:01:47 +0200)
> >>>
> >>> ----------------------------------------------------------------
> >>> Kconfig settings for the Arm machines
> >>> (v2: Fix the dependency of q35 to AHCI_ICH9 in the second patch)
> >>> ----------------------------------------------------------------
> >>
> >> Hi -- this is still failing in the build test where I 'make clean'
> >
> > Very weird. What is running before the "make clean"? Could you provide
> > me with the content of i386-softmmu/config-devices.mak please?
>
> It worked for me after running 'git fetch --tags', maybe because Thomas
> used the same tag?

Maybe because Thomas used the same tag you are still trying the
previous version?

