Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF967C28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 13:37:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 822DC20665
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 13:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn0bRosi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822DC20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41875 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYW6o-000309-Po
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 09:37:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hYW5Y-0002A5-8t
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hYW5X-0006aY-E2
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:36:24 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530]:39567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hYW5X-0006Zm-7k
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 09:36:23 -0400
Received: by mail-ed1-x530.google.com with SMTP id m10so5838312edv.6
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 06:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=XxCuyWvH/ZMOfnSDFTnwwPUG/3lD5TJMtC66xPu+ONs=;
	b=gn0bRosijdLrhQjmYtFWLHQqTAYUPV4jfvwKYATKAjGuMlgwX01nVVfdSeG1KUxei7
	n+BO0dqdWPhCt8duyj7FXvEstcR8MJftfBhuqzMUXd7uLedCyUZfEtM1qiSWBR+9+Tap
	4fipIS+yF1B18ZZ8Dd3VIkQJosZG/OoEpc9QDVGegaOxBFv6LSYfUFU3QgTCFu+vZKt8
	WeFfk3t1GLMbXMbu6MxgVkuIuYlIF7xfqPSi9uHRyOgmDdPngRXYZJw2mZHsaS2Nu/+1
	3rvo2gjRmuq+9GXRfvda3vXKJ9p5IhEtSu4BKp15UGETM2IgvBxKAyHeQqJuS+ffO4oX
	63tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=XxCuyWvH/ZMOfnSDFTnwwPUG/3lD5TJMtC66xPu+ONs=;
	b=NF3RLj+qlmA3yoIrAlENBl8+1YGe+TJHRtStukjDg62EG+jULqxHJTd260jaVN/07F
	LgCaafnygTWI2qXo0lgdWBwaASznbta7YjdMyOL0c92V5icvB43Tup/JJULSSwIS/BGf
	fHeSJ4DTxGMAHFx1kBWENOrxUT6KMKafjq9qGxgPBGHu6a5rF/bxo8j+yq9YCMSEy/Ns
	2lzBImIgA/0TsgbydZypDzIV+n1Q5tJqOSvuhJtg0bkdvZQ5ZM7qSBdqgJG6rJPccF/v
	3IUMJ0ahFbBCQSWNMdoHv/6GnXQ8ZW/xfFJTBzcC0GpkbLooKpo0kC/UCKreqs6Ypd2V
	ZMGw==
X-Gm-Message-State: APjAAAXkDqtK3OSybmzcAZ7KXCciJa44ChW+qvnzMpfHXhs+7gTeswHg
	w/VfcF6kfrTzn1EmWxuEQt78SvxS
X-Google-Smtp-Source: APXvYqzrf1qXTzWuCQ3SPlXO/6+UuwW5l6vD/Zv0Pcce++tyBUxK1SyTtDsKlgMzZSGXNI4i6b+9AQ==
X-Received: by 2002:a17:906:448d:: with SMTP id
	y13mr35433357ejo.262.1559741782107; 
	Wed, 05 Jun 2019 06:36:22 -0700 (PDT)
Received: from localhost ([185.92.221.13]) by smtp.gmail.com with ESMTPSA id
	j19sm3631279edr.69.2019.06.05.06.36.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 05 Jun 2019 06:36:21 -0700 (PDT)
Date: Wed, 5 Jun 2019 13:36:20 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Philippe Mathieu-Daud?? <philmd@redhat.com>
Message-ID: <20190605133620.zf56y2swv67ymppx@master>
References: <20190605115318.9972-1-quintela@redhat.com>
	<20190605115318.9972-6-quintela@redhat.com>
	<60500aa5-856d-e754-3a4d-8d8b311087ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60500aa5-856d-e754-3a4d-8d8b311087ca@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::530
Subject: Re: [Qemu-devel] [PULL 5/5] migratioin/ram: leave RAMBlock->bmap
 blank on allocating
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	zhanghailiang <zhang.zhanghailiang@huawei.com>,
	Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 05, 2019 at 02:26:52PM +0200, Philippe Mathieu-Daud?? wrote:
>migratioin -> migration

Ah, you are right.

-- 
Wei Yang
Help you, Help me

