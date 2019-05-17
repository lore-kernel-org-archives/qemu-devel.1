Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A76C04AAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 00:13:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B88F20848
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 00:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="trB5X+v2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B88F20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38722 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRQVD-0004IQ-Em
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 20:13:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jstaron@google.com>) id 1hRQUP-0003zD-Gh
	for qemu-devel@nongnu.org; Thu, 16 May 2019 20:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jstaron@google.com>) id 1hRQUO-00058W-Jy
	for qemu-devel@nongnu.org; Thu, 16 May 2019 20:12:45 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jstaron@google.com>) id 1hRQUO-00054V-9p
	for qemu-devel@nongnu.org; Thu, 16 May 2019 20:12:44 -0400
Received: by mail-pg1-x542.google.com with SMTP id t22so2341840pgi.10
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 17:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=grI6nIUF/mMOBdv6LrPvHsdNVES0yai/LfFYIZ4bkWY=;
	b=trB5X+v2CFHJR5/h5Ogo8pnGEbixSq/5SbMCfW0BvmcDG2zeRdzxHL4lknPMI8JsaG
	91o9aNowjUtiTckfyBLWY/pZJBmRERl33EcI9dq0zR0lXd+XHl45wImJtwD6qTmBiD3C
	YvIdILOfNr02D208IUOgX7xjB1B80gLQERVK/akSkqvFqS79gmXpU/duephS4OxkvMCj
	iFkaZbcWb+04sJYfOvlYsPNWM7LK/oP8HkDOryS8f1XdKVoMLZUlQ8YVZMbBQiMDnraB
	fYXacmGWn0btEdYeftIv0rPSsHpeCBXpkkAwnfL+k2zqdhfQJ6WS6TGQ7DeGxI98ZyT1
	d5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=grI6nIUF/mMOBdv6LrPvHsdNVES0yai/LfFYIZ4bkWY=;
	b=AxR1Y34e0GX+4Aw+0aF22JaZagY4FIALgcUNQ0Qjm7VTbb33DYkAVI4dmnLFqLD3Ea
	BkZ1KSf7KlE1CV7YTpTlhGdJzp4Hisqs99auKpUzeRnYooJdFxJu0i22o3fNEUMePMKQ
	yHJUYfkSTs+sIH1Jkca4LxJHnNRtlIVVsKrT9mKOEGAC/LjNdy4CcfocF5SZr4SMx08U
	5x20akT8h7zgdfXpiaZhGGiDY05j+1ZnIFqZycfcT5WM93wHx8Zb029wDZ4n+VwGalf0
	nrjaHlatofGmU9yB2snzBy34xOQ716IYHhAxyyyRj1c4UZZwbcVMjCMVUfHkuwOWQacS
	qtFQ==
X-Gm-Message-State: APjAAAXvmtgHyiqO01lW6froxwFRGlQc5k7GV8WJ6px4g5ts4WlwdN5y
	T8DS4kHnj92SYrUFn8ozjcvPkQ==
X-Google-Smtp-Source: APXvYqyv1iVBQbL6jyOdYGu6UtPQiwVBUuqofcSXUoK/ck1DMyLzSDgzGJaT2Ro5WErOmsiHR9V/gQ==
X-Received: by 2002:a63:d816:: with SMTP id b22mr52619479pgh.16.1558051959951; 
	Thu, 16 May 2019 17:12:39 -0700 (PDT)
Received: from jstaron2.mtv.corp.google.com
	([2620:15c:202:201:b94f:2527:c39f:ca2d])
	by smtp.gmail.com with ESMTPSA id a6sm7245768pgd.67.2019.05.16.17.12.37
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 17:12:39 -0700 (PDT)
To: Pankaj Gupta <pagupta@redhat.com>, linux-nvdimm@lists.01.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-acpi@vger.kernel.org, qemu-devel@nongnu.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20190514145422.16923-1-pagupta@redhat.com>
	<20190514145422.16923-3-pagupta@redhat.com>
Message-ID: <c06514fd-8675-ba74-4b7b-ff0eb4a91605@google.com>
Date: Thu, 16 May 2019 17:12:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514145422.16923-3-pagupta@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v9 2/7] virtio-pmem: Add virtio pmem driver
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
From: =?UTF-8?Q?Jakub_Staro=c5=84?= via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: =?UTF-8?Q?Jakub_Staro=c5=84?= <jstaron@google.com>
Cc: jack@suse.cz, mst@redhat.com, jasowang@redhat.com, david@fromorbit.com,
	lcapitulino@redhat.com, adilger.kernel@dilger.ca,
	smbarber@google.com, zwisler@kernel.org, aarcange@redhat.com,
	dave.jiang@intel.com, darrick.wong@oracle.com,
	vishal.l.verma@intel.com, david@redhat.com, willy@infradead.org,
	hch@infradead.org, jmoyer@redhat.com, nilal@redhat.com,
	lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com,
	yuval.shaia@oracle.com, stefanha@redhat.com, pbonzini@redhat.com,
	dan.j.williams@intel.com, kwolf@redhat.com, tytso@mit.edu,
	xiaoguangrong.eric@gmail.com, cohuck@redhat.com,
	rjw@rjwysocki.net, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 7:54 AM, Pankaj Gupta wrote:
> +		if (!list_empty(&vpmem->req_list)) {
> +			req_buf = list_first_entry(&vpmem->req_list,
> +					struct virtio_pmem_request, list);
> +			req_buf->wq_buf_avail = true;
> +			wake_up(&req_buf->wq_buf);
> +			list_del(&req_buf->list);
Yes, this change is the right one, thank you!

> +	 /*
> +	  * If virtqueue_add_sgs returns -ENOSPC then req_vq virtual
> +	  * queue does not have free descriptor. We add the request
> +	  * to req_list and wait for host_ack to wake us up when free
> +	  * slots are available.
> +	  */
> +	while ((err = virtqueue_add_sgs(vpmem->req_vq, sgs, 1, 1, req,
> +					GFP_ATOMIC)) == -ENOSPC) {
> +
> +		dev_err(&vdev->dev, "failed to send command to virtio pmem" \
> +			"device, no free slots in the virtqueue\n");
> +		req->wq_buf_avail = false;
> +		list_add_tail(&req->list, &vpmem->req_list);
> +		spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> +
> +		/* A host response results in "host_ack" getting called */
> +		wait_event(req->wq_buf, req->wq_buf_avail);
> +		spin_lock_irqsave(&vpmem->pmem_lock, flags);
> +	}
> +	err1 = virtqueue_kick(vpmem->req_vq);
> +	spin_unlock_irqrestore(&vpmem->pmem_lock, flags);
> +
> +	/*
> +	 * virtqueue_add_sgs failed with error different than -ENOSPC, we can't
> +	 * do anything about that.
> +	 */
> +	if (err || !err1) {
> +		dev_info(&vdev->dev, "failed to send command to virtio pmem device\n");
> +		err = -EIO;
> +	} else {
> +		/* A host repsonse results in "host_ack" getting called */
> +		wait_event(req->host_acked, req->done);
> +		err = req->ret;
> +I confirm that the failures I was facing with the `-ENOSPC` error path are not present in v9.

Best,
Jakub Staron

