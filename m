Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D598C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 19:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C4A321019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 19:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="u2CwdPBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4A321019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42267 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hORtt-000690-FK
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 15:06:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jstaron@google.com>) id 1hORsv-0005Ay-Iv
	for qemu-devel@nongnu.org; Wed, 08 May 2019 15:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jstaron@google.com>) id 1hORsu-0007vG-C0
	for qemu-devel@nongnu.org; Wed, 08 May 2019 15:05:45 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37498)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jstaron@google.com>) id 1hORsu-0007uL-2T
	for qemu-devel@nongnu.org; Wed, 08 May 2019 15:05:44 -0400
Received: by mail-pf1-x444.google.com with SMTP id g3so10966057pfi.4
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 12:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=from:subject:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=Xx1nBdwm/fMIaQ+XRMTVvJx4homKW8vOYVCrjJQah8c=;
	b=u2CwdPBWUhvunu491lhDVH7O10yitnzRdNYTDcNKNGaaMw+pYsmkpn0J9MsT99d39Y
	Q/Wk7PGyXcjoc1tha4UuyE89T0rOnD72kAWNnjYRKkjCa0DELX1ElQVVB5fGF3jmFGkX
	uLZw9HuRYb+PEeZ/PPFrro1K3Iw9vCnd+ELZuZL2OKCDNAb8u9QKbTbbytR8kbwE4FBI
	Zo/dlYVRRbaMO0EpBIfmHWL9EiKzdxDQc7t8r9e2EKWR9k2JLXoh6H4LfMbZMUTXsaF+
	muQoMtmzSSBP8hE/rlSXFu27Me96rPxVPBbMGgvYpGy27lg+hjZKYMbf9BMngu5WO2ck
	kXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:subject:to:cc:references:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=Xx1nBdwm/fMIaQ+XRMTVvJx4homKW8vOYVCrjJQah8c=;
	b=BXQgN8xBeaBXr49qIeym+c+Aobx4pWch7giUaypeb7g2t9hMTVahaDdDUaxxrQmW9M
	Cns3gnBq938gyl24FERTsbOxvdebun0LivvR3YLQSXvlZpVLpgaxARJ+6/yEsnx25ztb
	C1YYi5rbQiyTl32fLfisu4eWPzVg6gHS4pPeXb9ezy3vEliu1rkzg/oBhNfPQrLI/NyQ
	HR6aiAC+n77a/bpALCtRbV9f0rYa8bi/FaxMUSQZfwVAplciONe/stiq0KsNzsWf+HAo
	gQfDIVYxuLkT9+eABa/MmeeRgSyrxzA3gCVAESjlYPa+T1PO9p8TMjx7wkEcXRzG0JmS
	4uPg==
X-Gm-Message-State: APjAAAWhsbkfl2IdYBXGTVuLLVnxS5Op89hl0cBdRRwqS7rFvs/BNDS0
	zENKpUuAt8jgLVtJgBQOuokd2w==
X-Google-Smtp-Source: APXvYqzypNLQt7uc54cFtZOQcJp0DaX+ClanYsAzKwneRj68EqOnfHTAe97HizrDj+ZvHjUmPOl5NA==
X-Received: by 2002:a65:5cc8:: with SMTP id b8mr47363166pgt.36.1557342342253; 
	Wed, 08 May 2019 12:05:42 -0700 (PDT)
Received: from jstaron2.mtv.corp.google.com
	([2620:15c:202:201:b94f:2527:c39f:ca2d])
	by smtp.gmail.com with ESMTPSA id
	129sm23470533pff.140.2019.05.08.12.05.40
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 12:05:41 -0700 (PDT)
To: Pankaj Gupta <pagupta@redhat.com>
References: <20190426050039.17460-1-pagupta@redhat.com>
	<20190426050039.17460-3-pagupta@redhat.com>
	<3d6479ae-6c39-d614-f1d9-aa1978e2e438@google.com>
	<1555943483.27247564.1557313967518.JavaMail.zimbra@redhat.com>
Message-ID: <3d643ac5-ea1b-efba-9f42-31b2ed3ab5b0@google.com>
Date: Wed, 8 May 2019 12:05:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555943483.27247564.1557313967518.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v7 2/6] virtio-pmem: Add virtio pmem driver
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
Cc: cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com,
	jasowang@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org,
	virtualization@lists.linux-foundation.org,
	adilger kernel <adilger.kernel@dilger.ca>, smbarber@google.com,
	zwisler@kernel.org, aarcange@redhat.com,
	dave jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
	vishal l verma <vishal.l.verma@intel.com>, david@redhat.com,
	willy@infradead.org, hch@infradead.org,
	linux-acpi@vger.kernel.org, jmoyer@redhat.com,
	linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl,
	riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>,
	stefanha@redhat.com, imammedo@redhat.com,
	dan j williams <dan.j.williams@intel.com>,
	lcapitulino@redhat.com, kwolf@redhat.com, nilal@redhat.com,
	tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>,
	darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/19 4:12 AM, Pankaj Gupta wrote:
> 
>>
>> On 4/25/19 10:00 PM, Pankaj Gupta wrote:
>>
>>> +void host_ack(struct virtqueue *vq)
>>> +{
>>> +	unsigned int len;
>>> +	unsigned long flags;
>>> +	struct virtio_pmem_request *req, *req_buf;
>>> +	struct virtio_pmem *vpmem = vq->vdev->priv;
>>> +
>>> +	spin_lock_irqsave(&vpmem->pmem_lock, flags);
>>> +	while ((req = virtqueue_get_buf(vq, &len)) != NULL) {
>>> +		req->done = true;
>>> +		wake_up(&req->host_acked);
>>> +
>>> +		if (!list_empty(&vpmem->req_list)) {
>>> +			req_buf = list_first_entry(&vpmem->req_list,
>>> +					struct virtio_pmem_request, list);
>>> +			list_del(&vpmem->req_list);
>>
>> Shouldn't it be rather `list_del(vpmem->req_list.next)`? We are trying to
>> unlink
>> first element of the list and `vpmem->req_list` is just the list head.
> 
> This looks correct. We are not deleting head but first entry in 'req_list'
> which is device corresponding list of pending requests.
> 
> Please see below:
> 
> /**
>  * Retrieve the first list entry for the given list pointer.
>  *
>  * Example:
>  * struct foo *first;
>  * first = list_first_entry(&bar->list_of_foos, struct foo, list_of_foos);
>  *
>  * @param ptr The list head
>  * @param type Data type of the list element to retrieve
>  * @param member Member name of the struct list_head field in the list element.
>  * @return A pointer to the first list element.
>  */
> #define list_first_entry(ptr, type, member) \
>     list_entry((ptr)->next, type, member)

Please look at this StackOverflow question:
https://stackoverflow.com/questions/19675419/deleting-first-element-of-a-list-h-list

Author asks about deleting first element of the queue. In our case
(and also in the question's author case), `vpmem->req_list` is not element
of any request struct and not an element of the list. It's just a list head storing 
`next` and `prev` pointers which are then pointing to respectively first and
last element of the list. We want to unlink the first element of the list,
so we need to pass pointer to the first element of the list to
the `list_del` function - that is, the `vpmem->req_list.next`.

Thank you,
Jakub Staron

