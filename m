Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BECC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 18:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F2020862
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 18:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wfGVKnAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F2020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41795 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTseC-0003LZ-Eo
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 14:41:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTsdO-0002t6-HO
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:40:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTsdK-0001Yd-Ge
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:40:07 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:38662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTsdK-0001We-CG
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:40:06 -0400
Received: by mail-yb1-xb41.google.com with SMTP id x7so2654513ybg.5
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 11:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=i+JfqXbcsE7edk3YPIVrEZru5XOSY8KimP5PNBlWRks=;
	b=wfGVKnAZjPrgn/85Ak4SYLKWm0P5uXtWoNgX10ZWbS5og3v86YZb3qLXd4I99fY/DK
	1Xp65rPNq85cvMyr8LwEf8YHpGuNfVclUhvI0NxBYhHoKlHs8mIrlcsvEMbfjZueTHX9
	bii1xuh5/nyqcGVXxEYGjIHyZmpCk3rTEQZAJPiP+lOTWbvH4ZMWHqFviNlj9R0GxGBd
	9N36hbYasBWfvaUnbMwW1fS3TyG0ZiQ3upmk2CyIXxq9Y56z/VAKHpPzC4eG6zAsmQK6
	d42Nfkx+rJglVzsvzZJCU3nGyiSh/szKGgz6BDVeY4RpOxT/bSAcZ7lWFcI/jAUmbOvG
	w40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=i+JfqXbcsE7edk3YPIVrEZru5XOSY8KimP5PNBlWRks=;
	b=hI4+y6/6p7T7YSdlDk8oNY1FJsepcqNvie74+YYNNO8ocBXt/sDcl8r1A9CgVNgIH6
	oxkcZ35pM+kQGHrLQynxBcZbzu6Va9juWmzf7hkRF7IYee4n5M7WFjkpH8Lbqmxqi5dB
	hi8LGan5fh/dE+RiMDgqUbidLpELr/i75Knb+DY66VR6o6lkzgbrTBinXFw0LrxOJBu7
	XkEbsm0gsERitwdaduELdEX6nOBt/WACgTDImjjTx77OJJJ8zSvx7nqu87DX+IbDNqpR
	jqRKAY0Wh8Gmd3cTykhI2pLGLRjASkRtsNlNuwdIWZ2bYhuteM+/sZ6WZSra0bZ0C32n
	lkKQ==
X-Gm-Message-State: APjAAAUXemED4wC03RWcDHIgCo9ppuSsUUNy6UY4qwVfafx/k91C5nOx
	L19E5uyc7E0PfKFLgM6nHtvayYklAaw=
X-Google-Smtp-Source: APXvYqxfiI0pldfsBKt3C9AW5nCJVXbbWrfkDViO8e3lgWgr9Jr06gysZ1kHeaZjgsd1irJsFX8Lzw==
X-Received: by 2002:a25:2744:: with SMTP id n65mr189652ybn.331.1558636802540; 
	Thu, 23 May 2019 11:40:02 -0700 (PDT)
Received: from [10.241.6.101] ([71.46.56.12])
	by smtp.gmail.com with ESMTPSA id a202sm13067ywe.44.2019.05.23.11.40.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 11:40:01 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20190523143508.25387-1-armbru@redhat.com>
	<20190523143508.25387-3-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9f7b8d8d-5da5-f47a-643e-14c32deb7c94@linaro.org>
Date: Thu, 23 May 2019 14:39:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523143508.25387-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b41
Subject: Re: [Qemu-devel] [PATCH 2/4] qemu-common: Move qemu_isalnum() etc.
 to qemu/ctype.h
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 10:35 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/ssh.c                |  1 +
>  block/vvfat.c              |  1 +
>  gdbstub.c                  |  2 ++
>  hw/core/bus.c              |  2 +-
>  hw/core/qdev-properties.c  |  1 +
>  hw/s390x/s390-virtio-ccw.c |  1 +
>  hw/scsi/scsi-generic.c     |  2 +-
>  include/qemu-common.h      | 16 ----------------
>  include/qemu/ctype.h       | 27 +++++++++++++++++++++++++++
>  monitor.c                  |  1 +
>  net/net.c                  |  1 +
>  net/tap-solaris.c          |  1 +
>  qapi/qapi-util.c           |  2 +-
>  qobject/json-parser.c      |  2 +-
>  target/ppc/monitor.c       |  2 ++
>  target/riscv/cpu.c         |  1 +
>  tests/libqtest.c           |  1 +
>  tests/vhost-user-bridge.c  |  2 +-
>  ui/keymaps.c               |  1 +
>  util/cutils.c              |  3 ++-
>  util/id.c                  |  2 +-
>  util/readline.c            |  2 +-
>  22 files changed, 50 insertions(+), 24 deletions(-)
>  create mode 100644 include/qemu/ctype.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


